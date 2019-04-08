#!/bin/bash
i=1
FILE=$1
while [ 1 ]
do
	if [[ "$(tail -1 $FILE)" == "This run of the ANSYS CFX Solver has finished." ]]
	then
		echo "SUA SIMULAÇÃO ESTÁ PARADA !!!" | bash telebot.sh diego
	fi
	
	FLOWTIME=$( tail -1000 $FILE | grep "TIME STEP" | tail -1 | cut -d" " -f10 )
	TIMESTEP=$( tail -1000 $FILE | grep "TIME STEP" | tail -1 | cut -d" " -f6 )
	printf -v FLOWTIME "%.f" "$FLOWTIME"
	printf -v STEP "%.f" "$STEP"
	FLOWTIME_H=$(bc <<< "scale=3;$FLOWTIME/3600")
	FLOWTIME_D=$(bc <<< "scale=3;$FLOWTIME/86400")
	MESSAGE="*STEP*:$TIMESTEP\n*FLOW*:$FLOWTIME\[s], $FLOWTIME_H\[h], $FLOWTIME_D\[d]" 
	echo -e $MESSAGE | bash telebot.sh diego
	sleep $2
done	