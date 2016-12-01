#!/bin/bash

echo "Between which versions do you want to generate a changelog?"

echo "Initial version?"
read initial_version
if [ ! `git branch --list ${initial_version}` ]
	then
	echo "This version doesn't exist"
	exit 0
fi

echo "Finale version?"
read final_version
if [ ! `git branch --list ${final_version}` ]
	then
	echo "This version doesn't exist"
	exit 0
fi

git checkout dev && git diff $initial_version $final_version > "Diff-${initial_version}_${final_version}.log"
echo "Your changelog is here: Diff-${initial_version}_${final_version}.log"

exit 0
