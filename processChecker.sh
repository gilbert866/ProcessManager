#! /bin/bash
#Name: processChecker.sh
#Description: Script to determine the top cpu consuming processes

 function report_utilization {
	#Process collected data
	echo 
	echo "These applications are consuming too much cpu resources :"
	
	cat /tmp/cpu_usage.$$ |
awk '
{ process[$1]+=$2; }
END{
	for(i in process)
	{
	printf("%-20s %s\n",i,process[i])}
	}' | sort -nrk 2| head
	
#Remove the temporary log file
rm /tmp/cpu_usage.$$
exit 0
}


trap 'report_utilization' INT

SECS=60
UNIT_TIME=10


STEPS=$(( $SECS / $UNIT_TIME))
echo "Watching CPU usage.......;"

#Collect data in temp file
for((i=0;i<$STEPS;i++)); do
	ps -eocomm,pcpu | egrep -v '(0.0)|(%CPU)' >> /tmp/cpu_usage.$$
	sleep $UNIT_TIME
done



report_utilization

