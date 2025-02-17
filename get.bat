:: Junkware Removal Tool (JRT) v8.1.4
:: Created by Thisisu @Malwarebytes
@echo OFF
title Junkware Removal Tool by Malwarebytes - Version 8.1.4
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
SET "JRT=%TEMP%\jrt"
SET "JTEMP=%TEMP%\jrt\TEMP"
SET "GREP=%temp%\jrt\GREP.DAT"
SET "SED=%temp%\jrt\SED.DAT"
SET "SORT_=%temp%\jrt\SORT_.DAT"
SET "CUT=%temp%\jrt\CUT.DAT"
SET "SHORTCUT=%temp%\jrt\SHORTCUT.DAT"
SET "WGET=%temp%\jrt\WGET.DAT"
SET "NIRCMD=%temp%\jrt\NIRCMD.DAT"
SET "QUICKLAUNCHALL=%appdata%\Microsoft\Internet Explorer\Quick Launch"
SET "PROGRAMS1ALL=%allusersprofile%\Start Menu\Programs"
REM PROGRAMS1ALL contains both folders and .lnk files. http://imgur.com/tnT8DZu
SET "PROGRAMS2ALL=%userprofile%\Start Menu\Programs"
REM PROGRAMS2ALL contains both folders (limited) and .LNK files. http://imgur.com/b71EmoM
if exist "%windir%\Sysnative\cmd.exe" ( SET "SYS32=%windir%\Sysnative" ) else ( SET "SYS32=%windir%\System32" )
SET "TASKS=%windir%\Tasks"
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
if exist %windir%\syswow64 ( set ARCH=x64 ) else ( set ARCH=x86 )
if %ARCH%==x64 (
 SET "SYSWOW64=%windir%\SysWOW64"
)
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
FOR /F "tokens=2*" %%A IN ('REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v ComputerName 2^>NUL') DO SET COMPUTERNAME=%%B
FOR /F "tokens=2*" %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName 2^>NUL') DO SET OS=%%B
ECHO %OS%|FIND "Windows XP" >NUL
IF %ERRORLEVEL% EQU 0 (
 SET "LOCALA=%userprofile%\Local Settings\Application Data"
 SET "MYDOCS=%userprofile%\My Documents"
 SET "MYDLS=%userprofile%\My Documents\Downloads"
 SET "MYMUSIC=%userprofile%\My Documents\My Music"
 SET "LNK1XP=%allusersprofile%\Start Menu"
 SET "LNK2XP=%userprofile%\Start Menu"
 SET "STARTUP=%userprofile%\Start Menu\Programs\Startup"
 SET "DRM=%allusersprofile%\DRM"
 SET "TIFS=%systemdrive%\Documents and Settings\LocalService\Local Settings\Temporary Internet Files\Content.IE5"
 SET "TIFS2=%windir%\System32\config\systemprofile\Local Settings\Temporary Internet Files\Content.IE5"
) ELSE (
 SET "LOCALA=%localappdata%"
 SET "LOCALLOW=%userprofile%\Appdata\LocalLow"
 SET "MYDOCS=%userprofile%\Documents"
 SET "MYDLS=%userprofile%\Downloads"
 SET "MYMUSIC=%userprofile%\Music"
 SET "PUBDESKTOP=%systemdrive%\Users\Public\Desktop"
 SET "PUBDOCS=%systemdrive%\users\Public\Documents"
 SET "PUBLIC=%systemdrive%\Users\Public"
 SET "QUICKLAUNCH17=%appdata%\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu"
 SET "QUICKLAUNCH27=%appdata%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
 SET "PROGRAMS17=%allusersprofile%\Microsoft\Windows\Start Menu\Programs"
 SET "PROGRAMS27=%appdata%\Microsoft\Windows\Start Menu\Programs"
 SET "STARTMENU17=%allusersprofile%\Microsoft\windows\Start Menu"
 SET "STARTMENU27=%appdata%\Microsoft\Windows\Start Menu"
 SET "STARTUP=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"
 SET "DRM=%allusersprofile%\Microsoft\DRM"
 SET "TIFS=%localappdata%\Microsoft\Windows\Temporary Internet Files\Content.IE5"
 SET "TIFS2=%windir%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.IE5"
)
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
net session >NUL 2>&1
IF %ERRORLEVEL% EQU 0 ( SET USERSTATUS=Administrator) else (
 Echo(*** JRT runs best with administrator privileges ***
 echo.
 Echo(If you wish to run with administrator privileges, please close this window and run as an administrator.
 echo.
 Echo(If you wish to run without administrator privileges, please hit any key to continue.
 echo.
 SET USERSTATUS=Limited
 pause
)
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
DEL /F/Q "%JTEMP%\*" >NUL 2>&1
DEL /F/Q "%JRT%\JRT.*" >NUL 2>&1
DEL /F/Q "%JRT%\jrtnewmd5" >NUL 2>&1
DEL /F/Q "%JRT%\JRT_NewerVersion\*" >NUL 2>&1
Echo(Checking for update
PING -n 1 www.google.com >NUL 2>&1
IF ERRORLEVEL 1 (
 ECHO(Unable to ping, skipping update check
 GOTO :Disclaimer
)
"%WGET%" -q "http://data-cdn.mbamupdates.com/v1/tools/jrt/jrtnewmd5"
FC "%JRT%\jrtnewmd5" "%JRT%\jrtcurrentmd5" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Disclaimer )
ECHO(An update was found... Please wait
"%WGET%" -q "http://downloads.malwarebytes.org/file/jrt_update"
MD "%JRT%\JRT_NewerVersion" >NUL 2>&1
MOVE /Y "%JRT%\JRT.exe" "%JRT%\JRT_NewerVersion\JRT.exe" >NUL 2>&1
START /d "%JRT%\JRT_NewerVersion" JRT.exe
EXIT
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
:Disclaimer
title Junkware Removal Tool by Malwarebytes - Version 8.1.4
echo( ================================================================
echo( [                                                              ]
Echo( [         Junkware Removal Tool (JRT) by Malwarebytes          ]
Echo( [                  Version 8.1.4 (07.09.2017)                  ]
echo( [         Information about this tool can be found at          ]
echo( [                     www.malwarebytes.com                     ]
echo( [                                                              ]
echo( [           This software is free to download and use          ]
echo( [                                                              ]
Echo( [      Please save any unsaved work before proceeding as       ]
Echo( [  the program will terminate most applications during cleanup ]
echo( [                                                              ]
echo( [                                                              ]
echo( [                       ** DISCLAIMER **                       ]
echo( [                                                              ]
echo( [           This software is provided "as is" without          ]
echo( [        warranty of any kind. You may use this software       ]
echo( [                       at your own risk.                      ]
echo( [                                                              ]
echo( [     Click the [X] in the top-right corner of this window     ]
echo( [                if you wish to exit. Otherwise,               ]
echo( ================================================================
Echo(
pause
echo.
Set StartDate=%date%
set StartTime=%time%
"%JRT%\CreateRestorePoint.exe" "JRT Pre-Junkware Removal"
IF %ERRORLEVEL% NEQ 0 (
  Echo.
  Echo(Restore point creation encountered an error. 
  Echo(If you would like to continue anyway,
  pause
  echo.
)
:Processes
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
Echo((*       )  Processes
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
IF NOT EXIST %SYS32%\tasklist.exe GOTO :Logon
TASKLIST /FO CSV /NH 2>NUL|"%GREP%" -i "\.exe">"%JTEMP%\PLIST"
FINDSTR /IVG:"%JRT%\wl_processes.cfg" "%JTEMP%\PLIST" 2>NUL>"%JTEMP%\PLIST2"
"%SED%" -r "s:\.exe\".*:\.exe:I;s:^\"::" <"%JTEMP%\PLIST2" >"%JTEMP%\PLIST"
IF NOT EXIST %SYS32%\taskkill.exe (
 for /f "usebackq delims=" %%i in ("%JTEMP%\PLIST") do (
    "%NIRCMD%" KILLPROCESS "%%i" >NUL 2>&1
    )
 ) ELSE (
 for /f "usebackq delims=" %%i in ("%JTEMP%\PLIST") do (
    TASKKILL /F /IM "%%i" >NUL 2>&1
    )
)
:Logon
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
Echo((**      )  Startup - Logon
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
IF NOT EXIST %SYS32%\reg.exe GOTO :Tasks
REG QUERY "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Windows" /V APPINIT_DLLs 2>NUL>"%JTEMP%\APPINIT"
if %ARCH%==x64 (
  REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /V APPINIT_DLLs 2>NUL>>"%JTEMP%\APPINIT"
)
FINDSTR /V "REG.EXE REG_MULTI_SZ" "%JTEMP%\APPINIT" 2>NUL>"%JTEMP%\APPINIT2"
FC "%JTEMP%\APPINIT2" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Logon_0 )
FINDSTR /IG:"%JRT%\bl_appinit.cfg" "%JTEMP%\APPINIT2" 2>NUL>"%JTEMP%\APPINIT_T"
FC "%JTEMP%\APPINIT_T" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Logon_0 )
IF %ARCH%==x64 (
  REG ADD "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /V APPINIT_DLLs /d "" /F >NUL 2>&1
  ECHO(Successfully repaired: HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows\\APPINIT_DLLs ^(Registry Value^)>>"%JTEMP%\R_Registry.txt"
)
REG ADD "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Windows" /V APPINIT_DLLs /d "" /F >NUL 2>&1
ECHO(Successfully repaired: HKLM\Software\Microsoft\Windows NT\CurrentVersion\Windows\\APPINIT_DLLs ^(Registry Value^)>>"%JTEMP%\R_Registry.txt"
:Logon_0
REG QUERY HKCU\Software\Microsoft\Windows\CurrentVersion\Run 2>NUL|"%GREP%" "REG_SZ">"%JTEMP%\LOGON"
REG QUERY HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce 2>NUL|"%GREP%" "REG_SZ">>"%JTEMP%\LOGON"
REG QUERY HKLM\Software\Microsoft\Windows\CurrentVersion\Run 2>NUL|"%GREP%" "REG_SZ">>"%JTEMP%\LOGON"
if %ARCH%==x64 (
 REG QUERY HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run 2>NUL|"%GREP%" "REG_SZ">>"%JTEMP%\LOGON"
)
FC "%JTEMP%\LOGON" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Tasks )
"%SED%" -r "s/^\s{4}//;s/\s+REG_SZ\s+.*//" <"%JTEMP%\LOGON" >"%JTEMP%\LOGON2"
"%SORT_%" -f -u <"%JTEMP%\LOGON2" >"%JTEMP%\LOGON"
"%GREP%" -i -P "^\w+_\w{2} browser plugin (?:loader|loader 64)$|^\w+ search scope monitor$|^\w+ EPM Support$|^\w+ AppIntegrator (?:32|64)-bit$|^ConduitFloatingPlugin_.*|^GoogleChromeAutoLaunch_.*|^SaferAutoLaunch_.*|^shopperz\d{5,}$|^groover\d{5,}$|^firstOffer\d{5,}$|^[a-z]{3,6}_[a-z]{2}_\d{2,9}$|^tmp[0-9A-F]{4}$|^updater\d{5}$|^[0-9a-f]{32}$|^\d{8}$|^[a-z]{1}utoauto$|^ ?maintance$|^ ?qqpctray$|^sun\d{1}$|^SimpleNoteApp\d{1,}$|^Advanced PC-?\s*(?:Fixer|Care).*" "%JTEMP%\LOGON" 2>NUL>"%JTEMP%\LOGON_H"
"%GREP%" -i -x -f "%JRT%\bl_values.cfg" "%JTEMP%\LOGON" 2>NUL>>"%JTEMP%\LOGON_H"
FC "%JTEMP%\LOGON_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Tasks )
"%SORT_%" -f -u <"%JTEMP%\LOGON_H" >"%JTEMP%\LOGON_T"
for /f "usebackq delims=" %%i in ("%JTEMP%\LOGON_T") do (
  REG QUERY HKCU\Software\Microsoft\Windows\CurrentVersion\Run /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\Run /V "%%i" /F >NUL 2>&1
    REG QUERY HKCU\Software\Microsoft\Windows\CurrentVersion\Run /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKCU\Software\Microsoft\Windows\CurrentVersion\Run\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKCU\Software\Microsoft\Windows\CurrentVersion\Run\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
  REG QUERY HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce /V "%%i" /F >NUL 2>&1
    REG QUERY HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
  REG QUERY HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run /V "%%i" /F >NUL 2>&1
    REG QUERY HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
  REG QUERY HKLM\Software\Microsoft\Windows\CurrentVersion\Run /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE HKLM\Software\Microsoft\Windows\CurrentVersion\Run /V "%%i" /F >NUL 2>&1
    REG QUERY HKLM\Software\Microsoft\Windows\CurrentVersion\Run /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKLM\Software\Microsoft\Windows\CurrentVersion\Run\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKLM\Software\Microsoft\Windows\CurrentVersion\Run\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
)
:Tasks
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
Echo((***     )  Startup - Scheduled Tasks
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
DIR /B/A:-D "%TASKS%\*.JOB" 2>NUL>"%JTEMP%\TASKS"
FINDSTR /IVG:"%JRT%\wl_tasks.cfg" "%JTEMP%\TASKS" 2>NUL>"%JTEMP%\TASKS_SUSPECT"
FC "%JTEMP%\TASKS_SUSPECT" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Tasks_0 )
"%GREP%" -P "^\d{4}avUpdateInfo.*\.job$|^newSI_\d{1,5}\.job$|^At\d{1,4}\.job$|^\d{4}tb_RML\.job$|^ava[a-z]{1}v[a-z]{2}(?:v|x|y)[a-z]{1,3}\.job$|^bvxv[a-z]{1}(?:v|x)[a-z]{1,3}\.job$|^[A-Z]{16}\.job$|^[A-Z]{5,10}1\.job$|^[A-Z]{10}\.job$|^0$\.job|^MS\.job$|^blockerpro\.job$|^Security Center Update - \d{9,}\.job$|^GoogleUp\.job$|^impo\.job$|^win\.job$|^import\.job$|^Googleuptodate\.job$|^Google Update\.job$|^EssentialUpdateMachine\.job$|^Lanwifi\.job$|^Systemhi\.job$|^rdf\d{4}\.job$|^RunAtStartup\.job$|^[A-Za-z]{10,}V2\.job$|^sys\.job$|^patch1\.job$" "%JTEMP%\TASKS_SUSPECT" 2>NUL>"%JTEMP%\TASKS_H"
"%GREP%" -i -P "^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}-\d{1,}.*\.job$" "%JTEMP%\TASKS_SUSPECT" 2>NUL>>"%JTEMP%\TASKS_H"
"%GREP%" -i -f "%JRT%\bl_tasks.cfg" "%JTEMP%\TASKS_SUSPECT" 2>NUL>>"%JTEMP%\TASKS_H"
FC "%JTEMP%\TASKS_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Tasks_0 )
"%SORT_%" -f -u <"%JTEMP%\TASKS_H" >"%JTEMP%\TASKS_T"
for /f "usebackq delims=" %%i in ("%JTEMP%\TASKS_T") do (
  DEL /F/Q "%TASKS%\%%i" >NUL 2>&1
  IF EXIST "%TASKS%\%%i" ( ECHO(Failed to delete: "%TASKS%\%%i" ^(Task^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: "%TASKS%\%%i" ^(Task^)>>"%JTEMP%\R_Files.txt" )
)
:Tasks_0
ECHO %OS%|FIND "Windows XP" >NUL
IF %ERRORLEVEL% EQU 0 ( GOTO :Services )
IF NOT EXIST %SYS32%\schtasks.exe GOTO :Services
DIR /B/A:-D "%SYS32%\Tasks" 2>NUL>"%JTEMP%\SYSTASKS"
FINDSTR /IVG:"%JRT%\wl_tasks.cfg" "%JTEMP%\SYSTASKS" 2>NUL>"%JTEMP%\SYSTASKS_SUSPECT"
FC "%JTEMP%\SYSTASKS_SUSPECT" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Services )
"%GREP%" -P "^\d{4}avUpdateInfo.*|^newSI_\d{1,5}$|^At\d{1,4}$|^\d{4}tb_RML$|^ava[a-z]{1}v[a-z]{2}(?:v|x|y)[a-z]{1,3}$|^bvxv[a-z]{1}(?:v|x)[a-z]{1,3}$|^[A-Z]{16}$|^[A-Z]{5,10}1$|^[A-Z]{10}$|^0$|^MS$|^blockerpro$|^Security Center Update - \d{9,}$|^GoogleUp$|^impo$|^win$|^import$|^Googleuptodate$|^Google Update$|^EssentialUpdateMachine$|^Lanwifi$|^Systemhi$|^rdf\d{4}$|^RunAtStartup$|^[A-Za-z]{10,}V2$|^sys$|^patch1$|^[0-9a-f]{32}$" "%JTEMP%\SYSTASKS_SUSPECT">"%JTEMP%\SYSTASKS_H"
"%GREP%" -i -P "^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}-\d{1,}.*" "%JTEMP%\SYSTASKS_SUSPECT">>"%JTEMP%\SYSTASKS_H"
"%GREP%" -i -f "%JRT%\bl_tasks.cfg" "%JTEMP%\SYSTASKS_SUSPECT">>"%JTEMP%\SYSTASKS_H"
FC "%JTEMP%\SYSTASKS_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Services )
"%SORT_%" -f -u <"%JTEMP%\SYSTASKS_H" >"%JTEMP%\SYSTASKS_T"
for /f "usebackq delims=" %%i in ("%JTEMP%\SYSTASKS_T") do (
  SCHTASKS /DELETE /TN "%%i" /F >NUL 2>&1
  ECHO(Successfully deleted: "%SYS32%\Tasks\%%i" ^(Task^)>>"%JTEMP%\R_Files.txt"
)
:Services
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
Echo((****    )  Services
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
IF NOT EXIST %SYS32%\reg.exe GOTO :Files
REG QUERY HKLM\SYSTEM\CurrentControlSet\services 2>NUL|"%GREP%" -iP "ControlSet\\services\\[^\s]">"%JTEMP%\SERVICES"
"%SED%" -r "s:^HKEY_.*\\services\\::" <"%JTEMP%\SERVICES" >"%JTEMP%\SERVICES2"
"%GREP%" -i -v -x -f "%JRT%\wl_services.cfg" "%JTEMP%\SERVICES2">"%JTEMP%\SERVICES_SUSPECT"
FC "%JTEMP%\SERVICES_SUSPECT" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Files )
"%GREP%" -i -x -f "%JRT%\bl_services.cfg" "%JTEMP%\SERVICES_SUSPECT">"%JTEMP%\SERVICES_T"
FC "%JTEMP%\SERVICES_T" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Services_0 )
for /f "usebackq delims=" %%i in ("%JTEMP%\SERVICES_T") do (
 REG QUERY "HKLM\SYSTEM\CurrentControlSet\services\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\SYSTEM\CurrentControlSet\services\%%i" /F >NUL 2>&1
    REG QUERY "HKLM\SYSTEM\CurrentControlSet\services\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKLM\SYSTEM\CurrentControlSet\services\%%i" ^(Registry Key^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKLM\SYSTEM\CurrentControlSet\services\%%i" ^(Registry Key^)>>"%JTEMP%\R_Registry.txt" )
    )
)
:Services_0
"%GREP%" -P "^[a-z0-9]{4}m[a-z0-9]{2}2[a-z0-9]{4}b[a-z0-9]{2}$|^dg\d{3}$|^\d{15,17}mcinstcleanup$|^Updater Service for .* Toolbar$|^[a-z]{1,4}(?:fd|svc|drvr|srvc)_.*\d{1,2}(?:\.|_)\d{1,2}(?:\.|_)\d{1,2}(?:\.|_)\d{1,2}$|^[0-9a-f]{7,8}$|^wstlib.*|^vToolbarUpdater.*|^Service Mgr [A-Z]{1}.*|^Update Mgr [A-Z]{1}.*|^SPDRIVER_\d{1}\.\d{2}\.\d{1}\.\d{4}$|^MaintainerSvc\d{1}\.\d{2}\..*|^AppMgr\d{1}\.\d{2}\..*|^shopperz\d{5,}$|^groover\d{5,}$|^firstOffer\d{5,}$" "%JTEMP%\SERVICES_SUSPECT">"%JTEMP%\SERVICES_H"
"%GREP%" -i -P "^\{[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\}(?:gt|gt64|gw|gw64|t|t64|w|w64)$|^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12,13}$|^Wajam.*|^WebInstr.*|wstlib.*|^mintcast.*|^Shell&ServicesEngine.*|^NTSRV_?\d{8,}$|^hwopt_?\d{8,}$|^Media_Manager_?\d{8,}$|^clean_hrdwre_service_?\d{8,}$|^bigworldsearch_?\d{8,}$|^big(?:_|-)world(?:_|-)search_?\d{8,}$" "%JTEMP%\SERVICES_SUSPECT">>"%JTEMP%\SERVICES_H"
FC "%JTEMP%\SERVICES_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Services_1 )
for /f "usebackq delims=" %%i in ("%JTEMP%\SERVICES_H") do (
 REG QUERY "HKLM\SYSTEM\CurrentControlSet\services\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\SYSTEM\CurrentControlSet\services\%%i" /F >NUL 2>&1
    REG QUERY "HKLM\SYSTEM\CurrentControlSet\services\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKLM\SYSTEM\CurrentControlSet\services\%%i" ^(Registry Key^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKLM\SYSTEM\CurrentControlSet\services\%%i" ^(Registry Key^)>>"%JTEMP%\R_Registry.txt" )
    )
)
:Services_1
"%GREP%" -P "^[a-f0-9]{32}$" "%JTEMP%\SERVICES_SUSPECT">"%JTEMP%\SERVICES_Wajam"
FC "%JTEMP%\SERVICES_Wajam" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Services_2 )
for /f "usebackq delims=" %%i in ("%JTEMP%\SERVICES_Wajam") do (
  REG QUERY "HKLM\SYSTEM\CurrentControlSet\services\%%i" /v "ImagePath" 2>NUL|"%GREP%" -P "\\[Dd]rivers\\[a-f0-9]{32}\.sys|Program\sFiles(?:\\|\s\(x86\)\\)[a-f0-9]{32}\\[a-f0-9]{32}\.exe">>"%JTEMP%\Files_Wajam2" && ECHO %%i>>"%JTEMP%\SERVICES_Wajam2"
)
FC "%JTEMP%\SERVICES_Wajam2" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Services_2 )
for /f "usebackq delims=" %%i in ("%JTEMP%\SERVICES_Wajam2") do (
  REG DELETE "HKLM\SYSTEM\CurrentControlSet\services\%%i" /F >NUL 2>&1
  REG QUERY "HKLM\SYSTEM\CurrentControlSet\services\%%i" >NUL 2>&1
  IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKLM\SYSTEM\CurrentControlSet\services\%%i" ^(Registry Key^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKLM\SYSTEM\CurrentControlSet\services\%%i" ^(Registry Key^)>>"%JTEMP%\R_Registry.txt" )
)
:Services_2
:Services_3
:Services_4
:Files
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
Echo((*****   )  File System
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
for %%i in (
"%allusersprofile%\%computername%\%computername%.exe"
"%allusersprofile%\backup.exe"
"%allusersprofile%\displayswitch.exe"
"%allusersprofile%\duplicaterecord.js"
"%allusersprofile%\google\google chrome.exe"
"%allusersprofile%\hometask.exe"
"%allusersprofile%\mntemp"
"%allusersprofile%\origin\update.vbe"
"%allusersprofile%\registryreviver.exe"
"%allusersprofile%\start.exe"
"%allusersprofile%\windows 7\windows 7.exe"
"%allusersprofile%\windows 8.1\windows 8.1.exe"
"%allusersprofile%\windows 8\windows 8.exe"
"%allusersprofile%\windows vista\windows vista.exe"
"%allusersprofile%\windows xp\windows xp.exe"
"%allusersprofile%\wms.exe"
"%appdata%\avpro.exe"
"%appdata%\babmaint.exe"
"%appdata%\bsetter-own.exe"
"%appdata%\checkrun22find.exe"
"%appdata%\del.bat"
"%appdata%\fdm-setup.exe"
"%appdata%\fdmer.exe"
"%appdata%\microsoft\internet explorer\qipsearchbar.dll"
"%appdata%\microsoft\systemcertificates\vssvc.exe"
"%appdata%\microsoft\wstask.exe"
"%appdata%\speedrunnerslog.txt"
"%appdata%\updater\winupd.exe"
"%appdata%\wf.exe"
"%locala%\apps\2.\abril.exe"
"%locala%\chromeupdate.crx"
"%locala%\couponalertauto.exe"
"%locala%\google\chrome\user data\default\bprotector web data"
"%locala%\google\chrome\user data\default\bprotectorpreferences"
"%locala%\microsoft\extensions\extsetup.exe"
"%locala%\microsoft\extensions\safebrowser.exe"
"%locala%\msfix.exe"
"%locala%\proxy.log"
"%locala%\speedial.crx"
"%locala%\vol-flex"
"%locala%\wikiupdate.exe"
"%locala%\xc3000error.exe"
"%mydls%\apcsetupppro.exe"
"%mydls%\driverrepair_signed.exe"
"%mydls%\fix-my-pc-setup.exe"
"%mydocs%\1click.cfg"
"%programfiles%\adobe\wlrt1.exe"
"%programfiles%\google\chrome\application\chrome.bat"
"%programfiles%\google\chrome\application\emorhc.bat"
"%programfiles%\ieadsblocker.dll"
"%programfiles%\iis\iis.exe"
"%programfiles%\internet explorer\erolpxei.bat"
"%programfiles%\internet explorer\iexplore.bat"
"%programfiles%\internet explorer\internet.exe"
"%programfiles%\microsoft\sysnm.exe"
"%programfiles%\opera\arepo.bat"
"%programfiles%\opera\opera.bat"
"%programfiles%\prefs.js"
"%programfiles%\reference assemblies\microsoft\framework\v3.5\redistlist\syscomplus80.exe"
"%programfiles%\task host\taskhost.exe"
"%startup%\%username%.exe"
"%systemdrive%\a\wincheckfe.exe"
"%systemdrive%\chatzum_nt.exe"
"%systemdrive%\chromehplog.txt"
"%systemdrive%\clarainstaller.txt"
"%systemdrive%\domainblacklist.xml"
"%systemdrive%\end"
"%systemdrive%\user.js"
"%userprofile%\funshion.ini"
"%windir%\ads.js"
"%windir%\amdave64win.exe"
"%windir%\apppatch\apppatch64\vcldr64.dll"
"%windir%\apppatch\custom\custom64\{cf2797aa-b7ec-e311-8ed9-005056c00008}.sdb"
"%windir%\apppatch\custom\{8a4d5a43-c64a-45ab-bdf4-804fe18ceafd}.sdb"
"%windir%\apppatch\nbin\vc32loader.dll"
"%windir%\chp.exe"
"%windir%\chromebrowser.exe"
"%windir%\country"
"%windir%\couponprinter.ocx"
"%windir%\cygavb.exe"
"%windir%\default.cfg"
"%windir%\dvf.exe"
"%windir%\exentinfo.exe"
"%windir%\fiddlercore4.dll"
"%windir%\hgfs.sys"
"%windir%\initcvtr.bat"
"%windir%\keywords.txt"
"%windir%\kyq.dat"
"%windir%\launcher.exe"
"%windir%\lnx.dat"
"%windir%\lnx.exe"
"%windir%\mdvf.exe"
"%windir%\memupdate.exe"
"%windir%\mhg.dat"
"%windir%\mhg.exe"
"%windir%\mint.exe"
"%windir%\mlnx.exe"
"%windir%\mlwps.exe"
"%windir%\mmhg.exe"
"%windir%\mrzv.exe"
"%windir%\mstdcvtr.bat"
"%windir%\navigatorvph.txt"
"%windir%\patsearch.bin"
"%windir%\pgbmaf.exe"
"%windir%\plofgye"
"%windir%\popup_count.txt"
"%windir%\prleth.sys"
"%windir%\provider\updatertoolservice.exe"
"%windir%\pss\wandoujia_helper.lnk"
"%windir%\rcore.exe"
"%windir%\reimage.ini"
"%windir%\rzv.dat"
"%windir%\s.bat"
"%windir%\sc.bat"
"%windir%\screentk.sys"
"%windir%\searchkeeper.exe"
"%windir%\shost.bin"
"%windir%\soxe"
"%windir%\storegidfilter.sys"
"%windir%\svchost.exe"
"%windir%\sysfix.exe"
"%windir%\sysinfo.exe"
"%windir%\tempcoral.vbs"
"%windir%\updatesvc.exe"
"%windir%\version.ini"
"%windir%\version_navigator.txt"
"%windir%\verson_hawker.txt"
"%windir%\winfix.ini"
"%windir%\wininit.ini"
"%windir%\winload32.exe"
"%windir%\wuappl.exe"
"%windir%\zri.dat"
) DO (
      IF EXIST %%i (
                    DEL /F/Q %%i >NUL 2>&1
                    IF EXIST %%i ( ECHO(Failed to delete: %%i ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %%i ^(File^)>>"%JTEMP%\R_Files.txt" )
                   )             
)
for %%i in (
"%allusersprofile%\*detectpcmgrdllex*"
"%allusersprofile%\sectaskman\*safeguard*"
"%allusersprofile%\spl????.tmp"
"%allusersprofile%\system32\*safeguard*"
"%allusersprofile%\trz????.tmp"
"%appdata%\*.boostrap.log"
"%appdata%\*.installation.log"
"%appdata%\appdata*.bin"
"%appdata%\fe????.tmp"
"%drm%\??.tmp"
"%drm%\????.tmp"
"%drm%\????.tmp.dat"
"%locala%\*_uninst.exe"
"%locala%\*ns*.tmp*"
"%locala%\funmoods*"
"%locala%\google\chrome\user data\default\ext_*"
"%locala%\mysearchdial*"
"%locala%\volity.exe*"
"%locala%\windowssys*.exe"
"%programfiles%\gum????.tmp"
"%programfiles%\gut????.tmp"
"%programfiles%\mozilla firefox\browser\defaults\preferences\!vitruvian-*"
"%programfiles%\mozilla firefox\browser\searchplugins\*.js"
"%programfiles%\mozilla firefox\vitruvian-*"
"%programfiles%\svchost.exe"
"%public%\trz????.tmp"
"%systemdrive%\a\????????.bat"
"%systemdrive%\a\????????????????????.exe"
"%systemdrive%\a\internetport*.exe"
"%systemdrive%\users\default\trz???.tmp"
"%systemdrive%\users\default\trz????.tmp"
"%temp%\vitruvian-installer-*"
"%userprofile%\trz????.tmp"
"%userprofile%\desktop\*TweakBit *.lnk"
"%userprofile%\desktop\Continue *install*.lnk"
"%windir%\allpcoptimizer*"
) DO (
      IF EXIST %%i (
                    DEL /F/Q "%%i" >NUL 2>&1
                    IF EXIST %%i ( ECHO(Failed to delete: %%i ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %%i ^(File^)>>"%JTEMP%\R_Files.txt" )
                   )
)
for %%i in (
"%sys32%\${logfile}"
"%sys32%\adpeakproxy64.dll"
"%sys32%\basementdusteroff.ini"
"%sys32%\bh.dll"
"%sys32%\br media player.exe"
"%sys32%\brrotate.dll"
"%sys32%\codecs\updatechecker.exe"
"%sys32%\conduitengine.tmp"
"%sys32%\crtdll32.exe"
"%sys32%\dcadssuggest.dll"
"%sys32%\dds_trash_log.cmd"
"%sys32%\dmwu.exe"
"%sys32%\drivers\adpeakwfp64.sys"
"%sys32%\drivers\askprotect64.sys"
"%sys32%\drivers\blnetfilter.sys"
"%sys32%\drivers\bsdriver.sys"
"%sys32%\drivers\cherimoya.sys"
"%sys32%\drivers\contentdefenderdrv.sys"
"%sys32%\drivers\cygwin.sys"
"%sys32%\drivers\dgsafe.sys"
"%sys32%\drivers\filehiders.sys"
"%sys32%\drivers\fp.sys"
"%sys32%\drivers\gfilterdrv.sys"
"%sys32%\drivers\healusb.sys"
"%sys32%\drivers\isafenetfilter.sys"
"%sys32%\drivers\ncuponsdrv.sys"
"%sys32%\drivers\netfilter.sys"
"%sys32%\drivers\netfilter64.sys"
"%sys32%\drivers\nethfdrv.sys"
"%sys32%\drivers\nscp_cnb.sys"
"%sys32%\drivers\qknfd.sys"
"%sys32%\drivers\sdfhgdf.sys"
"%sys32%\drivers\sppd.sys"
"%sys32%\drivers\ssnfd.sys"
"%sys32%\drivers\swdumon.sys"
"%sys32%\drivers\tammgf119.sys"
"%sys32%\drivers\tammgr119.sys"
"%sys32%\drivers\taoaccelerator64.sys"
"%sys32%\drivers\taokernel64.sys"
"%sys32%\drivers\tfsfltx64.sys"
"%sys32%\drivers\udieo120.sys"
"%sys32%\drivers\votw864.sys"
"%sys32%\drivers\windivert64.sys"
"%sys32%\drivers\winpacket.pac"
"%sys32%\drivers\xieca120.sys"
"%sys32%\express\explorer.exe"
"%sys32%\ezsp_px.exe"
"%sys32%\f3pssavr.scr"
"%sys32%\fsearchbar.dll"
"%sys32%\funshion.ini"
"%sys32%\gfiltersvc.exe"
"%sys32%\grouppolicy\machine\r"
"%sys32%\grouppolicy\user\scripts\logon\appletide.exe"
"%sys32%\hfnapi.dll"
"%sys32%\hfpapi.dll"
"%sys32%\imhttpcomm.dll"
"%sys32%\kbdmai.dll"
"%sys32%\mrvcl32.exe"
"%sys32%\nethtsrv.exe"
"%sys32%\netupdsrv.exe"
"%sys32%\newsoft"
"%sys32%\nsx37.dll"
"%sys32%\pio12.dll"
"%sys32%\protector.dll"
"%sys32%\rqono.dll"
"%sys32%\sasnative32.exe"
"%sys32%\sasnative64.exe"
"%sys32%\spads.dll"
"%sys32%\windowspowershell\taskprocess.exe"
"%sys32%\wscm32.dll"
"%sys32%\wscm64.dll"
"%sys32%\wstart.dll"
"%sys32%\xmlprovi0.dll"
"%sys32%\yealt.dll"
"%sys32%\ysdzac23.dll"
"%sys32%\ysxja.exe"
"%sys32%\yuotubedownloader.xpi"
) DO (
      IF EXIST %%i (
                    DEL /F/Q %%i >NUL 2>&1
                    IF EXIST %%i ( ECHO(Failed to delete: %%i ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %%i ^(File^)>>"%JTEMP%\R_Files.txt" )
                   )             
)
for %%i in (
"%sys32%\000?????.tmp"
"%sys32%\cpuminer-*"
"%sys32%\drivers\msft_kernel_webtinstmktn*.wdf"
"%sys32%\drivers\webtinstmktn*.sys"
"%sys32%\ocl????.tmp"
"%sys32%\rad?????.tmp"
"%sys32%\ren????.tmp"
"%sys32%\roboot*"
"%sys32%\sho????.tmp"
"%sys32%\votprx*"
"%sys32%\xenwul*"
) DO (
      IF EXIST %%i (
                    DEL /F/Q "%%i" >NUL 2>&1
                    IF EXIST %%i ( ECHO(Failed to delete: %%i ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %%i ^(File^)>>"%JTEMP%\R_Files.txt" )
                   )
)
:: SysWOW64
ECHO %ARCH%|FIND "x64" >NUL
IF %ERRORLEVEL% NEQ 0 ( GOTO :PublicFiles )
for %%i in (
"%programw6432%\nsprotector.js"
"%syswow64%\adbcnsl.exe"
"%syswow64%\basementdusteroff.ini"
"%syswow64%\bh.dll"
"%syswow64%\brrotate.dll"
"%syswow64%\conduitengine.tmp"
"%syswow64%\crtdll32.exe"
"%syswow64%\dcadssuggest.dll"
"%syswow64%\dds_trash_log.cmd"
"%syswow64%\dmwu.exe"
"%syswow64%\drivers\adip58209xxc.sys"
"%syswow64%\drivers\alaperformance.ini"
"%syswow64%\drivers\dgsafe.sys"
"%syswow64%\drivers\eventlogman32.exe"
"%syswow64%\drivers\kvn398nryw.exe"
"%syswow64%\drivers\msconfigvm.exe"
"%syswow64%\drivers\ndsvmaheklaiea32r3.sys"
"%syswow64%\drivers\nkbyrnkdaklsys462.sys"
"%syswow64%\drivers\nvacyu3258b.exe"
"%syswow64%\drivers\rdtvdaslgmmsb32.sys"
"%syswow64%\drivers\svchost.exe"
"%syswow64%\drivers\sysdriver32l.exe"
"%syswow64%\drivers\tsskx64.sys"
"%syswow64%\drivers\umdf\en-us\eventlogman32.exe"
"%syswow64%\drivers\umdf\profileconfig2.exe"
"%syswow64%\drivers\wndvrt64.sys"
"%syswow64%\f3pssavr.scr"
"%syswow64%\findit.xml"
"%syswow64%\fsearchbar.dll"
"%syswow64%\funshion.ini"
"%syswow64%\gambali.dll"
"%syswow64%\get.dat"
"%syswow64%\gfiltersvc.exe"
"%syswow64%\hfnapi.dll"
"%syswow64%\hfpapi.dll"
"%syswow64%\imhttpcomm.dll"
"%syswow64%\lnsecsl.exe"
"%syswow64%\nethtsrv.exe"
"%syswow64%\netupdsrv.exe"
"%syswow64%\notepad8.dll"
"%syswow64%\nsx37.dll"
"%syswow64%\p5pssavr.scr"
"%syswow64%\pio12.dll"
"%syswow64%\protector.dll"
"%syswow64%\registryhelperlm.ocx"
"%syswow64%\rqono.dll"
"%syswow64%\spads.dll"
"%syswow64%\webmons.dll"
"%syswow64%\wstart.dll"
"%syswow64%\x64.txt"
"%syswow64%\xmlprovi0.dll"
"%syswow64%\yealt.dll"
"%syswow64%\ysdzac23.dll"
"%syswow64%\yuotubedownloader.xpi"
) DO (
      IF EXIST %%i (
                    DEL /F/Q %%i >NUL 2>&1
                    IF EXIST %%i ( ECHO(Failed to delete: %%i ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %%i ^(File^)>>"%JTEMP%\R_Files.txt" )
                   )             
)
for %%i in (
"%syswow64%\fap????.tmp"
"%syswow64%\ren????.tmp"
"%syswow64%\roboot*"
"%syswow64%\sho????.tmp"
"%syswow64%\votprx*"
"%syswow64%\xenwul*"
) DO (
      IF EXIST %%i (
                    DEL /F/Q "%%i" >NUL 2>&1
                    IF EXIST %%i ( ECHO(Failed to delete: %%i ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %%i ^(File^)>>"%JTEMP%\R_Files.txt" )
                   )
)
:PublicFiles
ECHO %OS%|FIND "Windows XP" >NUL
IF %ERRORLEVEL% EQU 0 ( GOTO :Drivers_Suspect )
for %%i in (
"%locallow%\microsoft\silverlight\outofbrowser\index\portal.qtrax.com"
"%locallow%\skwconfig.bin"
"%pubdocs%\updator.exe"
"%pubdocs%\windows.exe"
"%public%\asr.dat"
) DO (
      IF EXIST %%i (
                    DEL /F/Q %%i >NUL 2>&1
                    IF EXIST %%i ( ECHO(Failed to delete: %%i ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %%i ^(File^)>>"%JTEMP%\R_Files.txt" )
                   )             
)
:Drivers_Suspect
DIR /B/A:-D "%SYS32%\drivers\{????????-????-????-????-????????????}*.sys" 2>NUL>"%JTEMP%\DRIVERS_SUSPECT"
DIR /B/A:-D "%SYS32%\drivers\????m??2????b??.sys" 2>NUL>>"%JTEMP%\DRIVERS_SUSPECT"
DIR /B/A:-D "%SYS32%\drivers\n??3????m??????.sys" 2>NUL>>"%JTEMP%\DRIVERS_SUSPECT"
DIR /B/A:-D "%SYS32%\drivers\?*fd_?*_?*_?*_?*.sys" 2>NUL>>"%JTEMP%\DRIVERS_SUSPECT"
DIR /B/A:-D "%SYS32%\drivers\?*fd_v?_?*_?*_?*_?*.sys" 2>NUL>>"%JTEMP%\DRIVERS_SUSPECT"
DIR /B/A:-D "%SYS32%\drivers\?*drvr_v?_?*_?*_?*_?*.sys" 2>NUL>>"%JTEMP%\DRIVERS_SUSPECT"
FC "%JTEMP%\DRIVERS_SUSPECT" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :All1 )
"%GREP%" -P "^[a-z0-9]{4}m[a-z0-9]{2}2[a-z0-9]{4}b[a-z0-9]{2}\.sys$|^n[a-z0-9]{2}3[a-z0-9]{4}m[a-z0-9]{6}\.sys$|^[a-z]{1,4}(fd|drvr)_.*\d{1,2}_\d{1,2}_\d{1,2}_\d{1,2}\.sys$" "%JTEMP%\DRIVERS_SUSPECT">"%JTEMP%\DRIVERS_SUSPECT_H"
"%GREP%" -i -P "^\{[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\}(gt|gt64|gw|gw64|t|t64|w|w64)\.sys$" "%JTEMP%\DRIVERS_SUSPECT">>"%JTEMP%\DRIVERS_SUSPECT_H"
FC "%JTEMP%\DRIVERS_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :All1 )
for /f "usebackq delims=" %%i in ("%JTEMP%\DRIVERS_SUSPECT_H") do (
  DEL /F/Q "%SYS32%\Drivers\%%i" >NUL 2>&1
  IF EXIST "%SYS32%\Drivers\%%i" ( ECHO(Failed to delete: %SYS32%\Drivers\%%i ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %SYS32%\Drivers\%%i ^(File^)>>"%JTEMP%\R_Files.txt" )
)
:All1
for /f "usebackq delims=" %%i in ("%JRT%\bl_lnkfiles.cfg") do (
 DIR "%QUICKLAUNCHALL%\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%QUICKLAUNCHALL%\%%i" >NUL 2>&1
    DIR "%QUICKLAUNCHALL%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%QUICKLAUNCHALL%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%QUICKLAUNCHALL%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" )
    )
 DIR "%PROGRAMS1ALL%\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%PROGRAMS1ALL%\%%i" >NUL 2>&1
    DIR "%PROGRAMS1ALL%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%PROGRAMS1ALL%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%PROGRAMS1ALL%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" )
    )
 DIR "%PROGRAMS2ALL%\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%PROGRAMS2ALL%\%%i" >NUL 2>&1
    DIR "%PROGRAMS2ALL%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%PROGRAMS2ALL%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%PROGRAMS2ALL%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" )
    )
 DIR "%STARTUP%\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%STARTUP%\%%i" >NUL 2>&1
    DIR "%STARTUP%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%STARTUP%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%STARTUP%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" )
    )
 DIR "%userprofile%\Desktop\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%userprofile%\Desktop\%%i" >NUL 2>&1
    DIR "%userprofile%\Desktop\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%userprofile%\Desktop\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%userprofile%\Desktop\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" )
    )
)
:: Fake adobe license
cd /d "%windir%\Temp" >NUL 2>&1
for /d %%a in (
mrt????.tmp
) do (
  DIR "%windir%\temp\%%a\stdrt.exe" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    DEL /F/Q "%windir%\Temp\%%a\stdrt.exe" >NUL 2>&1
    DIR "%windir%\temp\%%a\stdrt.exe" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: %windir%\Temp\%%a\stdrt.exe ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: %windir%\Temp\%%a\stdrt.exe ^(File^)>>"%JTEMP%\R_Files.txt" )
    )
)
DIR /B/A:-D "%systemdrive%\awh*.tmp" 2>NUL>"%JTEMP%\SYSTEMDRIVE_F_SUSPECT"
"%GREP%" -P "^awh[0-9A-F]{3,4}\.tmp$" "%JTEMP%\SYSTEMDRIVE_F_SUSPECT">"%JTEMP%\SYSTEMDRIVE_F_SUSPECT_H"
FC "%JTEMP%\SYSTEMDRIVE_F_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :All2 )
for /f "usebackq delims=" %%i in ("%JTEMP%\SYSTEMDRIVE_F_SUSPECT_H") do (
  DEL /F/Q "%systemdrive%\%%i" >NUL 2>&1
  IF EXIST "%systemdrive%\%%i" ( ECHO(Failed to delete: %systemdrive%\%%i ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %systemdrive%\%%i ^(File^)>>"%JTEMP%\R_Files.txt" )
)
:All2
DIR /B/A:-D "%LOCALA%" 2>NUL>"%JTEMP%\LOCALA_F_SUSPECT"
"%GREP%" -P "^[0-9a-f]{32}$|^Tempdivx[0-9a-f]{4}$" "%JTEMP%\LOCALA_F_SUSPECT">"%JTEMP%\LOCALA_F_SUSPECT_H"
FC "%JTEMP%\LOCALA_F_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :All3 )
for /f "usebackq delims=" %%i in ("%JTEMP%\LOCALA_F_SUSPECT_H") do (
  DEL /F/Q "%LOCALA%\%%i" >NUL 2>&1
  IF EXIST "%LOCALA%\%%i" ( ECHO(Failed to delete: "%LOCALA%\%%i" ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: "%LOCALA%\%%i" ^(File^)>>"%JTEMP%\R_Files.txt" )
)
:All3
DIR /B/A:-D "%ALLUSERSPROFILE%\*.dat" 2>NUL>"%JTEMP%\ALLUSERSPROFILE_F_SUSPECT"
DIR /B/A:-D "%ALLUSERSPROFILE%\*.bin" 2>NUL>>"%JTEMP%\ALLUSERSPROFILE_F_SUSPECT"
"%GREP%" -P "^\d{10}\.bdinstall\.bin$|^\d{10}\.\d{3,4}\.bin$" "%JTEMP%\ALLUSERSPROFILE_F_SUSPECT">"%JTEMP%\ALLUSERSPROFILE_F_SUSPECT_H"
"%GREP%" -i -P "^\w{6,9}\.dat$" "%JTEMP%\ALLUSERSPROFILE_F_SUSPECT"|"%GREP%" -P "\d{1,}.*\d{1,}">>"%JTEMP%\ALLUSERSPROFILE_F_SUSPECT_H"
FC "%JTEMP%\ALLUSERSPROFILE_F_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :All4 )
for /f "usebackq delims=" %%i in ("%JTEMP%\ALLUSERSPROFILE_F_SUSPECT_H") do (
  DEL /F/Q "%ALLUSERSPROFILE%\%%i" >NUL 2>&1
  IF EXIST "%ALLUSERSPROFILE%\%%i" ( ECHO(Failed to delete: "%ALLUSERSPROFILE%\%%i" ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: "%ALLUSERSPROFILE%\%%i" ^(File^)>>"%JTEMP%\R_Files.txt" )
)
:All4
DIR /B/A:-D "%APPDATA%\*.exe" 2>NUL>"%JTEMP%\APPDATA_F_SUSPECT"
"%GREP%" -P "^[A-Z]{4,8}\.exe$|^BackUp\d{9}\.exe$|^~[a-z]{7}\.exe$" "%JTEMP%\APPDATA_F_SUSPECT">"%JTEMP%\APPDATA_F_SUSPECT_H"
FC "%JTEMP%\APPDATA_F_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :All5 )
for /f "usebackq delims=" %%i in ("%JTEMP%\APPDATA_F_SUSPECT_H") do (
  DEL /F/Q "%APPDATA%\%%i" >NUL 2>&1
  IF EXIST "%APPDATA%\%%i" ( ECHO(Failed to delete: "%APPDATA%\%%i" ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: "%APPDATA%\%%i" ^(File^)>>"%JTEMP%\R_Files.txt" )
)
:All5
DIR /B/A:-D "%STARTUP%\?.lnk" 2>NUL>"%JTEMP%\STARTUP_F_SUSPECT"
"%GREP%" -P "^[a-z]{1}\.lnk$" "%JTEMP%\STARTUP_F_SUSPECT">"%JTEMP%\STARTUP_F_SUSPECT_H"
FC "%JTEMP%\STARTUP_F_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :All6 )
for /f "usebackq delims=" %%i in ("%JTEMP%\STARTUP_F_SUSPECT_H") do (
  DEL /F/Q "%STARTUP%\%%i" >NUL 2>&1
  IF EXIST "%STARTUP%\%%i" ( ECHO(Failed to delete: "%STARTUP%\%%i" ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: "%STARTUP%\%%i" ^(File^)>>"%JTEMP%\R_Files.txt" )
)
:All6
DIR /B/S "%ALLUSERSPROFILE%\plugin.exe" 2>NUL>"%JTEMP%\PLUGIN_F_SUSPECT"
DIR /B/S "%ALLUSERSPROFILE%\plugincontainer.exe" 2>NUL>>"%JTEMP%\PLUGIN_F_SUSPECT"
"%GREP%" -P "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\\plugins\\\d{1,2}\\plugin\.exe$|[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\\plugincontainer\.exe$" "%JTEMP%\PLUGIN_F_SUSPECT">"%JTEMP%\PLUGIN_F_SUSPECT_H"
FC "%JTEMP%\PLUGIN_F_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :All7 )
for /f "usebackq delims=" %%i in ("%JTEMP%\PLUGIN_F_SUSPECT_H") do (
  DEL /F/Q "%%i" >NUL 2>&1
  IF EXIST "%%i" ( ECHO(Failed to delete: "%%i" ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: "%%i" ^(File^)>>"%JTEMP%\R_Files.txt" )
)
:All7
cd /d "%allusersprofile%" >NUL 2>&1
for /d %%a in (
a*c*t*i*v*e*d*e*a*l*s
a*d*b*l*o*c*k*e*r
a*d*b*l*o*c*k*n*w*a*t*c*h
a*d*d*i*c*t*-*t*h*i*n*g
a*d*d*t*o*t*h*i*s
a*l*a*w*a*r
a*l*l*c*h*e*a*p*p*r*i*c*e
a*l*l*d*a*y*p*r*i*c*e
a*l*l*d*a*y*s*a*v*i*n*g*s
a*l*l*d*e*a*l*s*a*p*p
a*l*l*s*a*v*e*r
a*p*p*e*n*d*r*u*n*n*e*r
a*p*p*s*a*v*e*
a*p*p*t*o*u
a*u*t*o*d*e*a*l*s*a*p*p
b*a*l*l*o*o*n*s*d*e*s*i*g*n
b*c*o*o*l
b*e*e*m*p*3
b*e*s*t*a*d*b*l*o*c*k*e*r
b*e*s*t*p*r*i*c*e*s*a*p*p
b*e*s*t*s*a*v*e*f*o*r*y*o*u
b*e*t*e*r*e*m
b*e*t*t*e*r*p*r*i*c*e*
b*e*t*t*e*r*s*h*o*p*p*e*r
b*i*g*d*e*a*l
b*i*o*c*u*r*e
b*i*t*s*a*v*e*r
b*l*o*c*k*t*h*e*a*d*a*p*p
b*l*o*c*k*u*t*u*b*e*a*d
b*r*o*w*s*e*2*s*a*v*e
b*r*o*w*s*e*a*n*d*s*h*o*p
b*r*o*w*s*e*r*e*n*h*a*n*c*e
b*r*o*w*s*e*r*s*h*o*p
b*r*o*w*s*e*t*o*b*u*y
b*r*o*w*s*e*t*o*s*a*v*e
b*r*o*w*s*i*n*g*c*l*e*a*r
b*r*o*w*s*i*n*g*c*l*e*a*r*l*y
b*s*a*v*i*n*g
b*u*y*a*n*d*b*r*o*w*s*e
b*u*y*f*a*s*t
b*u*y*n*s*a*v*e
c*h*e*a*p*4*a*l*l
c*h*e*a*p*c*o*u*p
c*h*e*a*p*m*e
c*h*o*o*s*e*2*s*a*v*e
c*l*e*a*r*b*r*o*w*s*e
c*l*i*c*k*2*s*a*v*e
c*l*i*c*k*f*o*r*s*a*l*e
c*l*i*c*k*s*a*v*i*n*g*s
c*o*d*e*c*-*c
c*o*d*e*c*-*v
c*o*d*e*c*c
c*o*d*e*c*v
c*o*i*n*s*a*v*e
c*o*m*f*y
c*o*m*p*a*r*e*b*u*y
c*o*m*p*a*r*e*i*t*a*p*p
c*o*m*p*a*r*e*i*t*a*p*p*l*i*c
c*o*m*p*a*r*e*t*o*o*p*t*i*m*i*z*e
c*o*n*t*i*n*u*e*t*o*s*a*v*e
c*o*n*v*e*r*t*m*e
c*o*o*l*n*c*h*e*a*p
c*o*o*l*y*o*u
c*o*s*t*m*i*n
c*o*u*p*a*p*p
c*o*u*p*c*o*u*p
c*o*u*p*e*x*t*e*n*s*i*o*n
c*o*u*p*m*a*n*i*a
c*o*u*p*s*c*a*n*n*e*r
c*o*u*p*s*e*e*k
c*o*u*p*y*o*u
c*r*a*z*y*l*o*w*p*r*i*c*e*s
c*u*r*r*e*n*c*y* c*o*n*v*e*r*t*e*r
c*u*t*t*h*e*p*r*i*c*e
d*a*i*l*e*y*p*r*i*z*e
d*a*i*l*y*p*r*i*z*e
d*e*a*l*2*d*e*a*l
d*e*a*l*2*d*e*a*l*i*t
d*e*a*l*4*m*e
d*e*a*l*4*r*e*a*l
d*e*a*l*e*x*p*r*e*s*s
d*e*a*l*n*o*d*e*a*l
d*e*a*l*p*e*a*k
d*e*a*l*p*l*u*g
d*e*a*l*s*f*i*n*d*e*r*p*r*o
d*e*a*l*s*p*a*c*e
d*e*a*l*s*t*a*r*a*p*p
d*e*a*l*s*t*e*r
d*i*g*i*s*a*v*e*r*
d*i*s*c*o*u*n*t*b*o*m*b
d*i*s*c*o*u*n*t*e*x*t*e*n*s*i*o*n
d*i*s*c*o*u*n*t*l*o*c*a*t*o*r
d*i*s*c*o*u*n*t*m*a*n
d*i*s*c*o*u*n*t*s*m*a*s*h*e*r
d*o*c*s*c*o*n*v*e*r*t*e*r
d*o*c*s*v*i*e*w*e*r
d*o*c*t*o*c*o*n*v*e*r*t*e*r
d*o*c*t*o*t*x*t*c*o*n*v*e*r*t
d*o*l*l*a*r*k*e*e*p*e*r
d*o*l*l*a*r*s*a*v*e*r
d*o*w*n*l*o*a*d*a*n*d*s*a
d*o*w*n*l*o*a*d*a*n*d*s*a*v*e
d*o*w*n*l*o*a*d*i*t*k*e*e*p
d*o*w*n*l*o*a*d*k*e*e*p*e*r
d*o*w*n*l*o*a*d*n*s*a*v*e
d*o*w*n*l*o*w*a*p*p
d*o*w*n*s*a*v*e
e*a*r*n*s*a*l*e
e*a*s*y*t*o*s*h*o*p
e*b*o*o*k*b*r*o*w*s*e
e*n*o*r*m*o*u*s*a*l*e*s
e*n*o*r*m*o*u*s*s*a*l*e*s
e*x*e*c*h*e*c*k*e*r
e*x*e*r*u*n*n*e*r
e*x*t*r*a*s*a*v*i*n*g
e*x*t*r*a*s*a*v*i*n*g*s
e*x*t*r*a*s*h*o*p*p*e*r
f*a*s*t*n*c*h*e*a*p
f*a*s*t*s*a*l*e
f*a*s*t*s*a*l*e*r
f*a*s*t*s*a*v*e
f*i*n*d*a*d*e*a*l
f*i*n*d*b*e*s*t*d*e*a*l
f*i*n*d*d*e*a*l*s*o*f*t
f*i*n*e*d*e*a*l*s*o*f*t
f*l*e*x*i*b*l*e*s*h*o*p*p*e*r
f*r*e*e*2*y*o*u
f*r*e*e*d*e*l*i*v*e*r*y
f*u*n*2*s*a*v*e
f*u*n*d*e*a*l*s
f*u*n*s*h*o*p*p*e*r
f*u*n*t*o*s*a*v*e
g*e*t*d*i*s*c*o*u*n*t*a*p*p
g*e*t*s*a*v*i*n
g*e*t*t*h*e*d*i*s*c*o*u*n*t
g*o*s*a*v*e
g*o*s*a*v*e*o
g*r*e*a*t*s*a*v*e*4*u
g*r*e*a*t*s*a*v*e*r
g*r*e*a*t*s*a*v*i*n*g
h*a*p*p*y*2*s*a*v*e
h*a*p*p*y*s*a*l*e*s
h*t*m*l*v*a*l*i*d*a*t*o*r
i*c*o*c*o*n*v*e*r*t*e*r
i*c*o*v*a*l*i*d
i*m*a*g*e*t*o*p*n*g
i*n*s*t*a*p*a*p*e*r
i*s*a*v*e*r
i*t*u*m*e*n
j*o*i*n*t*h*e*s*h*o*p
j*u*m*b*o*d*e*a*l*s
k*e*e*p*e*r*s*e*x*t
k*e*e*p*i*t*b*r*o*w*s*e
k*e*e*p*n*o*w
k*o*b*i
l*e*s*s*2*p*a*y
l*e*t*l*i*v*e
l*o*w*e*r*p*r*i*c*e*s
l*o*w*e*r*p*r*i*c*i*n*g
l*o*w*p*r*i*c*e*s
l*o*w*r*a*t*e
l*u*c*k*y*s*h*o*p*p*e*r
m*a*g*n*i*p*i*c
m*a*r*k*e*t*c*o*m*p*a*r*e
m*i*n*i*m*u*m*p*r*i*c*e
m*o*n*s*o*o*n*r*e*v*e*n*u*e
m*p*3*m*a*k*e*r
m*y*p*r*i*c*e*c*u*t
m*y*s*e*a*r*c*h
m*y*s*h*o*p*p*e*r
m*y*t*o*o*l*s
n*e*w*s*a*v*e*r
n*e*x*t*c*o*u*p
n*i*c*e*f*r*e*e
n*i*c*e*n*f*r*e*e
n*i*c*e*o*f*f*e*r*s
n*i*t*r*o*d*e*a*l*
n*o*n*o*i*z*e*b*r*o*w*s*e
o*f*f*e*r*a*p*p
o*f*f*e*r*d*e*a*l
o*f*f*e*r*p*o*p
o*f*f*e*r*s*a*l*e
o*f*f*e*r*s*o*f*t
o*n*l*i*n*e*l*o*w*d*e*a*l*s
o*n*l*i*n*e*s*h*o*p*p*i*n*g
o*p*t*o*n
o*u*t*c*o*m*e*o*p*t*i*m*i*z*e*r
p*a*g*e*a*r*c*h*i*v*e*r
p*c*a*p*p
p*d*f*v*i*e*w*e*r
p*i*c*k*n*s*a*v*e*i*t
p*l*u*g*s*t*e*r
p*n*g*t*o*p*p*t*c*o*n*v*e*r*t
p*o*p*d*e*a*l*s
p*p*t*c*h*e*c*k*e*r
p*r*i*c*e*c*h*o*p
p*r*i*c*e*d*o*w*n*l*o*a*d*e*r
p*r*i*c*e*k*e*e*p*e*r
p*r*i*c*e*l*e*s*s
p*r*i*c*e*m*i*n*u*s
p*r*o*s*h*o*p*p*e*r
p*s*d*c*h*e*c*k*e*r
p*s*d*t*o*p*n*g
q*u*i*c*k*s*h*o*p
q*u*i*c*k*v*i*e*w*e*r
r*a*n*d*o*m*p*r*i*c*e
r*e*a*l*d*e*a*l
r*e*g*u*l*a*r*d*e*a*l*s
r*e*m*o*v*e*t*h*e*a*d*a*p*p
r*e*s*p*e*c*t*s*a*l*e
r*i*g*h*t*c*o*n*v*e*r*t*e*r
r*i*v*a*l*c*o*u*p
r*o*b*o*s*a*v*e
r*o*b*o*s*a*v*e*r
r*o*c*k*a*p*p*s
r*o*c*k*e*t*d*e*a*l
r*o*c*k*e*t*s*a*l*e
r*o*y*a*l*s*h*o*p*p*e*r*a*p*p
s*a*f*e*r*w*e*b
s*a*f*e*s*a*v*e
s*a*f*e*w*e*b
s*a*l*e*c*h*e*c*k*e*r
s*a*l*e*o*f*f*e*r
s*a*l*e*p*l*u*s
s*a*l*e*p*r*i*z*e*
s*a*l*e*s*a*l*e*
s*a*l*e*s*c*h*e*c*k*e*r
s*a*l*e*s*m*a*g*n*e*t
s*a*v*e*a*s
s*a*v*e*b*o*x
s*a*v*e*b*y*c*l*i*c*k
s*a*v*e*c*l*i*c*k*e*r
s*a*v*e*e*x*t*e*n*s*i*o*n
s*a*v*e*i*n*s*h*o*p
s*a*v*e*i*t
s*a*v*e*i*t*k*e*e*p
s*a*v*e*k*e*e*p
s*a*v*e*l*o*t*s
s*a*v*e*m*a*s*s
s*a*v*e*n*e*t
s*a*v*e*n*e*w*a*p*p*z
s*a*v*e*n*o*w
s*a*v*e*n*s*h*a*r*e
s*a*v*e*o*n*m*a*c
s*a*v*e*r*a*d*d*o*n
s*a*v*e*r*b*o*x
s*a*v*e*r*e*x*t*e*n*s*i*o*n
s*a*v*e*r*n*e*t
s*a*v*e*r*p*r*o
s*a*v*e*s*a*f*e
s*a*v*e*s*h*a*r*e
s*a*v*e*w*e*b
s*a*v*i*n*g*t*o*y*o*u
s*a*v*i*n*s*h*o*p
s*e*a*r*c*h*-*n*e*w*t*a*b
s*e*a*r*c*h*n*e*w*t*a*b
s*h*o*p*b*r*a*i*n
s*h*o*p*d*r*o*p
s*h*o*p*e*a*s*y
s*h*o*p*n*c*o*m*p*a*r*e
s*h*o*p*o*p*t*i*m*i*z*e*r
s*h*o*p*p*e*r*m*a*s*t*e*r
s*h*o*p*p*i*l*a*t*i*o*n
s*h*o*p*p*i*n*g*c*h*i*p
s*h*o*p*p*i*n*g*d*e*a*l*f*a*c*t*o*r*y
s*h*o*p*p*i*n*g*h*e*l*p*e*r
s*h*o*p*s*h*o*p
s*h*o*w*-*p*a*s*s*w*o*r*d
s*k*y*p*e*m*o*t*i*c*o*n*s
s*m*a*r*t*c*o*m*p*a*r*e
s*m*o*o*t*h*v*i*e*w
s*o*f*t*c*o*u*p
s*o*f*t*s*a*f*e
s*p*a*c*e*o*f*f*e*r*s
s*t*u*d*e*n*t*p*s*y*c*h*o*m
s*u*r*f*a*n*d*k*e*e*p
s*u*r*f*e*r*s*s*a*v*e*r
s*u*r*f*k*e*e*p*i*t
t*a*b*a*l*l*c*o*n*v*e*r*t*e*r
t*a*b*l*e*c*o*n*v*e*r*t*e*r
t*a*b*l*e*v*i*e*w*e*r
t*a*k*e*i*t*c*h*e*a*p
t*a*k*e*s*h*o*p
t*h*e*b*f*l*i*x
t*he*b*l*o*c*k*e*r
t*i*n*y*w*a*l*l*e*t
t*o*p*b*u*y*e*r
t*o*p*d*e*a*l
t*o*y*o*t*a
t*r*e*m*e*n*d*o*u*s*s*a*l*e
t*u*b*e*a*d*b*l*o*c*k*e*r
t*u*b*e*i*t*a*d*b*l*o*c*k*a*p
t*x*t*f*i*l*e*s*c*o*n*v*e*r*t
u*a*d*r*e*m*o*v*a*l*a*p*p
u*n*i*d*e*a*l*s
u*n*i*s*a*l*e*s
u*t*u*b*e*a*d*b*l*o*c*k
u*t*u*b*e*a*d*r*e*m*o*v*a*l
u*t*u*b*e*n*o*a*d*s
v*a*u*d*i*x
v*i*e*w*p*a*s*s*w*o*r*d
w*a*t*c*h*i*t*a*d*b*l*o*c*k
w*e*b*b*i*n*g
w*e*b*s*a*v*e
w*e*b*s*a*v*e*r
w*e*e*k*a*p*p
w*h*i*t*e*d*e*a*l*s
w*h*i*t*e*o*f*f*e*r*a*p*p
w*x*d*f*a*s*t
w*x*d*o*w*n*l*o*a*d
y*a*e*l*e*r*l*i*c*h
y*o*u*t*u*b*e*a*d*b*l*o*c*k*e*r
y*o*u*t*u*b*e*a*d*r*e*m*o*v*e
) do (
      if exist "%%a" (
                      dir "%allusersprofile%\%%a\*.tlb" >NUL 2>&1
	              IF NOT ERRORLEVEL 1 (
			                   rd /s/q "%allusersprofile%\%%a" >NUL 2>&1
                                           dir "%allusersprofile%\%%a" >NUL 2>&1
                                           IF ERRORLEVEL 1 (
                                                            Echo(Successfully deleted: %allusersprofile%\%%a ^(Folder^)>>"%JTEMP%\R_Files.txt"
                                                           ) else (
                                                                   Echo(Failed to delete: %allusersprofile%\%%a ^(Folder^)>>"%JTEMP%\R_Files.txt"
                                                                  )
                                          )
                     )
)
cd /d "%programfiles%" >NUL 2>&1
for /d %%a in (
a*c*t*i*v*e*d*e*a*l*s
a*d*b*l*o*c*k*e*r
a*d*b*l*o*c*k*n*w*a*t*c*h
a*d*d*i*c*t*-*t*h*i*n*g
a*d*d*t*o*t*h*i*s
a*l*a*w*a*r
a*l*l*c*h*e*a*p*p*r*i*c*e
a*l*l*d*a*y*p*r*i*c*e
a*l*l*d*a*y*s*a*v*i*n*g*s
a*l*l*d*e*a*l*s*a*p*p
a*l*l*s*a*v*e*r
a*p*p*e*n*d*r*u*n*n*e*r
a*p*p*s*a*v*e*
a*p*p*t*o*u
a*u*t*o*d*e*a*l*s*a*p*p
b*a*l*l*o*o*n*s*d*e*s*i*g*n
b*c*o*o*l
b*e*e*m*p*3
b*e*s*t*a*d*b*l*o*c*k*e*r
b*e*s*t*p*r*i*c*e*s*a*p*p
b*e*s*t*s*a*v*e*f*o*r*y*o*u
b*e*t*e*r*e*m
b*e*t*t*e*r*p*r*i*c*e*
b*e*t*t*e*r*s*h*o*p*p*e*r
b*i*g*d*e*a*l
b*i*o*c*u*r*e
b*i*t*s*a*v*e*r
b*l*o*c*k*t*h*e*a*d*a*p*p
b*l*o*c*k*u*t*u*b*e*a*d
b*r*o*w*s*e*2*s*a*v*e
b*r*o*w*s*e*a*n*d*s*h*o*p
b*r*o*w*s*e*r*e*n*h*a*n*c*e
b*r*o*w*s*e*r*s*h*o*p
b*r*o*w*s*e*t*o*b*u*y
b*r*o*w*s*e*t*o*s*a*v*e
b*r*o*w*s*i*n*g*c*l*e*a*r
b*r*o*w*s*i*n*g*c*l*e*a*r*l*y
b*s*a*v*i*n*g
b*u*y*a*n*d*b*r*o*w*s*e
b*u*y*f*a*s*t
b*u*y*n*s*a*v*e
c*h*e*a*p*4*a*l*l
c*h*e*a*p*c*o*u*p
c*h*e*a*p*m*e
c*h*o*o*s*e*2*s*a*v*e
c*l*e*a*r*b*r*o*w*s*e
c*l*i*c*k*2*s*a*v*e
c*l*i*c*k*f*o*r*s*a*l*e
c*l*i*c*k*s*a*v*i*n*g*s
c*o*d*e*c*-*c
c*o*d*e*c*-*v
c*o*d*e*c*c
c*o*d*e*c*v
c*o*i*n*s*a*v*e
c*o*m*f*y
c*o*m*p*a*r*e*b*u*y
c*o*m*p*a*r*e*i*t*a*p*p
c*o*m*p*a*r*e*i*t*a*p*p*l*i*c
c*o*m*p*a*r*e*t*o*o*p*t*i*m*i*z*e
c*o*n*t*i*n*u*e*t*o*s*a*v*e
c*o*n*v*e*r*t*m*e
c*o*o*l*n*c*h*e*a*p
c*o*o*l*y*o*u
c*o*s*t*m*i*n
c*o*u*p*a*p*p
c*o*u*p*c*o*u*p
c*o*u*p*e*x*t*e*n*s*i*o*n
c*o*u*p*m*a*n*i*a
c*o*u*p*s*c*a*n*n*e*r
c*o*u*p*s*e*e*k
c*o*u*p*y*o*u
c*r*a*z*y*l*o*w*p*r*i*c*e*s
c*u*r*r*e*n*c*y* c*o*n*v*e*r*t*e*r
c*u*t*t*h*e*p*r*i*c*e
d*a*i*l*e*y*p*r*i*z*e
d*a*i*l*y*p*r*i*z*e
d*e*a*l*2*d*e*a*l
d*e*a*l*2*d*e*a*l*i*t
d*e*a*l*4*m*e
d*e*a*l*4*r*e*a*l
d*e*a*l*e*x*p*r*e*s*s
d*e*a*l*n*o*d*e*a*l
d*e*a*l*p*e*a*k
d*e*a*l*p*l*u*g
d*e*a*l*s*f*i*n*d*e*r*p*r*o
d*e*a*l*s*p*a*c*e
d*e*a*l*s*t*a*r*a*p*p
d*e*a*l*s*t*e*r
d*i*g*i*s*a*v*e*r*
d*i*s*c*o*u*n*t*b*o*m*b
d*i*s*c*o*u*n*t*e*x*t*e*n*s*i*o*n
d*i*s*c*o*u*n*t*l*o*c*a*t*o*r
d*i*s*c*o*u*n*t*m*a*n
d*i*s*c*o*u*n*t*s*m*a*s*h*e*r
d*o*c*s*c*o*n*v*e*r*t*e*r
d*o*c*s*v*i*e*w*e*r
d*o*c*t*o*c*o*n*v*e*r*t*e*r
d*o*c*t*o*t*x*t*c*o*n*v*e*r*t
d*o*l*l*a*r*k*e*e*p*e*r
d*o*l*l*a*r*s*a*v*e*r
d*o*w*n*l*o*a*d*a*n*d*s*a
d*o*w*n*l*o*a*d*a*n*d*s*a*v*e
d*o*w*n*l*o*a*d*i*t*k*e*e*p
d*o*w*n*l*o*a*d*k*e*e*p*e*r
d*o*w*n*l*o*a*d*n*s*a*v*e
d*o*w*n*l*o*w*a*p*p
d*o*w*n*s*a*v*e
e*a*r*n*s*a*l*e
e*a*s*y*t*o*s*h*o*p
e*b*o*o*k*b*r*o*w*s*e
e*n*o*r*m*o*u*s*a*l*e*s
e*n*o*r*m*o*u*s*s*a*l*e*s
e*x*e*c*h*e*c*k*e*r
e*x*e*r*u*n*n*e*r
e*x*t*r*a*s*a*v*i*n*g
e*x*t*r*a*s*a*v*i*n*g*s
e*x*t*r*a*s*h*o*p*p*e*r
f*a*s*t*n*c*h*e*a*p
f*a*s*t*s*a*l*e
f*a*s*t*s*a*l*e*r
f*a*s*t*s*a*v*e
f*i*n*d*a*d*e*a*l
f*i*n*d*b*e*s*t*d*e*a*l
f*i*n*d*d*e*a*l*s*o*f*t
f*i*n*e*d*e*a*l*s*o*f*t
f*l*e*x*i*b*l*e*s*h*o*p*p*e*r
f*r*e*e*2*y*o*u
f*r*e*e*d*e*l*i*v*e*r*y
f*u*n*2*s*a*v*e
f*u*n*d*e*a*l*s
f*u*n*s*h*o*p*p*e*r
f*u*n*t*o*s*a*v*e
g*e*t*d*i*s*c*o*u*n*t*a*p*p
g*e*t*s*a*v*i*n
g*e*t*t*h*e*d*i*s*c*o*u*n*t
g*o*s*a*v*e
g*o*s*a*v*e*o
g*r*e*a*t*s*a*v*e*4*u
g*r*e*a*t*s*a*v*e*r
g*r*e*a*t*s*a*v*i*n*g
h*a*p*p*y*2*s*a*v*e
h*a*p*p*y*s*a*l*e*s
h*t*m*l*v*a*l*i*d*a*t*o*r
i*c*o*c*o*n*v*e*r*t*e*r
i*c*o*v*a*l*i*d
i*m*a*g*e*t*o*p*n*g
i*n*s*t*a*p*a*p*e*r
i*s*a*v*e*r
i*t*u*m*e*n
j*o*i*n*t*h*e*s*h*o*p
j*u*m*b*o*d*e*a*l*s
k*e*e*p*e*r*s*e*x*t
k*e*e*p*i*t*b*r*o*w*s*e
k*e*e*p*n*o*w
k*o*b*i
l*e*s*s*2*p*a*y
l*e*t*l*i*v*e
l*o*w*e*r*p*r*i*c*e*s
l*o*w*e*r*p*r*i*c*i*n*g
l*o*w*p*r*i*c*e*s
l*o*w*r*a*t*e
l*u*c*k*y*s*h*o*p*p*e*r
m*a*g*n*i*p*i*c
m*a*r*k*e*t*c*o*m*p*a*r*e
m*i*n*i*m*u*m*p*r*i*c*e
m*o*n*s*o*o*n*r*e*v*e*n*u*e
m*p*3*m*a*k*e*r
m*y*p*r*i*c*e*c*u*t
m*y*s*e*a*r*c*h
m*y*s*h*o*p*p*e*r
m*y*t*o*o*l*s
n*e*w*s*a*v*e*r
n*e*x*t*c*o*u*p
n*i*c*e*f*r*e*e
n*i*c*e*n*f*r*e*e
n*i*c*e*o*f*f*e*r*s
n*i*t*r*o*d*e*a*l*
n*o*n*o*i*z*e*b*r*o*w*s*e
o*f*f*e*r*a*p*p
o*f*f*e*r*d*e*a*l
o*f*f*e*r*p*o*p
o*f*f*e*r*s*a*l*e
o*f*f*e*r*s*o*f*t
o*n*l*i*n*e*l*o*w*d*e*a*l*s
o*n*l*i*n*e*s*h*o*p*p*i*n*g
o*p*t*o*n
o*u*t*c*o*m*e*o*p*t*i*m*i*z*e*r
p*a*g*e*a*r*c*h*i*v*e*r
p*c*a*p*p
p*d*f*v*i*e*w*e*r
p*i*c*k*n*s*a*v*e*i*t
p*l*u*g*s*t*e*r
p*n*g*t*o*p*p*t*c*o*n*v*e*r*t
p*o*p*d*e*a*l*s
p*p*t*c*h*e*c*k*e*r
p*r*i*c*e*c*h*o*p
p*r*i*c*e*d*o*w*n*l*o*a*d*e*r
p*r*i*c*e*k*e*e*p*e*r
p*r*i*c*e*l*e*s*s
p*r*i*c*e*m*i*n*u*s
p*r*o*s*h*o*p*p*e*r
p*s*d*c*h*e*c*k*e*r
p*s*d*t*o*p*n*g
q*u*i*c*k*s*h*o*p
q*u*i*c*k*v*i*e*w*e*r
r*a*n*d*o*m*p*r*i*c*e
r*e*a*l*d*e*a*l
r*e*g*u*l*a*r*d*e*a*l*s
r*e*m*o*v*e*t*h*e*a*d*a*p*p
r*e*s*p*e*c*t*s*a*l*e
r*i*g*h*t*c*o*n*v*e*r*t*e*r
r*i*v*a*l*c*o*u*p
r*o*b*o*s*a*v*e
r*o*b*o*s*a*v*e*r
r*o*c*k*a*p*p*s
r*o*c*k*e*t*d*e*a*l
r*o*c*k*e*t*s*a*l*e
r*o*y*a*l*s*h*o*p*p*e*r*a*p*p
s*a*f*e*r*w*e*b
s*a*f*e*s*a*v*e
s*a*f*e*w*e*b
s*a*l*e*c*h*e*c*k*e*r
s*a*l*e*o*f*f*e*r
s*a*l*e*p*l*u*s
s*a*l*e*p*r*i*z*e*
s*a*l*e*s*a*l*e*
s*a*l*e*s*c*h*e*c*k*e*r
s*a*l*e*s*m*a*g*n*e*t
s*a*v*e*a*s
s*a*v*e*b*o*x
s*a*v*e*b*y*c*l*i*c*k
s*a*v*e*c*l*i*c*k*e*r
s*a*v*e*e*x*t*e*n*s*i*o*n
s*a*v*e*i*n*s*h*o*p
s*a*v*e*i*t
s*a*v*e*i*t*k*e*e*p
s*a*v*e*k*e*e*p
s*a*v*e*l*o*t*s
s*a*v*e*m*a*s*s
s*a*v*e*n*e*t
s*a*v*e*n*e*w*a*p*p*z
s*a*v*e*n*o*w
s*a*v*e*n*s*h*a*r*e
s*a*v*e*o*n*m*a*c
s*a*v*e*r*a*d*d*o*n
s*a*v*e*r*b*o*x
s*a*v*e*r*e*x*t*e*n*s*i*o*n
s*a*v*e*r*n*e*t
s*a*v*e*r*p*r*o
s*a*v*e*s*a*f*e
s*a*v*e*s*h*a*r*e
s*a*v*e*w*e*b
s*a*v*i*n*g*t*o*y*o*u
s*a*v*i*n*s*h*o*p
s*e*a*r*c*h*-*n*e*w*t*a*b
s*e*a*r*c*h*n*e*w*t*a*b
s*h*o*p*b*r*a*i*n
s*h*o*p*d*r*o*p
s*h*o*p*e*a*s*y
s*h*o*p*n*c*o*m*p*a*r*e
s*h*o*p*o*p*t*i*m*i*z*e*r
s*h*o*p*p*e*r*m*a*s*t*e*r
s*h*o*p*p*i*l*a*t*i*o*n
s*h*o*p*p*i*n*g*c*h*i*p
s*h*o*p*p*i*n*g*d*e*a*l*f*a*c*t*o*r*y
s*h*o*p*p*i*n*g*h*e*l*p*e*r
s*h*o*p*s*h*o*p
s*h*o*w*-*p*a*s*s*w*o*r*d
s*k*y*p*e*m*o*t*i*c*o*n*s
s*m*a*r*t*c*o*m*p*a*r*e
s*m*o*o*t*h*v*i*e*w
s*o*f*t*c*o*u*p
s*o*f*t*s*a*f*e
s*p*a*c*e*o*f*f*e*r*s
s*t*u*d*e*n*t*p*s*y*c*h*o*m
s*u*r*f*a*n*d*k*e*e*p
s*u*r*f*e*r*s*s*a*v*e*r
s*u*r*f*k*e*e*p*i*t
t*a*b*a*l*l*c*o*n*v*e*r*t*e*r
t*a*b*l*e*c*o*n*v*e*r*t*e*r
t*a*b*l*e*v*i*e*w*e*r
t*a*k*e*i*t*c*h*e*a*p
t*a*k*e*s*h*o*p
t*h*e*b*f*l*i*x
t*he*b*l*o*c*k*e*r
t*i*n*y*w*a*l*l*e*t
t*o*p*b*u*y*e*r
t*o*p*d*e*a*l
t*o*y*o*t*a
t*r*e*m*e*n*d*o*u*s*s*a*l*e
t*u*b*e*a*d*b*l*o*c*k*e*r
t*u*b*e*i*t*a*d*b*l*o*c*k*a*p
t*x*t*f*i*l*e*s*c*o*n*v*e*r*t
u*a*d*r*e*m*o*v*a*l*a*p*p
u*n*i*d*e*a*l*s
u*n*i*s*a*l*e*s
u*t*u*b*e*a*d*b*l*o*c*k
u*t*u*b*e*a*d*r*e*m*o*v*a*l
u*t*u*b*e*n*o*a*d*s
v*a*u*d*i*x
v*i*e*w*p*a*s*s*w*o*r*d
w*a*t*c*h*i*t*a*d*b*l*o*c*k
w*e*b*b*i*n*g
w*e*b*s*a*v*e
w*e*b*s*a*v*e*r
w*e*e*k*a*p*p
w*h*i*t*e*d*e*a*l*s
w*h*i*t*e*o*f*f*e*r*a*p*p
w*x*d*f*a*s*t
w*x*d*o*w*n*l*o*a*d
y*a*e*l*e*r*l*i*c*h
y*o*u*t*u*b*e*a*d*b*l*o*c*k*e*r
y*o*u*t*u*b*e*a*d*r*e*m*o*v*e
) do (
      if exist "%%a" (
	              set "line=%%a"
                      setlocal EnableDelayedExpansion
                      dir "!programfiles!\!line!\*.tlb" >NUL 2>&1
                      IF NOT ERRORLEVEL 1 (
                                           rd /s/q "!programfiles!\!line!" >NUL 2>&1
                                           dir "!programfiles!\!line!" >NUL 2>&1
                                           IF ERRORLEVEL 1 (
						            Echo(Successfully deleted: "!programfiles!\!line!" ^(Folder^)>>"!JTEMP!\R_Files.txt"
                                                           ) else (
                                                                   Echo(Failed to delete: "!programfiles!\!line!" ^(Folder^)>>"!JTEMP!\R_Files.txt"
                                                                  )
                                          )
                     )
		      endlocal
)
cd /d "%programfiles%" >NUL 2>&1
for /d %%a in (
"advanced system optimizer*"
"bucksbee loyalty plugin*"
"cinem* plus*"
"com notifications*"
"freeven*"
"ftdownloader*"
"hd cinema*"
"hd plus*"
"hdv*"
"hq-video*"
"hqcinema*"
"mixidj*"
"mybrowser*v*"
"optimizer pro*"
"oryte*"
"plus-hd*"
"pricora*"
"savepass*"
"WinZip Driver Updater*"
"shop to win*"
"shopperreport*"
"speed test*"
"speedanalysis*"
"speedtest*"
"superplusradio*"
"sweetpacks*"
"toolbar*"
"torntv*"
"videos_mediaplayers*"
"wse_*"
"xvidly*"
*hohobnd*
00000000-0000-0000-0000-000000000000
arudaenttibiward*
atabugh*
blekkotb*
bowdomphocather*
browserv*
cinema_plus*
cinemaplus*
cineplus*
cinplus_*
ciplus-*
cknather*
cladikchhose*
clagosemerzos*
cleversearch*
dpcc_??_*
dply_??_*
efas_??_*
eorezo*
freeven*
fst_??_*
ftdownloader*
gititysabpy*
gmsd_??_*
gohd*
gtfpoquott*
hd-quality*
hdqual-*
hofight
hq-video*
infonaut*
keybar*
linkwiz*
maintenance software
majtuto4pc_??_*
maxcomputercleaner*
mbot_??_*
mediaplayervid*
mediawatchv*
mixidj*
mlekgrocach*
mpck_??_*
oasi_??_*
oryte*
ospd_??_*
phrasefinder*
phraseprofessor*
platoward*
plus-hd*
pricora*
quickref*
quicksurf*
rapidreader*
rec_??_*
reucition*
savepass*
shociph*
shopperreport*
shopperz*
shuqogeclaale*
spacesondpro*
speedanalysis*
speedtest*
stv_??_*
sunnyday?
superclick_*
superplusradio*
sweetpacks*
swiftsearch*
termblazer*
termtrident*
terpotion*
tiqichqehile*
toolbar*
torntv*
tuto4pc_??_*
updater1*
updater2*
upfst_??_*
upgmsd_??_*
ver*blockandsurf*
ver*speeditup*
version*checkmeup*
version*ineedspeed
videoplayerv*
videos_mediaplayers*
win_??_*
wordanchor*
wordfly*
wordinator*
wordshark*
wordwizard*
wse_*
wutaingjlaph*
xvidly*
yessearches-*
zmghtnaduse*
) do (
      if exist %%a (
	            set "line=%%a"
                    setlocal EnableDelayedExpansion
                    dir "!programfiles!\!line!" >NUL 2>&1
	            IF NOT ERRORLEVEL 1 (
                                         rd /s/q "!programfiles!\!line!" >NUL 2>&1
                                         dir "!programfiles!\!line!" >NUL 2>&1
                                         IF ERRORLEVEL 1 (
				                  	  Echo(Successfully deleted: "!programfiles!\!line!" ^(Folder^)>>"!JTEMP!\R_Files.txt"
                                                         ) else (
                                                                 Echo(Failed to delete: "!programfiles!\!line!" ^(Folder^)>>"!JTEMP!\R_Files.txt"
                                                                )
                                        )
                   )
		   endlocal
)
cd /d "%APPDATA%" >NUL 2>&1
for /d %%a in (
FCTB*
MarketSamurai*
) do (
      if exist %%a (
                    DIR "%APPDATA%\%%a" >NUL 2>&1
	            IF NOT ERRORLEVEL 1 (
                                         RD /S/Q "%APPDATA%\%%a" >NUL 2>&1
                                         DIR "%APPDATA%\%%a" >NUL 2>&1
                                         IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%APPDATA%\%%a" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%APPDATA%\%%a" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
                                        )
                   )
)
cd /d "%LOCALA%" >NUL 2>&1
for /d %%a in (
bitoptimiser??
cinplus_*
csdi_monetize*
destinyhoroscopes*
dpcc_??_*
dply_??_*
drive_backup\driverpro.exe_url_*
efas_??_*
eorezo_??_*
fst_??_*
gmsd_??_*
majtuto4pc_??_*
mbot_??_*
mpck_??_*
oasi_??_*
one10_pc_cleaner*
ospd_??_*
pcmaticplus*
rec_??_*
stv_??_*
sunny?
tuto4pc_??_*
tuto_monetize*
upfst_??_*
upgmsd_??_*
win_??_*
yayzap*
) do (
      if exist %%a (
                    DIR "%LOCALA%\%%a" >NUL 2>&1
	            IF NOT ERRORLEVEL 1 (
                                         RD /S/Q "%LOCALA%\%%a" >NUL 2>&1
                                         DIR "%LOCALA%\%%a" >NUL 2>&1
                                         IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%LOCALA%\%%a" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%LOCALA%\%%a" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
                                        )
                   )
)
cd /d "%LOCALA%" >NUL 2>&1
for /d %%a in (
????????-??????????-????-????-????????????
) do (
      dir "%LOCALA%\%%a\*ns*.tmp*" >NUL 2>&1
      IF NOT ERRORLEVEL 1 (
                           RD /S/Q "%LOCALA%\%%a" >NUL 2>&1
                           DIR "%LOCALA%\%%a" >NUL 2>&1
                           IF ERRORLEVEL 1 (
                                            Echo(Successfully deleted: "%LOCALA%\%%a" ^(Folder^)>>"%JTEMP%\R_Files.txt"
                                           ) else (
                                                   Echo(Failed to delete: "%LOCALA%\%%a" ^(Folder^)>>"%JTEMP%\R_Files.txt"
                                                  )
                          )
)
DIR /B/A:D "%APPDATA%" 2>NUL>"%JTEMP%\APPDATA_D_SUSPECT"
"%GREP%" -P "^newSI_\d{1,5}$|^\d{4}$|^StormFall\d{3}$|^TheSettlersOnline\d{3}$|^Pirates\d{3}$|^InfiniteCrisis\d{3}$|^WorldofTanks\d{3}$|^n[a-z0-9]{2}3[a-z0-9]{4}m[a-z0-9]{6}$|^[a-z0-9]{4}m[a-z0-9]{2}2[a-z0-9]{4}b[a-z]{2}$|^uiksdl\d{7,}$" "%JTEMP%\APPDATA_D_SUSPECT">"%JTEMP%\APPDATA_D_SUSPECT_H"
"%GREP%" -i -P "^(0|1)\w{1}1\w{1}1\w{5}1.*" "%JTEMP%\APPDATA_D_SUSPECT">>"%JTEMP%\APPDATA_D_SUSPECT_H"
FC "%JTEMP%\APPDATA_D_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :All8 )
for /f "usebackq delims=" %%i in ("%JTEMP%\APPDATA_D_SUSPECT_H") do (
  RD /S/Q "%APPDATA%\%%i" >NUL 2>&1
  IF EXIST "%APPDATA%\%%i" ( ECHO(Failed to delete: "%APPDATA%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: "%APPDATA%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
)
:All8
DIR /B/A:D "%ALLUSERSPROFILE%" 2>NUL>"%JTEMP%\ALLUSERSPROFILE_D_SUSPECT"
"%GREP%" -P "^\d{18,20}$|^[0-9a-f]{16,40}$|^\d{6}$|^Avg_Update_\d{4}av$|^Service\d{4}$|^\d{20}[A-Z]{2}$|^[A-Za-z0-9]{1}WinManPro[A-Za-z0-9]{1}$|^[A-Za-z0-9]{1}WdsManPro[A-Za-z0-9]{1}$|^[A-Za-z0-9]{1}MiniPro[A-Za-z0-9]{1}$|^[a-p]{32}$|^MaintainerSvc\d{1}\.\d{2}\..*|^AppMgr\d{1}\.\d{2}\..*|^uiksdl\d{7,}$|^\{?[a-f0-9]{8}-[a-f0-9]{4}-\d{1}\}?$|^[a-f0-9]{8}$" "%JTEMP%\ALLUSERSPROFILE_D_SUSPECT">"%JTEMP%\ALLUSERSPROFILE_D_SUSPECT_H"
FC "%JTEMP%\ALLUSERSPROFILE_D_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :All9 )
for /f "usebackq delims=" %%i in ("%JTEMP%\ALLUSERSPROFILE_D_SUSPECT_H") do (
  RD /S/Q "%ALLUSERSPROFILE%\%%i" >NUL 2>&1
  IF EXIST "%ALLUSERSPROFILE%\%%i" ( ECHO(Failed to delete: "%ALLUSERSPROFILE%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: "%ALLUSERSPROFILE%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
)
:All9
DIR /B/A:D "%LOCALA%" 2>NUL>"%JTEMP%\LOCALA_D_SUSPECT"
"%GREP%" -P "^\d{4,5}$|^ava(a|b)v[a-z]{2}v[a-z]{1,3}$|^n[a-z0-9]{2}3[a-z0-9]{4}m[a-z0-9]{6}$|^[a-z0-9]{4}m[a-z0-9]{2}2[a-z0-9]{4}b[a-z]{2}$|^bvxvy(x|v)[a-z]{1,}$" "%JTEMP%\LOCALA_D_SUSPECT">"%JTEMP%\LOCALA_D_SUSPECT_H"
FC "%JTEMP%\LOCALA_D_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :All10 )
for /f "usebackq delims=" %%i in ("%JTEMP%\LOCALA_D_SUSPECT_H") do (
  RD /S/Q "%LOCALA%\%%i" >NUL 2>&1
  IF EXIST "%LOCALA%\%%i" ( ECHO(Failed to delete: "%LOCALA%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: "%LOCALA%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
)
:All10
DIR /B/A:D "%COMMONPROGRAMFILES%" 2>NUL>"%JTEMP%\COMMONPROGRAMFILES_D_SUSPECT"
"%GREP%" -i -P "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12,13}$" "%JTEMP%\COMMONPROGRAMFILES_D_SUSPECT">"%JTEMP%\COMMONPROGRAMFILES_D_SUSPECT_H"
FC "%JTEMP%\COMMONPROGRAMFILES_D_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :All11 )
for /f "usebackq delims=" %%i in ("%JTEMP%\COMMONPROGRAMFILES_D_SUSPECT_H") do (
  set "line=%%i"
  SETLOCAL EnableDelayedExpansion
  DIR "!COMMONPROGRAMFILES!\!line!" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
      RD /S/Q "!COMMONPROGRAMFILES!\!line!" >NUL 2>&1
      DIR "!COMMONPROGRAMFILES!\!line!" >NUL 2>&1
      IF ERRORLEVEL 1 ( ECHO(Successfully deleted: !COMMONPROGRAMFILES!\!line! ^(Folder^)>>"!JTEMP!\R_Files.txt" ) ELSE ( ECHO(Failed to delete: !COMMONPROGRAMFILES!\!line! ^(Folder^)>>"!JTEMP!\R_Files.txt" )
      )
  ENDLOCAL
)
:All11
DIR /B/A:D "%PROGRAMFILES%" 2>NUL>"%JTEMP%\PROGRAMFILES_D_SUSPECT"
"%GREP%" -P "^n[a-z0-9]{2}3[a-z0-9]{4}m[a-z0-9]{6}$|^[a-z0-9]{4}m[a-z0-9]{2}2[a-z0-9]{4}b[a-z]{2}$" "%JTEMP%\PROGRAMFILES_D_SUSPECT">"%JTEMP%\PROGRAMFILES_D_SUSPECT_H"
FC "%JTEMP%\PROGRAMFILES_D_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :All12 )
for /f "usebackq delims=" %%i in ("%JTEMP%\PROGRAMFILES_D_SUSPECT_H") do (
  set "line=%%i"
  SETLOCAL EnableDelayedExpansion
  DIR "!PROGRAMFILES!\!line!" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
      RD /S/Q "!PROGRAMFILES!\!line!" >NUL 2>&1
      DIR "!PROGRAMFILES!\!line!" >NUL 2>&1
      IF ERRORLEVEL 1 ( ECHO(Successfully deleted: !PROGRAMFILES!\!line! ^(Folder^)>>"!JTEMP!\R_Files.txt" ) ELSE ( ECHO(Failed to delete: !PROGRAMFILES!\!line! ^(Folder^)>>"!JTEMP!\R_Files.txt" )
      )
  ENDLOCAL
)
:All12
DIR /B/A:D "%WINDIR%" 2>NUL>"%JTEMP%\WINDIR_D_SUSPECT"
"%GREP%" -i -P "^mintcast_\d{8,}$|^Shell&ServicesEngine_\d{8,}$|^NTSRV_\d{8,}$|^hwopt_\d{8,}$|^Media Manager_\d{8,}$|^bigworldsearch_\d{8,}$|^digisearch_?\d{8,}$" "%JTEMP%\WINDIR_D_SUSPECT">"%JTEMP%\WINDIR_D_SUSPECT_H"
FC "%JTEMP%\WINDIR_D_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :All13 )
for /f "usebackq delims=" %%i in ("%JTEMP%\WINDIR_D_SUSPECT_H") do (
  RD /S/Q "%WINDIR%\%%i" >NUL 2>&1
  IF EXIST "%WINDIR%\%%i" ( ECHO(Failed to delete: "%WINDIR%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: "%WINDIR%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
)
:All13
DIR /B/A:D "%TIFS%\????????" 2>NUL>"%JTEMP%\TIFS_D_SUSPECT"
DIR /B/A:D "%TIFS2%\????????" 2>NUL>>"%JTEMP%\TIFS_D_SUSPECT"
FC "%JTEMP%\TIFS_D_SUSPECT" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :All14 )
"%GREP%" -P "[A-Z0-9]{8}" "%JTEMP%\TIFS_D_SUSPECT">"%JTEMP%\TIFS_D_SUSPECT_H"
FC "%JTEMP%\TIFS_D_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :All14 )
for /f "usebackq delims=" %%i in ("%JTEMP%\TIFS_D_SUSPECT_H") do (
  RD /S/Q "%TIFS%\%%i" >NUL 2>&1
  IF EXIST "%TIFS%\%%i" ( ECHO(Failed to delete: %TIFS%\%%i ^(Temporary Internet Files Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %TIFS%\%%i ^(Temporary Internet Files Folder^)>>"%JTEMP%\R_Files.txt" )
  RD /S/Q "%TIFS2%\%%i" >NUL 2>&1
  IF EXIST "%TIFS2%\%%i" ( ECHO(Failed to delete: %TIFS2%\%%i ^(Temporary Internet Files Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %TIFS2%\%%i ^(Temporary Internet Files Folder^)>>"%JTEMP%\R_Files.txt" )
)
:All14
IF NOT EXIST %SYS32%\reg.exe GOTO :All15
REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\ROOT\Certificates>"%JTEMP%\CERTS_R_SUSPECT"
for /f "usebackq delims=" %%i in ("%JTEMP%\CERTS_R_SUSPECT") do (
  REG QUERY %%i 2>NUL|"%GREP%" -q "0.7A64656E67696E65.0"
  IF NOT ERRORLEVEL 1 (
    REG DELETE %%i /F >NUL 2>&1
    REG QUERY %%i >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: %%i ^(Registry Key - PennyBee Certificate^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: %%i ^(Registry Key - PennyBee Certificate^)>>"%JTEMP%\R_Registry.txt" )
    )
)
:All15
for /f "usebackq delims=" %%i in ("%JRT%\bl_foldersM.cfg") do (
  set "line=%%i"
  SETLOCAL EnableDelayedExpansion
  DIR "!PROGRAMFILES!\!line!" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    RD /S/Q "!PROGRAMFILES!\!line!" >NUL 2>&1
    DIR "!PROGRAMFILES!\!line!" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: !PROGRAMFILES!\!line! ^(Folder^)>>"!JTEMP!\R_Files.txt" ) ELSE ( ECHO(Failed to delete: !PROGRAMFILES!\!line! ^(Folder^)>>"!JTEMP!\R_Files.txt" )
    )
  ENDLOCAL
)
for /f "usebackq delims=" %%i in ("%JRT%\bl_foldersC.cfg") do (
  set "line=%%i"
  SETLOCAL EnableDelayedExpansion
  DIR "!COMMONPROGRAMFILES!\!line!" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    RD /S/Q "!COMMONPROGRAMFILES!\!line!" >NUL 2>&1
    DIR "!COMMONPROGRAMFILES!\!line!" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: !COMMONPROGRAMFILES!\!line! ^(Folder^)>>"!JTEMP!\R_Files.txt" ) ELSE ( ECHO(Failed to delete: !COMMONPROGRAMFILES!\!line! ^(Folder^)>>"!JTEMP!\R_Files.txt" )
    )
  ENDLOCAL
)
for /f "usebackq delims=" %%i in ("%JRT%\bl_foldersM.cfg") do (
  DIR "%APPDATA%\%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    RD /S/Q "%APPDATA%\%%i" >NUL 2>&1
    DIR "%APPDATA%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%APPDATA%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%APPDATA%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
    )
)
for /f "usebackq delims=" %%i in ("%JRT%\bl_foldersM.cfg") do (
  DIR "%ALLUSERSPROFILE%\%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    RD /S/Q "%ALLUSERSPROFILE%\%%i" >NUL 2>&1
    DIR "%ALLUSERSPROFILE%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%ALLUSERSPROFILE%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%ALLUSERSPROFILE%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
    )
)
for /f "usebackq delims=" %%i in ("%JRT%\bl_foldersM.cfg") do (
  DIR "%LOCALA%\%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    RD /S/Q "%LOCALA%\%%i" >NUL 2>&1
    DIR "%LOCALA%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%LOCALA%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%LOCALA%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
    )
)
for /f "usebackq delims=" %%i in ("%JRT%\bl_foldersS.cfg") do (
  DIR "%PROGRAMS1ALL%\%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    RD /S/Q "%PROGRAMS1ALL%\%%i" >NUL 2>&1
    DIR "%PROGRAMS1ALL%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%PROGRAMS1ALL%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%PROGRAMS1ALL%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
    )
)
for /f "usebackq delims=" %%i in ("%JRT%\bl_foldersS.cfg") do (
  DIR "%PROGRAMS2ALL%\%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    RD /S/Q "%PROGRAMS2ALL%\%%i" >NUL 2>&1
    DIR "%PROGRAMS2ALL%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%PROGRAMS2ALL%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%PROGRAMS2ALL%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
    )
)
for %%i in (
"%allusersprofile%\dvf"
"%allusersprofile%\microsoft\windows\windowsaccmanager"
"%allusersprofile%\microsoft\windows\windowsaccountmanager"
"%allusersprofile%\program status"
"%allusersprofile%\schedule"
"%allusersprofile%\unknown"
"%allusersprofile%\updater"
"%appdata%\event monitor"
"%appdata%\network checker"
"%appdata%\store\windapp"
"%appdata%\system"
"%locala%\iconnect"
"%locala%\installer"
"%locala%\microsoft\evt"
"%locala%\mscupdate"
"%locala%\programs\befrugal.com"
"%mydocs%\add-in express"
"%mydocs%\Optimum PC Boost"
"%mydocs%\alawarwrapper"
"%mydocs%\TLCPCBooster"
"%mydocs%\cyber tech expert_1-855-907-2767"
"%mydocs%\dev360 cleaner"
"%mydocs%\downloaded installers"
"%mydocs%\driver maximizer"
"%mydocs%\guid"
"%mydocs%\maxcomputercleaner"
"%mydocs%\EasyRegistryCleaner"
"%mydocs%\my pagemanager"
"%mydocs%\optimizer pro"
"%mydocs%\pc faster"
"%mydocs%\pc health kit"
"%mydocs%\pc system boost"
"%mydocs%\pcprivacydock"
"%mydocs%\pcspeedup"
"%mydocs%\probit software"
"%mydocs%\propccleaner"
"%mydocs%\smart pc cleaner"
"%mydocs%\startup maximizer"
"%mydocs%\super optimizer"
"%mydocs%\ultimatepcoptimizer"
"%mydocs%\ytahelper"
"%mymusic%\qtrax media library"
"%startup%\GreatZip"
"%programfiles%\microsoft games\windows games"
"%programfiles%\product key"
"%programfiles%\software\scrollup"
"%programfiles%\windows\error file remover"
"%systemdrive%\ai_recyclebin"
"%systemdrive%\breakingnewsalert"
"%systemdrive%\iqiyi video"
"%systemdrive%\nava labs"
"%systemdrive%\rei"
"%systemdrive%\SearchProtect"
"%systemdrive%\terasgames"
"%systemdrive%\xiaomi"
"%userprofile%\funshion"
"%userprofile%\qtrax"
"%windir%\book source"
"%windir%\buzzsocialpointschecker"
"%windir%\free youtube downloader"
"%windir%\freecorder"
"%windir%\joberphlusisp"
"%windir%\microsoft\system update kb70007"
"%windir%\pcbhdnw"
"%windir%\provider"
"%windir%\provider32"
"%windir%\snail translator"
) DO (
      IF EXIST %%i (
                    RD /S/Q %%i >NUL 2>&1
                    IF EXIST %%i ( ECHO(Failed to delete: %%i ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %%i ^(Folder^)>>"%JTEMP%\R_Files.txt" )
                   )             
)
for %%i in (
"%sys32%\abis"
"%sys32%\ai_recyclebin"
"%sys32%\arfc"
"%sys32%\c2mp"
"%sys32%\cacl"
"%sys32%\dfrg"
"%sys32%\Tasks\TweakBit"
"%sys32%\Tasks\Protected Search"
"%sys32%\itruscert"
"%sys32%\jmdp"
"%sys32%\ljkb"
"%sys32%\popupalert"
"%sys32%\wnlt"
) DO (
      IF EXIST %%i (
                    RD /S/Q %%i >NUL 2>&1
                    IF EXIST %%i ( ECHO(Failed to delete: %%i ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %%i ^(Folder^)>>"%JTEMP%\R_Files.txt" )
                   )             
)
:: LOCALA empty folders
cd /d "%LOCALA%\{????????-????-????-????-????????????}" >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 ( GOTO :OS64_0 )
cd /d "%LOCALA%" >NUL 2>&1
for /f "delims=" %%i in ('DIR /B/A:D "%LOCALA%\{????????-????-????-????-????????????}" ^| SORT') do (
  RD "%%i" >NUL 2>&1
  DIR "%%i" >NUL 2>&1
  IF ERRORLEVEL 1 (
                   Echo(Successfully deleted: "%LOCALA%\%%i" ^(Empty Folder^)>>"%JTEMP%\R_Files.txt"
                  ) else ( 
                          REM Will fail if NOT empty. DO NOTHING.
                         )
)
:OS64_0
ECHO %ARCH%|FIND "x64" >NUL
IF %ERRORLEVEL% NEQ 0 ( GOTO :PublicFolders )
DIR /B/A:-D "%SYSWOW64%\????????.bat" 2>NUL>"%JTEMP%\SYSWOW64_F_SUSPECT"
FC "%JTEMP%\SYSWOW64_F_SUSPECT" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :OS64_1 )
"%GREP%" -P "^\d{8}\.bat" "%JTEMP%\SYSWOW64_F_SUSPECT">"%JTEMP%\SYSWOW64_F_SUSPECT_H"
FC "%JTEMP%\SYSWOW64_F_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :OS64_1 )
for /f "usebackq delims=" %%i in ("%JTEMP%\SYSWOW64_F_SUSPECT_H") do (
  DEL /F/Q "%SYSWOW64%\%%i" >NUL 2>&1
  IF EXIST "%SYSWOW64%\%%i" ( ECHO(Failed to delete: %SYSWOW64%\%%i ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %SYSWOW64%\%%i ^(File^)>>"%JTEMP%\R_Files.txt" )
)
:OS64_1
DIR /B/A:D "%SYSWOW64%\dg???" 2>NUL>"%JTEMP%\SYSWOW64_D_SUSPECT"
FC "%JTEMP%\SYSWOW64_D_SUSPECT" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :OS64_2 )
"%GREP%" -P "^dg\d{3}$" "%JTEMP%\SYSWOW64_D_SUSPECT">"%JTEMP%\SYSWOW64_D_SUSPECT_H"
FC "%JTEMP%\SYSWOW64_D_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :OS64_2 )
for /f "usebackq delims=" %%i in ("%JTEMP%\SYSWOW64_D_SUSPECT_H") do (
  RD /S/Q "%SYSWOW64%\%%i" >NUL 2>&1
  IF EXIST "%SYSWOW64%\%%i" ( ECHO(Failed to delete: %SYSWOW64%\%%i ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %SYSWOW64%\%%i ^(Folder^)>>"%JTEMP%\R_Files.txt" )
)
:OS64_2
DIR /B/A:-D "%ProgramW6432%\????????.exe" 2>NUL>"%JTEMP%\PROGRAMFILES6432_F_SUSPECT"
FC "%JTEMP%\PROGRAMFILES6432_F_SUSPECT" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :OS64_3 )
"%GREP%" -P "^[A-Z0-9]{8}\.exe$" "%JTEMP%\PROGRAMFILES6432_F_SUSPECT">"%JTEMP%\PROGRAMFILES6432_F_SUSPECT_H"
FC "%JTEMP%\PROGRAMFILES6432_F_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :OS64_3 )
for /f "usebackq delims=" %%i in ("%JTEMP%\PROGRAMFILES6432_F_SUSPECT_H") do (
  DEL /F/Q "%ProgramW6432%\%%i" >NUL 2>&1
  IF EXIST "%ProgramW6432%\%%i" ( ECHO(Failed to delete: %ProgramW6432%\%%i ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %ProgramW6432%\%%i ^(File^)>>"%JTEMP%\R_Files.txt" )
)
:OS64_3
DIR /B/A:D "%CommonProgramW6432%" 2>NUL>"%JTEMP%\COMMONPROGRAMFILES6432_D_SUSPECT"
"%GREP%" -i -P "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12,13}$" "%JTEMP%\COMMONPROGRAMFILES6432_D_SUSPECT">"%JTEMP%\COMMONPROGRAMFILES6432_D_SUSPECT_H"
FC "%JTEMP%\COMMONPROGRAMFILES6432_D_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :OS64_4 )
for /f "usebackq delims=" %%i in ("%JTEMP%\COMMONPROGRAMFILES6432_D_SUSPECT_H") do (
  RD /S/Q "%CommonProgramW6432%\%%i" >NUL 2>&1
  IF EXIST "%CommonProgramW6432%\%%i" ( ECHO(Failed to delete: %CommonProgramW6432%\%%i ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %CommonProgramW6432%\%%i ^(Folder^)>>"%JTEMP%\R_Files.txt" )
)
:OS64_4
DIR /B/A:D "%ProgramW6432%" 2>NUL>"%JTEMP%\PROGRAMFILES6432_D_SUSPECT"
"%GREP%" -P "^shopperz\d{5,}$|^groover\d{5,}$|^firstOffer\d{5,}$" "%JTEMP%\PROGRAMFILES6432_D_SUSPECT">"%JTEMP%\PROGRAMFILES6432_D_SUSPECT_H"
FC "%JTEMP%\PROGRAMFILES6432_D_SUSPECT_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :OS64_5 )
for /f "usebackq delims=" %%i in ("%JTEMP%\PROGRAMFILES6432_D_SUSPECT_H") do (
  RD /S/Q "%ProgramW6432%\%%i" >NUL 2>&1
  IF EXIST "%ProgramW6432%\%%i" ( ECHO(Failed to delete: %ProgramW6432%\%%i ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %ProgramW6432%\%%i ^(Folder^)>>"%JTEMP%\R_Files.txt" )
)
:OS64_5
for /f "usebackq delims=" %%i in ("%JRT%\bl_foldersM.cfg") do (
  DIR "%ProgramW6432%\%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    RD /S/Q "%ProgramW6432%\%%i" >NUL 2>&1
    DIR "%ProgramW6432%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: %ProgramW6432%\%%i ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: %ProgramW6432%\%%i ^(Folder^)>>"%JTEMP%\R_Files.txt" )
    )
)
for /f "usebackq delims=" %%i in ("%JRT%\bl_foldersC.cfg") do (
  DIR "%CommonProgramW6432%\%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    RD /S/Q "%CommonProgramW6432%\%%i" >NUL 2>&1
    DIR "%CommonProgramW6432%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: %CommonProgramW6432%\%%i ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: %CommonProgramW6432%\%%i ^(Folder^)>>"%JTEMP%\R_Files.txt" )
    )
)
cd /d "%ProgramW6432%" >NUL 2>&1
for /d %%a in (
*c*o*u*p*o*n*
a*c*t*i*v*e*d*e*a*l*s
a*d*b*l*o*c*k*e*r
a*d*b*l*o*c*k*n*w*a*t*c*h
a*d*d*i*c*t*-*t*h*i*n*g
a*d*d*t*o*t*h*i*s
a*l*a*w*a*r
a*l*l*c*h*e*a*p*p*r*i*c*e
a*l*l*d*a*y*p*r*i*c*e
a*l*l*d*a*y*s*a*v*i*n*g*s
a*l*l*d*e*a*l*s*a*p*p
a*l*l*s*a*v*e*r
a*p*p*e*n*d*r*u*n*n*e*r
a*p*p*s*a*v*e*
a*p*p*t*o*u
a*u*t*o*d*e*a*l*s*a*p*p
b*a*l*l*o*o*n*s*d*e*s*i*g*n
b*c*o*o*l
b*e*e*m*p*3
b*e*s*t*a*d*b*l*o*c*k*e*r
b*e*s*t*p*r*i*c*e*s*a*p*p
b*e*s*t*s*a*v*e*f*o*r*y*o*u
b*e*t*e*r*e*m
b*e*t*t*e*r*p*r*i*c*e*
b*e*t*t*e*r*s*h*o*p*p*e*r
b*i*g*d*e*a*l
b*i*o*c*u*r*e
b*i*t*s*a*v*e*r
b*l*o*c*k*t*h*e*a*d*a*p*p
b*l*o*c*k*u*t*u*b*e*a*d
b*r*o*w*s*e*2*s*a*v*e
b*r*o*w*s*e*a*n*d*s*h*o*p
b*r*o*w*s*e*r*e*n*h*a*n*c*e
b*r*o*w*s*e*r*s*h*o*p
b*r*o*w*s*e*t*o*b*u*y
b*r*o*w*s*e*t*o*s*a*v*e
b*r*o*w*s*i*n*g*c*l*e*a*r
b*r*o*w*s*i*n*g*c*l*e*a*r*l*y
b*s*a*v*i*n*g
b*u*y*a*n*d*b*r*o*w*s*e
b*u*y*f*a*s*t
b*u*y*n*s*a*v*e
c*h*e*a*p*4*a*l*l
c*h*e*a*p*c*o*u*p
c*h*e*a*p*m*e
c*h*o*o*s*e*2*s*a*v*e
c*l*e*a*r*b*r*o*w*s*e
c*l*i*c*k*2*s*a*v*e
c*l*i*c*k*f*o*r*s*a*l*e
c*l*i*c*k*s*a*v*i*n*g*s
c*o*d*e*c*-*c
c*o*d*e*c*-*v
c*o*d*e*c*c
c*o*d*e*c*v
c*o*i*n*s*a*v*e
c*o*m*f*y
c*o*m*p*a*r*e*b*u*y
c*o*m*p*a*r*e*i*t*a*p*p
c*o*m*p*a*r*e*i*t*a*p*p*l*i*c
c*o*m*p*a*r*e*t*o*o*p*t*i*m*i*z*e
c*o*n*t*i*n*u*e*t*o*s*a*v*e
c*o*n*v*e*r*t*m*e
c*o*o*l*n*c*h*e*a*p
c*o*o*l*y*o*u
c*o*s*t*m*i*n
c*o*u*p*a*p*p
c*o*u*p*c*o*u*p
c*o*u*p*e*x*t*e*n*s*i*o*n
c*o*u*p*m*a*n*i*a
c*o*u*p*s*c*a*n*n*e*r
c*o*u*p*s*e*e*k
c*o*u*p*y*o*u
c*r*a*z*y*l*o*w*p*r*i*c*e*s
c*u*r*r*e*n*c*y* c*o*n*v*e*r*t*e*r
c*u*t*t*h*e*p*r*i*c*e
d*a*i*l*e*y*p*r*i*z*e
d*a*i*l*y*p*r*i*z*e
d*e*a*l*2*d*e*a*l
d*e*a*l*2*d*e*a*l*i*t
d*e*a*l*4*m*e
d*e*a*l*4*r*e*a*l
d*e*a*l*e*x*p*r*e*s*s
d*e*a*l*n*o*d*e*a*l
d*e*a*l*p*e*a*k
d*e*a*l*p*l*u*g
d*e*a*l*s*f*i*n*d*e*r*p*r*o
d*e*a*l*s*p*a*c*e
d*e*a*l*s*t*a*r*a*p*p
d*e*a*l*s*t*e*r
d*i*g*i*s*a*v*e*r*
d*i*s*c*o*u*n*t*b*o*m*b
d*i*s*c*o*u*n*t*e*x*t*e*n*s*i*o*n
d*i*s*c*o*u*n*t*l*o*c*a*t*o*r
d*i*s*c*o*u*n*t*m*a*n
d*i*s*c*o*u*n*t*s*m*a*s*h*e*r
d*o*c*s*c*o*n*v*e*r*t*e*r
d*o*c*s*v*i*e*w*e*r
d*o*c*t*o*c*o*n*v*e*r*t*e*r
d*o*c*t*o*t*x*t*c*o*n*v*e*r*t
d*o*l*l*a*r*k*e*e*p*e*r
d*o*l*l*a*r*s*a*v*e*r
d*o*w*n*l*o*a*d*a*n*d*s*a
d*o*w*n*l*o*a*d*a*n*d*s*a*v*e
d*o*w*n*l*o*a*d*i*t*k*e*e*p
d*o*w*n*l*o*a*d*k*e*e*p*e*r
d*o*w*n*l*o*a*d*n*s*a*v*e
d*o*w*n*l*o*w*a*p*p
d*o*w*n*s*a*v*e
e*a*r*n*s*a*l*e
e*a*s*y*t*o*s*h*o*p
e*b*o*o*k*b*r*o*w*s*e
e*n*o*r*m*o*u*s*a*l*e*s
e*n*o*r*m*o*u*s*s*a*l*e*s
e*x*e*c*h*e*c*k*e*r
e*x*e*r*u*n*n*e*r
e*x*t*r*a*s*a*v*i*n*g
e*x*t*r*a*s*a*v*i*n*g*s
e*x*t*r*a*s*h*o*p*p*e*r
f*a*s*t*n*c*h*e*a*p
f*a*s*t*s*a*l*e
f*a*s*t*s*a*l*e*r
f*a*s*t*s*a*v*e
f*i*n*d*a*d*e*a*l
f*i*n*d*b*e*s*t*d*e*a*l
f*i*n*d*d*e*a*l*s*o*f*t
f*i*n*e*d*e*a*l*s*o*f*t
f*l*e*x*i*b*l*e*s*h*o*p*p*e*r
f*r*e*e*2*y*o*u
f*r*e*e*d*e*l*i*v*e*r*y
f*u*n*2*s*a*v*e
f*u*n*d*e*a*l*s
f*u*n*s*h*o*p*p*e*r
f*u*n*t*o*s*a*v*e
g*e*t*d*i*s*c*o*u*n*t*a*p*p
g*e*t*s*a*v*i*n
g*e*t*t*h*e*d*i*s*c*o*u*n*t
g*o*s*a*v*e
g*o*s*a*v*e*o
g*r*e*a*t*s*a*v*e*4*u
g*r*e*a*t*s*a*v*e*r
g*r*e*a*t*s*a*v*i*n*g
h*a*p*p*y*2*s*a*v*e
h*a*p*p*y*s*a*l*e*s
h*t*m*l*v*a*l*i*d*a*t*o*r
i*c*o*c*o*n*v*e*r*t*e*r
i*c*o*v*a*l*i*d
i*m*a*g*e*t*o*p*n*g
i*n*s*t*a*p*a*p*e*r
i*s*a*v*e*r
i*t*u*m*e*n
j*o*i*n*t*h*e*s*h*o*p
j*u*m*b*o*d*e*a*l*s
k*e*e*p*e*r*s*e*x*t
k*e*e*p*i*t*b*r*o*w*s*e
k*e*e*p*n*o*w
k*o*b*i
l*e*s*s*2*p*a*y
l*e*t*l*i*v*e
l*o*w*e*r*p*r*i*c*e*s
l*o*w*e*r*p*r*i*c*i*n*g
l*o*w*p*r*i*c*e*s
l*o*w*r*a*t*e
l*u*c*k*y*s*h*o*p*p*e*r
m*a*g*n*i*p*i*c
m*a*r*k*e*t*c*o*m*p*a*r*e
m*i*n*i*m*u*m*p*r*i*c*e
m*o*n*s*o*o*n*r*e*v*e*n*u*e
m*p*3*m*a*k*e*r
m*y*p*r*i*c*e*c*u*t
m*y*s*e*a*r*c*h
m*y*s*h*o*p*p*e*r
m*y*t*o*o*l*s
n*e*w*s*a*v*e*r
n*e*x*t*c*o*u*p
n*i*c*e*f*r*e*e
n*i*c*e*n*f*r*e*e
n*i*c*e*o*f*f*e*r*s
n*i*t*r*o*d*e*a*l*
n*o*n*o*i*z*e*b*r*o*w*s*e
o*f*f*e*r*a*p*p
o*f*f*e*r*d*e*a*l
o*f*f*e*r*p*o*p
o*f*f*e*r*s*a*l*e
o*f*f*e*r*s*o*f*t
o*n*l*i*n*e*l*o*w*d*e*a*l*s
o*n*l*i*n*e*s*h*o*p*p*i*n*g
o*p*t*o*n
o*u*t*c*o*m*e*o*p*t*i*m*i*z*e*r
p*a*g*e*a*r*c*h*i*v*e*r
p*c*a*p*p
p*d*f*v*i*e*w*e*r
p*i*c*k*n*s*a*v*e*i*t
p*l*u*g*s*t*e*r
p*n*g*t*o*p*p*t*c*o*n*v*e*r*t
p*o*p*d*e*a*l*s
p*p*t*c*h*e*c*k*e*r
p*r*i*c*e*c*h*o*p
p*r*i*c*e*d*o*w*n*l*o*a*d*e*r
p*r*i*c*e*k*e*e*p*e*r
p*r*i*c*e*l*e*s*s
p*r*i*c*e*m*i*n*u*s
p*r*o*s*h*o*p*p*e*r
p*s*d*c*h*e*c*k*e*r
p*s*d*t*o*p*n*g
q*u*i*c*k*s*h*o*p
q*u*i*c*k*v*i*e*w*e*r
r*a*n*d*o*m*p*r*i*c*e
r*e*a*l*d*e*a*l
r*e*g*u*l*a*r*d*e*a*l*s
r*e*m*o*v*e*t*h*e*a*d*a*p*p
r*e*s*p*e*c*t*s*a*l*e
r*i*g*h*t*c*o*n*v*e*r*t*e*r
r*i*v*a*l*c*o*u*p
r*o*b*o*s*a*v*e
r*o*b*o*s*a*v*e*r
r*o*c*k*a*p*p*s
r*o*c*k*e*t*d*e*a*l
r*o*c*k*e*t*s*a*l*e
r*o*y*a*l*s*h*o*p*p*e*r*a*p*p
s*a*f*e*r*w*e*b
s*a*f*e*s*a*v*e
s*a*f*e*w*e*b
s*a*l*e*c*h*e*c*k*e*r
s*a*l*e*o*f*f*e*r
s*a*l*e*p*l*u*s
s*a*l*e*p*r*i*z*e*
s*a*l*e*s*a*l*e*
s*a*l*e*s*c*h*e*c*k*e*r
s*a*l*e*s*m*a*g*n*e*t
s*a*v*e*a*s
s*a*v*e*b*o*x
s*a*v*e*b*y*c*l*i*c*k
s*a*v*e*c*l*i*c*k*e*r
s*a*v*e*e*x*t*e*n*s*i*o*n
s*a*v*e*i*n*s*h*o*p
s*a*v*e*i*t
s*a*v*e*i*t*k*e*e*p
s*a*v*e*k*e*e*p
s*a*v*e*l*o*t*s
s*a*v*e*m*a*s*s
s*a*v*e*n*e*t
s*a*v*e*n*e*w*a*p*p*z
s*a*v*e*n*o*w
s*a*v*e*n*s*h*a*r*e
s*a*v*e*o*n*m*a*c
s*a*v*e*r*a*d*d*o*n
s*a*v*e*r*b*o*x
s*a*v*e*r*e*x*t*e*n*s*i*o*n
s*a*v*e*r*n*e*t
s*a*v*e*r*p*r*o
s*a*v*e*s*a*f*e
s*a*v*e*s*h*a*r*e
s*a*v*e*w*e*b
s*a*v*i*n*g*t*o*y*o*u
s*a*v*i*n*s*h*o*p
s*e*a*r*c*h*-*n*e*w*t*a*b
s*e*a*r*c*h*n*e*w*t*a*b
s*h*o*p*b*r*a*i*n
s*h*o*p*d*r*o*p
s*h*o*p*e*a*s*y
s*h*o*p*n*c*o*m*p*a*r*e
s*h*o*p*o*p*t*i*m*i*z*e*r
s*h*o*p*p*e*r*m*a*s*t*e*r
s*h*o*p*p*i*l*a*t*i*o*n
s*h*o*p*p*i*n*g*c*h*i*p
s*h*o*p*p*i*n*g*d*e*a*l*f*a*c*t*o*r*y
s*h*o*p*p*i*n*g*h*e*l*p*e*r
s*h*o*p*s*h*o*p
s*h*o*w*-*p*a*s*s*w*o*r*d
s*k*y*p*e*m*o*t*i*c*o*n*s
s*m*a*r*t*c*o*m*p*a*r*e
s*m*o*o*t*h*v*i*e*w
s*o*f*t*c*o*u*p
s*o*f*t*s*a*f*e
s*p*a*c*e*o*f*f*e*r*s
s*t*u*d*e*n*t*p*s*y*c*h*o*m
s*u*r*f*a*n*d*k*e*e*p
s*u*r*f*e*r*s*s*a*v*e*r
s*u*r*f*k*e*e*p*i*t
t*a*b*a*l*l*c*o*n*v*e*r*t*e*r
t*a*b*l*e*c*o*n*v*e*r*t*e*r
t*a*b*l*e*v*i*e*w*e*r
t*a*k*e*i*t*c*h*e*a*p
t*a*k*e*s*h*o*p
t*h*e*b*f*l*i*x
t*he*b*l*o*c*k*e*r
t*i*n*y*w*a*l*l*e*t
t*o*p*b*u*y*e*r
t*o*p*d*e*a*l
t*o*y*o*t*a
t*r*e*m*e*n*d*o*u*s*s*a*l*e
t*u*b*e*a*d*b*l*o*c*k*e*r
t*u*b*e*i*t*a*d*b*l*o*c*k*a*p
t*x*t*f*i*l*e*s*c*o*n*v*e*r*t
u*a*d*r*e*m*o*v*a*l*a*p*p
u*n*i*d*e*a*l*s
u*n*i*s*a*l*e*s
u*t*u*b*e*a*d*b*l*o*c*k
u*t*u*b*e*a*d*r*e*m*o*v*a*l
u*t*u*b*e*n*o*a*d*s
v*a*u*d*i*x
v*i*e*w*p*a*s*s*w*o*r*d
w*a*t*c*h*i*t*a*d*b*l*o*c*k
w*e*b*b*i*n*g
w*e*b*s*a*v*e
w*e*b*s*a*v*e*r
w*e*e*k*a*p*p
w*h*i*t*e*d*e*a*l*s
w*h*i*t*e*o*f*f*e*r*a*p*p
w*x*d*f*a*s*t
w*x*d*o*w*n*l*o*a*d
y*a*e*l*e*r*l*i*c*h
y*o*u*t*u*b*e*a*d*b*l*o*c*k*e*r
y*o*u*t*u*b*e*a*d*r*e*m*o*v*e
) do (
      if exist "%%a" (
                      dir "%ProgramW6432%\%%a\*.tlb" >NUL 2>&1
	              IF NOT ERRORLEVEL 1 (
			                   rd /s/q "%ProgramW6432%\%%a" >NUL 2>&1
                                           dir "%ProgramW6432%\%%a" >NUL 2>&1
                                           IF ERRORLEVEL 1 (
                                                            Echo(Successfully deleted: %ProgramW6432%\%%a ^(Folder^)>>"%JTEMP%\R_Files.txt"
                                                           ) else (
                                                                   Echo(Failed to delete: %ProgramW6432%\%%a ^(Folder^)>>"%JTEMP%\R_Files.txt"
                                                                  )
                                          )
                     )
)
:PublicFolders
ECHO %OS%|FIND "Windows XP" >NUL
IF %ERRORLEVEL% EQU 0 ( GOTO :OSXP_Files )
for /f "usebackq delims=" %%i in ("%JRT%\bl_lnkfiles.cfg") do (
 DIR "%PUBDESKTOP%\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%PUBDESKTOP%\%%i" >NUL 2>&1
    DIR "%PUBDESKTOP%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%PUBDESKTOP%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%PUBDESKTOP%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" )
    )
 DIR "%QUICKLAUNCH17%\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%QUICKLAUNCH17%\%%i" >NUL 2>&1
    DIR "%QUICKLAUNCH17%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%QUICKLAUNCH17%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%QUICKLAUNCH17%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" )
    )
 DIR "%QUICKLAUNCH27%\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%QUICKLAUNCH27%\%%i" >NUL 2>&1
    DIR "%QUICKLAUNCH27%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%QUICKLAUNCH27%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%QUICKLAUNCH27%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" )
    )
 DIR "%PROGRAMS17%\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%PROGRAMS17%\%%i" >NUL 2>&1
    DIR "%PROGRAMS17%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%PROGRAMS17%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%PROGRAMS17%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" )
    )
 DIR "%PROGRAMS27%\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%PROGRAMS27%\%%i" >NUL 2>&1
    DIR "%PROGRAMS27%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%PROGRAMS27%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%PROGRAMS27%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" )
    )
 DIR "%STARTMENU17%\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%STARTMENU17%\%%i" >NUL 2>&1
    DIR "%STARTMENU17%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%STARTMENU17%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%STARTMENU17%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" )
    )
 DIR "%STARTMENU27%\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%STARTMENU27%\%%i" >NUL 2>&1
    DIR "%STARTMENU27%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%STARTMENU27%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%STARTMENU27%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" )
    )
)
for /f "usebackq delims=" %%i in ("%JRT%\bl_foldersM.cfg") do (
  DIR "%LOCALLOW%\%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    RD /S/Q "%LOCALLOW%\%%i" >NUL 2>&1
    DIR "%LOCALLOW%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%LOCALLOW%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%LOCALLOW%\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
    )
)
cd /d "%LOCALLOW%" >NUL 2>&1
for /d %%a in (
FCTB*
*toolbar*
) do (
      if exist %%a (
                    DIR "%LOCALLOW%\%%a" >NUL 2>&1
	            IF NOT ERRORLEVEL 1 (
                                         RD /S/Q "%LOCALLOW%\%%a" >NUL 2>&1
                                         DIR "%LOCALLOW%\%%a" >NUL 2>&1
                                         IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%LOCALLOW%\%%a" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%LOCALLOW%\%%a" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
                                        )
                   )
)
for %%i in (
"%pubdocs%\add-in express"
"%pubdocs%\alawarwrapper"
"%pubdocs%\downloaded installers"
"%pubdocs%\guid"
"%pubdocs%\maxcomputercleaner"
"%pubdocs%\optimizer pro"
"%pubdocs%\pc faster"
"%pubdocs%\pc system boost"
"%pubdocs%\pcprivacydock"
"%pubdocs%\pcspeedup"
"%pubdocs%\propccleaner"
"%pubdocs%\smart pc cleaner"
"%pubdocs%\ultimatepcoptimizer"
"%pubdocs%\ytahelper"
"%public%\qiyi"
"%public%\thunder network"
) DO (
      IF EXIST %%i (
                    RD /S/Q %%i >NUL 2>&1
                    IF EXIST %%i ( ECHO(Failed to delete: %%i ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %%i ^(Folder^)>>"%JTEMP%\R_Files.txt" )
                   )             
)
GOTO :Browsers
:OSXP_Files
for /f "usebackq delims=" %%i in ("%JRT%\bl_lnkfiles.cfg") do (
 DIR "%LNK1XP%\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%LNK1XP%\%%i" >NUL 2>&1
    DIR "%LNK1XP%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%LNK1XP%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%LNK1XP%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" )
    )
 DIR "%LNK2XP%\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%LNK2XP%\%%i" >NUL 2>&1
    DIR "%LNK2XP%\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%LNK2XP%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%LNK2XP%\%%i" ^(Shortcut^)>>"%JTEMP%\R_Files.txt" )
    )
)
:Browsers
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
Echo((******  )  Browsers
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
IF NOT EXIST %SYS32%\reg.exe GOTO :Shortcuts
REG QUERY "HKCU\Software\Microsoft\Internet Explorer\SearchScopes" 2>NUL|"%GREP%" -iP "\\SearchScopes\\{[a-f0-9]+-.*}$">"%JTEMP%\IE_SS"
if %ARCH%==x64 (
  REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\SearchScopes" 2>NUL|"%GREP%" -iP "\\SearchScopes\\{[a-f0-9]+-.*}$">>"%JTEMP%\IE_SS"
)
REG QUERY "HKLM\Software\Microsoft\Internet Explorer\SearchScopes" 2>NUL|"%GREP%" -iP "\\SearchScopes\\{[a-f0-9]+-.*}$">>"%JTEMP%\IE_SS"
FC "%JTEMP%\IE_SS" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_0 )
"%SORT_%" -f -u <"%JTEMP%\IE_SS" >"%JTEMP%\IE_SS2"
FC "%JTEMP%\IE_SS2" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_0 )
for /f "usebackq delims=" %%i in ("%JTEMP%\IE_SS2") do (
 REG QUERY "%%i" /V URL >NUL 2>&1
 IF ERRORLEVEL 1 (
    REG DELETE "%%i" /F >NUL 2>&1
    ECHO(Successfully deleted: %%i ^(Registry Key^)>>"%JTEMP%\R_Registry.txt"
    )
)
for /f "usebackq delims=" %%i in ("%JTEMP%\IE_SS2") do (
 REG QUERY "%%i" 2>NUL|FINDSTR /IG:"%JRT%\bl_urls.cfg" >NUL 2>&1
 IF NOT ERRORLEVEL 1 (
    REG DELETE "%%i" /F >NUL 2>&1
    ECHO(Successfully deleted: %%i ^(Registry Key^)>>"%JTEMP%\R_Registry.txt"
    )
)
:Browsers_0
REG QUERY "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects" 2>NUL|"%GREP%" -iP "\\Browser Helper Objects\\{[a-f0-9]+-.*}$">"%JTEMP%\IE_BHO"
if %ARCH%==x64 (
  REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects" 2>NUL|"%GREP%" -iP "\\Browser Helper Objects\\{[a-f0-9]+-.*}$">>"%JTEMP%\IE_BHO"
)
FC "%JTEMP%\IE_BHO" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_1 )
"%SORT_%" -f -u <"%JTEMP%\IE_BHO" >"%JTEMP%\IE_BHO2"
FC "%JTEMP%\IE_BHO2" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_1 )
FINDSTR /IVG:"%JRT%\wl_bhos.cfg" "%JTEMP%\IE_BHO2">"%JTEMP%\IE_BHO_T"
FC "%JTEMP%\IE_BHO_T" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_1 )
for /f "usebackq delims=" %%i in ("%JTEMP%\IE_BHO_T") do (
  REG DELETE "%%i" /F >NUL 2>&1
  ECHO(Successfully deleted: %%i ^(Registry Key^)>>"%JTEMP%\R_Registry.txt"
  )
)
:Browsers_1
REG QUERY "HKCU\Software\Microsoft\Internet Explorer\Toolbar" 2>NUL|"%GREP%" -iP "{[a-f0-9]+-.*}">"%JTEMP%\IE_TB"
if %ARCH%==x64 (
  REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar" 2>NUL|"%GREP%" -iP "{[a-f0-9]+-.*}">>"%JTEMP%\IE_TB"
)
REG QUERY "HKLM\Software\Microsoft\Internet Explorer\Toolbar" 2>NUL|"%GREP%" -iP "{[a-f0-9]+-.*}">>"%JTEMP%\IE_TB"
REG QUERY "HKCU\Software\Microsoft\Internet Explorer\Toolbar\WebBrowser" 2>NUL|"%GREP%" -iP "{[a-f0-9]+-.*}">>"%JTEMP%\IE_TB"
FC "%JTEMP%\IE_TB" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_2 )
"%SORT_%" -f -u <"%JTEMP%\IE_TB" >"%JTEMP%\IE_TB2"
REM '/^\s*$/d' you may have space/tabs in your "empty" line try this, see if it helps: http://stackoverflow.com/questions/16414410/delete-empty-lines-using-sed
"%SED%" -r "s/^\s{4}//;s/}\s+REG_.*/}/;/^\s*$/d" <"%JTEMP%\IE_TB" >"%JTEMP%\IE_TB2"
FINDSTR /IVG:"%JRT%\wl_toolbars.cfg" "%JTEMP%\IE_TB2">"%JTEMP%\IE_TB_T"
FC "%JTEMP%\IE_TB_T" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_2 )
for /f "usebackq delims=" %%i in ("%JTEMP%\IE_TB_T") do (
  REG QUERY "HKCU\Software\Microsoft\Internet Explorer\Toolbar" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKCU\Software\Microsoft\Internet Explorer\Toolbar" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKCU\Software\Microsoft\Internet Explorer\Toolbar" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKCU\Software\Microsoft\Internet Explorer\Toolbar\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKCU\Software\Microsoft\Internet Explorer\Toolbar\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
  REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Toolbar\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
  REG QUERY "HKLM\Software\Microsoft\Internet Explorer\Toolbar" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\Software\Microsoft\Internet Explorer\Toolbar" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKLM\Software\Microsoft\Internet Explorer\Toolbar" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKLM\Software\Microsoft\Internet Explorer\Toolbar\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKLM\Software\Microsoft\Internet Explorer\Toolbar\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
  REG QUERY "HKCU\Software\Microsoft\Internet Explorer\Toolbar\WebBrowser" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKCU\Software\Microsoft\Internet Explorer\Toolbar\WebBrowser" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKCU\Software\Microsoft\Internet Explorer\Toolbar\WebBrowser" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKCU\Software\Microsoft\Internet Explorer\Toolbar\WebBrowser\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKCU\Software\Microsoft\Internet Explorer\Toolbar\WebBrowser\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
)
:Browsers_2
REG QUERY "HKCU\Software\Microsoft\Internet Explorer\URLSearchHooks" 2>NUL|"%GREP%" -iP "{[a-f0-9]+-.*}">"%JTEMP%\IE_SH"
if %ARCH%==x64 (
  REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\URLSearchHooks" 2>NUL|"%GREP%" -iP "{[a-f0-9]+-.*}">>"%JTEMP%\IE_SH"
)
REG QUERY "HKLM\Software\Microsoft\Internet Explorer\URLSearchHooks" 2>NUL|"%GREP%" -iP "{[a-f0-9]+-.*}">>"%JTEMP%\IE_SH"
FC "%JTEMP%\IE_SH" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_3 )
"%SORT_%" -f -u <"%JTEMP%\IE_SH" >"%JTEMP%\IE_SH2"
FINDSTR /IG:"%JRT%\bl_urls.cfg" "%JTEMP%\IE_SH2">"%JTEMP%\IE_SH_T"
FC "%JTEMP%\IE_SH_T" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_3 )
"%GREP%" -i -P "\{.*\}" -o "%JTEMP%\IE_SH_T">"%JTEMP%\IE_SH_H"
for /f "usebackq delims=" %%i in ("%JTEMP%\IE_SH_H") do (
  REG QUERY "HKCU\Software\Microsoft\Internet Explorer\URLSearchHooks" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKCU\Software\Microsoft\Internet Explorer\URLSearchHooks" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKCU\Software\Microsoft\Internet Explorer\URLSearchHooks" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKCU\Software\Microsoft\Internet Explorer\URLSearchHooks\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKCU\Software\Microsoft\Internet Explorer\URLSearchHooks\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
  REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\URLSearchHooks" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\URLSearchHooks" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\URLSearchHooks" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\URLSearchHooks\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\URLSearchHooks\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
  REG QUERY "HKLM\Software\Microsoft\Internet Explorer\URLSearchHooks" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\Software\Microsoft\Internet Explorer\URLSearchHooks" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKLM\Software\Microsoft\Internet Explorer\URLSearchHooks" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKLM\Software\Microsoft\Internet Explorer\URLSearchHooks\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKLM\Software\Microsoft\Internet Explorer\URLSearchHooks\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
)
:Browsers_3
REG QUERY "HKCU\Software\Microsoft\Internet Explorer\Main" 2>NUL|"%GREP%" -iP "REG_.*SZ\s+http">"%JTEMP%\IE_MAIN"
REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Main" 2>NUL|"%GREP%" -iP "REG_.*SZ\s+http">>"%JTEMP%\IE_MAIN"
REG QUERY "HKLM\Software\Microsoft\Internet Explorer\Main" 2>NUL|"%GREP%" -iP "REG_.*SZ\s+http">>"%JTEMP%\IE_MAIN"
FC "%JTEMP%\IE_MAIN" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_4 )
"%SORT_%" -f -u <"%JTEMP%\IE_MAIN" >"%JTEMP%\IE_MAIN2"
FC "%JTEMP%\IE_MAIN2" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_4 )
FINDSTR /IG:"%JRT%\bl_urls.cfg" "%JTEMP%\IE_MAIN2">"%JTEMP%\IE_MAIN_T"
FC "%JTEMP%\IE_MAIN_T" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_4 )
"%SED%" -r "s/^\s{4}//;s/\s+REG_SZ\s+.*//" "%JTEMP%\IE_MAIN_T">"%JTEMP%\IE_MAIN_H"
for /f "usebackq delims=" %%i in ("%JTEMP%\IE_MAIN_H") do (
  REG QUERY "HKCU\Software\Microsoft\Internet Explorer\Main" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKCU\Software\Microsoft\Internet Explorer\Main" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKCU\Software\Microsoft\Internet Explorer\Main" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKCU\Software\Microsoft\Internet Explorer\Main\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKCU\Software\Microsoft\Internet Explorer\Main\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
  REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Main" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Main" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Main" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Main\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Main\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
  REG QUERY "HKLM\Software\Microsoft\Internet Explorer\Main" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\Software\Microsoft\Internet Explorer\Main" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKLM\Software\Microsoft\Internet Explorer\Main" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKLM\Software\Microsoft\Internet Explorer\Main\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKLM\Software\Microsoft\Internet Explorer\Main\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
)
:Browsers_4
REG QUERY "HKCU\Software\Microsoft\Internet Explorer\Search" 2>NUL|"%GREP%" -iP "REG_.*SZ\s+http">"%JTEMP%\IE_SEARCH"
REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Search" 2>NUL|"%GREP%" -iP "REG_.*SZ\s+http">>"%JTEMP%\IE_SEARCH"
REG QUERY "HKLM\Software\Microsoft\Internet Explorer\Search" 2>NUL|"%GREP%" -iP "REG_.*SZ\s+http">>"%JTEMP%\IE_SEARCH"
FC "%JTEMP%\IE_SEARCH" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_5 )
"%SORT_%" -f -u <"%JTEMP%\IE_SEARCH">"%JTEMP%\IE_SEARCH2"
FC "%JTEMP%\IE_SEARCH2" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_5 )
FINDSTR /IG:"%JRT%\bl_urls.cfg" "%JTEMP%\IE_SEARCH2">"%JTEMP%\IE_SEARCH_T"
FC "%JTEMP%\IE_SEARCH_T" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_5 )
"%SED%" "s/^....//;s/REG_SZ.*//g;s/\s*$//g" "%JTEMP%\IE_SEARCH_T">"%JTEMP%\IE_SEARCH_H"
for /f "usebackq delims=" %%i in ("%JTEMP%\IE_SEARCH_H") do (
  REG QUERY "HKCU\Software\Microsoft\Internet Explorer\Search" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKCU\Software\Microsoft\Internet Explorer\Search" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKCU\Software\Microsoft\Internet Explorer\Search" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKCU\Software\Microsoft\Internet Explorer\Search\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKCU\Software\Microsoft\Internet Explorer\Search\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
  REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Search" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Search" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Search" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Search\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Search\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
  REG QUERY "HKLM\Software\Microsoft\Internet Explorer\Search" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\Software\Microsoft\Internet Explorer\Search" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKLM\Software\Microsoft\Internet Explorer\Search" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKLM\Software\Microsoft\Internet Explorer\Search\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKLM\Software\Microsoft\Internet Explorer\Search\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
)
:Browsers_5
REG QUERY "HKCU\Software\Microsoft\Internet Explorer\SearchUrl" 2>NUL|FINDSTR "http">"%JTEMP%\IE_SEARCHURL"
REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\SearchUrl" 2>NUL|FINDSTR "http">>"%JTEMP%\IE_SEARCHURL"
REG QUERY "HKLM\Software\Microsoft\Internet Explorer\SearchUrl" 2>NUL|FINDSTR "http">>"%JTEMP%\IE_SEARCHURL"
FC "%JTEMP%\IE_SEARCHURL" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_6 )
"%SORT_%" -f -u <"%JTEMP%\IE_SEARCHURL" >"%JTEMP%\IE_SEARCHURL2"
FC "%JTEMP%\IE_SEARCHURL2" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_6 )
FINDSTR /IG:"%JRT%\bl_urls.cfg" "%JTEMP%\IE_SEARCHURL">"%JTEMP%\IE_SEARCHURL_T"
FC "%JTEMP%\IE_SEARCHURL_T" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Browsers_6 )
"%SED%" "s/^....//;s/REG_SZ.*//g;s/\s*$//g" "%JTEMP%\IE_SEARCHURL_T">"%JTEMP%\IE_SEARCHURL_H"
for /f "usebackq delims=" %%i in ("%JTEMP%\IE_SEARCHURL_H") do (
  REG QUERY "HKCU\Software\Microsoft\Internet Explorer\SearchUrl" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKCU\Software\Microsoft\Internet Explorer\SearchUrl" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKCU\Software\Microsoft\Internet Explorer\SearchUrl" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKCU\Software\Microsoft\Internet Explorer\SearchUrl\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKCU\Software\Microsoft\Internet Explorer\SearchUrl\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
  REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\SearchUrl" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\SearchUrl" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKLM\Software\Microsoft\Wow6432Node\Internet Explorer\SearchUrl" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\SearchUrl\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\SearchUrl\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
  REG QUERY "HKLM\Software\Microsoft\Internet Explorer\SearchUrl" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\Software\Microsoft\Internet Explorer\SearchUrl" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKLM\Software\Microsoft\Internet Explorer\SearchUrl" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKLM\Software\Microsoft\Internet Explorer\SearchUrl\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKLM\Software\Microsoft\Internet Explorer\SearchUrl\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
)
:Browsers_6
REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\AboutURLs" 2>NUL|FINDSTR "http">>"%JTEMP%\IE_ABOUTURL"
REG QUERY "HKLM\Software\Microsoft\Internet Explorer\AboutURLs" 2>NUL|FINDSTR "http">>"%JTEMP%\IE_ABOUTURL"
FC "%JTEMP%\IE_ABOUTURL" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :FireFox_0 )
FINDSTR /IG:"%JRT%\bl_urls.cfg" "%JTEMP%\IE_ABOUTURL" 2>NUL>"%JTEMP%\IE_ABOUTURL_SUSPECT"
FC "%JTEMP%\IE_ABOUTURL_SUSPECT" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :FireFox_0 )
"%SED%" "s/^....//;s/REG_SZ.*//g;s/\s*$//g" "%JTEMP%\IE_ABOUTURL_SUSPECT">"%JTEMP%\IE_ABOUTURL_H"
"%SORT_%" -f -u <"%JTEMP%\IE_ABOUTURL_H" >"%JTEMP%\IE_ABOUTURL_T"
for /f "usebackq delims=" %%i in ("%JTEMP%\IE_ABOUTURL_T") do (
  REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\AboutURLs" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\AboutURLs" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\AboutURLs" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\AboutURLs\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\AboutURLs\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
  REG QUERY "HKLM\Software\Microsoft\Internet Explorer\AboutURLs" /V "%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\Software\Microsoft\Internet Explorer\AboutURLs" /V "%%i" /F >NUL 2>&1
    REG QUERY "HKLM\Software\Microsoft\Internet Explorer\AboutURLs" /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: HKLM\Software\Microsoft\Internet Explorer\AboutURLs\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: HKLM\Software\Microsoft\Internet Explorer\AboutURLs\\%%i ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
)
:FireFox_0
DIR /B/S/A:-D "%PROGRAMFILES%\Mozilla Firefox" 2>NUL>"%JTEMP%\FIREFOX_F_PROG"
FC "%JTEMP%\FIREFOX_F_PROG" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :FireFox_1 )
for %%i in (
"%programfiles%\mozilla firefox\defaults\pref\all-iminent.js"
"%programfiles%\mozilla firefox\defaults\pref\itms.js"
"%programfiles%\mozilla firefox\nsprotector.js"
"%programfiles%\mozilla firefox\plugins\npclntax_clickpotatolitesa.dll"
"%programfiles%\mozilla firefox\plugins\npcouponprinter.dll"
"%programfiles%\mozilla firefox\plugins\npdnu.dll"
"%programfiles%\mozilla firefox\plugins\npdnu.xpt"
"%programfiles%\mozilla firefox\plugins\npdnupdater2.dll"
"%programfiles%\mozilla firefox\plugins\npdnupdater2.xpt"
"%programfiles%\mozilla firefox\plugins\npmozcouponprinter.dll"
"%programfiles%\mozilla firefox\plugins\nptrademanager.dll"
"%programfiles%\mozilla firefox\plugins\npwangwang.dll"
) DO (
      IF EXIST %%i (
                    DEL /F/Q %%i >NUL 2>&1
                    IF EXIST %%i ( ECHO(Failed to delete: %%i ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: %%i ^(File^)>>"%JTEMP%\R_Files.txt" )
                   )             
)
FINDSTR /I "\.XML$" "%JTEMP%\FIREFOX_F_PROG" 2>NUL>"%JTEMP%\FIREFOX_F_PROGXML"
FC "%JTEMP%\FIREFOX_F_PROGXML" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :FireFox_1 )
for /f "usebackq delims=" %%i in ("%JRT%\bl_ffxml.cfg") do (
 DIR "%PROGRAMFILES%\Mozilla Firefox\searchplugins\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%PROGRAMFILES%\Mozilla Firefox\searchplugins\%%i" >NUL 2>&1
    DIR "%PROGRAMFILES%\Mozilla Firefox\searchplugins\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%PROGRAMFILES%\Mozilla Firefox\searchplugins\%%i" ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%PROGRAMFILES%\Mozilla Firefox\searchplugins\%%i" ^(File^)>>"%JTEMP%\R_Files.txt" )
    )
)
:FireFox_1
DIR /B/A:D "%PROGRAMFILES%\Mozilla Firefox\browser\extensions" 2>NUL>"%JTEMP%\FIREFOX_D_PROG"
FC "%JTEMP%\FIREFOX_D_PROG" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :FireFox_3 )
"%GREP%" -i -P "^ffxtlbr@.*|^\w{2}ffxtbr@.*_\w{2}\.com$|^\d{3}$|^[0-9a-f]{21,30}@[0-9a-f]{24,29}\.com$|^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}@[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\.com$" "%JTEMP%\FIREFOX_D_PROG">"%JTEMP%\FIREFOX_D_PROG_H"
FC "%JTEMP%\FIREFOX_D_PROG_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :FireFox_2 )
for /f "usebackq delims=" %%i in ("%JTEMP%\FIREFOX_D_PROG_H") do (
 DIR "%PROGRAMFILES%\Mozilla Firefox\browser\extensions\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    RD /S/Q "%PROGRAMFILES%\Mozilla Firefox\browser\extensions\%%i" >NUL 2>&1
    DIR "%PROGRAMFILES%\Mozilla Firefox\browser\extensions\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%PROGRAMFILES%\Mozilla Firefox\browser\extensions\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%PROGRAMFILES%\Mozilla Firefox\browser\extensions\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
    )
 REG QUERY HKCU\Software\Mozilla\Firefox\Extensions /V "%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1 (
    REG DELETE HKCU\Software\Mozilla\Firefox\Extensions /V "%%i" /F >NUL 2>&1
    REG QUERY HKCU\Software\Mozilla\Firefox\Extensions /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKCU\Software\Mozilla\Firefox\Extensions\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKCU\Software\Mozilla\Firefox\Extensions\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
 REG QUERY HKLM\Software\Wow6432Node\Mozilla\Firefox\Extensions /V "%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1 (
    REG DELETE HKLM\Software\Wow6432Node\Mozilla\Firefox\Extensions /V "%%i" /F >NUL 2>&1
    REG QUERY HKLM\Software\Wow6432Node\Mozilla\Firefox\Extensions /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKLM\Software\Wow6432Node\Mozilla\Firefox\Extensions\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKLM\Software\Wow6432Node\Mozilla\Firefox\Extensions\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
 REG QUERY HKLM\Software\Mozilla\Firefox\Extensions /V "%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1 (
    REG DELETE HKLM\Software\Mozilla\Firefox\Extensions /V "%%i" /F >NUL 2>&1
    REG QUERY HKLM\Software\Mozilla\Firefox\Extensions /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKLM\Software\Mozilla\Firefox\Extensions\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKLM\Software\Mozilla\Firefox\Extensions\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
)
:FireFox_2
for /f "usebackq delims=" %%i in ("%JRT%\bl_ffext.cfg") do (
 DIR "%PROGRAMFILES%\Mozilla Firefox\browser\extensions\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    RD /S/Q "%PROGRAMFILES%\Mozilla Firefox\browser\extensions\%%i" >NUL 2>&1
    DIR "%PROGRAMFILES%\Mozilla Firefox\browser\extensions\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%PROGRAMFILES%\Mozilla Firefox\browser\extensions\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%PROGRAMFILES%\Mozilla Firefox\browser\extensions\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
    )
 REG QUERY HKCU\Software\Mozilla\Firefox\Extensions /V "%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1 (
    REG DELETE HKCU\Software\Mozilla\Firefox\Extensions /V "%%i" /F >NUL 2>&1
    REG QUERY HKCU\Software\Mozilla\Firefox\Extensions /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKCU\Software\Mozilla\Firefox\Extensions\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKCU\Software\Mozilla\Firefox\Extensions\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
 REG QUERY HKLM\Software\Wow6432Node\Mozilla\Firefox\Extensions /V "%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1 (
    REG DELETE HKLM\Software\Wow6432Node\Mozilla\Firefox\Extensions /V "%%i" /F >NUL 2>&1
    REG QUERY HKLM\Software\Wow6432Node\Mozilla\Firefox\Extensions /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKLM\Software\Wow6432Node\Mozilla\Firefox\Extensions\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKLM\Software\Wow6432Node\Mozilla\Firefox\Extensions\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
 REG QUERY HKLM\Software\Mozilla\Firefox\Extensions /V "%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1 (
    REG DELETE HKLM\Software\Mozilla\Firefox\Extensions /V "%%i" /F >NUL 2>&1
    REG QUERY HKLM\Software\Mozilla\Firefox\Extensions /V "%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKLM\Software\Mozilla\Firefox\Extensions\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKLM\Software\Mozilla\Firefox\Extensions\\%%i" ^(Registry Value^)>>"%JTEMP%\R_Registry.txt" )
    )
)
:FireFox_3
DIR /B/S/A:-D "%APPDATA%\Mozilla\Firefox\Profiles" 2>NUL>"%JTEMP%\FIREFOX_F_APPDATA"
FC "%JTEMP%\FIREFOX_F_APPDATA" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :FireFox_5 )
"%GREP%" -P "user\.js$|firefox@www\.[a-z]{10,}\.(com|net)\.xpi$" "%JTEMP%\FIREFOX_F_APPDATA">"%JTEMP%\FIREFOX_F_APPDATA_H"
"%GREP%" -i -P "(bprotector|browsermngr)_.*\..*$|invalidprefs.js$|\d{3}\.xpi$" "%JTEMP%\FIREFOX_F_APPDATA">>"%JTEMP%\FIREFOX_F_APPDATA_H"
FINDSTR /IG:"%JRT%\bl_ffxpi.cfg" "%JTEMP%\FIREFOX_F_APPDATA" 2>NUL>>"%JTEMP%\FIREFOX_F_APPDATA_H"
"%GREP%" -v -P ".*\\gm_scripts\\.*|.*\\foxmarks@kei\.com\\.*" "%JTEMP%\FIREFOX_F_APPDATA_H">"%JTEMP%\FIREFOX_F_APPDATA_H_WL"
FC "%JTEMP%\FIREFOX_F_APPDATA_H_WL" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :FireFox_4 )
for /f "usebackq delims=" %%i in ("%JTEMP%\FIREFOX_F_APPDATA_H_WL") do (
  DEL /F/Q "%%i" >NUL 2>&1
  IF EXIST "%%i" ( ECHO(Failed to delete: "%%i" ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: "%%i" ^(File^)>>"%JTEMP%\R_Files.txt" )
)
:FireFox_4
FINDSTR /I "\.XML$" "%JTEMP%\FIREFOX_F_APPDATA" 2>NUL>"%JTEMP%\FIREFOX_F_APPDATAXML"
FC "%JTEMP%\FIREFOX_F_APPDATAXML" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :FireFox_5 )
FINDSTR /IG:"%JRT%\bl_ffxml.cfg" "%JTEMP%\FIREFOX_F_APPDATAXML" 2>NUL>"%JTEMP%\FIREFOX_F_APPDATAXML_H"
FC "%JTEMP%\FIREFOX_F_APPDATAXML_H" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :FireFox_5 )
for /f "usebackq delims=" %%i in ("%JTEMP%\FIREFOX_F_APPDATAXML_H") do (
  DEL /F/Q "%%i" >NUL 2>&1
  IF EXIST "%%i" ( ECHO(Failed to delete: "%%i" ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: "%%i" ^(File^)>>"%JTEMP%\R_Files.txt" )
)
:FireFox_5
"%GREP%" -i -P "\\Firefox\\Profiles\\.*\.default.*\\prefs.js$" "%JTEMP%\FIREFOX_F_APPDATA" 2>NUL>"%JTEMP%\FIREFOX_F_APPDATAJS"
FC "%JTEMP%\FIREFOX_F_APPDATAJS" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :FireFox_6 )
for /f "usebackq delims=" %%i in ("%JTEMP%\FIREFOX_F_APPDATAJS") do (
  COPY /Y "%%i" "%JTEMP%\prefs.js" >NUL 2>&1
)
IF NOT EXIST "%JTEMP%\prefs.js" GOTO :FireFox_6
SET /p FFJS=<"%JTEMP%\FIREFOX_F_APPDATAJS"
FINDSTR /IG:"%JRT%\bl_urls.cfg" "%JTEMP%\prefs.js" 2>NUL|"%CUT%" -c1-175>"%JTEMP%\FIREFOX_PREFS_BAD"
FINDSTR /IVG:"%JRT%\wl_firefox.cfg" "%JTEMP%\FIREFOX_PREFS_BAD" 2>NUL>"%JTEMP%\FIREFOX_PREFS_BAD_WL"
FC "%JTEMP%\FIREFOX_PREFS_BAD_WL" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :FireFox_6 )
FINDSTR /IVG:"%JTEMP%\FIREFOX_PREFS_BAD_WL" "%JTEMP%\prefs.js" 2>NUL>"%JTEMP%\FIREFOX_PREFS_CLEAN.js"
COPY /Y "%JTEMP%\FIREFOX_PREFS_CLEAN.js" "%FFJS%" >NUL 2>&1
TYPE "%JTEMP%\FIREFOX_PREFS_BAD_WL">"%JTEMP%\R_FireFox.txt"
:FireFox_6
DIR /B/S/A:D "%APPDATA%\Mozilla\Firefox\Profiles" 2>NUL>"%JTEMP%\FIREFOX_D_APPDATA"
FC "%JTEMP%\FIREFOX_D_APPDATA" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :Chrome )
FINDSTR "\\extensions\\" "%JTEMP%\FIREFOX_D_APPDATA" 2>NUL>"%JTEMP%\FIREFOX_D_APPDATAEXT"
FC "%JTEMP%\FIREFOX_D_APPDATAEXT" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :FireFox_7 )
"%GREP%" -i -P "ffxtlbr@.*|\d{3}$|[0-9a-f]{21,30}@[0-9a-f]{24,29}\.com$|[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}@[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\.com$" "%JTEMP%\FIREFOX_D_APPDATAEXT">"%JTEMP%\FIREFOX_D_APPDATAEXT_H"
FINDSTR /IELG:"%JRT%\bl_ffext.cfg" "%JTEMP%\FIREFOX_D_APPDATAEXT" 2>NUL>>"%JTEMP%\FIREFOX_D_APPDATAEXT_H"
"%GREP%" -v -P ".*\\https-everywhere.*|.*\\[a-z]{2}_\d{3}$" "%JTEMP%\FIREFOX_D_APPDATAEXT_H">"%JTEMP%\FIREFOX_D_APPDATAEXT_H_WL"
FC "%JTEMP%\FIREFOX_D_APPDATAEXT_H_WL" "%JRT%\null" >NUL 2>&1
IF %ERRORLEVEL% NEQ 1 ( GOTO :FireFox_7 )
"%SORT_%" -f -u <"%JTEMP%\FIREFOX_D_APPDATAEXT_H_WL" >"%JTEMP%\FIREFOX_D_APPDATAEXT_T"
for /f "usebackq delims=" %%i in ("%JTEMP%\FIREFOX_D_APPDATAEXT_T") do (
  RD /S/Q "%%i" >NUL 2>&1
  IF EXIST "%%i" ( ECHO(Failed to delete: "%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Successfully deleted: "%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
)
:FireFox_7
REG QUERY "HKLM\Software\MozillaPlugins" >NUL 2>&1
IF ERRORLEVEL 1 GOTO FireFox_8
for /f "usebackq delims=" %%i in ("%JRT%\bl_ffplugin.cfg") do (
  REG QUERY "HKLM\Software\MozillaPlugins\%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\Software\MozillaPlugins\%%i" /F >NUL 2>&1
    REG QUERY "HKLM\Software\MozillaPlugins\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKLM\Software\MozillaPlugins\%%i" ^(Registry Key^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKLM\Software\MozillaPlugins\%%i" ^(Registry Key^)>>"%JTEMP%\R_Registry.txt" )
    )
)
:FireFox_8
REG QUERY "HKLM\Software\Wow6432Node\MozillaPlugins" >NUL 2>&1
IF ERRORLEVEL 1 GOTO Chrome
for /f "usebackq delims=" %%i in ("%JRT%\bl_ffplugin.cfg") do (
  REG QUERY "HKLM\Software\Wow6432Node\MozillaPlugins\%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\Software\Wow6432Node\MozillaPlugins\%%i" /F >NUL 2>&1
    REG QUERY "HKLM\Software\Wow6432Node\MozillaPlugins\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKLM\Software\Wow6432Node\MozillaPlugins\%%i" ^(Registry Key^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKLM\Software\Wow6432Node\MozillaPlugins\%%i" ^(Registry Key^)>>"%JTEMP%\R_Registry.txt" )
    )
)
:Chrome
CD /D "%LOCALA%\Google\Chrome\User Data\Default\Local Storage" >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 ( GOTO :Chrome_0 )
for /f "usebackq delims=" %%i in ("%JRT%\bl_chrstrg.cfg") do (
 DIR "%LOCALA%\Google\Chrome\User Data\Default\Local Storage\%%i" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%LOCALA%\Google\Chrome\User Data\Default\Local Storage\%%i" >NUL 2>&1
    DIR "%LOCALA%\Google\Chrome\User Data\Default\Local Storage\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%LOCALA%\Google\Chrome\User Data\Default\Local Storage\%%i" ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%LOCALA%\Google\Chrome\User Data\Default\Local Storage\%%i" ^(File^)>>"%JTEMP%\R_Files.txt" )
    )
 DIR "%LOCALA%\Google\Chrome\User Data\Default\Local Storage\%%i-journal" >NUL 2>&1
 IF NOT ERRORLEVEL 1  (
    DEL /F/Q "%LOCALA%\Google\Chrome\User Data\Default\Local Storage\%%i-journal" >NUL 2>&1
    DIR "%LOCALA%\Google\Chrome\User Data\Default\Local Storage\%%i-journal" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%LOCALA%\Google\Chrome\User Data\Default\Local Storage\%%i-journal" ^(File^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%LOCALA%\Google\Chrome\User Data\Default\Local Storage\%%i-journal" ^(File^)>>"%JTEMP%\R_Files.txt" )
   )
)
:Chrome_0
CD /D "%LOCALA%\Google\Chrome\User Data\Default\Extensions" >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 ( GOTO :Shortcuts )
for /f "usebackq delims=" %%i in ("%JRT%\bl_chrext.cfg") do (
  DIR "%LOCALA%\Google\Chrome\User Data\Default\Extensions\%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1  (
    RD /S/Q "%LOCALA%\Google\Chrome\User Data\Default\Extensions\%%i" >NUL 2>&1
    DIR "%LOCALA%\Google\Chrome\User Data\Default\Extensions\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%LOCALA%\Google\Chrome\User Data\Default\Extensions\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%LOCALA%\Google\Chrome\User Data\Default\Extensions\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
    )
  DIR "%LOCALA%\Google\Chrome\User Data\Default\Local Extension Settings\%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1  (
    RD /S/Q "%LOCALA%\Google\Chrome\User Data\Default\Local Extension Settings\%%i" >NUL 2>&1
    DIR "%LOCALA%\Google\Chrome\User Data\Default\Local Extension Settings\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "%LOCALA%\Google\Chrome\User Data\Default\Local Extension Settings\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" ) ELSE ( ECHO(Failed to delete: "%LOCALA%\Google\Chrome\User Data\Default\Local Extension Settings\%%i" ^(Folder^)>>"%JTEMP%\R_Files.txt" )
    )
  REG QUERY "HKCU\Software\Google\Chrome\Extensions\%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKCU\Software\Google\Chrome\Extensions\%%i" /F >NUL 2>&1
    REG QUERY "HKCU\Software\Google\Chrome\Extensions\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKCU\Software\Google\Chrome\Extensions\%%i" ^(Registry Key^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKCU\Software\Google\Chrome\Extensions\%%i" ^(Registry Key^)>>"%JTEMP%\R_Registry.txt" )
    )
  REG QUERY "HKLM\Software\Google\Chrome\Extensions\%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\Software\Google\Chrome\Extensions\%%i" /F >NUL 2>&1
    REG QUERY "HKLM\Software\Google\Chrome\Extensions\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKLM\Software\Google\Chrome\Extensions\%%i" ^(Registry Key^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKLM\Software\Google\Chrome\Extensions\%%i" ^(Registry Key^)>>"%JTEMP%\R_Registry.txt" )
    )
)
REG QUERY "HKLM\Software\Wow6432Node\Google\Chrome\Extensions" >NUL 2>&1
IF ERRORLEVEL 1 GOTO Shortcuts
for /f "usebackq delims=" %%i in ("%JRT%\bl_chrext.cfg") do (
  REG QUERY "HKLM\Software\Wow6432Node\Google\Chrome\Extensions\%%i" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
    REG DELETE "HKLM\Software\Wow6432Node\Google\Chrome\Extensions\%%i" /F >NUL 2>&1
    REG QUERY "HKLM\Software\Wow6432Node\Google\Chrome\Extensions\%%i" >NUL 2>&1
    IF ERRORLEVEL 1 ( ECHO(Successfully deleted: "HKLM\Software\Wow6432Node\Google\Chrome\Extensions\%%i" ^(Registry Key^)>>"%JTEMP%\R_Registry.txt" ) ELSE ( ECHO(Failed to delete: "HKLM\Software\Wow6432Node\Google\Chrome\Extensions\%%i" ^(Registry Key^)>>"%JTEMP%\R_Registry.txt" )
    )
)
:Shortcuts
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
Echo((******* )  Shortcuts
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
IF NOT EXIST "%SYS32%\cscript.exe" GOTO CreateReport
DIR /B/S "%QUICKLAUNCHALL%\*.lnk" 2>NUL>"%JTEMP%\SHORTCUTS"
DIR /B/S "%PROGRAMS1ALL%\*.lnk" 2>NUL>>"%JTEMP%\SHORTCUTS"
DIR /B/S "%PROGRAMS2ALL%\*.lnk" 2>NUL>>"%JTEMP%\SHORTCUTS"
DIR /B/S "%STARTUP%\*.lnk" 2>NUL>>"%JTEMP%\SHORTCUTS"
DIR /B/S "%userprofile%\Desktop\*.lnk" 2>NUL>>"%JTEMP%\SHORTCUTS"
ECHO %OS%|FIND "Windows XP" >NUL
IF %ERRORLEVEL% EQU 0 ( GOTO :Shortcuts_XP )
DIR /B/S "%PUBDESKTOP%\*.lnk" 2>NUL>>"%JTEMP%\SHORTCUTS"
DIR /B/S "%QUICKLAUNCH17%\*.lnk" 2>NUL>>"%JTEMP%\SHORTCUTS"
DIR /B/S "%QUICKLAUNCH27%\*.lnk" 2>NUL>>"%JTEMP%\SHORTCUTS"
DIR /B/S "%PROGRAMS17%\*.lnk" 2>NUL>>"%JTEMP%\SHORTCUTS"
DIR /B/S "%PROGRAMS27%\*.lnk" 2>NUL>>"%JTEMP%\SHORTCUTS"
DIR /B/S "%STARTMENU17%\*.lnk" 2>NUL>>"%JTEMP%\SHORTCUTS"
DIR /B/S "%STARTMENU27%\*.lnk" 2>NUL>>"%JTEMP%\SHORTCUTS"
GOTO Shortcuts_0
:Shortcuts_XP
DIR /B/S "%LNK1XP%\*.lnk" 2>NUL>>"%JTEMP%\SHORTCUTS"
DIR /B/S "%LNK2XP%\*.lnk" 2>NUL>>"%JTEMP%\SHORTCUTS"
:Shortcuts_0
"%SORT_%" -f -u <"%JTEMP%\SHORTCUTS" >"%JTEMP%\SHORTCUTS_SUSPECT"
for /f "usebackq delims=" %%i in ("%JTEMP%\SHORTCUTS_SUSPECT") do (
  "%SHORTCUT%" /F:"%%i" /A:Q|FINDSTR /IG:"%JRT%\bl_lnkurls.cfg" >NUL 2>&1
  IF NOT ERRORLEVEL 1 (
                       SETLOCAL EnableDelayedExpansion
                       CSCRIPT //B //NOLOGO "!JRT!\clean_shortcut.vbs" "%%i" >NUL 2>&1
                       ECHO(Successfully repaired: "%%i" ^(Shortcut^)>>"!JTEMP!\R_Files.txt"
                      )
                       ENDLOCAL
)
:CreateReport
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
Echo((********)  Preparing Report
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
echo.
Set R_Files="%JTEMP%\R_Files.txt"
Set R_Registry="%JTEMP%\R_Registry.txt"
Set /a _LinesF=0
Set /a _LinesR=0
For /f %%j in ('Type %R_Files% 2^>nul^|Find "" /v /c') Do Set /a _LinesF=%%j
For /f %%j in ('Type %R_Registry% 2^>nul^|Find "" /v /c') Do Set /a _LinesR=%%j
Echo(~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>"%JTEMP%\R_REPORT.txt"
Echo(Junkware Removal Tool ^(JRT^) by Malwarebytes>>"%JTEMP%\R_REPORT.txt"
Echo(Version: 8.1.4 ^(07.09.2017^)>>"%JTEMP%\R_REPORT.txt"
Echo(Operating System: %OS% %ARCH%>>"%JTEMP%\R_REPORT.txt"
Echo(Ran by "%username%" ^(%USERSTATUS%^) on %StartDate% at %StartTime%>>"%JTEMP%\R_REPORT.txt"
Echo(~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>"%JTEMP%\R_REPORT.txt"
echo.>>"%JTEMP%\R_REPORT.txt"
echo.>>"%JTEMP%\R_REPORT.txt"
echo.>>"%JTEMP%\R_REPORT.txt"
echo.>>"%JTEMP%\R_REPORT.txt"
ECHO(File System^: %_LinesF% >>"%JTEMP%\R_REPORT.txt"
echo.>>"%JTEMP%\R_REPORT.txt"
IF EXIST "%JTEMP%\R_Files.txt" (
  "%SORT_%" -f -u -s <"%JTEMP%\R_Files.txt" >"%JTEMP%\R_Files_T.txt"
  type "%JTEMP%\R_Files_T.txt">>"%JTEMP%\R_REPORT.txt"
)
IF EXIST "%JTEMP%\R_FireFox.txt" (
  echo.>>"%JTEMP%\R_REPORT.txt"
  ECHO(Deleted the following from "%FFJS%">>"%JTEMP%\R_REPORT.txt"
  type "%JTEMP%\R_FireFox.txt">>"%JTEMP%\R_REPORT.txt"
)
echo.>>"%JTEMP%\R_REPORT.txt"
echo.>>"%JTEMP%\R_REPORT.txt"
echo.>>"%JTEMP%\R_REPORT.txt"
ECHO(Registry^: %_LinesR% >>"%JTEMP%\R_REPORT.txt"
echo.>>"%JTEMP%\R_REPORT.txt"
IF EXIST "%JTEMP%\R_Registry.txt" (
  "%SORT_%" -f -u -s <"%JTEMP%\R_Registry.txt" >"%JTEMP%\R_Registry_T.txt"
  type "%JTEMP%\R_Registry_T.txt">>"%JTEMP%\R_REPORT.txt"
)
echo.>>"%JTEMP%\R_REPORT.txt"
echo.>>"%JTEMP%\R_REPORT.txt"
echo.>>"%JTEMP%\R_REPORT.txt"
echo.>>"%JTEMP%\R_REPORT.txt"
Echo(~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>"%JTEMP%\R_REPORT.txt"
Echo(Scan was completed on %date% at %time%>>"%JTEMP%\R_REPORT.txt"
Echo(End of JRT log>>"%JTEMP%\R_REPORT.txt"
Echo(~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>"%JTEMP%\R_REPORT.txt"
"%SED%" "s/\x22//g;s/\http/hxxp/g;s/Sysnative/system32/;s/HKEY_LOCAL_MACHINE/HKLM/;s/HKEY_CURRENT_USER/HKCU/" "%JTEMP%\R_REPORT.txt">"%JTEMP%\R_REPORT_T.txt"
COPY /Y "%JTEMP%\R_REPORT_T.txt" "%JTEMP%\JRT.txt" >NUL 2>&1
COPY /Y "%JTEMP%\R_REPORT_T.txt" "%USERPROFILE%\Desktop\JRT.txt" >NUL 2>&1
ECHO(JRT has successfully been run. Please review the report in JRT.txt.
NOTEPAD "%JTEMP%\JRT.txt"
DEL /F/Q "%JTEMP%\*" >NUL 2>&1
DEL /F/Q "%JRT%\*" >NUL 2>&1
EXIT