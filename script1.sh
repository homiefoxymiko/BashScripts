#!/bin/bash

#Creating configuration files

count=100;
for i in $(seq -w 1 $count)
do
        touch "configuration_file_"$i.cfg
        echo ServerName = nginx-$i.com > "configuration_file_"$i.cfg
done

#Server name corrects

echo "Write new server name:"
read ServerNewName
for configuration_file_path in ~/Documents/TaskScript1/*.cfg; 
do
	FileContent=$(<$configuration_file_path)
	sed -i -E 's/ServerName = .*/ServerName = '$ServerNewName'/g' $configuration_file_path
done
