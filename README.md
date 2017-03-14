# check-newest-files
Check Newest file on a folder starting on pattern for Nagios plugins.

This script allows you to check how old are files matching a pattern given a folder by parameter. 

Usage: 
``` bash 
$ ./check_newest_file.sh -d /var/log -t 10 -p syslog
OK: We have 1 in last 10 minutes|files=1
```
With Warning and Critical Thresholds 

``` bash 
./check_newest_file.sh -d /var/log -t 10  -w 5 -c 1
Warning: We have only 4 in last 10 minutes|files=4
```
