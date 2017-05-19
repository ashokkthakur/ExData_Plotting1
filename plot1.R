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

	png(file="plot1.png")
	hist(ucidata$Global_active_power, xlab= "Global Active Power (kilowatts)", col="red", main="Global Active Power")
	dev.off()
