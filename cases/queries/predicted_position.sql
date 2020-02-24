SELECT
     perf.date,
     sum(perf.imps*imprAbsTop)/sum(perf.imps) as prominence_abs_imps,
     sum(perf.imps*perf.pos)/sum(perf.imps) as avg_pos_imps,
     sum(perf.imps*acs.pos)/sum(perf.imps) as predicted_pos_imps,
     sum(perf.clicks*imprAbsTop)/sum(perf.clicks) as prominence_abs_clicks,
     sum(perf.clicks*perf.pos)/sum(perf.clicks) as avg_pos_clicks,
     sum(perf.clicks*acs.pos)/sum(perf.clicks) as predicted_pos_clicks,
    (sum(perf.maxcpc*perf.clicks)/sum(perf.clicks))/(sum(perf.cost)/sum(perf.clicks)) as bid2cpc
FROM performance_by_affcode_device perf
     left join ad_criterias_sim acs on acs.affcode = perf.affcode and acs.profile_id = perf.profile_id
     left join ad_criterias ac ON perf.affcode=ac.affcode AND perf.profile_id = ac.profile_id
     left join customer_campaigns c_camp on ac.campaign_id = c_camp.campaign_id AND ac.profile_id = c_camp.cust_profile_id
     left join channel_accounts c_accounts on c_camp.channel_account_id = c_accounts.id AND c_camp.cust_profile_id = c_accounts.profile_id
WHERE perf.date >  %(start_date)s
AND c_accounts.agency_channel_id = 1
AND perf.campaign_id in (select campaign_id from portfolio_members where portfolio_id =%(portfolio_id)s)
GROUP BY perf.date
ORDER BY perf.date DESC;