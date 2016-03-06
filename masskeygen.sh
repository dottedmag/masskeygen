#!/bin/sh -e

N=${1:-10000}
D=$(pwd)/gpgtmp

mkdir -p $D
chmod 700 $D

KS=""

for i in $(seq $N); do
  printf .
  K=$(gpg2 --homedir=$D --batch --gen-key batch-keys.conf 2>&1)
  K=$(echo $K | awk '/gpg: key [0-9A-F]+/ { print $3 }')
  KS="$KS\n$K"
done

echo "$KS" | sort
