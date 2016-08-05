# Makefile

include config.mak
vpath %.s $(SRCPATH)

ifeq ($(sys_arch), aarch64)
ifneq ($(AS),)
ASMSRC    =  arm64/macros_arm64.s
ASMSRC   +=  arm64/yuv2rgba_arm64.s
OBJASM  = $(ASMSRC:%.s=%.o)
endif
endif

ifeq ($(sys_arch), arm)
ifneq ($(AS),)
ASMSRC    =  arm/yuv2rgba_arm.s
OBJASM  = $(ASMSRC:%.s=%.o)
endif
endif

.PHONY: all clean install

$(LIBEXAMPLE): .depend $(OBJASM)
	rm -f $(LIBEXAMPLE)
	$(AR)$@ $(OBJASM)
	$(if $(RANLIB), $(RANLIB) $@)

$(OBJASM) : .depend

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<
	-@ $(if $(STRIP), $(STRIP) -x $@)

.depend: config.mak
	@rm -f .depend

depend: .depend
ifneq ($(wildcard .depend),)
include .depend
endif

clean:
	rm -f $(OBJASM) *.a
	rm -rf $(libdir)


install_static: $(LIBEXAMPLE)
	$(INSTALL) -d $(libdir)
	$(INSTALL) -m 644 $(LIBEXAMPLE) $(libdir)
	$(if $(RANLIB), $(RANLIB) $(libdir)/$(LIBEXAMPLE))
	rm -f *.a
