FILES  = zsh-themes-nemo.org
FILESO = $(FILES:.org=.zsh-theme)

all: zsh

zsh: $(FILESO)

%.zsh-theme: %.org
	@echo "Tangling $< theme file"
	@sed -e '/:tangle\s\+no/d' $< | sed -n '/BEGIN_SRC/,/END_SRC/p' | sed -e '/END_SRC/d' -e '/BEGIN_SRC/d' > $@
	@ln -sf $@ $(subst zsh-themes-,,$@)

doc: doc/index.html

doc/index.html:
	mkdir -p doc
	$(EMACS) --batch -Q --eval '(org-babel-load-file "zsh-utilities-publish.org")'
	rm zsh-utilities-publish.el
	cp doc/zsh-utilities.html doc/index.html
	echo "Documentation published to doc/"

clean:
	rm -f *.aux *.tex *.pdf *.zsh-theme zsh-themes-*.html doc/*html *~
	rm -rf doc
