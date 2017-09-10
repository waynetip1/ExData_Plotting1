library(data.table)
library(lubridate)
library(dplyr)
library(tidyr)
library(chron)
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile = "./data/dataset.zip")

unzip(zipfile ="./data/dataset.zip", exdir = "./data")
list.files("./data/")
pathdata <- "./data/household_power_consumption.txt"
pwrConsumption <- fread(pathdata, sep = ";",header = T, 
                        na.strings = c("?","NA","N/A","null"))

pwrCon <- pwrConsumption
subData <- filter(pwrCon, Date=="1/2/2007" | Date == "2/2/2007")

subData$Date_Time <- strptime(paste(subData$Date,subData$Time),
                              format = "%d/%m/%Y %H:%M:%S")

# plot 2
png(file="./data/plot2.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
plot(subData$Date_Time,subData$Global_active_power, type = "l", 
     ylab = "Global Active Power (Kilowatts)", xlab = '')
dev.off()