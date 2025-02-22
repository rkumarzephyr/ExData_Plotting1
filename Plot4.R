library(lubridate)
library(readr)
library(dplyr)
library(tibble)
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data.zip")
unzip("data.zip")

read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";")

data <- read_delim("household_power_consumption.txt",delim = ";",na = "?",
                 col_types = cols(Date = col_date(format = "%d/%m/%Y"),Time = col_time(format = "%H:%M:%S")))

minDate <- parse_date_time("2007-02-01","ymd")
maxDate <- parse_date_time("2007-02-02","ymd")

data <- mutate(data, DateTime = as_datetime(paste(data$Date,data$Time, sep = "")))
mydata <- subset(data,Date >= minDate & Date <= maxDate)

par(mfrow=c(2,2))

plot(as_datetime(mydata$DateTime,),
     mydata$Global_active_power, type ="l" , 
     ylab = "Global active power", xlab = "")

plot(as_datetime(mydata$DateTime,),
     mydata$Voltage, type ="l" , 
     ylab = "Voltage", xlab = "datetime")

plot(as_datetime(mydata$DateTime,),
     mydata$Sub_metering_1, type ="l" , 
     ylab = "Energey Sub metering", xlab = "")

lines(as_datetime(mydata$DateTime),
                  mydata$Sub_metering_2 ,col = "red")

lines(as_datetime(mydata$DateTime),
      mydata$Sub_metering_3 ,col = "blue")

legend("topright", 
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'), lty=c(1, 1, 1))

plot(as_datetime(mydata$DateTime,),
     mydata$Global_reactive_power, type ="l" , 
     ylab = "Global_reactive_power", xlab = "")

dev.copy(png,file = "Plot4.png")
dev.off()