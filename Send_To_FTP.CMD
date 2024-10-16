@ECHO OFF
TITLE Sending to MYFTP.FORSYTHE.COM...
:: **************************************************************************************
:: * FILE:         SEndToFTPr.bat
:: * AUTHOR:       Chris M.
:: * CREATED:      2011-09-29
:: * OS:	   Tested on Win 7 and Win XP.
:: * PURPOSE:      Upload selected file(s) to FTP site via context menu
:: * USAGE:        Right-Click file(s) > SEND TO from the context menu > SendToFTP.
:: *
:: **************************************************************************************
:: * INSTRUCTIONS:
:: *
:: * 1. Place the SendToFtp.bat script somewhere on your C: drive for safe keeping.
:: * 2. Edit script and put in your FTP UserName/Password in the Server Variables section.
:: * 3. Start - RUn - Shell:sendto
:: * 4. Paste shortcut here.
:: *
:: **************************************************************************************
ECHO.
ECHO.

SETLOCAL EnableExtensions

:: Server Variables:
SET Server=myftp.mysite.com
SET UserName=YOUR_FTP_USERNAME_HERE
SET Password=YOUR_FTP_PASSWORD_HERE

:: Temp textdump file
SET dumpfile="%TEMP%\FTPdumpfile_%RANDOM%.txt"

:: FTP username and password
ECHO %UserName%> %dumpfile%
ECHO %Password%>> %dumpfile%

:: FTP transfer in binary mode
ECHO binary >> %dumpfile%

:AddFiles
IF {%1}=={} GOTO CloseConnection
ECHO put "%~dpnx1" >> %dumpfile%
SHIFT /1
GOTO AddFiles

:CloseConnection
:: Kill the FTP connection
ECHO close >> %dumpfile%
ECHO bye >> %dumpfile%

:: Initiate the FTP transfer
FTP -d -i -s:%dumpfile% %Server%

ECHO.
ECHO.

:: Erase textdump file
IF EXIST %dumpfile% DEL %dumpfile%

ENDLOCAL

TIMEOUT /T 10 