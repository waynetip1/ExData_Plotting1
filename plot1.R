library(data.table)
library(lubridate)
library(dplyr)
library(tidyr)
library(chron)

# Assign download URl to variable and then download
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile = "./data/dataset.zip")

# Unzip file
unzip(zipfile ="./data/dataset.zip", exdir = "./data")
list.files("./data/")
pathdata <- "./data/household_power_consumption.txt"

# Read data in
pwrConsumption <- fread(pathdata, sep = ";",header = T, 
                        na.strings = c("?","NA","N/A","null"))
# assign to new variable to manipulate
pwrCon <- pwrConsumption
# subset the data to view particular days
subData <- filter(pwrCon, Date=="1/2/2007" | Date == "2/2/2007")
# create a date time column
subData$Date_Time <- strptime(paste(subData$Date,subData$Time),
                              format = "%d/%m/%Y %H:%M:%S")
# plot 1
# open the png 
png(file="./data/plot1.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
# The Historgram
hist(subData$Global_active_power,main = "Global Active Power",
     xlab = "Global Active Power(kilowatts)", ylab = "Frequency", col = "red")
# close the png
dev.off()
