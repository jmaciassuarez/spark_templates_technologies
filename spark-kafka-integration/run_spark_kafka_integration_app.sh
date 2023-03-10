#!/bin/bash

SCRIPT_NAME=`basename "$0"`

printf "\nRunning the <${SCRIPT_NAME}> script.\n"

if [ $# -lt 2 ]; then
    printf "Usage  : ${SCRIPT_NAME} <KAFKA_BOOTSTRAP_SERVERS> <KAFKA_TOPIC_NAMES>\n"
    exit 1
fi

KAFKA_BOOTSTRAP_SERVERS=$1
KAFKA_TOPIC_NAMES=$2

spark-submit \
	--conf spark.app.name=SparkKafkaIntegration \
	--conf spark.master=yarn \
	--conf spark.submit.deployMode=client \
	--conf spark.driver.memory=1g \
	--conf spark.executor.memory=1g \
	--conf spark.driver.cores=1 \
	--conf spark.executor.cores=3 \
	--conf spark.executor.instances=2 \
	--conf spark.driver.extraJavaOptions="-Djava.security.auth.login.config=/apps/spark/spark-kafka-integration/kafka_client_jaas.conf" \
	--conf spark.executor.extraJavaOptions="-Djava.security.auth.login.config=/apps/spark/spark-kafka-integration/kafka_client_jaas.conf" \
 	--files /apps/spark/spark-kafka-integration/kafka_client_jaas.conf \
	--class com.ranga.spark.kafka.SparkKafkaIntegrationApp \
	/apps/spark/spark-kafka-integration/spark-kafka-integration-1.0.0-SNAPSHOT.jar ${KAFKA_BOOTSTRAP_SERVERS},${KAFKA_TOPIC_NAMES}

printf "Finished <${SCRIPT_NAME}> script.\n"