.PHONY: all clean

all: clean \
	results/horse_pop_plot_largest_sd.png \
	results/horse_pops_plot.png \
	results/horses_sd.csv \
	docs/horse_pop_plot_largest_sd.png \
	docs/horse_pops_plot.png \
	docs/index.html

# Step 1: Generate figures and CSV
results/horse_pop_plot_largest_sd.png results/horse_pops_plot.png results/horses_sd.csv: source/generate_figures.R data/00030067-eng.csv
	Rscript source/generate_figures.R --input_dir="data/00030067-eng.csv" --out_dir="results"

# Step 2: Copy figures explicitly to docs
docs/horse_pop_plot_largest_sd.png: results/horse_pop_plot_largest_sd.png
	cp $< $@

docs/horse_pops_plot.png: results/horse_pops_plot.png
	cp $< $@

# Step 3: Render Quarto report
docs/index.html: index.qmd docs/horse_pop_plot_largest_sd.png docs/horse_pops_plot.png
	quarto render index.qmd --to html --output-dir docs
	touch docs/.nojekyll

# Clean generated files
clean:
	rm -rf results/*
	rm -rf docs/*.png docs/*.html docs/.nojekyll
	rm -rf index.html reports/qmd_example.pdf reports/qmd_example_files
