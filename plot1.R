## plot2
## Global Active Power

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

# plot data into "plot1.png" file
png("plot1.png")
hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power", col="red")
dev.off()
