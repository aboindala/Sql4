WITH CTE AS(
    SELECT home_team_id as r1, home_team_goals as g1, away_team_goals as g2 FROM Matches
    UNION ALL
    SELECT away_team_id as r1, away_team_goals as g1, home_team_goals as g2 FROM Matches
)
SELECT t.team_name, COUNT(c.r1) AS 'matches_played', SUM(
    CASE
        WHEN c.g1 > c.g2 THEN 3
        WHEN c.g1 = c.g2 THEN 1
        ELSE 0
    END
)
AS 'points', SUM(c.g1) AS 'goal_for' , SUM(c.g2) AS 'goal_against', SUM(c.g1) - SUM(C.g2)
AS 'goal_diff' FROM teams t JOIN CTE c ON t.team_id = c.r1 GROUP BY c.r1 ORDER BY points DESC, goal_diff
DESC, t.team_name;