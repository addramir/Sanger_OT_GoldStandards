cd ~/projects/SS_GS_233ids

gwas_list=$(gsutil ls gs://genetics-portal-dev-sumstats/tmp/yt4-filtered-GS-233/)

path2csv=~/projects/SS_GS_233ids/01_text
path2zip=~/projects/SS_GS_233ids/02_zip

path2zip_gs=gs://genetics-portal-dev-sumstats/tmp/yt4-filtered-GS-233-zip/

for gw in $gwas_list
do
	studyid=${gw:58}
	studyid=${studyid%?}
	echo $studyid
	cat ~/projects/filter_SS/header.txt > "$path2csv"/"$studyid".csv
	gsutil cat "$gw"*.csv >> "$path2csv"/"$studyid".csv
	zip "$path2zip"/"$studyid".zip "$path2csv"/"$studyid".csv
	gsutil cp "$path2zip"/"$studyid".zip $path2zip_gs
done