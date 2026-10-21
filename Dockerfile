# Environment for the PySpark analysis: Python + a Java runtime.
# (Spark runs on the JVM, so a Python-only image isn't enough.)
FROM python:3.11-slim

# default-jre-headless installs Java 17, which PySpark 3.5 supports.
RUN apt-get update \
    && apt-get install -y --no-install-recommends default-jre-headless \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python deps first, as their own layer. Docker caches this, so it
# only re-runs pip when requirements.txt changes, not on every code edit.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the analysis code into the image.
COPY sparkSQL/ sparkSQL/
COPY ml_model/ ml_model/

# The Yelp dataset (several GB) is NOT baked into the image. You mount it at
# run time to /app/yelp_dataset, and results are written to /app/output.
# By default this image runs the Spark SQL analysis:
CMD ["python", "sparkSQL/analysisQueries.py"]
