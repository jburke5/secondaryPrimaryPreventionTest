use "/Users/burke/Documents/research/bpCog/testRodJeremyThesis/simulatedDataOutput.dta"

drop  trueCausalEffect observedTreatmentEffect  secondaryRisk treatmentEffect


stset time, id(id) failure(noTreatmentT) enter(time==0) exit(time==10)


stcox baselineRisk secondaryPrevention , nohr
predict basehaz, basechaz
regress basehaz time



stcox baselineRisk, shared(secondaryPrevention) forceshared nohr
predict frailities, effects
predict basesurv, basesurv
predict basehaz, basechaz

regress basehaz time

table secondaryPrevention, c(mean frailities)

