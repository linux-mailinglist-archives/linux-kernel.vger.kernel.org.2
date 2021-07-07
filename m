Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394B43BEFD9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhGGSyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGGSx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:53:58 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C916C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 11:51:18 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id z1-20020a17090a1701b0290172f4a773b4so2222576pjd.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cTXCexUCBYLjSq8WLV6y4Psori5M9mLAKAHZFzbkUxE=;
        b=OrPI9jXSGASdQUDl6kI263sh5Mio1Rf8HCJNzHaY7NR6DEFJ3YeuqF5/9uDfdzGfZa
         pDvpAF5aTDBe+jxgDpRWBf2K+TI2SEjDxQWIuy2I5oHyieVUyk15cYxdQYG/R4YCHSmb
         XjZALcdD2m4k09rgUsNoE90XsHZvm7TMgxJJ0AVOwh8lBK84XKfrlyqYhxLCfGn2PvXd
         RYskLuggttGWUJ8KhjZYewVj4x/iz0m6/zxgKFlefBhb0SiXC/5KrwByKDVdk9cCf+ye
         y41AbslvwMS/8IIUmDhuV6iutMgcqYP55AX5dZ2TI91UAtQlfHMF2PR7kK6eLsG1FZ6K
         ulEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cTXCexUCBYLjSq8WLV6y4Psori5M9mLAKAHZFzbkUxE=;
        b=JCnYJg9TmGtxq95YIWVhSB2DD96Bn4Z7QpK/Sn4kW35M/EPRcCiPTN1ShZVmgFsNm/
         2P8H3NRQ4sbVvSkojG+iz4b1s4aUgwCqM46QuSEks7+ykXzA5X6BWUlop9d+AGqOJFSk
         kmOY3E//2xQtFdnkIvdiZaQ7NHKS070aRtWHiCGyMCs5SOb6JVqb7gMEOh1MUODnpa43
         r0jZGnEofCQ8aVFENhHSLhZjSUs7Oy/yKJzB52iVUqSvUy94EpJfRvPapVfOlmnLFaLw
         4JF6aBFCcezljppKtUk3cmN6FjbkeJo+fN9zrQ/LOncSPstW/P6xFLBSFgmyc6kuuQRq
         ouzQ==
X-Gm-Message-State: AOAM532dSV17LuDAVMDeA/DQXD185aasFeau/CxWITE4sl2CiXRwb45Y
        VzwCUXz659IOyWZa9+hqOcfec8qVnHLJpw==
X-Google-Smtp-Source: ABdhPJykBvcRyNzdtBhE2SdtWe6ckhl0TLkLvtHmT/DPg7RRqbFnKZnyUzQuLHzYvDOrJcuyKi49Nvn4teXU6w==
X-Received: from abdulras.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:41e1])
 (user=abdulras job=sendgmr) by 2002:a05:6a00:2145:b029:30b:127:e0a3 with SMTP
 id o5-20020a056a002145b029030b0127e0a3mr26856522pfk.34.1625683877901; Wed, 07
 Jul 2021 11:51:17 -0700 (PDT)
Date:   Wed,  7 Jul 2021 18:51:05 +0000
Message-Id: <20210707185105.1180526-1-abdulras@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] riscv: explicitly use symbol offsets for VDSO
From:   Saleem Abdulrasool <abdulras@google.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Bill Wendling <morbo@google.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Saleem Abdulrasool <abdulras@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of the `__rt_sigaction` reference computed an
absolute offset relative to the mapped base of the VDSO.  While this can
be handled in the medlow model, the medany model cannot handle this as
it is meant to be position independent.  The current implementation
relied on the BFD linker relaxing the PC-relative relocation into an
absolute relocation as it was a near-zero address allowing it to be
referenced relative to `zero`.

We now extract the offsets and create a generated header allowing the
build with LLVM and lld to succeed as we no longer depend on the linker
rewriting address references near zero.  This change was largely
modelled after the ARM64 target which does something similar.

Signed-off-by: Saleem Abdulrasool <abdulras@google.com>
---
 arch/riscv/Makefile                        |  4 ++++
 arch/riscv/include/asm/vdso.h              | 11 ++---------
 arch/riscv/kernel/vdso/Makefile            | 21 +++++++++------------
 arch/riscv/kernel/vdso/gen_vdso_offsets.sh |  5 +++++
 arch/riscv/kernel/vdso/so2s.sh             |  6 ------
 5 files changed, 20 insertions(+), 27 deletions(-)
 create mode 100755 arch/riscv/kernel/vdso/gen_vdso_offsets.sh
 delete mode 100755 arch/riscv/kernel/vdso/so2s.sh

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index e241e0e85ac8..f2beaa3c9fcb 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -92,6 +92,10 @@ PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
 
+prepare: vdso_prepare
+vdso_prepare: prepare0
+	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso include/generated/vdso-offsets.h
+
 ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_KENDRYTE),yy)
 KBUILD_IMAGE := $(boot)/loader.bin
 else
diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index 8454f746bbfd..a72c4093d1c7 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -9,24 +9,17 @@
 #define _ASM_RISCV_VDSO_H
 
 #include <linux/types.h>
+#include <generated/vdso-offsets.h>
 
 #ifndef GENERIC_TIME_VSYSCALL
 struct vdso_data {
 };
 #endif
 
-/*
- * The VDSO symbols are mapped into Linux so we can just use regular symbol
- * addressing to get their offsets in userspace.  The symbols are mapped at an
- * offset of 0, but since the linker must support setting weak undefined
- * symbols to the absolute address 0 it also happens to support other low
- * addresses even when the code model suggests those low addresses would not
- * otherwise be availiable.
- */
 #define VDSO_SYMBOL(base, name)							\
 ({										\
 	extern const char __vdso_##name[];					\
-	(void __user *)((unsigned long)(base) + __vdso_##name);			\
+	(void __user *)((unsigned long)(base) + __vdso_##name##_offset);	\
 })
 
 asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index f001ae91ef46..17cb755cf282 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -42,20 +42,22 @@ $(obj)/vdso.o: $(obj)/vdso.so
 # link rule for the .so file, .lds has to be first
 $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold)
-LDFLAGS_vdso.so.dbg = -shared -s -soname=linux-vdso.so.1 \
+LDFLAGS_vdso.so.dbg = -shared -S -soname=linux-vdso.so.1 \
 	--build-id=sha1 --hash-style=both --eh-frame-hdr
 
-# We also create a special relocatable object that should mirror the symbol
-# table and layout of the linked DSO. With ld --just-symbols we can then
-# refer to these symbols in the kernel code rather than hand-coded addresses.
-$(obj)/vdso-syms.S: $(obj)/vdso.so FORCE
-	$(call if_changed,so2s)
-
 # strip rule for the .so file
 $(obj)/%.so: OBJCOPYFLAGS := -S
 $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
+# Generate VDSO offsets using helper script
+gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
+quiet_cmd_vdsosym = VDSOSYM $@
+	cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
+
+include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
+	$(call if_changed,vdsosym)
+
 # actual build commands
 # The DSO images are built using a special linker script
 # Make sure only to export the intended __vdso_xxx symbol offsets.
@@ -64,11 +66,6 @@ quiet_cmd_vdsold = VDSOLD  $@
                    $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
                    rm $@.tmp
 
-# Extracts symbol offsets from the VDSO, converting them into an assembly file
-# that contains the same symbols at the same offsets.
-quiet_cmd_so2s = SO2S    $@
-      cmd_so2s = $(NM) -D $< | $(srctree)/$(src)/so2s.sh > $@
-
 # install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
       cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
diff --git a/arch/riscv/kernel/vdso/gen_vdso_offsets.sh b/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
new file mode 100755
index 000000000000..c2e5613f3495
--- /dev/null
+++ b/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+LC_ALL=C
+sed -n -e 's/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define \2_offset\t0x\1/p'
diff --git a/arch/riscv/kernel/vdso/so2s.sh b/arch/riscv/kernel/vdso/so2s.sh
deleted file mode 100755
index e64cb6d9440e..000000000000
--- a/arch/riscv/kernel/vdso/so2s.sh
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright 2020 Palmer Dabbelt <palmerdabbelt@google.com>
-
-sed 's!\([0-9a-f]*\) T \([a-z0-9_]*\)\(@@LINUX_4.15\)*!.global \2\n.set \2,0x\1!' \
-| grep '^\.'
-- 
2.32.0.93.g670b81a890-goog

