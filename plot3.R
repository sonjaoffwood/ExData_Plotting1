##Getting and preparing the data
#downloading the data and reading it into R
url="http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"hpc.zip")
data=read.table(unz("hpc.zip","household_power_consumption.txt"),sep=";", header=TRUE, na.strings="?")
dateDownloaded=date()

#create timestamp by using date and time of data
data$Date=as.character(data$Date)
data$Time=as.character(data$Time)
data[,"timestamp"]=as.POSIXct(paste(data$Date,data$Time),format='%d/%m/%Y %H:%M:%S')

#subset data to only use the two required dates
data$Date=as.Date(data$Date, format='%d/%m/%Y')
data2=subset(data, Date %in% as.Date(c('2007-02-01','2007-02-02')))

#plot3
png(filename="plot3.png",width = 480, height = 480)
plot(data2$timestamp,data2$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(data2$timestamp,data2$Sub_metering_1, col='black')
lines(data2$timestamp,data2$Sub_metering_2, col='red')
lines(data2$timestamp,data2$Sub_metering_3, col='blue')
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)
dev.off()
