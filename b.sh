#!/bin/bash

if [[ $1 = '-n' ]]; then
    meret=$2
    shift
    shift
else
    meret=0
fi
szo=$1
from=$2
to=$3

allomanyok=$(ls -t "$from")
for elem in $allomanyok
do
    file "$from/$elem" | grep -c -q 'text'
    if (($? != 0)) then
        continue
    fi
    grep -q -w "$szo" "$from/$elem"
    if (($? != 0)) then
        continue
    fi
    elemmeret=$(ls -l --block-size=K "$from/$elem" | grep  -E -o '[0-9]+K' | tr 'K' ' ')
    if ((elemmeret > meret)); then
      continue
    fi
    if [ -f "$to/$file" ]
    then
      elem1=$(date -r "$from/$elem" +%s)
      elem2=$(date -r "$to/$elem" +%s)
      if((elem1<elem2))
      then
        printf '%s ' $elem
        #cp $from/$file" "$to/$file"
      fi
    else
      printf '%s ' $elem
      #cp $from/$file" "$to/$file"
    fi
done
echo ""
