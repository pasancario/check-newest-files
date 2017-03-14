#!/bin/bash
#
# Author: Luis I. Perez Villota <luis.perez@pareteum.com>
# License: GPL-3
#
# Changelog:
# 2017-03-10 : First version
#
# Description: 
#
# This plugins uses a find command to check how many files has been creted in a given directory with a name pattern in last n minutes


#Nagios Constants
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3

print_usage() {
echo " 
Usage: check_newest_file.sh  -d <directory> -m <minutes> [ -p <pattern> ] [ -w <warning> ] [ -c <critical> ]
Description: 

This plugins uses a find command to check how many files has been creted in a given directory with a name pattern in last n minutes

"
}

print_help(){
	print_usage
}


execute_find(){
	total_files=`find $folder -name "$pattern*" -mmin -$MINUTES 2> /dev/null| wc -l `
	if [ $critical ]; then
		if [ $total_files -le $critical ]; then
		        echo "Critical: We have only $total_files in last $MINUTES minutes|files=$total_files"
		        exit $STATE_CRITICAL
		fi
	fi
	if [ $warning ]; then
		if [ $total_files -le $warning ]; then
		        echo "Warning: We have only $total_files in last $MINUTES minutes|files=$total_files"
		        exit $STATE_WARNING
		fi
	fi
       echo "OK: We have $total_files in last $MINUTES minutes|files=$total_files"
        exit $STATE_OK
}

# Make sure the correct number of command line
# arguments have been supplied
if [ $# -lt 1 ]; then
    print_usage
    exit 3
fi

while test -n "$1"; do
    case "$1" in
        --help)
            print_help
            exit $STATE_OK
            ;;
        -h)
            print_help
            exit $STATE_OK
            ;;
        --dirs)
            folder=$2
            shift
            ;;
        -d)
            folder=$2
            shift
            ;;
	-t) 
	    MINUTES=$2
	    shift
	    ;;
	-p) 
	    pattern=$2
	    shift
	    ;;
	-w) 
	    warning=$2
	    shift
            ;;
	-c) 
	    critical=$2
	    shift
            ;;
	*)
	    echo "Unknown Argument: $1"
	    print_usage
            exit 3
	    ;;
    esac
    shift
done

if [ ! "$folder" ]; then
	echo "No diretories provided."
	exit $STATE_UNKNOWN
fi
if [ ! "$MINUTES" ]; then
	echo "No Minutes provided"
	exit $STAT_UNKNOWN
fi
if [ ! "$pattern" ]; then 
	pattern="*"
fi	
execute_find
