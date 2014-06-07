if(!file.exists("./data/household_power_consumption.RData")){
  dat<-read.table("./data/household_power_consumption.txt",sep=";"
                  ,comment.char="",header=TRUE)
  save(dat,file="./data/household_power_consumption.RData")
}else{
  load("./data/household_power_consumption.RData")
}

Sys.setlocale("LC_TIME", "C");
d1<-as.Date("2007-02-01")
d2<-as.Date("2007-02-02")

Date<-as.Date(dat$Date,format='%d/%m/%Y')
index<- Date==d1 | Date==d2
Dat<-dat[index,]


times<-as.vector(Dat$Time)
dates<-as.vector(Dat$Date)
z<-paste(dates, times)
tmp<-strptime(z, "%d/%m/%Y %H:%M:%S")
plot(tmp,as.numeric(as.vector(Dat$Global_active_power)),type="l",
     ylab="Global Active Power(kilowatts)")
dev.copy(png, file = "./data/plot2.png", width=480, height=480)
dev.off()