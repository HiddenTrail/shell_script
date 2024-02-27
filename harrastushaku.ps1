# Check if less than 1 argument is passed
if ($args.Count -lt 1) {
    Write-Host "`nusage: harrastushaku.ps1 [max_users] [ramp_up_time] [loop_count] [server] [basepath]"
    Write-Host "  for example harrastushaku.ps1 10 10 20 -- runs 10 users with 10 sec ramp up 20 rounds"
    Write-Host "              harrastushaku.ps1 10 10 20 harrastepalvelu.oly.mpia.fi YM2.hyvaksymistesti.harrastepalvelu/api -- same as above but with specified server and basepath"
    exit
}

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$maxusers = if ($args[0]) { $args[0] } else { 1 }
$rampup = if ($args[1]) { $args[1] } else { 1 }
$loopcount = if ($args[2]) { $args[2] } else { 1 }
$server = if ($args[3]) { $args[3] } else { "harrastepalvelu.oly.mpia.fi" }
$basepath = if ($args[4]) { $args[4] } else { "YM2.hyvaksymistesti.harrastepalvelu/api" }
$out_dir = "output/$timestamp"

# Ensure output directory exists
$null = New-Item -ItemType Directory -Force -Path $out_dir

# Construct and execute the JMeter command
$jmeterCommand = 'jmeter -n -t "jmx/harrastushaku.jmx" -Jmax_users="$maxusers" -Jramp_up="$rampup" -Jloop_count="$loopcount" -Jserver="$server" -Jbasepath="$basepath" -l "$out_dir/harrastushaku.jtl" -e -o "$out_dir/report" -j "$out_dir/jmeter.log"'
Invoke-Expression $jmeterCommand

# Output settings to file
$settings = "Server = $server`nBasepath = $basepath`n`nUsers = $maxusers`nRamp up time = $rampup sec`nLoop count = $loopcount`n"
$settings | Out-File "$out_dir/settings.txt"
