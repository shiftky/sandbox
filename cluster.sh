#!/bin/bash

redis-server --cluster-enabled yes --cluster-config-file 7000-nodes.conf --port 7000 &
redis-server --cluster-enabled yes --cluster-config-file 7001-nodes.conf --port 7001 &
redis-server --cluster-enabled yes --cluster-config-file 7002-nodes.conf --port 7002 &
redis-server --cluster-enabled yes --cluster-config-file 7003-nodes.conf --port 7003 &
redis-server --cluster-enabled yes --cluster-config-file 7004-nodes.conf --port 7004 &
redis-server --cluster-enabled yes --cluster-config-file 7005-nodes.conf --port 7005 &

sleep 3

echo yes | redis-cli --cluster create 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 --cluster-replicas 1 -x

sleep 10

kill -9 `pgrep redis-server`
rm -f *.conf dump.rdb
