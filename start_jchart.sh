#!/bin/bash


cd `dirname $0`

#####################################################
# is running
#####################################################
running()
{
    if [ "ABC" == "ABC$1" ]
    then
            echo "PID is FAILED..."
            return 1;
    else
            CMD="ps -p $1|awk '{print \$1}'"
            echo $CMD
            r_pid=`ps -p $1|awk '{print \$1}'`
            echo return the pid $r_pid
            if [ "x$r_pid" == "xPID" ]
            then
                    echo "PID $r_pid is FAILED!"
                    return 1;
            else
                    echo "PID $r_pid is running..."
                    return 0;
            fi
    fi
}

echo "exe:$1|cfg:$2"
# echo "command: nohup $1 $2 >> $2.nohup &"
sleep 3

# runtime="7h"
mypid=$$

daystart="0424"
dayend="2305"
nightstart="2306"
nightend="0240"

cd `dirname $0`

i_start=false


while true; do
echo $@
nowtime=`date +%H%M`
nowd=`date +%Y%m%d`
echo $nowd,$nowtime
    echo "##### i_start:$i_start|mypid:$mypid|pid:$pid"

    # check if pid not running ,exit this loop
    if [[ true = $i_start ]];then
        if running $pid
        then
            echo ""
        else
            echo "process not running ,exit...."
            break
        fi
    fi

    # daystart
    if [[ ( "$nowtime" > $daystart && "$nowtime" < $dayend )  && false = $i_start ]];then

        #echo "kill $1"
        #pkill -f "$1"
        echo "start $1"

        voila \
          --MappingKernelManager.cull_interval=60 \
          --MappingKernelManager.cull_idle_timeout=120 \
          --no-browser --port=50009 --base_url=/jchart/ \
          --VoilaConfiguration.file_allowlist="['.*']" \
          jchart_wdg.ipynb &

        pid=$!
        # echo "My PID=$mypid. Server's PID=$pid1"
        ps -f $pid

        i_start=true
        sleep 10
    fi

    if [[ ( "$nowtime" > $dayend && "$nowtime" < $nightstart || "$nowtime" > $nightend && "$nowtime" < $daystart  ) && true = $i_start  ]];then

        kill -s SIGTERM $pid
        i_start=false
    fi

    sleep 17

done


