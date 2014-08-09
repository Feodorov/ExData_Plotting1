## plot2
## Fluctuations of Global Active Power during the week 

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

# convert date
data$Date <- as.Date(data$Date, "%d/%m/%Y")
# convert to "date time" for x axis
time <- as.POSIXct(paste(as.character(data$Date), data$Time, sep=" "))

# set locale for correct label names
Sys.setlocale("LC_TIME", "en_US.UTF-8")

# plot data in "plot2.png" file
png("plot2.png")
plot(time, data$Global_active_power, xlab="", type="l", ylab="Global Active Power (kilowatts)")
dev.off()
