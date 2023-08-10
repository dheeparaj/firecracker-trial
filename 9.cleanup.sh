#!/bin/bash

set -euo pipefail

COUNT=$(find /sys/class/net/* | wc -l)

#killall iperf3
FC_CNT=$(ps -ef | grep firecracker | wc -l)
if [[ $FC_CNT -gt 1 ]]
then
  killall firecracker
fi

for ((i=0; i<COUNT; i++))
do
  ip link del fc-"$i"-tap0 2> /dev/null &
done

rm -rf output/*
rm -rf /tmp/firecracker-sb*
