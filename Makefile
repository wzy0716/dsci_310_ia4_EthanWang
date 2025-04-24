# author: Jordan Bourak & Tiffany Timbers
# date: 2021-11-22
.PHONY: all clean

all: clean results/horse_pop_plot_largest_sd.png \
	results/horse_pops_plot.png \
	results/horses_sd.csv \
	docs/index.html

# generate figures and objects for report
results/horse_pop_plot_largest_sd.png results/horse_pops_plot.png results/horses_sd.csv: source/generate_figures.R data/00030067-eng.csv
	Rscript source/generate_figures.R --input_dir="data/00030067-eng.csv" \
		--out_dir="results"

# render quarto report in HTML and PDF
docs/index.html: index.qmd
	quarto render index.qmd --to html --output-dir docs
	touch docs/.nojekyll

# clean
clean:
	rm -rf results/*
	rm -rf index.html \
		reports/qmd_example.pdf \
		reports/qmd_example_files
