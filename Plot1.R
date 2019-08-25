library(lubridate)
library(readr)
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data.zip")
unzip("data.zip")

read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";")

data <- read_delim("household_power_consumption.txt",delim = ";",na = "?",
                 col_types = cols(Date = col_date(format = "%d/%m/%Y"),Time = col_time(format = "%H:%M:%S")))

minDate <- parse_date_time("2007-02-01","ymd")
maxDate <- parse_date_time("2007-02-02","ymd")
mydata <- subset(data,Date >= minDate & Date <= maxDate)
hist(mydata$Global_active_power,
     col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.copy(png,file = "Plot1.png")
dev.off()