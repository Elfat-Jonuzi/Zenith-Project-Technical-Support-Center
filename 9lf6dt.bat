@echo off

echo Current user privileges: %userprofile%
echo.
echo Requesting administrative privileges...

net session >nul 2>&1
if %errorLevel% == 0 (
    goto :continue
) else (
    goto :admin
)

:admin
echo.
echo You need to run this batch file as an Administrator.
echo Please grant administrative privileges by selecting "Yes" when prompted.
echo.
powershell -Command "Start-Process '%0' -Verb RunAs"
exit

:continue
echo Administrative privileges confirmed.
echo.
echo Disabling driver blocklist...

reg add HKLM\SYSTEM\CurrentControlSet\Control\CI\Config /v VulnerableDriverBlocklistEnable /t REG_DWORD /d 0x000000

echo.
echo Done! Please Restart
echo.
pause >nul
exit
