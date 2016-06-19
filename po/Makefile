# Installation directories
localedir = $(PREFIX)/usr/share/locale

PGOAL = mdkonline

PL_FILES = ../mdk*.pm ../mdkupdate ../mdkapplet ../mdkapplet-config ../mdkapplet-update-checker ../mdkapplet-upgrade-helper
POFILES = $(shell ls *.po)

POFILES = $(shell ls *.po)
MOFILES = $(POFILES:%.po=%.mo)
LANGS = $(POFILES:%.po=%)

GOALS = $(PGOAL).pot  $(MOFILES)

all: $(GOALS)

install: all
	for l in $(LANGS); do \
		install -d $(localedir)/$$l/LC_MESSAGES; \
		install -m 644 $$l.mo $(localedir)/$$l/LC_MESSAGES/$(PGOAL).mo; \
	done

clean:
	rm -f *~ *.[oas] *.mo TAGS POTFILES.in

%.mo: %.po
	msgfmt -o $@ $<

$(PGOAL).pot: $(PL_FILES) POTFILES.in
	intltool-update --gettext-package non-perl --pot
	perl_checker -q --generate-pot .$@ $(PL_FILES)
	msgcat -w 2048 --use-first .$@ non-perl.pot > $@
	rm -f non-perl.pot ..$@ .$@

POTFILES.in:
	(cd .. ; /bin/ls -1 polkit/*.policy.in; ) > POTFILES.in

update_n_merge: $(PGOAL).pot merge

merge:
	@for n in $(POFILES); do \
		echo "Merging $$n"; \
		msgmerge "$$n" $(PGOAL).pot > "$$n"t; \
		mv -f "$$n"t "$$n"; \
	done

# there are better ways to do this, but..
merge_mageia_translations: $(PGOAL).pot
	@for n in $(POFILES); do \
		echo "Merging $$n translations from Mageia"; \
		sed -e '/^$$/q' "$$n" > "$$n.header"; \
		mv "$$n" "$$n.orig"; \
		git checkout --theirs mageia/master "$$n"; \
		sed -e 's#mageia#openmandriva#g' -i "$$n"; \
		msgcat --use-first -o "$$n.temp" -t utf-8 -s "$$n.orig" "$$n"; \
		git checkout --theirs origin/master "$$n"; \
		msgcat --use-first -o "$$n.orig" -t utf-8 -s "$$n.header" "$$n.temp"; \
		mv "$$n.orig" "$$n"; \
		rm "$$n.temp" "$$n.header"; \
		msgmerge "$$n" $(PGOAL).pot > "$$n"t; \
		mv -f "$$n"t "$$n"; \
	done


