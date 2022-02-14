-- 1. Filter the data and create a new DataFrame or table to retrieve 
-- all the rows where the total_votes count is equal to or greater than 20 
-- to pick reviews that are more likely to be helpful and to avoid having division by zero errors later on.
-- save as VIEW total_votes_20 table

CREATE VIEW total_votes_20 AS
SELECT * 
FROM vine_table
WHERE total_votes >= 20;

-- 2. Filter the new DataFrame or table created in Step 1 
-- and create a new DataFrame or table to retrieve all the rows where 
-- the number of helpful_votes divided by total_votes is equal to or greater than 50%.
-- save as helpful_votes_50 table

CREATE VIEW total_votes_50Per AS
SELECT * 
FROM total_votes_20
WHERE (helpful_votes / total_votes) >= 0.5;

-- 3. Filter the DataFrame or table created in Step 2, 
-- and create a new DataFrame or table that retrieves all the rows 
-- where a review was written as part of the Vine program (paid), vine == 'Y'.

CREATE VIEW paid_reviews AS
SELECT *
FROM total_votes_50Per
WHERE vine = 'Y';

-- 4. Repeat Step 3, but this time retrieve all the rows 
-- where the review was not part of the Vine program (unpaid), vine == 'N'.

CREATE VIEW unpaid_reviews AS
SELECT *
FROM total_votes_50Per
WHERE vine = 'N';

-- 5. Determine the total number of total reviews, 
-- the number of 5-star reviews, 
-- and the percentage of 5-star reviews 
-- for the two types of review (paid vs unpaid).

-- FOR Paid:
CREATE VIEW total_paid AS
SELECT COUNT(total_votes) AS total_paid_reviews
FROM paid_reviews;

CREATE VIEW total_paid_five_star AS
SELECT COUNT(total_votes) AS total_paid_five_star_reviews
FROM paid_reviews
WHERE star_rating = 5;

CREATE VIEW paid_review_analysis AS
SELECT tp.total_paid_reviews, tpfs.total_paid_five_star_reviews,
	CAST(tpfs.total_paid_five_star_reviews AS FLOAT) / CAST(tp.total_paid_reviews AS FLOAT) * 100 AS percent_five_star_paid
FROM total_paid AS tp
INNER JOIN total_paid_five_star as tpfs
	ON 1 = 1;
	
-- FOR Unpaid:
CREATE VIEW total_unpaid AS
SELECT COUNT(total_votes) AS total_unpaid_reviews
FROM unpaid_reviews;

CREATE VIEW total_unpaid_five_star AS
SELECT COUNT(total_votes) AS total_unpaid_five_star_reviews
FROM unpaid_reviews
WHERE star_rating = 5;

CREATE VIEW unpaid_review_analysis AS
SELECT tu.total_unpaid_reviews, tufs.total_unpaid_five_star_reviews,
	CAST(tufs.total_unpaid_five_star_reviews AS FLOAT) / CAST(tu.total_unpaid_reviews AS FLOAT)* 100 AS percent_five_star_unpaid
FROM total_unpaid AS tu
INNER JOIN total_unpaid_five_star as tufs
	ON 1 = 1;
	
CREATE VIEW vines_review_analysis AS
SELECT *
FROM paid_review_analysis
INNER JOIN unpaid_review_analysis
	ON 1 = 1;
	










