@echo off
adb tcpip 5555
timeout /t 5 /nobreak >nul

set ip_address=
for /f "tokens=2 delims= " %%a in ('adb shell ip addr show wlan0 ^| findstr /i /c:"inet " ^| findstr /v /c:"127.0.0.1"') do (
    for /f "tokens=1 delims=/" %%b in ("%%a") do (
        set ip_address=%%b
        goto :break
    )
)
:break

if "%ip_address%"=="" (
    echo Failed to get IP address.
    pause
    exit /b
)

echo Successfully extracted IP address %ip_address%.

adb connect %ip_address%:5555

pause