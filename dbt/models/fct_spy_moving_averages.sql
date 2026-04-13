SELECT 
    Date, 
    Close,
    Open,
    AVG(Close) OVER (ORDER BY Date ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) as mavg_5_day,
    CASE 
        WHEN Close > Open THEN 'Gain'
        WHEN Close < Open THEN 'Loss'
        ELSE 'Flat'
    END as day_sentiment
FROM `{{ var("project_id") }}.market_data_raw.spy_prices`
