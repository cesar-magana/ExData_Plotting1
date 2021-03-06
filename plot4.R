#1. Verify if file exists
if(!file.exists("household_power_consumption.txt")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
}

#2. Load SQLDF library. If needed type install.packages("sqldf") in R console
library(sqldf)

#3. Data loading and processing
filename <- "./household_power_consumption.txt"
hpc <- file(filename)
attr(hpc, "file.format") <- list(sep = ";", header = TRUE)  
power <- sqldf("select * from hpc where Date='1/2/2007' OR Date='2/2/2007'")
power$Date <- as.Date(power$Date, "%d/%m/%Y")
power <- transform(power, timestamp=as.POSIXct(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))
power$Global_active_power <- as.numeric(as.character(power$Global_active_power))
power$Global_reactive_power <- as.numeric(as.character(power$Global_reactive_power))
power$Voltage <- as.numeric(as.character(power$Voltage))
power$Sub_metering_1 <- as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 <- as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3 <- as.numeric(as.character(power$Sub_metering_3))

#4. Plot 
filename <- "plot4.png" 
png(file = filename, width=480, height=480)
par(mfrow=c(2,2))
plot(power$timestamp, power$Global_active_power, xlab="", type="l", ylab="Global Active Power (kilowatts)")
plot(power$timestamp, power$Voltage, xlab="datetime", type="l", ylab="Voltage")
plot(power$timestamp, power$Sub_metering_1, xlab="",type="l", ylab="Energy Submetering")
lines(power$timestamp, power$Sub_metering_2, col="red")
lines(power$timestamp, power$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1), lwd=c(2,2))
plot(power$timestamp, power$Global_reactive_power, xlab="datetime",type="l", ylab="Global_reactive_power")
dev.off()
