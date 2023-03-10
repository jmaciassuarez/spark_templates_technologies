package com.ranga.spark.avro

import org.apache.spark.sql.{Dataset, Row, SparkSession}
import org.apache.spark.SparkConf
import org.apache.log4j.Logger

/**
 * @author Ranga Reddy
 * Version: 1.0
 * Created : 10/18/2021
 */

object SparkAvroIntegrationApp extends Serializable {

    @transient lazy val logger: Logger = Logger.getLogger(getClass.getName)

    def main(args: Array[String]): Unit = {
        
        val appName = "Spark Avro Integration"
        
        // Creating the SparkConf object
        val sparkConf = new SparkConf().setAppName(appName).setIfMissing("spark.master", "local[2]")

        // Creating the SparkSession object
        val spark: SparkSession = SparkSession.builder().config(sparkConf).getOrCreate()
        logger.info("SparkSession created successfully")

        val avroFilePath = "/tmp/avro_data"

        val employeeDF = getEmployeeDS(spark)
        display(employeeDF)

        // write avro data
        df.coalesce(1).write.format("avro").mode("overwrite").save(avroFilePath)

       // read avro data
        val avroEmployeeDF = spark.read.format("avro").load(avroFilePath)
        display(avroEmployeeDF)

        logger.info("<Spark Avro Integration> successfully finished")

        // Close the SparkSession
        spark.close()
        logger.info("SparkSession closed successfully")
    }

    // Get the Employee Dataset
    def getEmployeeDS(spark: SparkSession): Dataset[Row] = {
        import spark.implicits._
        Seq(
            Employee(1L, "Ranga Reddy", 32, 80000.5f),
            Employee(2L, "Nishanth Reddy", 3, 180000.5f),
            Employee(3L, "Raja Sekhar Reddy", 59, 280000.5f),
            Employee(4L, "Manoj Reddy", 15, 8000.5f),
            Employee(5L, "Vasundra Reddy", 55, 580000.5f)
        ).toDF()
    }
    // Display the Dataset
    def display(df: Dataset[Row]): Unit = {
        df.printSchema()
        df.show()
    }

}