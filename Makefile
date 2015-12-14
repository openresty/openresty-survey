html_files := html/index.html

.DELETE_ON_ERRORS: $(html_files)

all: $(html_files)

html/%.html: template/%.tt
	tpage $< > $@
