#!/bin/bash
echo "Running <$0> script"

spark-submit \
  --master yarn \
  --deploy-mode client \
  --driver-memory 1g \
  --executor-memory 1g \
  --num-executors 2 \
  --executor-cores 3 \
  --class com.ranga.spark.hbase.shc.cdh.SparkHbaseShcCdhIntegrationApp \
  /apps/spark/spark-hbase-shc-cdh-integration/spark-hbase-shc-cdh-integration-1.0.0-SNAPSHOT.jar

echo "Finished <$0> script"