{{config(
    materialized = 'incremental',
    on_schema_change = 'fail'
    )
}}
WITH src_reviews as(
    SELECT *
    from {{ref("src_reviews")}}
)
SELECT * from src_reviews
where review_text is not null
{% if is_incremental() %}
AND review_date > (Select max(review_date) from {{this}})
{% endif %}