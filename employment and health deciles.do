********************************
*New models employment
*******************************************
*LGA
***************************************************
*Basic regressions for LGA with Decile for Employment
xi: logistic LGA i.decile_employment i.year

*Full model for LGA with decile for employment
xi: logistic LGA i.decile_employment i.year age late_booking i.parity overweight_obese smoker 

*Basic regressions for LGA with decile for employment
xi: logistic LGA i.decile_employment i.year

*Full model for LGA with decile for employment
xi: logistic LGA i.decile_employment i.year age late_booking i.parity overweight_obese smoker 

***************************
*SGA
***************************************************
*Basic regressions for SGA with Decile for employment
xi: logistic SGA i.decile_employment i.year

*Full model for SGA with decile for employment
xi: logistic SGA i.decile_employment i.year age late_booking i.parity overweight_obese smoker 

*Basic regressions for SGA with Decile for health
xi: logistic SGA i.decile_health i.year

*Full model for SGA with decile for health
xi: logistic SGA i.decile_health i.year age late_booking i.parity overweight_obese smoker 



**************************************************************************************************
*Perineal Tear Note need to remove year dummies from these models
************************************************************************************************
*Basic regressions for perineal tear with Decile for Employment
xi: logistic thirdfourthperineal_tear i.decile_employment

*Full model for perineal tear with decile for Employment
xi: logistic thirdfourthperineal_tear i.decile_employment  age late_booking i.parity overweight_obese smoker 

*Basic regressions for perineal tear with Decile for health
xi: logistic thirdfourthperineal_tear i.decile_health

*Full model for perineal tear with decile for health
xi: logistic thirdfourthperineal_tear i.decile_health age late_booking i.parity overweight_obese smoker 


*****************************************************************************
*Major PPH
******************************************************************************

*Basic regressions for MPPH with Decile for Access to Employment
xi: logistic majorpph i.decile_employment

*Full model for MPPH with decile for Employment
xi: logistic majorpph i.decile_employment  age late_booking i.parity overweight_obese smoker 

*Basic regressions for MPPH with Decile for health
xi: logistic majorpph i.decile_health

*Full model for MPPH with decile for health
xi: logistic majorpph i.decile_health  age late_booking i.parity overweight_obese smoker


**************************************************************************************
*Pre-term
***********************************************************************************
*Basic regressions for preterm with Decile for employment
xi: logistic preterm i.decile_employment i.year

*Full model for preterm with decile for employment
xi: logistic preterm i.decile_employment i.year age late_booking i.parity overweight_obese smoker 

*Basic regressions for preterm with Decile for health
xi: logistic preterm i.decile_health i.year

*Full model for preterm with decile for health
xi: logistic preterm i.decile_health i.year age late_booking i.parity overweight_obese smoker 

*********************************************************************************
*Apgar Score
******************************************************************************
*Basic regressions for apgar score with Decile for employment
xi: regress apgar_score i.decile_employment i.year

*Full model for apgar score with decile for employment
xi: regress apgar_score i.decile_employment i.year age late_booking i.parity overweight_obese smoker 

*Basic regressions for apgar score with Decile for health
xi: regress apgar_score i.decile_health i.year

*Full model for apgar score with decile for health
xi: regress apgar_score i.decile_health i.year age late_booking i.parity overweight_obese smoker 

*****************************************************************************
*Emergency c-section
****************************************************************************
*Basic regressions for emergency_csection with Decile for employment
xi: logistic emergency_csection i.decile_employment i.year

*Full model for emergency_csection with decile for employment
xi: logistic emergency_csection i.decile_employment i.year age late_booking i.parity overweight_obese smoker 

*Basic regressions for emergency_csection with Decile for health
xi: logistic emergency_csection i.decile_health i.year

*Full model for emergency_csection with decile for health
xi: logistic emergency_csection i.decile_health i.year age late_booking i.parity overweight_obese smoker 