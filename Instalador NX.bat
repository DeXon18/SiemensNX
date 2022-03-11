@echo off
title Instalacion desatendida Siemens NX Series

REM color fondo codigo letra
color 0A

:: Tamaño columnas y lineas
mode con cols=100 lines=30

:: Descompresion del Zip-y
echo Descomprimiendo Siemens NX
FOR /F "delims==" %%I IN ('dir /b /s "SiemensNX-*_wntx64.zip"') DO (
	"7z.exe" x -o"%%~dpnI" "%%I"
	cd %%~dpnI
)

REM Limpiamos pantalla
cls

dir /s
cls
REM Instalacion Siemens NX
echo Instalacion desatencida Siemens NX
FOR /F "delims==" %%I IN ('dir /b /s SiemensNX.msi') DO (=
	msiexec.exe /i %%I ALLUSERS=1 /passive /log output.log ADDLOCAL=FEAT_NXPLATFORM LANGUAGE=spanish SETUPTYPE=custom LICENSESERVER=28000@ServerName
)

REM  Instalacion Microsoft Visual C++ Redistributable
echo Instalacion desatencida Microsoft Visual C++ Redistributable
FOR /F "delims==" %%I IN ('dir /b /s VC_redist.x64.exe') DO (=
	START /WAIT %%I /Silent
)

REM  Instalacion .NET 5.0.3
echo Instalacion desatencida .NET 5.0.3
FOR /F "delims==" %%I IN ('dir /b /s dotnet-runtime-5.0.3-win-x64.exe') DO (=
	START /WAIT %%I /Silent
)

REM  Instalacion .NET Framework 4.7.2
REM  En versiones de Windows 10 y 11 no es necesario.

reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319\SKUs\.NETFramework,Version=v4.7.2" 2>nul
if errorlevel 1 (
	echo Instalacion desatencida .NET Framework 4.7.2
	FOR /F "delims==" %%I IN ('dir /b /s NDP472-KB4054530-x86-x64-AllOS-ENU.exe') DO (=
		START /WAIT %%I /Silent
	)
) else (
    echo .NET Framework 4.5.2 is installed
	pause
)




pause



