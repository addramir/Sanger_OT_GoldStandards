from pyspark.sql import DataFrame, SparkSession
import pandas as pd
import pyspark.sql.functions as f
from pyspark.sql.types import *
from pyspark.sql.window import Window
import numpy as np
import os


max_ram_to_use="10g"

def get_spark_session(max_ram_to_use):
    return (
        SparkSession.builder
        .master('local[*]')
        .config("spark.driver.memory", max_ram_to_use)
        .appName('spark')
        .getOrCreate()
    )

spark = get_spark_session(max_ram_to_use)


gsl = spark.read.json("gs://genetics-portal-dev-analysis/yt4/otg_gs_2023")

flattened_df = gsl.select(
    "association_info.otg_id",
    "gold_standard_info.gene_id",
    "gold_standard_info.highest_confidence",
    "metadata.set_label",
    "sentinel_variant.alleles.alternative",
    "sentinel_variant.alleles.reference",
    "sentinel_variant.locus_GRCh38.chromosome",
    "sentinel_variant.locus_GRCh38.position",
    "trait_info.ontology"
)

# Convert the flattened DataFrame to a pandas DataFrame
pandas_df = flattened_df.toPandas()

pandas_df("")