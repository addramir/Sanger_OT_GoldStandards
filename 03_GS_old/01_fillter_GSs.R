setwd("~/Projects/Sanger_OT_GoldStandards/03_GS_old/")

library(data.table)

GS=fread("GS_old.csv",data.table=F)

si=fread("~/Projects/Sanger_OT_MVA/05_descriptives/20230518_study_index.csv",data.table=F)
ind=match(GS$study_id,si$study_id)
table(si$study_id[ind]==GS$study_id)
GS$has_sumstats=si$has_sumstats[ind]

GS=cbind(GS,si[ind,c("trait_reported","source")])

ind=which(GS$gold_standard_status==1 & GS$gs_confidence%in%c("High","Medium"))
GS_pos=GS[ind,]

GS_pos=GS_pos[,c(1:6,69:75,52)]
fwrite(x=GS_pos,file="GS_positives.csv")

GS_pos_ss=GS_pos[GS_pos$has_sumstats=="TRUE",]
fwrite(x=GS_pos_ss,file="GS_positives_ss.csv")

length(unique(GS_pos_ss$study_id))
y=cbind(unique(GS_pos_ss$study_id))
fwrite(x=y,file="list_study_ids_with_ss_GS_positives.csv",col.names=F)
