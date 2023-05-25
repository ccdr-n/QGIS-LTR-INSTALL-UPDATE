:: Name:     qgis_ltr_install_update.bat
:: Purpose:  Automatic QGIS LTR install and update using osgeo4w-setup.exe
:: Author:   ricardo.pinho@ccdr-n.pt
:: Revision: 02 May 2023 - initial version
::
:: This script will:
:: 1. change the current directory to the user downloads folder
:: 2. download the OSGeo4W installer
:: 3. launch it passing command-line parameters to DOWNLOAD packages required to QGIS-LTR FULL
:: 4. launch it passing command-line parameters to INSTALL OR UPDATE QGIS-LTR
:: 
:: Documentation reference: https://trac.osgeo.org/osgeo4w/wiki/CommandLine
::
:: Inspiration from Guts Julien's QGIS powershell deploy and install script
:: https://gist.github.com/Guts/6303dc5eb941eb24be3e27609cd46985

@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

:: Set osgeo4w setup variables
SET starter_path=%cd%
SET osgeo4w_file=%UserProfile%\Downloads\osgeo4w-setup.exe
SET osgeo4w-setup_url=http://download.osgeo.org/osgeo4w/v2/osgeo4w-setup.exe
SET osgeo4w_site=http://ftp.osuosl.org/pub/osgeo/download/osgeo4w/v2
SET osgeo4w_root=C:\OSGeo4W


:: Set user persistent variable: QGIS_GLOBAL_SETTINGS_FILE
:: uncomment and replace path to set user persistent QGIS_GLOBAL_SETTINGS_FILE 
:: SET qgisglobalsettingsfile=\\server\path\qgis_global_settings\qgis_global_settings.ini
:: CALL SETX QGIS_GLOBAL_SETTINGS_FILE %qgisglobalsettingsfile%

:: Move into the user download directory
CALL CD /D %UserProfile%\Downloads\

:: Delete installer if exists
IF EXIST %osgeo4w_file% (
  REM Delete existing file
  DEL %osgeo4w_file%
) 

:: Download current osgeo4w-setup.exe
CURL %osgeo4w-setup_url% --output %osgeo4w_file%


:: Download and install (same command to upgrade with clean up)
CALL %osgeo4w_file%^
    --advanced^
    --arch x86_64^
    --autoaccept^
    --delete-orphans^
    --menu-name "QGIS LTR"^
    --no-desktop^
    --packages qgis-ltr-full^
    --quiet-mode^
    --root %osgeo4w_root%^
    --site %osgeo4w_site%^
    --upgrade-also

:: PAUSE

:END
ENDLOCAL
ECHO ON
@EXIT /B 0