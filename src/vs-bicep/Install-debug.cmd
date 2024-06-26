@echo off

taskkill /im devenv.exe /t /f 2>&1 | findstr /v "not found"

set VsWhereExePath=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe
set "ExtensionsRoot=%~dp0"

for /f "usebackq delims=" %%i in (`"%VsWhereExePath%" -latest -prerelease -products * -property enginePath`) do (
  set VSIXInstallerExePath=%%i
)

set VSIXInstallerExe=%VSIXInstallerExePath%\VSIXInstaller.exe
echo VSIXInstaller.exe location: "%VSIXInstallerExe%"

set BicepVsixPath=%ExtensionsRoot%Bicep.VSLanguageServerClient.Vsix\bin\Debug\vs-bicep.vsix
echo Bicep vsix location: %BicepVsixPath%

choice /M "Install? (Y/N)"
if errorlevel 2 goto skip_install

rem Install the VSIX here
call "%VSIXInstallerExe%" "%BicepVsixPath%"

:skip_install
