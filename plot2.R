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

# plot 2
# Open the PNG
png(file="./data/plot2.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
# create the plot
plot(subData$Date_Time,subData$Global_active_power, type = "l", 
     ylab = "Global Active Power (Kilowatts)", xlab = '')
# close the png
dev.off()