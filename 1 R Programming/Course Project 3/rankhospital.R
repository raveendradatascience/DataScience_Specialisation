# TODO: Add comment
#
# Author: Ravi
###############################################################################

library(lattice)
setwd("/Users/Ravi/Dropbox/R/RProgramming/tarea3")
Outcome <- read.csv("Outcome-of-care-measures.csv", colClasses = "character")
head(Outcome)

#PART 3
rankhospital <- function(stateChr, outcomeChr, rankObj) {
	outcomeDfr <- Init("Outcome-of-care-measures.csv")

	suppressWarnings(outcomeDfr[, 11] <- as.numeric(outcomeDfr[, 11]))
	suppressWarnings(outcomeDfr[, 17] <- as.numeric(outcomeDfr[, 17]))
	suppressWarnings(outcomeDfr[, 23] <- as.numeric(outcomeDfr[, 23]))

	tableDfr <- data.frame(State = names(tapply(outcomeDfr$State, outcomeDfr$State,
							length)), Freq = tapply(outcomeDfr$State, outcomeDfr$State, length))
	rownames(tableDfr) <- NULL

	inputDfr <- data.frame(Outcome = c("heart attack", "heart failure", "pneumonia"),
			Col = c(11, 17, 23))

	if (nrow(tableDfr[tableDfr$State == stateChr, ]) == 0)
		stop("invalid state")
	if (nrow(inputDfr[inputDfr$Outcome == outcomeChr, ]) == 0)
		stop("invalid outcome")

	stateDfr <- outcomeDfr[outcomeDfr$State == stateChr, ]
	colNum <- inputDfr[inputDfr$Outcome == outcomeChr, 2]
	stateDfr <- stateDfr[complete.cases(stateDfr[, colNum]), ]
	stateDfr <- stateDfr[order(stateDfr[, colNum], stateDfr$Hospital.Name),
	]

	if (rankObj == "best")
		rankObj <- 1
	if (rankObj == "worst")
		rankObj <- nrow(stateDfr)

	suppressWarnings(rankNum <- as.numeric(rankObj))

	return(stateDfr[rankNum, ]$Hospital.Name)
}
