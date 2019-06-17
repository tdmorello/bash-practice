#!/bin/bash

# This script will create a sequentially numbered directory in
# the working direcotry starting from 001

###### Set baseName #####
baseName="example"
#########################

padNumber () {
    printf "%03d" $1
}

count=1
paddedCount=$(padNumber $count)

nthDirectory=./$baseName-$paddedCount

if [ ! -d "$nthDirectory" ]; then
    mkdir $nthDirectory
else
    while [ -d "$nthDirectory" ]
    do
        count=$((count+1))
        paddedCount=$(padNumber $count)
        nthDirectory=./$baseName-$paddedCount
    done
    mkdir $nthDirectory
fi

echo "Created $nthDirectory"
