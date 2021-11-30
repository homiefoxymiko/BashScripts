#!/bin/bash
diffLog="/home/ubuntu/logs/diff.log"
mainLog="/home/ubuntu/logs/log1.log"
deleteLog="/home/ubuntu/logs/log2.log"
accessLog="/var/log/nginx/access.log"
tempLog3="/home/ubuntu/logs/temp_log3.log"
tempLog4="/home/ubuntu/logs/temp_log4.log"
mainLog3="/home/ubuntu/logs/log3.log"
mainLog4="/home/ubuntu/logs/log4.log"


CopyToLog(){
        > $diffLog
        diff -a $1 $2 | cut -c 3- > $diffLog
        sudo sed -i 1d $diffLog
        cat $diffLog >> $2
        cat $diffLog >> $mainLog
	sudo touch $mainLog
}

FindError(){
	> $2
        errorcode=$1
        for (( i=0; i<=99; i++ )); do
                awk '($9 ~ /'$errorcode'/)' $accessLog >> $2
                errorcode=$(($errorcode+1))
        done
	diff -a $2 $3 | cut -c 3- > $3
}

while true; do

FindError 400 /home/ubuntu/logs/temp_log4.log /home/ubuntu/logs/log4.log
FindError 500 /home/ubuntu/logs/temp_log3.log /home/ubuntu/logs/log3.log

CopyToLog /var/log/nginx/access.log /home/ubuntu/logs/temp_access.log
CopyToLog /var/log/nginx/error.log /home/ubuntu/logs/temp_error.log
sudo find /home/ubuntu/logs -name "log1.log" -size +500k -delete |  sudo chmod 777 /home/ubuntu/logs/log1.log

if [[ -s $mainLog ]];
then
echo "file is not empty"
else
echo -n "LogFile has been successfully cleared " >> $deleteLog
date >> $deleteLog
fi

sleep 5
done

exit
