library(zoo)
library(quantmod)
library(Quandl)
rm(list=ls(all=TRUE))
Efile <- read.csv.zoo("~/R/7011/final/Exchange.rate.csv", read = read.csv)
Edata <- Efile[,-14]
# DEXUSEU
getSymbols('DEXUSEU', src = "FRED",from = "1997-01-06",to = "2020-03-20")
getSymbols('EURUSD', src = "FRED",from = "1997-01-06",to = "2020-03-20")

Etemp <- merge(Edata,`DEXUSEU`)
Etemp <- as.xts(Etemp)
E <- Etemp["1999-01-04/2020-03-20"]
Efinal <- na.approx(E)

Edf <- data.frame(Efinal)
write.table(Edf,file = "New_ER.csv",row.names=TRUE,col.names=TRUE,sep=",")


Bfile <- read.csv.zoo("~/R/7011/final/bonds.csv", read = read.csv)
head(Bfile)
dim(Bfile)
Bfile <- as.xts(Bfile)
B <- Bfile["1999-01-04/2020-03-20"]
head(B)
# Create an index of weekend days using which()
Bindex <- which(.indexwday(B) == 6 | .indexwday(B) == 0)
# Select the index
Bweek <- B[-Bindex]
#Etemp.spline <- na.spline(Etemp)
plot(Bweek[,1])
plot(B[,1])
