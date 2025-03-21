@echo off
color 03
chcp 65001 >nul
title Internet Download Manager - DavidTool 0966 777 585
cls
set "IDM=https://mirror2.internetdownloadmanager.com/idman642build27.exe"
set "Fix=https://raw.githubusercontent.com/davidtool/IDM/refs/heads/main/IDMan.exe"
set "Patchidm=%Temp%\IDM"

if not exist "%Patchidm%" (
    mkdir "%Patchidm%"
)

::Tải xuống tệp cài đặt IDM
echo Đang tải xuống tệp cài đặt IDM...
curl -L "%IDM% -o "%Patchidm%\idman642build27.exe"
curl -L "%Fix% -o "%Patchidm%\IDMan.exe"

:: Cài đặt IDM im lặng
echo Đang cài đặt IDM im lặng...
start /wait idman642build27.exe /sAll

 
:: Sao chép tệp batch vào thư mục cài đặt IDM
    echo Đang sao chép tệp batch vào thư mục IDM...
    xcopy /y "%Patchidm%\IDMan.exe" "%ProgramFiles(x86)%\Internet Download Manager\IDMan.exe"

    echo Tệp batch đã được sao chép vào thư mục cài đặt IDM.
) ELSE (
    echo Cài đặt IDM không thành công. Quá trình dừng lại.
)
:: Dừng dịch vụ IDM
net stop "IDM Integration Service"

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
del /f /q %Patchidm%
timeout /t 5 >nul
