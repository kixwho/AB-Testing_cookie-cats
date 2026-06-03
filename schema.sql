--Schema definition for raw A/B test data
--Source: Kaggle Mobile Games A/B Testing Dataset

CREATE TABLE ab_test_data_raw (
	user_id INT,
	version TEXT,
	sum_gamerounds INT,
	retention_1 BOOLEAN,
	retention_7 BOOLEAN
);