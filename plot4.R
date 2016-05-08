library(dplyr)
library(lubridate)

#download url
dl_url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
#dest file name
filename <- 'dataset.zip'
#download the zip file if its not exists in the current working folder
if (!file.exists(filename)){
  download.file(dl_url, filename, method = 'curl')
}
#unzip the zip file if its content does not exists in the current working folder
if (!file.exists('household_power_consumption.txt')){
  unzip(filename)
}

data = read.csv('household_power_consumption.txt', sep = ';', stringsAsFactors = F)

#subset data with dates 2007-02-01 or 2007-02-02
data1 = filter(data, Date == '1/2/2007' | Date == '2/2/2007')

#change the data type of Global_Active_Power, Global_Reactive_Power, sub meter and voltage from character to numeric
data1$Global_active_power = as.numeric(data1$Global_active_power)

data1$Global_reactive_power = as.numeric(data1$Global_reactive_power)

data1$Sub_metering_1 = as.numeric(data1$Sub_metering_1)
data1$Sub_metering_2 = as.numeric(data1$Sub_metering_2)
data1$Sub_metering_3 = as.numeric(data1$Sub_metering_3)

data1$Voltage = as.numeric(data1$Voltage)

#concat the date and time into a new column, change this new column data type to date
data1 = mutate(data1, Datetime = paste(data1$Date, data1$Time))
data1$Datetime = dmy_hms(data1$Datetime)


par(mfrow = c(2, 2))

#plot global active power over time
plot(data1$Datetime, data1$Global_active_power, ylab = 'Global Active Power', type ='l', xlab = '' )

#plot voltage over time
plot(data1$Datetime, data1$Voltage, ylab = 'Voltage', type ='l', xlab = 'datetime' )

#plot the energy sub metering over timeseries
plot(data1$Datetime, data1$Sub_metering_1, type ='l', xlab = '', ylab = 'Energy Sub Metering')
lines(data1$Datetime, data1$Sub_metering_2, col ='red')
lines(data1$Datetime, data1$Sub_metering_3, col ='blue')
#set the legend of the plot
legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty = c(1,1,1), col = c('black', 'red', 'blue'), cex = 0.5, bty = 'n')

#plot the globacl reactive power over timeseries
plot(data1$Datetime, data1$Global_reactive_power, ylab = 'Global_reactive_power', type ='l', xlab = 'datetime' )

#save the plot to png file and close the device
dev.copy(png, 'plot4.png', width = 480, height = 480)
dev.off()