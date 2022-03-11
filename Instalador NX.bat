@echo off
title Instalacion desatendida Siemens NX Series

:: color fondo codigo letra
color 0A

:: Tamaño columnas y lineas
mode con cols=100 lines=30

:: Descompresion del Zip-y
echo Descomprimiendo Siemens NX
FOR /F "delims==" %%I IN ('dir /b /s "SiemensNX-*_wntx64.zip"') DO (
	"7z.exe" x -o"%%~dpnI" "%%I"
	cd %%~dpnI
)

:: Limpiamos pantalla
cls

dir /s
cls
:: Instalacion Siemens NX
echo Instalacion desatencida Siemens NX
FOR /F "delims==" %%I IN ('dir /b /s SiemensNX.msi') DO (=
	msiexec.exe /i %%I ALLUSERS=1 /passive /log output.log ADDLOCAL=FEAT_NXPLATFORM LANGUAGE=spanish SETUPTYPE=custom LICENSESERVER=28000@ServerName
)

echo Instalacion desatencida VC_redist.x64.exe
FOR /F "delims==" %%I IN ('dir /b /s VC_redist.x64.exe') DO (=
	START /WAIT %%I /Silent
)

echo Instalacion desatencida dotnet-runtime-5.0.3-win-x64.exe
FOR /F "delims==" %%I IN ('dir /b /s dotnet-runtime-5.0.3-win-x64.exe') DO (=
	START /WAIT %%I /Silent
)


echo Instalacion desatencida NDP472-KB4054530-x86-x64-AllOS-ENU.exe
FOR /F "delims==" %%I IN ('dir /b /s NDP472-KB4054530-x86-x64-AllOS-ENU.exe') DO (=
	START /WAIT %%I /Silent
)

pause



