# Demo_Big-Data and the ETL Process using AWS, postgreSQL, PySpark & Jupyter 

## Background:
Pet_Product reviews was selected from the Amazon's review site [Amazon Review Site](https://courses.bootcampspot.com/courses/941/assignments/18906?module_item_id=344531) in order to examine the relationship between paid reviews and unpaid reviews. Paid reviews are reviews by members of the VINE program. Background on the VINE program is available at [Vine Program](https://www.amazon.com/vine/about).

## Deliverables:
* Deliverable 1: Perform ETL on Amazon Product Reviews (Pet Products)
* Deliverable 2: Determine Bias of Vine Reviews (comparing 5-star reviews paid vs. unpaid)
* Deliverable 3: A Written Report on the Analysis (README.md)

## Methodology:
All Amazon reviews share the following data structure outlined in the following data dictionary:
![amazon review format](./Assignment_Resources/Images/data-16-challenge-format-and-info-amazon-review-datasets-columns.png).


* Step 1: Perform ETL on Amazon Product Reviews 
  - Create an AWS postgreSQL instance 
  - link to it using pgAdmin. Use the provided SQL schema file to create four seperate (empty) tables in a database called pet_product_db in the AWS postgreSQL instance
  - establish a PySpark session using google colab and follow the instructions outlined in Module 16.9.1 PySpark ETL to extract the reviews, parse the reviews into four tables and load the tables into postgreSQL
  
    EXTRACT / TRANSFORM / LOAD
    - Extract the Pet_Products reviews from an AWS bucket at https://s3.amazonaws.com/amazon-reviews-pds/tsv/amazon_reviews_us_Pet_Products_v1_00.tsv.gz
      
    - Transform the dataframe using the provided schema into the desired format creating four seperate tables (customers_table, products_table, review_id_table and vine_table)

    - Load each of the tables into the AWS postgreSQL instance.

* Step 2: Determine Bias of Vine Reviews (Using SQL, PySpark or Python/Pandas) using the vine_table (extracted as a csv file and loaded into an AWS S3 Bucket for use in PySpark)
    - filter the dataframe where total_votes >= 20
    - filter result for helpful_votes / total_votes > 50%
    - find the percentage of 5-star reviews for paid (vine == "Y") and unpaid (vine == "N")

* Step 3: Perform an analysis comparing the percentage of 5-star paid reviews vs. 5-star unpaid reviews


## Analysis:
Ho: 5star_vine = 5star_not_vine
(no difference in the percentage (proportion) of 5 star ratings paid (vine) vs unpaid (not vine)

Ha: 5star_vine <> 5star_not_vine
(there is a difference)

* percentage_5star_vine     = 38.24%
* percentage_5star_not_vine = 54.47%

* **finding: The percentage of 5star ratings is not the same when comparing vine reviews to not_vine reviews**
* **There is reason to believe that the percentage of 5star ratings is not directly tied to whether the reviewer is paid or unpaid.**

* note: for a quantitative analysis this hypothesis test would need to be evaluated comparing the proportion of 5 star reviews among the two samples