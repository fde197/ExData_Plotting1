plot4<- function() {
   # read the file
   print("Reading table...")
   data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
   
   # extract element to analyse
   print("Extracting the 2 days...")
   subData <- subset(data,(as.Date(data$Date,format='%d/%m/%Y')==as.Date('2007-02-01',format='%Y-%m-%d')) | (as.Date(data$Date,format='%d/%m/%Y')==as.Date('2007-02-02',format='%Y-%m-%d')))
   
   # combine date and time in a new col
   print("Combine date and time")
   library(data.table)
   subData <- as.data.table(subData)
   subData <- subData[, dt:=paste(subData$Date, subData$Time, sep=" ")]
   
   # since I am french set the date in english
   Sys.setlocale("LC_TIME", "C")
   
   # create a png 480 x 480
   print("Create plot4.png")
   png("plot4.png", width=480, height=480)
   
   # histogram
   print("Make Histogram")
   par(mfrow = c(2, 2))
   
   plot(strptime(subData$dt, "%d/%m/%Y %H:%M:%S"),subData$Global_active_power, type="l", xlab="", ylab="Global Active Power")
   
   plot(strptime(subData$dt, "%d/%m/%Y %H:%M:%S"),subData$Voltage, type="l", xlab="datetime", ylab="Voltage")
   
   plot(strptime(subData$dt, "%d/%m/%Y %H:%M:%S"), subData$Sub_metering_1, xlab="", ylab="Energy sub metering", col="black", type="l")
   points(strptime(subData$dt, "%d/%m/%Y %H:%M:%S"), subData$Sub_metering_2, xlab="", ylab="Energy sub metering", col="red", type="l")
   points(strptime(subData$dt, "%d/%m/%Y %H:%M:%S"), subData$Sub_metering_3, xlab="", ylab="Energy sub metering", col="blue", type="l")
   legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red", "blue"), lwd=2, bty="n")
   
   plot(strptime(subData$dt, "%d/%m/%Y %H:%M:%S"),subData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
   
   # copy on file
   print("Copy on file")
   dev.off()
}