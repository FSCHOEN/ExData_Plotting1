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



#Draw plot 2
png("plot2.png")
plot(hpc$Date,hpc$Global_active_power,type="l",xlab = "",ylab="Global Active Power (kilowatts)")
dev.off()

