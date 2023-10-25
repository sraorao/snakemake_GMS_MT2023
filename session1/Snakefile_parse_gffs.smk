rule all:
	input: 'output/all.tsv'


rule make_tsv_from_gff:
	input: 'data/Bos_taurus.ARS-UCD1.2.110.primary_assembly.{num}.gff3.gz'
	output: 'output/parsed_{num}.tsv'
	shell: 'Rscript --vanilla scripts/summarise_ensembl_gff.R --input {input} --output {output}'


rule concatenate_tsvs:
	input: expand('output/parsed_{num}.tsv', num=list(range(1,4)))
	output: 'output/all.tsv'
	shell: 
		"""
		cat {input} | head -n1 > {output} &&\
		tail -q -n+2 {input} >> {output}
		""" 
