#!/bin/bash

count=10;
for i in $(seq -w 1 $count)
do
	touch "random_text_"$i.txt
	tr -dc A-Za-z0-9 </dev/urandom | head -c 1000 > "random_text_"$i.txt
done
