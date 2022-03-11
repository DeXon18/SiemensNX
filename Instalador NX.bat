@echo off
title Instalacion desatendida Siemens NX Series
REM Color fondo codigo letra
color 0A
REM Tamaño columnas y lineas
mode con cols=100 lines=30

REM Verificamos si exisite la variable de entorno SPLM_LICENSE_Server
REM Si es asi utilizamos el valor para la instalación de Siemens NX
set ENV_PATH=%SPLM_LICENSE_Server%
if "%ENV_PATH%"== "" ( set DefaultServer 28000@localhost ) else ( set DefaultServer %ENV_PATH% )

REM Descompresion del Zip
REM Añadir -y para forzar sobreescribir.
echo ################################
echo ## Descomprimiendo Siemens NX ##
echo ################################
FOR /F "delims==" %%I IN ('dir /b /s "SiemensNX-*_wntx64.zip"') DO ( "7z.exe" x -o"%%~dpnI" "%%I" cd %%~dpnI )

cls
REM Instalacion Siemens NX

REM Las propiedades configurables para la instalación de NX son:

REM Comando LICENSESERVER
	REM Esta propiedad establece el valor del servidor de licencias NX. Por defecto, será el valor de la variable de entorno
	REM la variable de entorno SPLM_LICENSE_SERVER (si se ha establecido en una instalación
	REM instalación anterior) o 28000@<localhost> donde <localhost> es el nombre de su estación de trabajo.

REM Comando LANGUAGE
	REM Esta propiedad establece el valor del idioma de la interfaz de usuario para NX. Las opciones válidas son
	REM german, french, spanish, english, italian, japanese, korean, russian, simpl_chinese, trad_chinese, braz_portuguese, czech, hungarian and polish.
	REM El valor por defecto de esta propiedad es el english.

REM Comando INSTALLDIR
	REM Esta propiedad establece el directorio donde se instalará NX.
	REM Si no se especifica "C:\Program Files\Siemens\NX".

REM Comando ADDLOCAL
	REM Si está realizando una instalación completa, debe especificar ADDLOCAL=ALL.
	REM Si no se especifica ADDLOCAL en el comando, es lo mismo que ADDLOCAL=FEAT_NXPLATFORM solamente.
	REM El resto de características de instalación seleccionables para una instalación personalizada son:

	REM FEAT_AUTOMATION_DESIGNER      FEAT_AUTOMOTIVE
	REM FEAT_DIAGRAMMING              FEAT_DRAFTING
	REM FEAT_MANUFACTURING_PLANNING   FEAT_MANUFACTURING
	REM FEAT_MECHATRONICS             FEAT_NXNASTRAN
	REM FEAT_PROGRAMMING_TOOLS        FEAT_PROGRAMMING_TOOLS
	REM FEAT_ROUTING                  FEAT_SHIP_BUILDING
	REM FEAT_SIMULATION               FEAT_STUDIO_RENDER
	REM FEAT_TOOLING_DESIGN           FEAT_TOOLING_DESIGN
	REM FEAT_TRANSLATORS              FEAT_VALIDATION

REM TARGETDIR
	REM Esta propiedad establece el directorio donde se colocará una instalación administrativa de NX administrativa de NX.
	REM Esta propiedad es sólo para instalaciones administrativas. Consulte Instalación de NX para Parallel Product Testing para más información.

echo ###########################################
echo ##  Instalacion desatencida Siemens NX   ##
echo ###########################################
FOR /F "delims==" %%I IN ('dir /b /s SiemensNX.msi') DO (=
	msiexec.exe /i %%I ALLUSERS=1 /passive /log output.log LICENSESERVER=28000@%DefaultServer% LANGUAGE=spanish ADDLOCAL=ALL
)

REM  Instalacion Microsoft Visual C++ Redistributable
echo ##################################################################
echo ## Instalacion desatencida Microsoft Visual C++ Redistributable ##
echo ##################################################################
FOR /F "delims==" %%I IN ('dir /b /s VC_redist.x64.exe') DO (=
	START /WAIT %%I /Silent
)

REM  Instalacion .NET 5.0.3
echo ########################################
echo ## Instalacion desatencida .NET 5.0.3 ##
echo ########################################
FOR /F "delims==" %%I IN ('dir /b /s dotnet-runtime-5.0.3-win-x64.exe') DO (=
	START /WAIT %%I /Silent
)

REM  Instalacion .NET Framework 4.7.2
REM  En versiones de Windows 10 y 11 no es necesario ya que es nativo
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319\SKUs\.NETFramework,Version=v4.7.2" 2>nul
if errorlevel 1 (
    echo ##################################################
	echo ## Instalacion desatencida .NET Framework 4.7.2 ##
    echo ##################################################
	FOR /F "delims==" %%I IN ('dir /b /s NDP472-KB4054530-x86-x64-AllOS-ENU.exe') DO (=
		START /WAIT %%I /Silent
	)
) else (
    echo .NET Framework 4.5.2 is installed
	pause
)




pause



