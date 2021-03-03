Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D45732BFB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580071AbhCCSdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:33:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348076AbhCCRHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHe2UJa1GV9gPMlI4OtQnGzo32yVsNBjDhNRhl7PBJM=;
        b=f4JcQJ+izRaFXO1lne8CyuoyD5RaSV5gDbMZPxj/VHObjMXJwJMyeTbVviH8GR3s9Cjgfl
        vdIq/bGzLnIbf0EKbAnRfD8NXcCJwxg+C+QCGl+h2sCI68dzJFOxXxfZR5uxDbIKQMXxh/
        u3cO1MvVse8j5YUWtOVkpg4Ja1HFYfA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-u9EbhHHJPTyY_5kCJBf7cw-1; Wed, 03 Mar 2021 12:05:43 -0500
X-MC-Unique: u9EbhHHJPTyY_5kCJBf7cw-1
Received: by mail-wr1-f70.google.com with SMTP id h21so8601530wrc.19
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oHe2UJa1GV9gPMlI4OtQnGzo32yVsNBjDhNRhl7PBJM=;
        b=VCZEHT5JwRG8v2h/t6UyU5MFu5/pDGjYfA/SIQwyKdPjYh9NpRmPD3zZ3M4QFDNzOG
         2BhKyTaFu2MrwG1+I2HTYjcvPiQ58rt47t/ogd//TPyGQUKpHHlreG8SJ2IQXgXRq12t
         1UHrPZrutdw47reIWa3r8M8ASWrdW5rXsYhhus4++oVQaL8AT2ZUWWBOZgyv6xjNmEh9
         yycSqQ3C5Cq1rX4tW1MnH/qJBuFNWRJvahP01ZjYBfjmcLcXx3bEtY3HAREBFZOlY4D5
         TUeHm5+jzdAFY0FLASChbMEsjNS87gJDa3y1XdQ7b4JHEFI11ZM3BUrD4e9bKwFYU5IG
         40uw==
X-Gm-Message-State: AOAM530sL7HHIMcHvvFp32VfipHSKW7XlEIDEdzNagtPLpXS5UpWmDC0
        ytwGFheFiuWs9pNbm2wsMIrev+JvFfFfYhr0gFWC5s7vub82XZR6Q/dX0ZdFp50FyKun9Jm4nxI
        TXxSHIbo8I7DK2z7olsBh9RahOwUVD6u9C/nY2mTKW4uec3CtmJgUSG4N5X5MUIoQkVJqK3hGGV
        td
X-Received: by 2002:a7b:c341:: with SMTP id l1mr10597wmj.182.1614791142215;
        Wed, 03 Mar 2021 09:05:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjyAsbsHeWq0MALIF5czDTtQu+0Xg/zXijcZm/QhWaRy5zPghx7K2ZvxfHAPoC5ZZSS9OPTQ==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr10583wmj.182.1614791141988;
        Wed, 03 Mar 2021 09:05:41 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id d29sm32957827wra.51.2021.03.03.09.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:05:41 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 1/8] arm64: Move patching utilities out of instruction encoding/decoding
Date:   Wed,  3 Mar 2021 18:05:29 +0100
Message-Id: <20210303170536.1838032-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170536.1838032-1-jthierry@redhat.com>
References: <20210303170536.1838032-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Files insn.[c|h] containt some functions used for instruction patching.
In order to reuse the instruction encoder/decoder, move the patching
utilities to their own file.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/include/asm/insn.h     |   5 -
 arch/arm64/include/asm/patching.h |  13 +++
 arch/arm64/kernel/Makefile        |   2 +-
 arch/arm64/kernel/ftrace.c        |   1 +
 arch/arm64/kernel/insn.c          | 149 +-----------------------------
 arch/arm64/kernel/jump_label.c    |   1 +
 arch/arm64/kernel/patching.c      | 148 +++++++++++++++++++++++++++++
 arch/arm64/kernel/traps.c         |   1 +
 8 files changed, 168 insertions(+), 152 deletions(-)
 create mode 100644 arch/arm64/include/asm/patching.h
 create mode 100644 arch/arm64/kernel/patching.c

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 4ebb9c054ccc..7437b7e7e7eb 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -379,8 +379,6 @@ static inline bool aarch64_insn_is_adr_adrp(u32 insn)
 	return aarch64_insn_is_adr(insn) || aarch64_insn_is_adrp(insn);
 }
 
-int aarch64_insn_read(void *addr, u32 *insnp);
-int aarch64_insn_write(void *addr, u32 insn);
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
 bool aarch64_insn_uses_literal(u32 insn);
 bool aarch64_insn_is_branch(u32 insn);
@@ -487,9 +485,6 @@ u32 aarch64_insn_gen_prefetch(enum aarch64_insn_register base,
 s32 aarch64_get_branch_offset(u32 insn);
 u32 aarch64_set_branch_offset(u32 insn, s32 offset);
 
-int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
-int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
-
 s32 aarch64_insn_adrp_get_offset(u32 insn);
 u32 aarch64_insn_adrp_set_offset(u32 insn, s32 offset);
 
diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
new file mode 100644
index 000000000000..6bf5adc56295
--- /dev/null
+++ b/arch/arm64/include/asm/patching.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef	__ASM_PATCHING_H
+#define	__ASM_PATCHING_H
+
+#include <linux/types.h>
+
+int aarch64_insn_read(void *addr, u32 *insnp);
+int aarch64_insn_write(void *addr, u32 insn);
+
+int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
+int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
+
+#endif	/* __ASM_PATCHING_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index ed65576ce710..790af8c69338 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -17,7 +17,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   return_address.o cpuinfo.o cpu_errata.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
-			   syscall.o proton-pack.o idreg-override.o
+			   syscall.o proton-pack.o idreg-override.o patching.o
 
 targets			+= efi-entry.o
 
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 86a5cf9bc19a..fd7993f0c9c4 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -15,6 +15,7 @@
 #include <asm/debug-monitors.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
+#include <asm/patching.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 /*
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 6c0de2f60ea9..952e7d6fe60e 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -7,21 +7,14 @@
  */
 #include <linux/bitops.h>
 #include <linux/bug.h>
-#include <linux/compiler.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/smp.h>
-#include <linux/spinlock.h>
-#include <linux/stop_machine.h>
+#include <linux/printk.h>
+#include <linux/sizes.h>
 #include <linux/types.h>
-#include <linux/uaccess.h>
 
-#include <asm/cacheflush.h>
 #include <asm/debug-monitors.h>
-#include <asm/fixmap.h>
+#include <asm/errno.h>
 #include <asm/insn.h>
 #include <asm/kprobes.h>
-#include <asm/sections.h>
 
 #define AARCH64_INSN_SF_BIT	BIT(31)
 #define AARCH64_INSN_N_BIT	BIT(22)
@@ -83,81 +76,6 @@ bool aarch64_insn_is_branch_imm(u32 insn)
 		aarch64_insn_is_bcond(insn));
 }
 
-static DEFINE_RAW_SPINLOCK(patch_lock);
-
-static bool is_exit_text(unsigned long addr)
-{
-	/* discarded with init text/data */
-	return system_state < SYSTEM_RUNNING &&
-		addr >= (unsigned long)__exittext_begin &&
-		addr < (unsigned long)__exittext_end;
-}
-
-static bool is_image_text(unsigned long addr)
-{
-	return core_kernel_text(addr) || is_exit_text(addr);
-}
-
-static void __kprobes *patch_map(void *addr, int fixmap)
-{
-	unsigned long uintaddr = (uintptr_t) addr;
-	bool image = is_image_text(uintaddr);
-	struct page *page;
-
-	if (image)
-		page = phys_to_page(__pa_symbol(addr));
-	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
-		page = vmalloc_to_page(addr);
-	else
-		return addr;
-
-	BUG_ON(!page);
-	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
-			(uintaddr & ~PAGE_MASK));
-}
-
-static void __kprobes patch_unmap(int fixmap)
-{
-	clear_fixmap(fixmap);
-}
-/*
- * In ARMv8-A, A64 instructions have a fixed length of 32 bits and are always
- * little-endian.
- */
-int __kprobes aarch64_insn_read(void *addr, u32 *insnp)
-{
-	int ret;
-	__le32 val;
-
-	ret = copy_from_kernel_nofault(&val, addr, AARCH64_INSN_SIZE);
-	if (!ret)
-		*insnp = le32_to_cpu(val);
-
-	return ret;
-}
-
-static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
-{
-	void *waddr = addr;
-	unsigned long flags = 0;
-	int ret;
-
-	raw_spin_lock_irqsave(&patch_lock, flags);
-	waddr = patch_map(addr, FIX_TEXT_POKE0);
-
-	ret = copy_to_kernel_nofault(waddr, &insn, AARCH64_INSN_SIZE);
-
-	patch_unmap(FIX_TEXT_POKE0);
-	raw_spin_unlock_irqrestore(&patch_lock, flags);
-
-	return ret;
-}
-
-int __kprobes aarch64_insn_write(void *addr, u32 insn)
-{
-	return __aarch64_insn_write(addr, cpu_to_le32(insn));
-}
-
 bool __kprobes aarch64_insn_uses_literal(u32 insn)
 {
 	/* ldr/ldrsw (literal), prfm */
@@ -187,67 +105,6 @@ bool __kprobes aarch64_insn_is_branch(u32 insn)
 		aarch64_insn_is_bcond(insn);
 }
 
-int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
-{
-	u32 *tp = addr;
-	int ret;
-
-	/* A64 instructions must be word aligned */
-	if ((uintptr_t)tp & 0x3)
-		return -EINVAL;
-
-	ret = aarch64_insn_write(tp, insn);
-	if (ret == 0)
-		__flush_icache_range((uintptr_t)tp,
-				     (uintptr_t)tp + AARCH64_INSN_SIZE);
-
-	return ret;
-}
-
-struct aarch64_insn_patch {
-	void		**text_addrs;
-	u32		*new_insns;
-	int		insn_cnt;
-	atomic_t	cpu_count;
-};
-
-static int __kprobes aarch64_insn_patch_text_cb(void *arg)
-{
-	int i, ret = 0;
-	struct aarch64_insn_patch *pp = arg;
-
-	/* The first CPU becomes master */
-	if (atomic_inc_return(&pp->cpu_count) == 1) {
-		for (i = 0; ret == 0 && i < pp->insn_cnt; i++)
-			ret = aarch64_insn_patch_text_nosync(pp->text_addrs[i],
-							     pp->new_insns[i]);
-		/* Notify other processors with an additional increment. */
-		atomic_inc(&pp->cpu_count);
-	} else {
-		while (atomic_read(&pp->cpu_count) <= num_online_cpus())
-			cpu_relax();
-		isb();
-	}
-
-	return ret;
-}
-
-int __kprobes aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt)
-{
-	struct aarch64_insn_patch patch = {
-		.text_addrs = addrs,
-		.new_insns = insns,
-		.insn_cnt = cnt,
-		.cpu_count = ATOMIC_INIT(0),
-	};
-
-	if (cnt <= 0)
-		return -EINVAL;
-
-	return stop_machine_cpuslocked(aarch64_insn_patch_text_cb, &patch,
-				       cpu_online_mask);
-}
-
 static int __kprobes aarch64_get_imm_shift_mask(enum aarch64_insn_imm_type type,
 						u32 *maskp, int *shiftp)
 {
diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
index 9a8a0ae1e75f..fc98037e1220 100644
--- a/arch/arm64/kernel/jump_label.c
+++ b/arch/arm64/kernel/jump_label.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/jump_label.h>
 #include <asm/insn.h>
+#include <asm/patching.h>
 
 void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
new file mode 100644
index 000000000000..9d050e33901b
--- /dev/null
+++ b/arch/arm64/kernel/patching.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/stop_machine.h>
+#include <linux/uaccess.h>
+
+#include <asm/cacheflush.h>
+#include <asm/fixmap.h>
+#include <asm/kprobes.h>
+#include <asm/sections.h>
+
+static DEFINE_RAW_SPINLOCK(patch_lock);
+
+static bool is_exit_text(unsigned long addr)
+{
+	/* discarded with init text/data */
+	return system_state < SYSTEM_RUNNING &&
+		addr >= (unsigned long)__exittext_begin &&
+		addr < (unsigned long)__exittext_end;
+}
+
+static bool is_image_text(unsigned long addr)
+{
+	return core_kernel_text(addr) || is_exit_text(addr);
+}
+
+static void __kprobes *patch_map(void *addr, int fixmap)
+{
+	unsigned long uintaddr = (uintptr_t) addr;
+	bool image = is_image_text(uintaddr);
+	struct page *page;
+
+	if (image)
+		page = phys_to_page(__pa_symbol(addr));
+	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		page = vmalloc_to_page(addr);
+	else
+		return addr;
+
+	BUG_ON(!page);
+	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
+			(uintaddr & ~PAGE_MASK));
+}
+
+static void __kprobes patch_unmap(int fixmap)
+{
+	clear_fixmap(fixmap);
+}
+/*
+ * In ARMv8-A, A64 instructions have a fixed length of 32 bits and are always
+ * little-endian.
+ */
+int __kprobes aarch64_insn_read(void *addr, u32 *insnp)
+{
+	int ret;
+	__le32 val;
+
+	ret = copy_from_kernel_nofault(&val, addr, AARCH64_INSN_SIZE);
+	if (!ret)
+		*insnp = le32_to_cpu(val);
+
+	return ret;
+}
+
+static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
+{
+	void *waddr = addr;
+	unsigned long flags = 0;
+	int ret;
+
+	raw_spin_lock_irqsave(&patch_lock, flags);
+	waddr = patch_map(addr, FIX_TEXT_POKE0);
+
+	ret = copy_to_kernel_nofault(waddr, &insn, AARCH64_INSN_SIZE);
+
+	patch_unmap(FIX_TEXT_POKE0);
+	raw_spin_unlock_irqrestore(&patch_lock, flags);
+
+	return ret;
+}
+
+int __kprobes aarch64_insn_write(void *addr, u32 insn)
+{
+	return __aarch64_insn_write(addr, cpu_to_le32(insn));
+}
+
+int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
+{
+	u32 *tp = addr;
+	int ret;
+
+	/* A64 instructions must be word aligned */
+	if ((uintptr_t)tp & 0x3)
+		return -EINVAL;
+
+	ret = aarch64_insn_write(tp, insn);
+	if (ret == 0)
+		__flush_icache_range((uintptr_t)tp,
+				     (uintptr_t)tp + AARCH64_INSN_SIZE);
+
+	return ret;
+}
+
+struct aarch64_insn_patch {
+	void		**text_addrs;
+	u32		*new_insns;
+	int		insn_cnt;
+	atomic_t	cpu_count;
+};
+
+static int __kprobes aarch64_insn_patch_text_cb(void *arg)
+{
+	int i, ret = 0;
+	struct aarch64_insn_patch *pp = arg;
+
+	/* The first CPU becomes master */
+	if (atomic_inc_return(&pp->cpu_count) == 1) {
+		for (i = 0; ret == 0 && i < pp->insn_cnt; i++)
+			ret = aarch64_insn_patch_text_nosync(pp->text_addrs[i],
+							     pp->new_insns[i]);
+		/* Notify other processors with an additional increment. */
+		atomic_inc(&pp->cpu_count);
+	} else {
+		while (atomic_read(&pp->cpu_count) <= num_online_cpus())
+			cpu_relax();
+		isb();
+	}
+
+	return ret;
+}
+
+int __kprobes aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt)
+{
+	struct aarch64_insn_patch patch = {
+		.text_addrs = addrs,
+		.new_insns = insns,
+		.insn_cnt = cnt,
+		.cpu_count = ATOMIC_INIT(0),
+	};
+
+	if (cnt <= 0)
+		return -EINVAL;
+
+	return stop_machine_cpuslocked(aarch64_insn_patch_text_cb, &patch,
+				       cpu_online_mask);
+}
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index a05d34f0e82a..d7057e307bca 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -38,6 +38,7 @@
 #include <asm/extable.h>
 #include <asm/insn.h>
 #include <asm/kprobes.h>
+#include <asm/patching.h>
 #include <asm/traps.h>
 #include <asm/smp.h>
 #include <asm/stack_pointer.h>
-- 
2.25.4

