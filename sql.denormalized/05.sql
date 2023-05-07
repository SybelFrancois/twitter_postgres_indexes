/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */
select
    '#' || (jsonb->>'text') as tag,
    count(distinct id_tweets) as count
from (
    select
        data->>'id' as id_tweets,
        jsonb_array_elements(
            coalesce(data->'entities'->'hashtags', '[]') ||
           coalesce(data->'extended_tweet'->'entities'->'hashtags', '[]')
        ) as jsonb
    from tweets_jsonb
    where to_tsvector('english', coalesce(data->'extended_tweet'->>'full_text', data->>'text')) @@ to_tsquery('english', 'coronavirus')
      and data->>'lang' = 'en'
) t
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;


