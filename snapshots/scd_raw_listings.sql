{% snapshot scd_raw_listings %}
{{
 config(
 target_schema='dev',
 unique_key='id',
 strategy='timestamp',
 updated_at='updated_at',
 invalidate_hard_deletes=True
 )
}}
select * FROM {{ source('airbnb', 'listings') }}
{% endsnapshot %}

-- timestamp strategy
-- automatically created valid_from and valid_to column
-- will update at every change in any column
--For this configuration to work with the timestamp strategy,
-- the configured updated_at column must be of timestamp type.
-- Otherwise, queries will fail due to mixing data types.
-- crate undated_at =  null::timestamp as valid_to,

-- check stratgegy
-- strategy='check',
--    check_cols=['column1', 'column2'],
-- will considered data is updated if only mentioned column is updated
-- valid_from and valid_to table should be created manually

--The check snapshot strategy can be configured to track changes to all columns by 
-- supplying check_cols = 'all'. It is better to explicitly enumerate the columns 
-- that you want to check. Consider using a surrogate key to condense many columns into 
-- a single column.