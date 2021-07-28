Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8043D84C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 02:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhG1Aje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 20:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232926AbhG1Ajc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 20:39:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4FC460F58;
        Wed, 28 Jul 2021 00:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627432771;
        bh=MNUplsMFO1Q7AKGQ50jxh4neGoh+okDih5g+n2m2r94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IaxlxZ0djrFwhmYH9v4Mpl/S8RXIoOt7AbxwIcJBxRw2pgNxc+Jmn+nZBp17l4DId
         143cPLEv3lypXcsJ5jeOSJSQl6WTM3eecjNT7R6afva3qA0E3P1JQ+3kIZa8JV+B2K
         p6B6VKABNTyEK8R2D5rKqOsPrYUNIU4TFWR/YPxIicg4Wtu3J/K5X2Fw8X0Ey9hxhV
         ebuz9535ac4zMZm+MvGOUI3PH3So5YHVg+iBHI3S2RyJSriwov/DYUke6t4eqDG6um
         4ysV8pPLtxAoI8LXb+qX+uOpi4wLa3yv3Gx4Q/Thjj7T7lgCYTEP7d+ZW/FTjMXQGi
         xbxbEgXIZCFmA==
Date:   Tue, 27 Jul 2021 17:39:28 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Saleem Abdulrasool <abdulras@google.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: explicitly use symbol offsets for VDSO
Message-ID: <YQCnQARTYgAP9hbU@Ryzen-9-3900X.localdomain>
References: <20210707185105.1180526-1-abdulras@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707185105.1180526-1-abdulras@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saleem,

On Wed, Jul 07, 2021 at 06:51:05PM +0000, Saleem Abdulrasool wrote:
> The current implementation of the `__rt_sigaction` reference computed an
> absolute offset relative to the mapped base of the VDSO.  While this can
> be handled in the medlow model, the medany model cannot handle this as
> it is meant to be position independent.  The current implementation
> relied on the BFD linker relaxing the PC-relative relocation into an
> absolute relocation as it was a near-zero address allowing it to be
> referenced relative to `zero`.
> 
> We now extract the offsets and create a generated header allowing the
> build with LLVM and lld to succeed as we no longer depend on the linker
> rewriting address references near zero.  This change was largely
> modelled after the ARM64 target which does something similar.
> 
> Signed-off-by: Saleem Abdulrasool <abdulras@google.com>
> ---
>  arch/riscv/Makefile                        |  4 ++++
>  arch/riscv/include/asm/vdso.h              | 11 ++---------
>  arch/riscv/kernel/vdso/Makefile            | 21 +++++++++------------
>  arch/riscv/kernel/vdso/gen_vdso_offsets.sh |  5 +++++
>  arch/riscv/kernel/vdso/so2s.sh             |  6 ------
>  5 files changed, 20 insertions(+), 27 deletions(-)
>  create mode 100755 arch/riscv/kernel/vdso/gen_vdso_offsets.sh
>  delete mode 100755 arch/riscv/kernel/vdso/so2s.sh
> 
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index e241e0e85ac8..f2beaa3c9fcb 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -92,6 +92,10 @@ PHONY += vdso_install
>  vdso_install:
>  	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
>  
> +prepare: vdso_prepare
> +vdso_prepare: prepare0
> +	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso include/generated/vdso-offsets.h
> +
>  ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_KENDRYTE),yy)
>  KBUILD_IMAGE := $(boot)/loader.bin
>  else
> diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
> index 8454f746bbfd..a72c4093d1c7 100644
> --- a/arch/riscv/include/asm/vdso.h
> +++ b/arch/riscv/include/asm/vdso.h
> @@ -9,24 +9,17 @@
>  #define _ASM_RISCV_VDSO_H
>  
>  #include <linux/types.h>
> +#include <generated/vdso-offsets.h>
>  
>  #ifndef GENERIC_TIME_VSYSCALL
>  struct vdso_data {
>  };
>  #endif
>  
> -/*
> - * The VDSO symbols are mapped into Linux so we can just use regular symbol
> - * addressing to get their offsets in userspace.  The symbols are mapped at an
> - * offset of 0, but since the linker must support setting weak undefined
> - * symbols to the absolute address 0 it also happens to support other low
> - * addresses even when the code model suggests those low addresses would not
> - * otherwise be availiable.
> - */
>  #define VDSO_SYMBOL(base, name)							\
>  ({										\
>  	extern const char __vdso_##name[];					\
> -	(void __user *)((unsigned long)(base) + __vdso_##name);			\
> +	(void __user *)((unsigned long)(base) + __vdso_##name##_offset);	\
>  })
>  
>  asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index f001ae91ef46..17cb755cf282 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -42,20 +42,22 @@ $(obj)/vdso.o: $(obj)/vdso.so
>  # link rule for the .so file, .lds has to be first
>  $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
>  	$(call if_changed,vdsold)
> -LDFLAGS_vdso.so.dbg = -shared -s -soname=linux-vdso.so.1 \
> +LDFLAGS_vdso.so.dbg = -shared -S -soname=linux-vdso.so.1 \
>  	--build-id=sha1 --hash-style=both --eh-frame-hdr
>  
> -# We also create a special relocatable object that should mirror the symbol
> -# table and layout of the linked DSO. With ld --just-symbols we can then
> -# refer to these symbols in the kernel code rather than hand-coded addresses.
> -$(obj)/vdso-syms.S: $(obj)/vdso.so FORCE
> -	$(call if_changed,so2s)
> -
>  # strip rule for the .so file
>  $(obj)/%.so: OBJCOPYFLAGS := -S
>  $(obj)/%.so: $(obj)/%.so.dbg FORCE
>  	$(call if_changed,objcopy)
>  
> +# Generate VDSO offsets using helper script
> +gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
> +quiet_cmd_vdsosym = VDSOSYM $@
> +	cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
> +
> +include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
> +	$(call if_changed,vdsosym)
> +
>  # actual build commands
>  # The DSO images are built using a special linker script
>  # Make sure only to export the intended __vdso_xxx symbol offsets.
> @@ -64,11 +66,6 @@ quiet_cmd_vdsold = VDSOLD  $@
>                     $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
>                     rm $@.tmp
>  
> -# Extracts symbol offsets from the VDSO, converting them into an assembly file
> -# that contains the same symbols at the same offsets.
> -quiet_cmd_so2s = SO2S    $@
> -      cmd_so2s = $(NM) -D $< | $(srctree)/$(src)/so2s.sh > $@
> -
>  # install commands for the unstripped file
>  quiet_cmd_vdso_install = INSTALL $@
>        cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
> diff --git a/arch/riscv/kernel/vdso/gen_vdso_offsets.sh b/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
> new file mode 100755
> index 000000000000..c2e5613f3495
> --- /dev/null
> +++ b/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
> @@ -0,0 +1,5 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +LC_ALL=C
> +sed -n -e 's/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define \2_offset\t0x\1/p'
> diff --git a/arch/riscv/kernel/vdso/so2s.sh b/arch/riscv/kernel/vdso/so2s.sh
> deleted file mode 100755
> index e64cb6d9440e..000000000000
> --- a/arch/riscv/kernel/vdso/so2s.sh
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0+
> -# Copyright 2020 Palmer Dabbelt <palmerdabbelt@google.com>
> -
> -sed 's!\([0-9a-f]*\) T \([a-z0-9_]*\)\(@@LINUX_4.15\)*!.global \2\n.set \2,0x\1!' \
> -| grep '^\.'
> -- 
> 2.32.0.93.g670b81a890-goog

I had a difficult time getting this patch to apply as it does not appear
to be generated against the latest mainline tree, since the diff does
account for at least commit 772d7891e8b3 ("riscv: vdso: fix and clean-up
Makefile"), 08734e0581a5 ("riscv: Use vendor name for K210 SoC
support"), and 44c922572952 ("RISC-V: enable XIP") in it.

I was able to get it to apply but then I ran into the following error:

make[5]: *** No rule to make target 'arch/riscv/kernel/vdso/vdso-syms.o', needed by 'arch/riscv/kernel/vdso/built-in.a'.

The following diff works for me and it appears to build and boot in QEMU
without any issues. However, the errors on 5.10 still persist, I've commented
on GitHub for now.

Cheers,
Nathan

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index fa60e8241e42..f8cb9144a284 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -23,10 +23,10 @@ ifneq ($(c-gettimeofday-y),)
 endif

 # Build rules
-targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds vdso-syms.S
+targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))

-obj-y += vdso.o vdso-syms.o
+obj-y += vdso.o
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)

 # Disable -pg to prevent insert call site
