INSTALL ?= install
SHELLCHECK ?= shellcheck

.PHONY: all check install

all:

check:
	$(SHELLCHECK) sbupdate

install:
	$(INSTALL) -D -m 0755 -t "$(DESTDIR)/usr/bin" sbupdate
	$(INSTALL) -D -m 0644 -t "$(DESTDIR)/etc" sbupdate.conf
	$(INSTALL) -D -m 0755 -T hooks/sbupdate-hook-kernel-postinst "$(DESTDIR)/etc/kernel/postinst.d/zz-sbupdate-hook"
	$(INSTALL) -D -m 0755 -T hooks/sbupdate-hook-kernel-postrm "$(DESTDIR)/etc/kernel/postrm.d/zz-sbupdate-hook"
	$(INSTALL) -D -m 0755 -T hooks/sbupdate-hook-initramfs "$(DESTDIR)/etc/initramfs/post-update.d/zz-sbupdate-hook"
	$(INSTALL) -D -m 0644 -t "$(DESTDIR)/usr/lib/tmpfiles.d" tmpfiles.d/sbupdate.conf
	$(INSTALL) -D -m 0644 -t "$(DESTDIR)$(or $(DOCDIR),/usr/share/doc/sbupdate)" README.md

