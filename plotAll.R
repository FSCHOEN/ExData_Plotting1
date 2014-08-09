#This code assumes the data to be at the below path
dataHPCUrl <- "E:/household_power_consumption.txt"



#Below is the code for reading ONLY the dates for 2007-02-01 and 2007-02-02
firstRow_1_2_2007 <- 66637
lastRow_2_2_2007 <- 69517
nRow_dif <- lastRow_2_2_2007 - firstRow_1_2_2007
hpc <- read.table(dataHPCUrl,sep=";", header=FALSE, na.strings="?",skip =firstRow_1_2_2007, nrows =  nRow_dif)

#Set names
names(hpc) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")


#Code for reading whole data set
#hpc <- read.table(dataHPCUrl,sep=";",header=TRUE,na.strings="?",nrows=2075259)

#Format dates
#hpc[,1] <- as.Date(hpc[,1], '%d/%m/%y')
hpc$Date<- as.POSIXct(strptime(paste(hpc$Date,hpc$Time), "%d/%m/%Y %H:%M:%S"))


#Draw plot 1
png("plot1.png")
hist(hpc$Global_active_power,main="Global Active Power",col=2,xlab="Global Active Power (kilowatts)")
dev.off()

#Draw plot 2
png("plot2.png")
plot(hpc$Date,hpc$Global_active_power,type="l",xlab = "",ylab="Global Active Power (kilowatts)")
dev.off()

#Draw plot 3
png("plot3.png")
plot(hpc$Date,type="l",hpc$Sub_metering_1, xlab = "",ylab="Energy sub metering")
lines(hpc$Date,hpc$Sub_metering_2,col=2)
lines(hpc$Date,hpc$Sub_metering_3,col=4)

legend('topright',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"))

dev.off()

#Draw plot 4
png("plot4.png")
par(mfrow=c(2,2))

plot(hpc$Date,hpc$Global_active_power,type="l",xlab = "",ylab="Global Active Power")

plot(hpc$Date,hpc$Voltage,type="l",col=1,xlab="datetime",ylab="Voltage")

plot(hpc$Date,type="l",hpc$Sub_metering_1, xlab = "",ylab="Energy sub metering")
lines(hpc$Date,hpc$Sub_metering_2,col=2)
lines(hpc$Date,hpc$Sub_metering_3,col=4)

legend('topright',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1,bty = "n",  col=c("black","red","blue"))

plot(hpc$Date,hpc$Global_reactive_power,col=1,xlab="datetime",ylab="Global_reactive_power",type="l")

dev.off()
