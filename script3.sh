#!/bin/bash

hostname>>ConfigFile
cat /proc/meminfo | tee >(head -1 >>ConfigFile) 
lscpu | egrep 'CPU\(s\)' | tee >(head -1>>ConfigFile)
df -h / >>ConfigFile
