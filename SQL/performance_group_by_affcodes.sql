SELECT date
      ,affcode
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
  WHERE a.`campaign_id` IN(SELECT campaign_id FROM portfolio_members a WHERE portfolio_id=17 AND end_date IS NULL)
  AND profile_id=414 AND a.`date` > '2018-09-01'
  AND affcode IN
      (
         981464
        ,981666
        ,981712
        ,981789
        ,981630
        ,981696
        ,981659
        ,981637
        ,981761
        ,981780
      )
  GROUP BY
       date
      ,affcode
ORDER BY
      affcode
      ,date ASC;