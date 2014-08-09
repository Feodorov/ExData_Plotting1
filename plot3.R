## plot3
## Energy submetering

## use data.table library 
library(data.table) 

## open file connection and donwload .zip file
filename <- "household_power_consumption.zip"
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", filename, method="curl")

## get the .txt filename
dataName <- unzip(filename, list=TRUE)$Name
unzip(filename)

## read only required data
data <- fread(dataName, header=FALSE, sep=";", skip=66637, nrows=2880, na.strings="?")
setnames(data, old = colnames(data), new = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# set locale for correct label names
Sys.setlocale("LC_TIME", "en_US.UTF-8")

# convert date
data$Date <- as.Date(data$Date, "%d/%m/%Y")
# convert to "date time" for x axis
time <- as.POSIXct(paste(as.character(data$Date), data$Time, sep=" "))

# plot data in "plot3.png" file
png("plot3.png")
plot(time, data$Sub_metering_1, xlab="", type="l", ylab="Energy sub metering")
# add more lines to the same plot
lines(time, data$Sub_metering_2,col="red")
lines(time, data$Sub_metering_3,col="blue") 
# add a legend 
legend("topright", cex=1, col=c("black", "red", "blue"), 
       lwd=1, y.intersp=1, xjust=1, text.width = strwidth("Sub_metering_1"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()