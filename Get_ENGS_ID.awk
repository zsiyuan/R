#!/usr/bin/awk -f
BEGIN{
	print "ENGS_ID","Gene_number" > "ENGS_ID.txt";
	}
/gene_id/{
	split($9, Nine_Column, ";");
	split(Nine_Column[1], ENGS_ID, "\"");
	Gene_id[ENGS_ID[2]]+= 1;
	}
END{
	for (gene_id in Gene_id)
	{
		print gene_id,Gene_id[gene_id] >> "ENGS_ID.txt";
		}
	}
