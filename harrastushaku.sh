#!/bin/sh
if [ $# -lt 1 ]; then
	echo
	echo "usage: harrastushaku.sh [max_users] [ramp_up_time] [loop_count] [server] [basepath]"
	echo "  for example harrastushaku.sh 10 10 20  --  runs 10 users with 10 sec ramp up 20 rounds"
	echo "              harrastushaku.sh 10 10 20 harrastepalvelu.oly.mpia.fi YM2.hyvaksymistesti.harrastepalvelu/api  --  same as above but with specified server and basepath"
	echo
    exit 1
fi
timestamp=$(date +"%Y%m%d_%H%M%S")
maxusers=${1:-1}
rampup=${2:-1}
loopcount=${3:-1}
server=${4:-harrastepalvelu.oly.mpia.fi}
basepath=${5:-YM2.hyvaksymistesti.harrastepalvelu/api}
out_dir=output/$timestamp
jmeter -n -t jmx/harrastushaku.jmx -Jmax_users=$maxusers -Jramp_up=$rampup -Jloop_count=$loopcount -Jserver=$server -Jbasepath=$basepath -l $out_dir/harrastushaku.jtl -e -o $out_dir/report -j $out_dir/jmeter.log
echo Server = $server\\nBasepath = $basepath\\n\\nUsers = $maxusers\\nRamp up time = $rampup sec\\nLoop count = $loopcount\\n > $out_dir/settings.txt