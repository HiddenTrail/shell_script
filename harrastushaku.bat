@echo off
if not "%~1" == "" goto run_jmeter
echo:
echo usage: harrastushaku.bat [max_users] [ramp_up_time] [loop_count] [server] [basepath]
echo   for example harrastushaku.sh 10 10 20  --  runs 10 users with 10 sec ramp up 20 rounds
echo               harrastushaku.sh 10 10 20 harrastepalvelu.oly.mpia.fi YM2.hyvaksymistesti.harrastepalvelu/api  --  same as above but with specified server and basepath
echo:
goto:eof
:run_jmeter
set timestamp=%date:~9,4%%date:~6,2%%date:~3,2%_%time:~0,2%%time:~3,2%
set /a maxusers=%1
set /a rampup=1
IF NOT "%2" == "" set /a rampup=%2
set /a loopcount=1
IF NOT "%3" == "" set /a loopcount=%3
set server=harrastepalvelu.oly.mpia.fi
IF NOT "%4" == "" set server=%4
set basepath=YM2.hyvaksymistesti.harrastepalvelu/api
IF NOT "%5" == "" set basepath=%5
set out_dir=output\%timestamp%
mkdir %out_dir%
jmeter -n -t jmx\harrastushaku.jmx -Jmax_users=%maxusers% -Jramp_up=%rampup% -Jloop_count=%loopcount% -Jserver=%server% -Jbasepath=%basepath% -l %out_dir%\harrastushaku.jtl -e -o %out_dir%\report -j %out_dir%\jmeter.log
echo Server = %server% > %out_dir%\settings.txt
echo Basepath = %basepath% >> %out_dir%\settings.txt
echo. >> %out_dir%\settings.txt
echo Users = %maxusers% >> %out_dir%\settings.txt
echo Ramp up time = %rampup% sec >> %out_dir%\settings.txt
echo Loop count = %loopcount% >> %out_dir%\settings.txt