#!/bin/bash -e

docker build -t dowster/kafka_server ./kafka_server
docker build -t dowster/zookeeper_server ./zookeeper_server


# A non-default bridge network enables convenient name-to-hostname discovery
docker network create kafka-net || true

docker run -d --name zookeeper --network kafka-net dowster/zookeeper_server
docker run -d --name kafka0 --network kafka-net --interactive \
   --env ZOOKEEPER_IP=zookeeper \
   --env KAFKA_BROKER_ID=0 \
   --env KAFKA_PORT=9092 \
   dowster/kafka_server

docker run --rm --network kafka-net dowster/kafka_server \
   kafka-topics.sh --create --topic test --replication-factor 1 --partitions 1 --zookeeper zookeeper:2181
