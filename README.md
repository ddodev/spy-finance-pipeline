# SPY Market Trend & Sentiment Pipeline

An end-to-end data engineering pipeline for technical analysis of the S&P 500. Built with GCP, Terraform, Kestra, and dbt.

## Problem Statement

Individual investors often struggle with "market noise"—the daily fluctuations of the stock market that can lead to emotional decision-making. This project solves that by automating a daily technical analysis pipeline. By calculating a 5-day moving average and daily sentiment (Gains vs. Losses), it provides a smoothed view of market trends, helping users identify momentum rather than reacting to single-day volatility.

## Technologies Used

- Cloud: Google Cloud Platform (GCS, BigQuery)
- Infrastructure as Code (IaC): Terraform
- Workflow Orchestration: Kestra
- Data Warehouse: BigQuery (Partitioned & Clustered)
- Transformation: dbt
- Visualization: Looker Studio

## Project Architecture
```
[Yahoo Finance API]
       |
       V
[Kestra Workflow] (Docker)
       |
       |--> [Python Ingestion Script] (Self-Healing Check for Dataset)
       |--> [GCS Storage] (Data Lake Bucket)
       |
       V
[BigQuery Warehouse] (Date-Partitioned Table)
       |
       |--> [dbt Transformations] (5-Day Moving Average & Sentiment)
       |
       V
[Looker Studio Dashboard] (Visualization Layer)
```
## Data Warehouse Optimization

To ensure cost-efficiency and performance, the spy_prices table is partitioned by Date and clustered by Date. This optimization ensures that Looker Studio filters data by specific time ranges without scanning the entire dataset, significantly reducing query costs and latency.

## Reproducibility (The "How-To")

1. Clone the Repo

   
          git clone https://github.com/ddodev/spy-finance-pipeline.git

3. Infrastructure (Terraform)
   - Navigate to the /terraform directory.
   - Update variables.tf with your specific project_id.
   - Run: terraform init
   - Run: terraform apply

4. Orchestration (Kestra)
   - Import kestra/flow.yaml into your Kestra instance.
   - Add your GCP Service Account JSON to the Kestra KV Store as GCP_CREDS.
   - Execute the flow. 
   - Note: The "Self-Healing" Python script automatically verifies and creates the BigQuery dataset if it is missing.

## Dashboard Preview

The final dashboard provides actionable technical insights through two primary tiles:



- Chart 1: Temporal Line Chart (Closing Price vs. 5-Day Moving Average).
- Chart 2: Categorical Pie Chart (Distribution of Gain/Loss Days).

<img width="1184" height="649" alt="image" src="https://github.com/user-attachments/assets/2b61a9a5-85b3-4d86-b927-1d710fbf18ac" />
Public Link:
https://lookerstudio.google.com/reporting/ced90055-37b2-4c7d-a448-60ea8de0e646

## Pipeline Status

The pipeline is managed by Kestra, ensuring automated daily updates and error handling for the Yahoo Finance API ingestion.

<img width="559" height="590" alt="image" src="https://github.com/user-attachments/assets/32a736d1-d0ca-4595-bc8b-416876d98fe2" />
