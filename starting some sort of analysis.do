*First on initial assessment data

encode STATS_CURR_CENSUS_LOWER_SUPER_OU, gen(lsoa)

*Now on birth outcome data set-what I am going to do is make two datasets to start and can revise

encode STATS_CURR_CENSUS_LOWER_SUPER_OU, gen(lsoa)

*Now trying on IMD data
encode LSOA2001_CD, gen(lsoa)

*There are way too many observations, I think we really only need one-not sure why so many?

bys lsoa START_DATE: keep if _n==_N *This didn't really work*

*Trying something else
bys lsoa: gen obs=_n

keep if obs==1


merge 1:m lsoa using "S:\1020 - Upstream factors and wider determinants of health associated with adverse pr\birth outcomes.dta"


*Maternal age
tab MAT_AGE
gen age=MAT_AGE
replace age=. if age>57
replace age=. if age<13
tab age


*Apgar score
tab BIRTH_APGAR_SCORE
gen apgar_score=BIRTH_APGAR_SCORE
replace apgar_score=. if BIRTH_APGAR_SCORE==99
tab apgar_score

*IMD
tab WIMD_2011_DECILE

bys apgar: sum WIMD_2011_DECILE

bys WIMD_2011_DECILE: sum apgar_score



*Next Birth Mode-This needs more thought 
tab BIRTH_MODE_CD
gen v_birth=.
replace v_birth=1 if BIRTH_MODE_CD==1
replace v_birth=0 if BIRTH_MODE_CD==2| BIRTH_MODE_CD==3| BIRTH_MODE_CD==4|BIRTH_MODE_CD==5
label variable v_birth "spontaneous vaginal birth"
tab v_birth

gen assited_birth=.
replace assited_birth=1 if BIRTH_MODE_CD==2 | BIRTH_MODE_CD==3
replace assited_birth=0 if BIRTH_MODE_CD==1 |BIRTH_MODE_CD==4|BIRTH_MODE_CD==5
label variable assited_birth "ventouse/forceps birth"
tab assited_birth

gen elective_csection=.
replace elective_csection=1 if BIRTH_MODE_CD==4 
replace elective_csection=0 if BIRTH_MODE_CD==1 |BIRTH_MODE_CD==2|BIRTH_MODE_CD==5 | BIRTH_MODE_CD==3
label variable elective_csection "elective c-section"
tab elective_csection

gen emergency_csection=.
replace eemergency_csection=1 if BIRTH_MODE_CD==5 
replace emergency_csection=0 if BIRTH_MODE_CD==1 |BIRTH_MODE_CD==2|BIRTH_MODE_CD==4 | BIRTH_MODE_CD==3
label variable emergency_csection "emergency c-section"
tab emergency_csection

*Pre-term birth
tab LABOUR_ONSET_GEST_WEEKS
gen preterm=0
replace preterm=1 if LABOUR_ONSET_GEST_WEEKS<37 & BIRTH_OUTCOME_CD~=2
label variable preterm "Less than 27 weeks"
tab preterm
bys WIMD_2011_DECILE:tab preterm




*Now trying to add in initial assessment data

duplicates tag MOTHER_ALF_PE, gen(dup)
tab dup

*For now we are going to get rid of duplicates
drop if dup>=1

*NOTE THIS USES DATA AFTER REMOVING DUPLICATES*
 merge 1:m MOTHER_ALF_PE using "S:\1020 - Upstream factors and wider determinants of health associated with adverse pr\merged IMD and birth outcomes try one 190620 WITHOUT DUPLICATES.dta", force 
 
 *Going back to birth outcomes dataset and going to look at duplicates
 
 duplicates tag MOTHER_ALF_PE, gen(dup)
tab dup

*For now we are going to get rid of duplicates
drop if dup>=1

*LATE BOOKING IN >20

 tab GEST_WEEKS
 gen late_booking=0
 replace late_booking=1 if GEST_WEEKS>20 & GEST_WEEKS<43
 replace late_booking=. if GEST_WEEKS>43
 tab late_booking

bys WIMD_2011_DECILE: tab late_booking

*Now adding in parity
tab SERVICE_USER_PARITY_CD
gen parity=0
replace parity=1 if SERVICE_USER_PARITY_CD==1
replace parity=2 if SERVICE_USER_PARITY_CD==2
replace parity=3 if SERVICE_USER_PARITY_CD==3


*Now creating a variable for BMI and overweight and obese
sum SERVICE_USER_HEIGHT 
tab SERVICE_USER_HEIGHT  

*Going to scale from 120cm to 200cm
gen height=SERVICE_USER_HEIGHT 
replace height=. if SERVICE_USER_HEIGHT<120
replace height=. if SERVICE_USER_HEIGHT>200
tab height
gen height_metres=height/100
sum height_metres 

sum SERVICE_USER_WEIGHT_KG
tab SERVICE_USER_WEIGHT_KG
*Going to cap at 40kg to 200kg
gen weight=SERVICE_USER_WEIGHT_KG
replace weight=. if SERVICE_USER_WEIGHT_KG<40
replace weight=. if SERVICE_USER_WEIGHT_KG>200
sum weight

gen BMI=weight/(height_metres^2)
sum BMI
replace BMI=. if BMI>80

gen overweight_obese=.
replace overweight_obese=0 if BMI>11 &BMI<25
replace overweight_obese=1 if BMI>25 &BMI<80
tab overweight_obese 

*Now adding maternal smoking status
tab SERVICE_USER_SMOKER_STS_CD
gen smoker=.
replace smoker=1 if SERVICE_USER_SMOKER_STS_CD==1
replace smoker=0 if SERVICE_USER_SMOKER_STS_CD==2|SERVICE_USER_SMOKER_STS_CD==3| SERVICE_USER_SMOKER_STS_CD==4
replace smoker=. if SERVICE_USER_SMOKER_STS_CD==9
tab smoker 

*Now looking at stillbirth
tab BIRTH_OUTCOME_CD

gen stillbirth=0
replace stillbirth=1 if BIRTH_OUTCOME_CD==2
tab stillbirth


*BLOOD LOSS HEMROGING
sum LABOUR_ESTIMATED_BLOOD_LOSS_ML
gen majorpph=.
replace majorpph=0 if LABOUR_ESTIMATED_BLOOD_LOSS_ML>=0 & LABOUR_ESTIMATED_BLOOD_LOSS_ML<1500
replace majorpph=1 if LABOUR_ESTIMATED_BLOOD_LOSS_ML>1500 & LABOUR_ESTIMATED_BLOOD_LOSS_ML<3000
tab majorpph



*PERINEAL TEAR
tab LABOUR_PERINEAL_STS_CD

gen thirdfourthperineal_tear=.
replace thirdfourthperineal_tear=0 if LABOUR_PERINEAL_STS_CD==1| LABOUR_PERINEAL_STS_CD==2 | LABOUR_PERINEAL_STS_CD==8
replace thirdfourthperineal_tear=1 if LABOUR_PERINEAL_STS_CD==9
tab thirdfourthperineal_tear




*BIRTHWEIGHT
sum SERVICE_USER_WEIGHT_GRAMS
tab SERVICE_USER_WEIGHT_GRAMS
gen birthweight=SERVICE_USER_WEIGHT_GRAMS
*Going to drop those with a weight of <750g and greater than 5443g
replace birthweight=. if SERVICE_USER_WEIGHT_GRAMS<750
replace birthweight=. if SERVICE_USER_WEIGHT_GRAMS>5443
sum birthweight 

*For SGA and LGA used RSGO growth charts to determine

*Now small for gestational age
gen SGA=0
replace SGA=1 if birthweight<1500 & LABOUR_ONSET_GEST_WEEKS==32
replace SGA=1 if birthweight<1700 & LABOUR_ONSET_GEST_WEEKS==33
replace SGA=1 if birthweight<1800 & LABOUR_ONSET_GEST_WEEKS==34
replace SGA=1 if birthweight<1900 & LABOUR_ONSET_GEST_WEEKS==35
replace SGA=1 if birthweight<2000 & LABOUR_ONSET_GEST_WEEKS==36
replace SGA=1 if birthweight<2300 & LABOUR_ONSET_GEST_WEEKS==37
replace SGA=1 if birthweight<2500 & LABOUR_ONSET_GEST_WEEKS==38
replace SGA=1 if birthweight<2700 & LABOUR_ONSET_GEST_WEEKS==39
replace SGA=1 if birthweight<3000 & LABOUR_ONSET_GEST_WEEKS==40
replace SGA=1 if birthweight<3200 & LABOUR_ONSET_GEST_WEEKS==41
replace SGA=1 if birthweight<3200 & LABOUR_ONSET_GEST_WEEKS==42
tab SGA


*LGA
gen LGA=0
replace LGA=1 if birthweight>2200 & LABOUR_ONSET_GEST_WEEKS==32
replace LGA=1 if birthweight>2400 & LABOUR_ONSET_GEST_WEEKS==33
replace LGA=1 if birthweight>2500 & LABOUR_ONSET_GEST_WEEKS==34
replace LGA=1 if birthweight>2700 & LABOUR_ONSET_GEST_WEEKS==35
replace LGA=1 if birthweight>3000 & LABOUR_ONSET_GEST_WEEKS==36
replace LGA=1 if birthweight>3200 & LABOUR_ONSET_GEST_WEEKS==37
replace LGA=1 if birthweight>3500 & LABOUR_ONSET_GEST_WEEKS==38
replace LGA=1 if birthweight>3700 & LABOUR_ONSET_GEST_WEEKS==39
replace LGA=1 if birthweight>4000 & LABOUR_ONSET_GEST_WEEKS==40
replace LGA=1 if birthweight>4200 & LABOUR_ONSET_GEST_WEEKS==41
replace LGA=1 if birthweight>4200 & LABOUR_ONSET_GEST_WEEKS==42
tab LGA



*Putting in year to see if that makes a difference

gen yearborb=year(BABY_BIRTH_DT)

