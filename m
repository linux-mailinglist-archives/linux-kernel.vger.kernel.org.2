Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD343E06D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhHDRf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhHDRf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:35:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C931C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 10:35:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h9so4905243ejs.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 10:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YhZiYOgndOKxjc09S0PXNRg2bwREnpEcJqoGdi9R3j4=;
        b=uPKmDG4mWdPVccRtNrmtq3Z3t9xbtfSjYd05HwrgyEmNtnwM6QI54yUqLRWlTArX3M
         U4ZPHSF1CietFYSZjIL/ZV/c/mteQE27BzX7RnoBoKyr3LC3ZII7dRpDeKzd31BJz/Px
         PcnMO14xn+nOzudhRkgFDoHG5lU1zHzPi2QkNbtQ3HpScrnwvKfLs0GzkXXY1wmLQbfC
         KBD8cLQPkjW6G8Q2Bd19AJW+nkwSbi3rNUf4nXMn0ujd+COkun3zyFzWzJm2Z2ZDkdsH
         f9wNinvfOwwQHQWP3Yy8eEaeEpK/Wrquxr8wpvXyUo/MO9FoAVEkbnmrDQmWvLP7Jdxx
         7YQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YhZiYOgndOKxjc09S0PXNRg2bwREnpEcJqoGdi9R3j4=;
        b=NG5cAudOQSFd+waPAmClPSj971fqwQig658m2QTc6kb9ItzgVC6GzyIpyfX9blakd6
         jeoQEmQWSk3X81Hbxkx+WrP7QBPvNe2qP0sfzXcybdK/OztiFWDV0rNNtNRbzbErO5wp
         nMiPgaSy5BiVNvPQZxYq8qQNSPaGLiFFGn2BXnQxZC2fwY7U7vlUSNAYOhbxwvqewZVp
         FTPthadJAp+pjWevS8GdefieDhrqx04lVlwVIC0xwDUQZKCvwiaoMrBRq1PMIpgRtX9c
         R716g7CILDrepOOQJPV7/Q4Z5yVp9dwe/9QaE9sgbG6odIqTz/KdIbWPnoV/mOTlRPrn
         MFNg==
X-Gm-Message-State: AOAM533QsvNzAMJn3GeTwZ4mq/6XbEOQ9HFFdi+kgV3PE+RVlYIUPnON
        VhRpvBTYtlWwami04zFzhpI9selVodR7YKUnUOqDVQ==
X-Google-Smtp-Source: ABdhPJymCBqSnZgzBKSNmr2MjF0wpRwbeglHEpm4zXemFVzbR6C40A4/FY2kBM4h652XG2mpuMxECGFnFC8tuINkG34=
X-Received: by 2002:a17:906:53ce:: with SMTP id p14mr299514ejo.477.1628098542007;
 Wed, 04 Aug 2021 10:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210802210016.642262-1-abdulras@google.com> <mhng-fc0ced4d-4e60-422b-8728-7e9bdd0276fb@palmerdabbelt-glaptop>
In-Reply-To: <mhng-fc0ced4d-4e60-422b-8728-7e9bdd0276fb@palmerdabbelt-glaptop>
From:   Saleem Abdulrasool <abdulras@google.com>
Date:   Wed, 4 Aug 2021 10:35:29 -0700
Message-ID: <CAO8XFHs-s2SHajL8NpWsK_JcG0ZoyDr9qd9jGDxdQ6bU-cKqiw@mail.gmail.com>
Subject: Re: [PATCH] riscv: explicitly use symbol offsets for VDSO v2
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 8:55 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Mon, 02 Aug 2021 14:00:17 PDT (-0700), abdulras@google.com wrote:
> > The current implementation of the `__rt_sigaction` reference computed a=
n
> > absolute offset relative to the mapped base of the VDSO.  While this ca=
n
> > be handled in the medlow model, the medany model cannot handle this as
> > it is meant to be position independent.  The current implementation
> > relied on the BFD linker relaxing the PC-relative relocation into an
> > absolute relocation as it was a near-zero address allowing it to be
> > referenced relative to `zero`.
> >
> > We now extract the offsets and create a generated header allowing the
> > build with LLVM and lld to succeed as we no longer depend on the linker
> > rewriting address references near zero.  This change was largely
> > modelled after the ARM64 target which does something similar.
> >
> > Signed-off-by: Saleem Abdulrasool <abdulras@google.com>
> > ---
> >  arch/riscv/Makefile                        |  4 ++++
> >  arch/riscv/include/asm/vdso.h              | 11 ++--------
> >  arch/riscv/kernel/vdso/Makefile            | 25 ++++++++++------------
> >  arch/riscv/kernel/vdso/gen_vdso_offsets.sh |  5 +++++
> >  arch/riscv/kernel/vdso/so2s.sh             |  6 ------
> >  5 files changed, 22 insertions(+), 29 deletions(-)
> >  create mode 100755 arch/riscv/kernel/vdso/gen_vdso_offsets.sh
> >  delete mode 100755 arch/riscv/kernel/vdso/so2s.sh
> >
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index bc74afdbf31e..e026b2d0a5a4 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -108,6 +108,10 @@ PHONY +=3D vdso_install
> >  vdso_install:
> >       $(Q)$(MAKE) $(build)=3Darch/riscv/kernel/vdso $@
> >
> > +prepare: vdso_prepare
> > +vdso_prepare: prepare0
> > +     $(Q)$(MAKE) $(build)=3Darch/riscv/kernel/vdso include/generated/v=
dso-offsets.h
> > +
> >  ifneq ($(CONFIG_XIP_KERNEL),y)
> >  ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN),yy)
> >  KBUILD_IMAGE :=3D $(boot)/loader.bin
> > diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vds=
o.h
> > index 1453a2f563bc..098795262b92 100644
> > --- a/arch/riscv/include/asm/vdso.h
> > +++ b/arch/riscv/include/asm/vdso.h
> > @@ -9,24 +9,17 @@
> >  #define _ASM_RISCV_VDSO_H
> >
> >  #include <linux/types.h>
> > +#include <generated/vdso-offsets.h>
> >
> >  #ifndef CONFIG_GENERIC_TIME_VSYSCALL
> >  struct vdso_data {
> >  };
> >  #endif
> >
> > -/*
> > - * The VDSO symbols are mapped into Linux so we can just use regular s=
ymbol
> > - * addressing to get their offsets in userspace.  The symbols are mapp=
ed at an
> > - * offset of 0, but since the linker must support setting weak undefin=
ed
> > - * symbols to the absolute address 0 it also happens to support other =
low
> > - * addresses even when the code model suggests those low addresses wou=
ld not
> > - * otherwise be availiable.
> > - */
> >  #define VDSO_SYMBOL(base, name)                                       =
               \
> >  ({                                                                    =
       \
> >       extern const char __vdso_##name[];                               =
       \
> > -     (void __user *)((unsigned long)(base) + __vdso_##name);          =
       \
> > +     (void __user *)((unsigned long)(base) + __vdso_##name##_offset); =
       \
> >  })
> >
> >  asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t=
);
> > diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/M=
akefile
> > index 24d936c147cd..f8cb9144a284 100644
> > --- a/arch/riscv/kernel/vdso/Makefile
> > +++ b/arch/riscv/kernel/vdso/Makefile
> > @@ -23,10 +23,10 @@ ifneq ($(c-gettimeofday-y),)
> >  endif
> >
> >  # Build rules
> > -targets :=3D $(obj-vdso) vdso.so vdso.so.dbg vdso.lds vdso-syms.S
> > +targets :=3D $(obj-vdso) vdso.so vdso.so.dbg vdso.lds
> >  obj-vdso :=3D $(addprefix $(obj)/, $(obj-vdso))
> >
> > -obj-y +=3D vdso.o vdso-syms.o
> > +obj-y +=3D vdso.o
> >  CPPFLAGS_vdso.lds +=3D -P -C -U$(ARCH)
> >
> >  # Disable -pg to prevent insert call site
> > @@ -43,20 +43,22 @@ $(obj)/vdso.o: $(obj)/vdso.so
> >  # link rule for the .so file, .lds has to be first
> >  $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
> >       $(call if_changed,vdsold)
> > -LDFLAGS_vdso.so.dbg =3D -shared -s -soname=3Dlinux-vdso.so.1 \
> > +LDFLAGS_vdso.so.dbg =3D -shared -S -soname=3Dlinux-vdso.so.1 \
> >       --build-id=3Dsha1 --hash-style=3Dboth --eh-frame-hdr
> >
> > -# We also create a special relocatable object that should mirror the s=
ymbol
> > -# table and layout of the linked DSO. With ld --just-symbols we can th=
en
> > -# refer to these symbols in the kernel code rather than hand-coded add=
resses.
> > -$(obj)/vdso-syms.S: $(obj)/vdso.so FORCE
> > -     $(call if_changed,so2s)
> > -
> >  # strip rule for the .so file
> >  $(obj)/%.so: OBJCOPYFLAGS :=3D -S
> >  $(obj)/%.so: $(obj)/%.so.dbg FORCE
> >       $(call if_changed,objcopy)
> >
> > +# Generate VDSO offsets using helper script
> > +gen-vdsosym :=3D $(srctree)/$(src)/gen_vdso_offsets.sh
> > +quiet_cmd_vdsosym =3D VDSOSYM $@
> > +     cmd_vdsosym =3D $(NM) $< | $(gen-vdsosym) | LC_ALL=3DC sort > $@
> > +
> > +include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
> > +     $(call if_changed,vdsosym)
> > +
> >  # actual build commands
> >  # The DSO images are built using a special linker script
> >  # Make sure only to export the intended __vdso_xxx symbol offsets.
> > @@ -65,11 +67,6 @@ quiet_cmd_vdsold =3D VDSOLD  $@
> >                     $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-syms))=
 $@.tmp $@ && \
> >                     rm $@.tmp
> >
> > -# Extracts symbol offsets from the VDSO, converting them into an assem=
bly file
> > -# that contains the same symbols at the same offsets.
> > -quiet_cmd_so2s =3D SO2S    $@
> > -      cmd_so2s =3D $(NM) -D $< | $(srctree)/$(src)/so2s.sh > $@
> > -
> >  # install commands for the unstripped file
> >  quiet_cmd_vdso_install =3D INSTALL $@
> >        cmd_vdso_install =3D cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
> > diff --git a/arch/riscv/kernel/vdso/gen_vdso_offsets.sh b/arch/riscv/ke=
rnel/vdso/gen_vdso_offsets.sh
> > new file mode 100755
> > index 000000000000..c2e5613f3495
> > --- /dev/null
> > +++ b/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
> > @@ -0,0 +1,5 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +LC_ALL=3DC
> > +sed -n -e 's/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#def=
ine \2_offset\t0x\1/p'
> > diff --git a/arch/riscv/kernel/vdso/so2s.sh b/arch/riscv/kernel/vdso/so=
2s.sh
> > deleted file mode 100755
> > index e64cb6d9440e..000000000000
> > --- a/arch/riscv/kernel/vdso/so2s.sh
> > +++ /dev/null
> > @@ -1,6 +0,0 @@
> > -#!/bin/sh
> > -# SPDX-License-Identifier: GPL-2.0+
> > -# Copyright 2020 Palmer Dabbelt <palmerdabbelt@google.com>
> > -
> > -sed 's!\([0-9a-f]*\) T \([a-z0-9_]*\)\(@@LINUX_4.15\)*!.global \2\n.se=
t \2,0x\1!' \
> > -| grep '^\.'
>
> This is giving me some unused variable warnings:
>
> In file included from arch/riscv/kernel/signal.c:16:
> arch/riscv/kernel/signal.c: In function =E2=80=98setup_rt_frame=E2=80=99:
> ./arch/riscv/include/asm/vdso.h:21:20: warning: unused variable =E2=80=98=
__vdso_rt_sigreturn=E2=80=99 [-Wunused-variable]
>    21 |  extern const char __vdso_##name[];     \
>       |                    ^~~~~~~
> arch/riscv/kernel/signal.c:197:28: note: in expansion of macro =E2=80=98V=
DSO_SYMBOL=E2=80=99
>   197 |  regs->ra =3D (unsigned long)VDSO_SYMBOL(
>       |                            ^~~~~~~~~~~

Thanks Palmer,

It seems that there was a difference in diagnostics between gcc and
clang.  The diagnostic indicated that I didn't scrub hard enough
during the cleanups.  I've sent out an updated version.  Thank you for
informing me of this missed cleanup!
