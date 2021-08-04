Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0223E06C7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbhHDRck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhHDRci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:32:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2473C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 10:32:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n192-20020a25dac90000b029054c59edf217so3593368ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/j6yv6+Ku7KXNVVOYpvwLhxyPAj/+OpFFq2HsmTelKU=;
        b=aEvu1PvvMB0wxMb2Y6q3SiE+UMNgDVxc1W6N99HhRM3K95m/7DZunZj/X7+Zr5jO/N
         T8HmzeMDLZbtx9q/yG403RgKgqX3JdtruL/brloTOQHYijCAEo21KvjI5T1fqfqNM1zv
         IfPWPE6TdbzO3fiiidOXzDEwGFkOiyxYbnyLV9qXRgPeqhXTal8egtUppE46j3BNlwxg
         0/K8y3ESUQihagJusSJ2tWJeu7VEkqNnJStFR6zVfGlZw9ttc95lJBK5/K2ueN46Tn6T
         uX375nj+F0PenkQr9Jyu3LRVAnYtTPtyVjClOHZWmGSVng6CqENui1UwcWd2470dGVt8
         CQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/j6yv6+Ku7KXNVVOYpvwLhxyPAj/+OpFFq2HsmTelKU=;
        b=s+xL+XefBuKrc5BWRQ+beS65YbF1inZeXuDVQk/EuvcKruqE3rIJq+2wHj3wzlK3Ar
         mxswekokM6sUe2dco6jwUD0HMCqZ9RJZulHyEM7pcvj1HMn0NLiflQjZr4aYdwMLGMnP
         gPvUYlXUrRoYLBeErlahEoxiHDXDZdQom31b3fIzy3fN74J9FCC8IWpVHXalHEqCQuZ4
         rsjJm6Xoz64jbR/2Hy0ooAOxsxHHjwdRrVDoQScb7RLTO69PrPqpr4YEqaYB+/mvjrQC
         8TSBcGh7mkUwXZ0+76/Drzt5AuqnhmbkOF7GYjTJutzTOC2/o2rH4r0LwwUNM+5qTjzw
         lQiA==
X-Gm-Message-State: AOAM531SDo/QOcgpEm8Jf3k5RuGkBExbcb3uzo0Cq9B+vrZynFnlTUMt
        FmjfwHigT+3VDwEIDG5oIMYylV62n1cRgA==
X-Google-Smtp-Source: ABdhPJylwM+QqkMC3yBbQTg9bJ7ZkETdzwvGbCdH9xVy46m+hhV1uOAp2KU2ao/EHeoNE7bMbsLdAQWv9NMZug==
X-Received: from abdulras.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:41e1])
 (user=abdulras job=sendgmr) by 2002:a25:c589:: with SMTP id
 v131mr621116ybe.344.1628098345153; Wed, 04 Aug 2021 10:32:25 -0700 (PDT)
Date:   Wed,  4 Aug 2021 17:32:14 +0000
Message-Id: <20210804173214.1027994-1-abdulras@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v3] riscv: explicitly use symbol offsets for VDSO
From:   Saleem Abdulrasool <abdulras@google.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        clang-built-linux@googlegroups.com,
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
 arch/riscv/include/asm/vdso.h              | 14 ++----------
 arch/riscv/kernel/vdso/Makefile            | 25 ++++++++++------------
 arch/riscv/kernel/vdso/gen_vdso_offsets.sh |  5 +++++
 arch/riscv/kernel/vdso/so2s.sh             |  6 ------
 5 files changed, 22 insertions(+), 32 deletions(-)
 create mode 100755 arch/riscv/kernel/vdso/gen_vdso_offsets.sh
 delete mode 100755 arch/riscv/kernel/vdso/so2s.sh

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index bc74afdbf31e..e026b2d0a5a4 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -108,6 +108,10 @@ PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
 
+prepare: vdso_prepare
+vdso_prepare: prepare0
+	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso include/generated/vdso-offsets.h
+
 ifneq ($(CONFIG_XIP_KERNEL),y)
 ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN),yy)
 KBUILD_IMAGE := $(boot)/loader.bin
diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index 1453a2f563bc..d8d003c2b5a3 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -9,25 +9,15 @@
 #define _ASM_RISCV_VDSO_H
 
 #include <linux/types.h>
+#include <generated/vdso-offsets.h>
 
 #ifndef CONFIG_GENERIC_TIME_VSYSCALL
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
-({										\
-	extern const char __vdso_##name[];					\
-	(void __user *)((unsigned long)(base) + __vdso_##name);			\
-})
+	(void __user *)((unsigned long)(base) + __vdso_##name##_offset)
 
 asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
 
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 24d936c147cd..f8cb9144a284 100644
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
@@ -43,20 +43,22 @@ $(obj)/vdso.o: $(obj)/vdso.so
 # link rule for the .so file, .lds has to be first
 $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
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
@@ -65,11 +67,6 @@ quiet_cmd_vdsold = VDSOLD  $@
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
2.32.0.554.ge1b32706d8-goog

