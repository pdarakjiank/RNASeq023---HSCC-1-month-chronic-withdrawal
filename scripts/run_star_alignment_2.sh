	#!/bin/bash
	#Priscila Darakjian
	#Script for Alignment with STAR 
	for cnt in {42 49 50 51 52 53}
	do
	        cd /lawrencedata/ongoing_analyses/RNASeq023/150423_D00735_0035_BC7D48ACXX/Sample_RNA150217RH_${cnt}_*
	        files=*.fastq.gz
	        pref=`pwd`
	        for i in $files
	        do
	                file_list=$file_list","$pref"/"$i
	        done
	        file_list=$(echo "$file_list" | sed 's/^,//')
	        echo $file_list
	        cd  /lawrencedata/ongoing_analyses/RNASeq023/Alignment_mm10
	        /lawrencedata/zheng/programs/star/STAR_2.3.0e/STAR --genomeDir /lawrencedata/sharedRNASeq/Mouse_reference_genome/unmasked/genome_for_STAR_mm10/ --readFilesIn  ${file_list} --readFilesCommand zcat --outFileNamePrefix RNA150217RH_${cnt}_ --runThreadN 12 --outFilterMismatchNmax 3 --outFilterMultimapNmax 1 --genomeLoad NoSharedMemory
	        samtools view -bS RNA150217RH_${cnt}_Aligned.out.sam > RNA150217RH_${cnt}_Aligned.out.bam
	        samtools sort RNA150217RH_${cnt}_Aligned.out.bam RNA150217RH_${cnt}_Aligned.out
	        samtools index RNA150217RH_${cnt}_Aligned.out.bam
	        file_list=""

done
