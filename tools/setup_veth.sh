#! /bin/bash

# export TEST_ROOT='/home/ubuntu/vp4-test'
# export SWITCH_ROOT='/home/ubuntu/onos-p4-dev/onos0p4-bmv2/targets/simple_switch'
# export SWITCH_EXE='/home/ubuntu/onos-p4-dev/onos-p4-bmv2/targets/simple_switch/simple_switch'

# JSON_FILE=${TEST_ROOT}/${1}/conf.json

ip link add veth1 type veth peer name veth3
ip link add veth2 type veth peer name veth4

ip netns add h1
ip netns add h2

ip link set veth1 netns h1
ip link set veth2 netns h2

ip netns exec h1 ifconfig lo up
ip netns exec h2 ifconfig lo up

ip netns exec h1 ifconfig veth1 hw ether 802200010001
ip netns exec h2 ifconfig veth2 hw ether 802200010002

ip netns exec h1 ifconfig veth1 10.0.0.1  up
ip netns exec h2 ifconfig veth2 10.0.0.2  up

ip netns exec h1 arp -s 10.0.0.2 80:22:00:01:00:02
ip netns exec h2 arp -s 10.0.0.1 80:22:00:01:00:01

sudo ifconfig veth1 up
sudo ifconfig veth2 up

#bash ${SWITCH_EXE} ${JSON_FILE} -i 1@veth1 -i 2@veth2 ${2} --thrift-port 9091

