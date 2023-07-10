@echo off
set /p run_tcpip=Run "adb tcpip 5555" command now? (y/n): 
if /i "%run_tcpip%"=="y" (
    adb tcpip 5555
    timeout /t 1 /nobreak >nul
)

timeout /t 5 /nobreak >nul

set ip_address=
for /f "tokens=2" %%a in ('adb shell ip addr show wlan0 ^| findstr /i /c:"inet " ^| findstr /v /c:"127.0.0.1"') do (
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

set /p connect_device=Connect to device at %ip_address%:5555 now? (y/n):
if /i "%connect_device%"=="y" (
    adb connect %ip_address%:5555
)

pause