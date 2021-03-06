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
#plot 4
# open the png
png(file="./data/plot4.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
# define plot page
par(mfrow=c(2,2))
# create panel 1
plot(subData$Date_Time,subData$Global_active_power, type = "l", 
     ylab = "Global Active Power (Kilowatts)", xlab = '')
# create panel 2
plot(subData$Date_Time,subData$Voltage, type = "l", 
     ylab = "Voltage", xlab = 'Date Time')

#create panel 3
plot(subData$Date_Time,subData$Sub_metering_1,
     ylim = c(0,38),type = "l", 
     ylab = "Energy sub metering", xlab = '')

par(new = TRUE)
plot(subData$Date_Time,subData$Sub_metering_2, 
     ylim = c(0,38),type = "l",
     ylab = "", xlab = '',col = "red", axes = F)

par(new = TRUE)
plot(subData$Date_Time,subData$Sub_metering_3,
     ylim = c(0,38),type = "l", 
     ylab = "", xlab = '',col = "blue", axes = F)
legend('topright', c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       col = c('black','red','blue'), bty = 'n', cex = .75)
# create panel 4
plot(subData$Date_Time,subData$Global_reactive_power, type = "l", 
     ylab = "Global_reactive_power", xlab = 'Date Time') 
# close the png
dev.off()