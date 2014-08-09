## plot4
## Different energy categories

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

# plot data in "plot4.png" file
png("plot4.png")
par(mfrow=c(2,2))
# plot topleft
plot(time, data$Global_active_power, xlab="", type="l", ylab="Global Active Power")
# plot topright
plot(time, data$Voltage, type="l", xlab="datetime", ylab="Voltage")
# plot bottom left
plot(time, data$Sub_metering_1, xlab="", type="l", ylab="Energy sub metering")
lines(time, data$Sub_metering_2, col="red")
lines(time, data$Sub_metering_3, col="blue") 
legend("topright", cex=1, col=c("black", "red", "blue"),lwd=2,bty="n",y.intersp=0.8,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# plot bottomright
plot(time, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()