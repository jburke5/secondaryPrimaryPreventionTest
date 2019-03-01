use "/Users/burke/Documents/research/bpCog/testRodJeremyThesis/simulatedDataOutput.dta"

drop  trueCausalEffect observedTreatmentEffect  secondaryRisk treatmentEffect


stset time, id(id) failure(treatmentT) enter(time==0) exit(time==10)


//first just try a simple model
stcox c.baselineRisk i.secondaryPrevention , nohr
predict basehazSimple, basechaz
regress basehazSimple time, nocons

//then an interaction
stcox c.baselineRisk##i.secondaryPrevention , nohr
predict basehazInt, basechaz
regress basehazInt time, nocons

//thjen stratified
stcox baselineRisk, strata(secondaryPrevention)  nohr
predict baseHazStrat, basechaz
regress baseHazStrat c.time if secondaryPrevention==1 , nocons
regress baseHazStrat c.time if secondaryPrevention==0 , nocons



#
stcox baselineRisk, shared(secondaryPrevention) forceshared nohr
predict frailities, effects
predict basesurv, basesurv
predict basehaz, basechaz

regress basehaz time

table secondaryPrevention, c(mean frailities)

