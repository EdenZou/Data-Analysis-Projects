library(quantmod)
library(Quandl)
rm(list=ls(all=TRUE))
indices <- read.csv("~/R/7011/final/marketindices.csv")

# A_list means Additional.variables list
A_list <- indices[1:7,'Additional.variables']
A_indices <- indices[1:7,'A.indices']
  
for(i in 1:7){
  series_name <- as.character(A_indices[i])
  getSymbols(series_name, src = "FRED",from = "1996-10-01",to = "2020-03-20")
  print(series_name)
}

Atemp <- merge(`USD1MTD156N`,`VIXCLS`,`GOLDAMGBD228NLBM`,`TEDRATE`,`DCOILWTICO`,`DFF`,`BAMLHYH0A3CMTRIV`)
dim(Atemp)
Atemp <- Atemp["1997-01-06/2020-03-20"]
dim(Atemp)
# Create an index of weekend days using which()
Aindex <- which(.indexwday(Atemp) == 6 | .indexwday(Atemp) == 0)
# Select the index
Atemp.week <- Atemp[-Aindex]
#bonds.week <- to.period(new_bonds, period = "weeks")
# Get the temporary file name
# Write the xts object using zoo to tmp 
#bonds.linear <- na.approx(bonds.week)
Atemp.spline <- na.spline(Atemp.week)
Adata <- data.frame(Atemp.spline)
write.table(Adata,file = "Additional.variables.csv",row.names=TRUE,col.names=TRUE,sep=",")
dim(Adata)



# 
E_list <- indices[1:18,'Exchange rate']
E_indices <- indices[1:18,'E.indices']

for(i in 1:18){
  series_name <- as.character(E_indices[i])
  getSymbols(series_name, src = "FRED",from = "1996-10-01",to = "2020-03-20")
  print(series_name)
}

Etemp <- merge(
  `DEXCHUS`,
  `DEXNOUS`,
  `DEXHKUS`,
  `DEXINUS`,
  `DEXJPUS`,
  `DEXKOUS`,
  `DEXMAUS`,
  `DEXMXUS`,
  `DEXNOUS`,
  `DEXSDUS`,
  `DEXSZUS`,
  `DEXTAUS`,
  `DEXTHUS`,
  `DEXUSEU`,
  `DEXUSUK`,
  `DEXCAUS`,
  `DEXUSAL`,
  `DEXUSNZ`,
  `EURUSD`
)
dim(Etemp)
head(Etemp)
Etemp <- Etemp["1997-01-06/2020-03-20"]
# Create an index of weekend days using which()
Eindex <- which(.indexwday(Etemp) == 6 | .indexwday(Etemp) == 0)
# Select the index
# Etemp.week <- Etemp[-Eindex]
Etemp.spline <- na.spline(Etemp)

Edata <- data.frame(Etemp.spline)
write.table(Edata,file = "Exchange.rate.csv",row.names=TRUE,col.names=TRUE,sep=",")
