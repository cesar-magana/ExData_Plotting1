#1. Verify if file exists
if(!file.exists("household_power_consumption.txt")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
}

#2. Load SQLDF library. If needed type install.packages("sqldf") in R console.
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
filename <- "plot2.png" 
png(file = filename, width=480, height=480)
plot(power$timestamp, power$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()



