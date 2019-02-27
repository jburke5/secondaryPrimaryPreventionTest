use "/Users/burke/Documents/research/bpCog/testRodJeremyThesis/simulatedDataOutput.dta"

drop  trueCausalEffect observedTreatmentEffect  secondaryRisk treatmentEffect


stset time, id(id) failure(treatmentT) enter(time==0) exit(time==10)


//first just try a simple model
stcox c.baselineRisk i.secondaryPrevention , nohr
predict basehazSimple, basechaz
regress basehazSimple time



stcox baselineRisk, shared(secondaryPrevention) forceshared nohr
predict frailities, effects
predict basesurv, basesurv
predict basehaz, basechaz

regress basehaz time

table secondaryPrevention, c(mean frailities)

