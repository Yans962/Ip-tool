@echo off
title Info-IP Tool
color 0A

:menu
cls
echo ===================================
echo         🛰️  INFO-IP TOOL 🛰️
echo ===================================
echo.
echo  [1] 🌐 Rechercher une IP (détails)
echo  [2] 👤 Nom associé à une IP
echo  [3] ❌ Quitter
echo.
set /p choice=🎯 Choisis une option [1-3] : 

if "%choice%"=="1" goto tracker
if "%choice%"=="2" goto ipname
if "%choice%"=="3" exit
goto menu

:tracker
cls
set /p target_ip=✏️  Entre l'adresse IP à analyser : 

echo.
echo [🔍] Recherche des informations pour %target_ip%...
echo.

curl -s http://ip-api.com/line/%target_ip% > ipinfo.txt

setlocal enabledelayedexpansion
set count=0
for /f "tokens=* delims=" %%a in (ipinfo.txt) do (
    set /a count+=1
    if !count! == 1 echo ✅ Statut           : %%a
    if !count! == 2 echo 🌍 Pays             : %%a
    if !count! == 3 echo 🏳️ Code pays        : %%a
    if !count! == 4 echo 📍 Région           : %%a
    if !count! == 5 echo 🧭 Région Code      : %%a
    if !count! == 6 echo 🏙️ Ville            : %%a
    if !count! == 7 echo 📨 Code Postal      : %%a
    if !count! == 8 (
        set lat=%%a
        echo 🧭 Latitude         : %%a
    )
    if !count! == 9 (
        set lon=%%a
        echo 🧭 Longitude        : %%a
    )
    if !count! == 10 echo 🌐 Fournisseur     : %%a
    if !count! == 11 (
        set org=%%a
        echo 🏢 Organisation     : [!org!]
    )
    if !count! == 12 echo 🔗 Réseau AS       : %%a
    if !count! == 13 echo 💻 IP Reçue        : %%a
)

echo.
echo 📍 Localisation approximative :
echo 🔗 Ouvrir Google Maps : https://www.google.com/maps?q=!lat!,!lon!

:: Ouvre le lien direct dans le navigateur
start https://www.google.com/maps?q=!lat!,!lon!

endlocal
del ipinfo.txt

echo.
echo [↩] Appuie sur une touche pour revenir au menu...
pause >nul
goto menu

:ipname
cls
set /p ipname=✏️  Entre l'adresse IP pour obtenir le nom associé : 

echo.
echo [👁️] Récupération du nom pour %ipname%...
echo.

curl -s http://ip-api.com/line/%ipname% > ipname.txt

setlocal enabledelayedexpansion
set count=0
for /f "tokens=* delims=" %%a in (ipname.txt) do (
    set /a count+=1
    if !count! == 11 set org=%%a
    if !count! == 12 set asn=%%a
)

echo 🏢 Organisation associée : ✨ [!org!] ✨
echo 🔗 Numéro réseau (AS)   : !asn!

endlocal
del ipname.txt

echo.
echo [↩] Appuie sur une touche pour revenir au menu...
pause >nul
goto menu
