plot1<- function() {
   # read the file
   print("Reading table...")
   data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

   # extract element to analyse
   print("Extracting the 2 days...")
   subData <- subset(data,(as.Date(data$Date,format='%d/%m/%Y')==as.Date('2007-02-01',format='%Y-%m-%d')) | (as.Date(data$Date,format='%d/%m/%Y')==as.Date('2007-02-02',format='%Y-%m-%d')))

   # create a png 480 x 480
   print("Create plot1.png")
   png("plot1.png", width=480, height=480)

   # histogram
   print("Make Histogram")
   hist(subData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

   # copy on file
   print("Copy on file")
   dev.off()
}