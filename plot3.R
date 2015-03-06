plot3<- function() {
   # read the file
   print("Read table...")
   data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
   
   # extract element to analyse
   print("Extract the 2 days...")
   subData <- subset(data,(as.Date(data$Date,format='%d/%m/%Y')==as.Date('2007-02-01',format='%Y-%m-%d')) | (as.Date(data$Date,format='%d/%m/%Y')==as.Date('2007-02-02',format='%Y-%m-%d')))
   
   # combine date and time in a new col
   print("Combine date and time")
   library(data.table)
   subData <- as.data.table(subData)
   subData <- subData[, dt:=paste(subData$Date, subData$Time, sep=" ")]
   
   # since I am french set the date in english
   Sys.setlocale("LC_TIME", "C")
   
   # create a png 480 x 480
   print("Create plot3.png")
   png("plot3.png", width=480, height=480)
   
   # histogram
   print("Make Histogram")
   plot(strptime(subData$dt, "%d/%m/%Y %H:%M:%S"), subData$Sub_metering_1, xlab="", ylab="Energy sub metering", col="black", type="l")
   points(strptime(subData$dt, "%d/%m/%Y %H:%M:%S"), subData$Sub_metering_2, xlab="", ylab="Energy sub metering", col="red", type="l")
   points(strptime(subData$dt, "%d/%m/%Y %H:%M:%S"), subData$Sub_metering_3, xlab="", ylab="Energy sub metering", col="blue", type="l")
   
   # add legend
   legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red", "blue"), lwd=2)
   
   # copy on file
   print("Copy on file")
   dev.off()
}