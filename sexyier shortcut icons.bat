@echo off
:: Set console color: 0 = black background, A = light green text
color 0A
title Remove Shortcut Arrow - Banner Edition
cls

:: Check for admin privileges
>nul 2>&1 "%windir%\system32\cacls.exe" "%windir%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting administrator privileges...
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c ""%~f0""", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
)

:: Remove shortcut overlay
echo Removing shortcut arrow overlay...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /t REG_SZ /d "" /f

:: Restart Explorer
echo Restarting Explorer...
taskkill /f /im explorer.exe >nul
start explorer.exe

echo.
echo Done! You may need to reboot your system for full effect.
echo This file brought to you by https://head.glass
echo Press any key to exit...
pause >nul
exit /b
