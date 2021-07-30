***
*Adding in individual domains
*********************
encode LSOA_CD, gen(lsoa)

merge m:m lsoa using "S:\1020 - Upstream factors and wider determinants of health associated with adverse pr\physical enviro domain 2014.dta"

gen decile_physicalenviro=DECILE 

gen score_phyiscalenviro=SCORE

gen rank_physicalenviro=RANK

merge m:m lsoa using "S:\1020 - Upstream factors and wider determinants of health associated with adverse pr\income domain.dta"

keep if _merge==3

drop _merge

gen decile_income=DECILE 

gen score_income=SCORE

gen rank_income=RANK

merge m:m lsoa using "S:\1020 - Upstream factors and wider determinants of health associated with adverse pr\housing domain 2014.dta"

keep if _merge==3

drop _merge

gen decile_housing=DECILE 

gen score_housing=SCORE

gen rank_housing=RANK

drop LSOA_CD LSOA_DESC LSOA_ONS_DESC LA_DESC SCORE RANK QUINTILE QUINTILE_DESC DECILE DECILE_DESC QUARTILE QUARTILE_DESC

merge m:m lsoa using "S:\1020 - Upstream factors and wider determinants of health associated with adverse pr\education domain 2014.dta"

keep if _merge==3

drop _merge

gen decile_education=DECILE 

gen score_education=SCORE

gen rank_education=RANK

encode LSOA_CD, gen(lsoa)

gen decile_access=DECILE 

gen score_access=SCORE

gen rank_access=RANK

drop AVAIL_FROM_DT QUARTILE_DESC QUARTILE DECILE_DESC DECILE QUINTILE_DESC QUINTILE RANK SCORE LA_DESC LSOA_ONS_DESC LSOA_DESC LSOA_CD

merge m:m lsoa using "S:\1020 - Upstream factors and wider determinants of health associated with adverse pr\access to services decile.dta"

keep if _merge==3

drop _merge


encode LSOA_CD, gen(lsoa)

gen decile_safety=DECILE 

gen score_safety=SCORE

gen rank_safety=RANK

drop AVAIL_FROM_DT QUARTILE_DESC QUARTILE DECILE_DESC DECILE QUINTILE_DESC QUINTILE RANK SCORE LA_DESC LSOA_ONS_DESC LSOA_DESC LSOA_CD


merge m:m lsoa using  "S:\1020 - Upstream factors and wider determinants of health associated with adverse pr\community safety domain.dta"

keep if _merge==3

drop _merge


encode LSOA_CD, gen(lsoa)

gen decile_employment=DECILE 

gen score_employment=SCORE

gen rank_employment=RANK

drop AVAIL_FROM_DT QUARTILE_DESC QUARTILE DECILE_DESC DECILE QUINTILE_DESC QUINTILE RANK SCORE LA_DESC LSOA_ONS_DESC LSOA_DESC LSOA_CD

merge m:m lsoa using "S:\1020 - Upstream factors and wider determinants of health associated with adverse pr\employment domain.dta"

keep if _merge==3

drop _merge

encode LSOA_CD, gen(lsoa)

gen decile_health=DECILE 

gen score_health=SCORE

gen rank_health=RANK

drop AVAIL_FROM_DT QUARTILE_DESC QUARTILE DECILE_DESC DECILE QUINTILE_DESC QUINTILE RANK SCORE LA_DESC LSOA_ONS_DESC LSOA_DESC LSOA_CD

merge m:m lsoa using "S:\1020 - Upstream factors and wider determinants of health associated with adverse pr\health domain.dta"

keep if _merge==3

drop _merge


