@echo off
rem Installe une liste de logiciels via winget. Trouver un ID : winget search <nom>
set LOGICIELS=Valve.Steam Discord.Discord RiotGames.LeagueOfLegends.EUW VeyonSolutions.Veyon EpicGames.EpicGamesLauncher Google.Chrome ppy.osu

net session >nul 2>&1 || (echo Clic droit sur le fichier puis "Executer en tant qu'administrateur". & pause & exit /b 1)

where winget >nul 2>&1 || (echo winget introuvable. Installez "App Installer" depuis le Microsoft Store. & pause & exit /b 1)

set ECHECS=
for %%i in (%LOGICIELS%) do call :installer %%i

echo.
if defined ECHECS (echo Echecs :%ECHECS%) else (echo Tout est installe.)
pause
exit /b

:installer
echo ==^> %1
winget install --id %1 --exact --silent --accept-package-agreements --accept-source-agreements
rem -1978335135 / -1978335189 = deja installe / pas de mise a jour : compte comme succes
if %errorlevel% neq 0 if %errorlevel% neq -1978335135 if %errorlevel% neq -1978335189 set ECHECS=%ECHECS% %1
exit /b
