/*
 * Count the number of English tweets containing the word "coronavirus"
 */

select
count(*)
from tweets_jsonb
where to_tsvector('english', coalesce(data->'extended_tweet'->>'full_text',data->>'text'))@@to_tsquery('english','coronavirus')
and data->>'lang'='en'
;
