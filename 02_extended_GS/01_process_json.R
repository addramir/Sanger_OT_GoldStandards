setwd("Projects/Sanger_OT_GoldStandards/02_extended_GS/")

library(jsonlite)
library(dplyr)

lines <- readLines("230103.json")
lines <- lapply(lines, fromJSON)
lines <- lapply(lines, unlist)
x <- bind_rows(lines)

y=x$association_info.otg_id
y=y[!is.na(y)]    
y=unique(y)

library(data.table)
fwrite(x=cbind(y=y),file="list_of_GS_otgid.txt",col.names = F,row.names = F)

fwrite(x=x,file="GS_l2G.txt",col.names = T,row.names = F)

y=x$trait_info.ontology
y=y[!is.na(y)]    
y=unique(y)


fwrite(x=cbind(y=y),file="list_of_EFOs.txt",col.names = F,row.names = F)
