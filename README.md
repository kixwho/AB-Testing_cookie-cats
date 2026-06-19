# Executive Summary

Cookie Cats tested whether moving the progression gate from level 30 (control) to level 40 (variant) improved player engagement and retention.

Analysis found no statistically significant difference in total gameplay (sum_gamerounds) between the two groups. However, day-7 retention was significantly lower in the variant group, with an approximate 4.3% relative decline compared to the control group.

Based on these results, the recommendation is to keep the gate at level 30.

# Test Overview

Players were randomly assigned to one of two groups:

* Control: gate_30
* Variant: gate_40

Player engagement was measured using total game rounds played during the first 14 days after installation (sum_gamerounds). Retention was measured one day and seven days after installation.

Data validation included checks for missing values, duplicate users, and sample-ratio mismatch. No structural issues were identified.

<img width="633" height="306" alt="image" src="https://github.com/user-attachments/assets/a493113b-d205-41f0-a67b-fb46822e59e8" />
<br><br>

<img width="392" height="235" alt="1" src="https://github.com/user-attachments/assets/234fbdfa-7da8-4f97-b8d7-ccc8ea7ec3f2" />

# Analysis

Initial SQL exploration showed that the variant group underperformed the control group across all key metrics.

<img width="513" height="344" alt="image" src="https://github.com/user-attachments/assets/77512212-df20-48e9-ae8a-99708985d69d" />

To investigate whether this difference was driven by a small number of highly engaged players, distribution characteristics were examined. While the control group showed substantially higher variance, quartile analysis suggested the difference was not limited to a handful of “whale” players.

One extreme observation reported 49,854 game rounds within a 14-day period. Given the implied playtime requirements, this record was treated as an anomaly and excluded from further analysis. Gameplay values above 3,000 rounds were also removed as extreme outliers.

The primary statistical analysis focused on sum_gamerounds, a continuous KPI that provides more granular information than binary retention metrics. Welch’s t-test found no statistically significant difference between groups (p ≈ 0.95), suggesting similar overall engagement.

<img width="501" height="325" alt="image" src="https://github.com/user-attachments/assets/4327c2de-114a-4e57-8154-810ee64f51ff" />

Retention outcomes were then evaluated using chi-square tests. Day-1 retention was not statistically significant. However, day-7 retention showed a statistically significant decline in the variant group, corresponding to an approximate 4.3% relative decrease.

# Recommendation

Moving the gate from level 30 to level 40 does not improve player engagement and may reduce longer-term retention.

Based on these findings, gate_30 should remain the preferred implementation.

# Methodology Notes

Gameplay data is highly right-skewed and non-normal, which is common for engagement metrics. Welch’s t-test was selected because of its robustness to unequal variances and the large sample size (~90,000 users), where the Central Limit Theorem supports inference on mean differences.
