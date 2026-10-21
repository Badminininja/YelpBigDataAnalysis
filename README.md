# Yelp’s Perfect Establishments

"Yelp's Perfect Establishments" is a Big Data analysis project. Using the Yelp Open Dataset, we extract business insights using Spark and display it on a user friendly interface. 

![Interactive Map Preview](https://github.com/kkadhith/YelpBigDataAnalysis/blob/main/images/BigDataPreview.png "Map Preview")

**Authors:** Adhith Karthikeyan, Joseph Mangapit, Srijan Pagadala, Sarah Ramirez

## Retrieving the Dataset

The Yelp Dataset can be found on https://www.yelp.com/dataset or download it from the Google Drive link. The two main pieces of data that is needed to run our Spark queries are `yelp_academic_dataset_business.json` and `yelp_academic_dataset_review.json`.

## Running the Code:
For the ML model, PySpark queries, and visualizations, install the required dependencies using 

`pip install -r requirements.txt`

The frontend directory contains detailed information on how to run the web app / interactive map.

## Running the Spark analysis with Docker

If you'd rather not install Java, Spark, and the Python packages by hand, a
Docker setup is included that bundles the whole environment. You only need
[Docker Desktop](https://www.docker.com/products/docker-desktop/) and the Yelp
dataset.

1. **Place the dataset.** Create a `yelp_dataset/` folder in the project root
   and put the two JSON files in it:
   ```
   yelp_dataset/
     yelp_academic_dataset_business.json
     yelp_academic_dataset_review.json
   ```
   (This folder is git-ignored, so the large files never get committed.)

2. **Build the image** (one time, and again whenever `requirements.txt` changes):
   ```bash
   docker compose build
   ```

3. **Run the Spark SQL analysis.** This reads the dataset and writes
   `output/analysis.json` (the file the frontend map uses):
   ```bash
   docker compose run --rm analysis
   ```

4. **Run the ML model** (interactive — it asks about a restaurant and predicts
   a rating):
   ```bash
   docker compose run --rm ml
   ```

How it fits together: the **image** (built from the `Dockerfile`) carries Python
and a Java runtime plus the dependencies; your **dataset** and the **output**
folder are mounted in at run time as volumes, so the multi-gigabyte data stays
on your machine and the image stays small.
