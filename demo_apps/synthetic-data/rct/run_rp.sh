#!/bin/bash

# Start the redis server
PORT=59465
/home/aymen/RADICAL/parsl_rp_mpi/redis-stable/src/redis-server --port $PORT --protected-mode no &> redis.out &
REDIS=$!

export RADICAL_LOG_LVL="DEBUG"
export RADICAL_PROFILE="TRUE"

echo "Redis started on $HOSTNAME:$PORT"

/home/aymen/ve/mpi/bin/python /home/aymen/RADICAL/parsl_rp_mpi/colmena_rp.py \
	                                                           --redis-host $HOSTNAME \
	                                                           --redis-port $PORT \
	                                                           --task-input-size 5 \
	                                                           --task-output-size 5 \
	                                                           --task-interval 0.1 \
	                                                           --task-count 50 \
                                                                   --output-dir runs/full_test_unique_30s_50x50_v3 \

# Kill the redis server
kill $REDIS
