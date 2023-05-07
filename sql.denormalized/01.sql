/*
 * Count the number of tweets that use #coronavirus
 */
select count(*)
from tweets_jsonb
where (data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
       or data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]');
