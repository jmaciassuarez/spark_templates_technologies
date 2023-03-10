#!/bin/bash

SCRIPT_NAME=`basename "$0"`

printf "\nRunning the <${SCRIPT_NAME}> script.\n"

if [ $# -lt 1 ]; then
    printf "Usage  : ${SCRIPT_NAME} <CASSANDRA_HOST>\n"
    exit 1
fi

CASSANDRA_HOST=$1

spark-submit \
	--conf spark.app.name=SparkCassandraIntegration \
	--conf spark.master=yarn \
	--conf spark.submit.deployMode=client \
	--conf spark.driver.memory=1g \
	--conf spark.executor.memory=1g \
	--conf spark.driver.cores=1 \
	--conf spark.executor.cores=3 \
	--conf spark.executor.instances=2 \
 	--class com.ranga.spark.cassandra.SparkCassandraIntegrationApp \
	/apps/spark/spark-cassandra-integration/spark-cassandra-integration-1.0.0-SNAPSHOT.jar ${CASSANDRA_HOST}

printf "Finished <${SCRIPT_NAME}> script.\n"