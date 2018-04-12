#!/usr/bin/awk -f

BEGIN{
	print "Chromosome_name","Annotiation_source","Feature_type","Genomic_start_location","Genomic_end_location","Gene_ID","Gene_type","Gene_status","Gene_name" > "Simple_Annotiation.txt"
}

/gene_id/{
	#染色体名字
	chr_name = $1;
	#注释来源
	annot_source = $2;
	#特征类型
	feature_type = $3;
	#基因起始位点
	genomic_start = $4;
	#基因终止位点
	genomic_end = $5;
	#gene_id
	split($9, Nine_Column, ";");
	split(Nine_Column[1], ENGS_ID, "\"");
	Gene_id = ENGS_ID[2];

	#Gene_status
	for (i in Nine_Column)
	{
		if (Nine_Column[i] ~ /^ gene_status/)
		{
			split(Nine_Column[i], gene_status, "\"");
			Gene_status = gene_status[2];
		}
	}

	#Gene_type
	for (i in Nine_Column)
	{
		if(Nine_Column[i] ~ /^ gene_type/)
		{
			split(Nine_Column[i], gene_type, "\"");
			Gene_type = gene_type[2];
		}
	}

	#Gene_name
	for (i in Nine_Column)
	{
		if(Nine_Column[i] ~ /^ gene_name/)
		{
			split(Nine_Column[i], gene_name, "\"");
			Gene_name = gene_name[2];
		}
	}

	#输出结果
	print chr_name,annot_source,feature_type,genomic_start,genomic_end,Gene_id,Gene_type,Gene_status,Gene_name >> "Simple_Annotiation.txt";
}
