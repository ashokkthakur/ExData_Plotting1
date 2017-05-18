library(dplyr)
library(tidyr)

## source file variable	
	file <- "./data/household_power_consumption.zip"

## capture url and download the zip file, if not already exists.
	if (!file.exists(file)){
		url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
		download.file(url, "./data/whousehold_power_consumption.zip")
 	}
## unzip the source data and get the contents of the zip file.
	 unzip("./data/household_power_consumption.zip", exdir="./data")

##install.packages("sqldf")
library(sqldf)

## read the text files and store in dataframes.
 	 ucidata<- read.csv.sql("./data/household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')", header = TRUE, sep = ";")

## format date-time
	 ucidata1<- ucidata
	 ucidata1$Time <- paste(ucidata1$Date, ucidata$Time)
	 ucidata1$Time <- as.POSIXct(ucidata1$Time, format="%d/%m/%Y %H:%M:%S")
##turn on png device, plot graph and turn png device off
	 png(file="plot2.png")
	 plot(Global_active_power~Time, ucidata1, type = "l", xlab= "", ylab= "Global Active Power (kilowatts)")
	 dev.off()


