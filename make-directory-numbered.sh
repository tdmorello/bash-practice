#!/bin/bash

# Make new directory
count=1
printf -v count "%03d" $count     # Pads the count variable with zeros
nthDirectory=./practice-$count
if [ ! -d "$nthDirectory" ]; then
    mkdir $nthDirectory
else
    while [ -d "$nthDirectory" ]
    do
        count=$(expr $count + 1)
        printf -v count "%03d" $count
        nthDirectory=./practice-$count
    done
    mkdir $nthDirectory
fi
directory=$nthDirectory
cd $directory
echo "Created $directory"
echo ""
