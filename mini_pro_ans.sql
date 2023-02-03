-- 1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.
select BIDDER_ID, BIDDER_NAME, 
(select count(*) from ipl_bidding_details bd where BID_STATUS = 'won' and bd.BIDDER_ID = ipl_bidder_details.BIDDER_ID)/
(select NO_OF_BIDS from ipl_bidder_points bp where bp.BIDDER_ID = ipl_bidder_details.BIDDER_ID) * 100 PERCENTAGE
from ipl_bidder_details order by PERCENTAGE DESC;

-- 2.	Display the number of matches conducted at each stadium with stadium name, city from the database.
select STADIUM_ID , 
(select STADIUM_NAME from ipl_stadium s where s.STADIUM_ID = ms.STADIUM_ID) STADIUM_NAME,  count(*) NO_OF_MATCHES
from ipl_match_schedule ms group by STADIUM_ID 
order by STADIUM_ID;

-- 3.	In a given stadium, what is the percentage of wins by a team which has won the toss?
select * from ipl_match;
select * from ipl_match_schedule;
select STADIUM_ID, STADIUM_NAME,
(select count(*) from ipl_match m join ipl_match_schedule ms on m.MATCH_ID = ms.MATCH_ID where (ms.STADIUM_ID = s.STADIUM_ID) AND (TOSS_WINNER = MATCH_WINNER)) /
(select count(*) from   ipl_match_schedule ms where ms.STADIUM_ID = s.STADIUM_ID) *100 PERCENTAGE_WIN
from ipl_stadium s;

-- 4.	Show the total bids along with bid team and team name.
select * from ipl_bidding_details;
select * from ipl_team;
select BID_TEAM, TEAM_NAME, count(*) TOTAL_BIDS from ipl_bidding_details bd join ipl_team t
on bd.BID_TEAM = t.TEAM_ID
group by BID_TEAM;

-- 5.	Show the team id who won the match as per the win details.
select * from ipl_match;
select * from ipl_team;
select TEAM_ID, TEAM_Name, MATCH_ID, t.REMARKS, WIN_DETAILS from ipl_team t 
join  ipl_match m 
on t.remarks = substring(WIN_DETAILS,6,2)
union all
select TEAM_ID, TEAM_Name, MATCH_ID, t.REMARKS, WIN_DETAILS from ipl_team t 
join  ipl_match m 
on t.remarks = substring(WIN_DETAILS,6,3)
union all
select TEAM_ID, TEAM_Name, MATCH_ID, t.REMARKS, WIN_DETAILS from ipl_team t 
join  ipl_match m 
on t.remarks = substring(WIN_DETAILS,6,4)
order by MATCH_ID;

-- 6.	Display total matches played, total matches won and total matches lost by team along with its team name
select t.TEAM_ID, TEAM_NAME, MATCHES_PLAYED, MATCHES_WON, MATCHES_LOST from ipl_team t 
join ipl_team_standings ts
on t.TEAM_ID = ts.TEAM_ID
group by t.TEAM_ID;

-- 7.	Display the bowlers for Mumbai Indians team
select tp.PLAYER_ID, PLAYER_NAME from ipl_team_players tp
join ipl_player p  
on  tp.PLAYER_ID = p.PLAYER_ID
where TEAM_ID = (select TEAM_ID from ipl_team where TEAM_NAME = 'Mumbai Indians') and PLAYER_ROLE = 'Bowler';

-- 8.	How many all-rounders are there in each team, Display the teams with more than 4 all-rounder in descending order.
select t.TEAM_ID, TEAM_NAME, count(*) NO_OF_ALL_ROUNDER from ipl_team t
join ipl_team_players tp 
on t.TEAM_ID = tp.TEAM_ID
where tp.PLAYER_ROLE = 'All-Rounder'
group by t.TEAM_ID;

select t.TEAM_ID, TEAM_NAME, count(*) NO_OF_ALL_ROUNDER from ipl_team t
join ipl_team_players tp 
on t.TEAM_ID = tp.TEAM_ID
where tp.PLAYER_ROLE = 'All-Rounder'
group by t.TEAM_ID having count(*)>4;


