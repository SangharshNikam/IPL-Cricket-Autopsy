USE ipl_db;

# 1 BASIC EXPLORATION
# 1.1 Total matches per season
select season, count(*) as total_matches,
count(distinct team1) as unique_teams
from matches
group by season
order by season;

#1.2 How many mactches each team won overall
select winner as team, count(*) as wins
from matches 
where winner is not null
group by winner 
order by wins desc;

-- Season Champions — IPL Finals
SELECT
    season,
    team1,
    team2,
    winner            AS ipl_champion,
    venue             AS final_venue
FROM   matches
WHERE  match_type = 'Final'
ORDER  BY season;

# 1.3 which venue hosted most matches
select venue,city, count(*) as matches_hosted
from matches
group by venue,city
order by matches_hosted desc
limit 15;

#-------------------------------------------
# 2: Toss Analysis 
# 2.1 Overall: Does winning the toss help win the match?
select count(*) as total_matches,
sum(toss_won_match) as toss_winner_also_won,
round(avg(toss_won_match)*100,1) as toss_win_pct
from matches;

# 2.2 Toss decision breakdown: bat vs field - which wins more?
select toss_decision, count(*) as matches,
sum(toss_won_match) as toss_winner_won,
round(avg(toss_won_match)*100,1) as win_pct
from matches
where toss_decision in('bat','field')
group by toss_decision;

# 2.3 Toss impact per season - did toss matter more in early IPL?
select season, count(*) as matches,
round(avg(toss_won_match)*100,1) as  toss_win_pct,
sum(case when toss_decision = 'field' then 1 else 0 end) as chose_field
from matches
group by season
order by season;

# 2.4 Per team: who benefits most from winning toss?
select toss_winner as team,
count(*) as toss_wins,
sum(toss_won_match) as match_wins_after_toss,
round(avg(toss_won_match)*100,1) as toss_to_win_pct
from matches
where toss_winner is not null
group by toss_winner
order by toss_to_win_pct desc;

# 3: HOME GORUND ADVANTAGE
# 3.1 Home ground wins - simplified
-- "Home" = city matches team's known home city
-- We tag home teams manually via CASE
select winner, city, count(*) as wins_in_city
from matches 
where winner is not null 
group by winner,city
order by winner, wins_in_city desc;

# 3.2 Win % at each venue by team (find dominant home venues)
select batting_team as team,
m.venue, 
count(distinct m.match_id) as matches_played,
sum(case when m.winner = batting_team then 1 else 0 end) as wins,
round(sum(case when m.winner = batting_team then 1 else 0 end) /
count(distinct m.match_id)*100,1) as win_pct
from deliveries d 
join matches m on d.match_id = m.match_id
where d.inning = 1
group by team,m.venue
having matches_played >=5
order by win_pct desc;

# 4: BATTING ANALYSIS
# 4.1 Top 10 run scorers all time
select batsman, count(*) as ball_faced,
sum(batsman_runs) as total_runs,
sum(case when batsman_runs = 4 then 1 else 0 end) as fours,
sum(case when batsman_runs = 6 then 1 else 0 end) as sixes,
round(sum(batsman_runs)/count(*) *100,1) as strike_rate
from deliveries
where extras_type!= 'wides'
group by batsman
order by total_runs desc
limit 10;

# 4.2 Team batting performance per season
select m.season, d.batting_team as team,
round(avg(d.total_runs)*120,1) as avg_score_per_20_overs,
sum(case when d.batsman_runs = 6 then 1 else 0 end) as total_sixes,
sum(case when d.batsman_runs = 4 then 1 else 0 end) as total_fours
from deliveries d
join matches m on d.match_id = m.match_id
where d.inning = 1
group by m.season, d.batting_team
order by m.season,avg_score_per_20_overs desc;


# 5: BOWLING ANALYSIS
# 5.1 Top wickets takers all time
SELECT
    bowler,
    COUNT(CASE WHEN is_wicket = 1
               AND dismissal_kind NOT IN ('run out','retired hurt','obstructing the field')
          THEN 1 END)           AS wickets,
    COUNT(CASE WHEN extras_type NOT IN ('wides','noballs') THEN 1 END) AS legal_balls,
    SUM(total_runs)             AS runs_conceded,
    ROUND(
        SUM(total_runs) /
        NULLIF(COUNT(CASE WHEN extras_type NOT IN ('wides','noballs') THEN 1 END), 0)
        * 6, 1
    )                           AS economy_rate
FROM   deliveries
GROUP  BY bowler
ORDER  BY wickets DESC
LIMIT  10;

-- 5.2 Dismissal types breakdown
SELECT
    dismissal_kind,
    COUNT(*) AS count,
    ROUND(COUNT(*) / SUM(COUNT(*)) OVER() * 100, 1) AS pct
FROM   deliveries
WHERE  is_wicket = 1
  AND  dismissal_kind IS NOT NULL
GROUP  BY dismissal_kind
ORDER  BY count DESC;

# PRESSURE ANALYSIS
# 6.1 Chasing succes rate overall 
select count(*) as total_matches,
sum(chased_successfully) as successful_chases,
round(avg(chased_successfully)*100,1) as chase_success_pct
from matches
where toss_decision in('bat','field');

# 6.2 Highest successful chases
SELECT
    m.season,
    m.team1, m.team2,
    m.winner                                AS chasing_team,
    m.inn1_runs                             AS target,
    m.inn2_runs                             AS chased,
    m.win_margin                             AS wickets_in_hand,
    m.venue
FROM   matches m
WHERE  m.chased_successfully = 1
  AND  m.inn1_runs IS NOT NULL
ORDER  BY m.inn1_runs DESC
LIMIT  10;
 
-- 6.3 Average runs in last 5 overs (pressure overs) per team per season
SELECT
    m.season,
    d.batting_team,
    ROUND(AVG(d.total_runs) * 30, 1)    AS avg_last5_over_runs
FROM   deliveries d
JOIN   matches m ON d.match_id = m.match_id
WHERE  d.`over` BETWEEN 15 AND 19
GROUP  BY m.season, d.batting_team
ORDER  BY m.season, avg_last5_over_runs DESC;


# 7: PLAYER OF THE MATCH ANALYSIS
# 7.1 Most of the Match awards
select  player_of_match, count(*) as pom_awards,
count(distinct season) as seasons_active
from matches
where player_of_match is not null 
and player_of_match!= 'Unknown'
group by player_of_match 
order by pom_awards desc
limit 15;

# 7.2 POM winners per team (which team has most match-winning individuals?)
select winner as team,
player_of_match, count(*) as awards
from matches
where player_of_match is not null 
and winner is not null 
group by winner, player_of_match
having awards >=3
order by winner, awards desc;


# 8: TITLE WINNERS - SEASON CHAMPIONS
# 8.1 IPL champions ( final match of each season = highest match_id per season)
with season_finals as (
select season, max(match_id) as final_match_id
from matches 
group by season 
)
select m.season, m.winner as ipl_champion,
m.venue as final_venue 
from matches m
join season_finals sf
on m.match_id = sf.final_match_id
order by m.season;

# 8.2 Most wins per season( dominace metirc)
select m.season, m.winner, count(*) as season_wins
from matches m
where m.winner is not null 
group by m.season, m.winner
order by m.season, season_wins desc;	

# 8.3 Who won the most trophies? 
SELECT 
    winner AS team,
    COUNT(*) AS trophies
FROM matches
WHERE match_id IN (
    SELECT MAX(match_id)
    FROM matches
    GROUP BY season
)
GROUP BY winner
ORDER BY trophies DESC;

# Saving Queries for powerbi 

