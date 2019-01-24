#!/bin/bash -e

docker build -t dowster/kafka_server ./kafka_server 
docker build -t dowster/zookeeper_server ./zookeeper_server 

docker tag dowster/kafka_server registry.dowster.net:443/dowster/kafka_server 
docker tag dowster/zookeeper_server registry.dowster.net:443/dowster/zookeeper_server 

docker push registry.dowster.net:443/dowster/kafka_server 
docker push registry.dowster.net:443/dowster/zookeeper_server 
