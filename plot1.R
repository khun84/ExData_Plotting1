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

#change the data type of Global_Active_Power from character to numeric
data1$Global_active_power = as.numeric(data1$Global_active_power)

#plot the histogram of Global_Active_Power
hist(data1$Global_active_power, col = 'red', xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency', main = 'Global Active Power')

#save the plot to png file and close the device
dev.copy(png, 'plot1.png', height = 480, width = 480)
dev.off()



