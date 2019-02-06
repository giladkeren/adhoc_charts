SELECT date
      ,SUM(a.`clicks`)AS clicks
      ,SUM(a.`cost`)/SUM(a.`clicks`) AS cpc
      ,SUM(cost) as cost
      ,SUM(conv) as conversions
      ,SUM(commission) as rev
      ,SUM(cost)/SUM(conv) AS cpa
      ,SUM(conv)/sum(clicks) as CVR
      ,SUM(imps*pos)/SUM(imps) AS avg_pos
      ,SUM(imps*maxCpc)/SUM(imps) AS avg_bid
      ,SUM(commission)/SUM(cost) AS KPI
  FROM performance_by_affcode_device A
  WHERE a.`campaign_id` IN(SELECT campaign_id FROM portfolio_members a WHERE portfolio_id={portfolio_id} AND end_date IS NULL)
  AND profile_id={profile_id} AND a.`date` BETWEEN '{from_date}' AND '{to_date}'
  AND device = 1
  GROUP BY date;