/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */

select '#' || t.tag as tag,
          count(*) as count
from (
select data->>'id',
              jsonb_path_query(data, '$.extended_tweet.entities.hashtags[*]')->>'text' as tag
from tweets_jsonb
where data ->'extended_tweet'->'entities'->'hashtags'@@'$[*].text == "coronavirus"'
union
select data->>'id',
          jsonb_path_query(data, '$.entities.hashtags[*]')->>'text' as tag
from tweets_jsonb
where  data->'entities'->'hashtags'@@'$[*].text == "coronavirus"'
)t
group by (1)
order by count DESC, (1)
limit 1000;
