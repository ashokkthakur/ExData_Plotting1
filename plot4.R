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
	 png(file="plot4.png")

## set paramaeter for 4 plots on the device
	 par(mfcol=c(2,2))
## plot 1st graph
	 plot(Global_active_power~Time, ucidata1, type = "l", xlab= "", ylab= "Global Active Power")

## plot 2nd graph
	 plot(Sub_metering_1~Time, ucidata1, col="black", type = "l", xlab= "", ylab= "Energy sub metering")
	 points(Sub_metering_2~Time, ucidata1, col="red", type = "l")
	 points(Sub_metering_3~Time, ucidata1, col="blue", type = "l")
	 legend("topright", lty=1, col= c("black", "red", "blue"), legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## plot 3rd graph	 
	 plot(Voltage~Time, ucidata1, type = "l", xlab= "datetime", ylab= "Voltage")

## plot 4th graph
	 plot(Global_reactive_power~Time, ucidata1, type = "l", xlab= "datetime", ylab= "Global_reactive_power")

dev.off()


