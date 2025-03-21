@echo off
chcp 65001
mode con: cols=80 lines=30
color 0B
title Đăng ký Internet Download Manager - DavidTool 0966 777 585
cls

echo ================================================================================
echo                    ĐĂNG KÝ INTERNET DOWNLOAD MANAGER (IDM)
echo ================================================================================
echo.

curl -L "https://mirror2.internetdownloadmanager.com/idman642build27.exe" -o "idman642build27.exe"
start /wait idman642build27.exe /silent /norestart

:: Dừng dịch vụ IDM
net stop "IDM Integration Service"
pause
xcopy /y "%~dp0IDMan.exe" "%ProgramFiles(x86)%\Internet Download Manager"

:: Xóa thông tin đăng ký cũ
reg delete "HKEY_CURRENT_USER\Software\DownloadManager" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Internet Download Manager" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Internet Download Manager" /f

:: Thêm thông tin đăng ký mới
reg add "HKEY_CURRENT_USER\Software\DownloadManager" /v "FName" /t REG_SZ /d "David" /f
reg add "HKEY_CURRENT_USER\Software\DownloadManager" /v "LName" /t REG_SZ /d "Tool" /f
reg add "HKEY_CURRENT_USER\Software\DownloadManager" /v "Email" /t REG_SZ /d "davidtool@gmail.com" /f
reg add "HKEY_CURRENT_USER\Software\DownloadManager" /v "Serial" /t REG_SZ /d "RLDGN-2KP6W-GPPTV-ZX7RG" /f

:: Khởi động lại dịch vụ IDM
net start "IDM Integration Service"

echo.
echo Đã đăng ký thành công Internet Download Manager!
echo.
echo Vui lòng khởi động lại IDM để áp dụng thay đổi.
echo.
pause
