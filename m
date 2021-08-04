Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743973DFA1F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 05:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhHDDzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 23:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhHDDzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 23:55:13 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A453C0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 20:55:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k4-20020a17090a5144b02901731c776526so6867010pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 20:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=AEwQ/+k1Yhzbo4qVQLJ3ZVzIRSYHoDA9qwjyJfKox9Q=;
        b=Z70A6b4xo/H9y9GGgfWgcIlmcSd9BrK+BPdwQgRhGWBTAmBHr8/jcnS3Ejk0RbIh7h
         cUKMXuWAzA0kOEz8E3yKPoDvCRZ5VhYm8BtQWHwlEOpcfWm8InteKOpmiDBMri8NBW8f
         4LpnrZUJncgnv+8HLmeyePxt3YQF62LWtUfpxb/y+ar41TpxFgosmhOCWB5LYs3XQ7WG
         1A8l9A+PQkN0hwIHRaDXWaboXeDDFs5utzoBHVguBoMg2ZBjqWfwRo1wSEyegt4KwvlG
         M8N9ALCRamfp00sprE2kSSSpgfvH3SQjjvu3R4UO4Fo9OH8Du7o8qISFr8lUb57KD1ik
         idXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=AEwQ/+k1Yhzbo4qVQLJ3ZVzIRSYHoDA9qwjyJfKox9Q=;
        b=mmY+mQ3yRtdqyQUo2TmpQhJIXbl+eAW7YEnlgUN05Eo+5KUOlzWO/zvJ7oQYp4XYQT
         xE9cSzGjQo/+vzXv2il5csgI49VzS22N4Dfn5oQ1U66tv6fXoIlaghIpeDO89wmKZrLC
         v14ddRoiLGVUadM2h5ooFh7EEG6BvTzugWWjsJA5hRFmeV1O2HUzgCMnKD0r3KB+ErwA
         U1ileFwehk4L9C21dQwTCFGwBCvdCTvC3KNS2Fl7OUe50z5P1yiHPYFzdN3oWuwAs5he
         Hf2Ub7PVaT/zFVe/eV2dBVfFSUyPnZsedk6NpitbPc/o6AqRw7tOupURYu5qcR2dVZn+
         8Glw==
X-Gm-Message-State: AOAM5332jraa7xiJsBQ4iPNolQbn1cJn4DtbS0n4N//bErWkyJ8a1Grv
        QJFIzRpsGFQpyO/XG7BO/TzC9A==
X-Google-Smtp-Source: ABdhPJz9yoqG+t1W8OTX4BEcgkRz4+ewRiQDlyMibsVaEvjIcIbF58ouyelrrWAZPOLe3F0snD7gFg==
X-Received: by 2002:a63:b04c:: with SMTP id z12mr863697pgo.86.1628049300557;
        Tue, 03 Aug 2021 20:55:00 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b12sm4366199pjw.6.2021.08.03.20.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 20:54:59 -0700 (PDT)
Date:   Tue, 03 Aug 2021 20:54:59 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Aug 2021 20:51:39 PDT (-0700)
Subject:     Re: [PATCH] riscv: explicitly use symbol offsets for VDSO v2
In-Reply-To: <20210802210016.642262-1-abdulras@google.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
        clang-built-linux@googlegroups.com, abdulras@google.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     abdulras@google.com
Message-ID: <mhng-fc0ced4d-4e60-422b-8728-7e9bdd0276fb@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Aug 2021 14:00:17 PDT (-0700), abdulras@google.com wrote:
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
>  arch/riscv/include/asm/vdso.h              | 11 ++--------
>  arch/riscv/kernel/vdso/Makefile            | 25 ++++++++++------------
>  arch/riscv/kernel/vdso/gen_vdso_offsets.sh |  5 +++++
>  arch/riscv/kernel/vdso/so2s.sh             |  6 ------
>  5 files changed, 22 insertions(+), 29 deletions(-)
>  create mode 100755 arch/riscv/kernel/vdso/gen_vdso_offsets.sh
>  delete mode 100755 arch/riscv/kernel/vdso/so2s.sh
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index bc74afdbf31e..e026b2d0a5a4 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -108,6 +108,10 @@ PHONY += vdso_install
>  vdso_install:
>  	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
>
> +prepare: vdso_prepare
> +vdso_prepare: prepare0
> +	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso include/generated/vdso-offsets.h
> +
>  ifneq ($(CONFIG_XIP_KERNEL),y)
>  ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN),yy)
>  KBUILD_IMAGE := $(boot)/loader.bin
> diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
> index 1453a2f563bc..098795262b92 100644
> --- a/arch/riscv/include/asm/vdso.h
> +++ b/arch/riscv/include/asm/vdso.h
> @@ -9,24 +9,17 @@
>  #define _ASM_RISCV_VDSO_H
>
>  #include <linux/types.h>
> +#include <generated/vdso-offsets.h>
>
>  #ifndef CONFIG_GENERIC_TIME_VSYSCALL
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
> index 24d936c147cd..f8cb9144a284 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -23,10 +23,10 @@ ifneq ($(c-gettimeofday-y),)
>  endif
>
>  # Build rules
> -targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds vdso-syms.S
> +targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds
>  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>
> -obj-y += vdso.o vdso-syms.o
> +obj-y += vdso.o
>  CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
>
>  # Disable -pg to prevent insert call site
> @@ -43,20 +43,22 @@ $(obj)/vdso.o: $(obj)/vdso.so
>  # link rule for the .so file, .lds has to be first
>  $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
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
> @@ -65,11 +67,6 @@ quiet_cmd_vdsold = VDSOLD  $@
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

This is giving me some unused variable warnings:

In file included from arch/riscv/kernel/signal.c:16:
arch/riscv/kernel/signal.c: In function ‘setup_rt_frame’:
./arch/riscv/include/asm/vdso.h:21:20: warning: unused variable ‘__vdso_rt_sigreturn’ [-Wunused-variable]
   21 |  extern const char __vdso_##name[];     \
      |                    ^~~~~~~
arch/riscv/kernel/signal.c:197:28: note: in expansion of macro ‘VDSO_SYMBOL’
  197 |  regs->ra = (unsigned long)VDSO_SYMBOL(
      |                            ^~~~~~~~~~~
