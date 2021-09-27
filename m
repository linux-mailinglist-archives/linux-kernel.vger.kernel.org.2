Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EFE4192E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhI0LPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbhI0LPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:15:37 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617C0C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 04:13:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x191so10551261pgd.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=mnrf+Q0CQZ3IArFfmE9Op5GKTEhvNo2IzKK88RxVwEQ=;
        b=DwR6bfb15nqteSsivntCrx8/k2X87Ika+piCPufYuThWThoxDwh6LF2oNOOGvak8Al
         tosqnFRRRkXwmb+HVNHw/CL5cQcaz7U4NQbDckPqlLWWy99QaZZjYmSm1G0yYy8duwvg
         2+7Vuvdi1GcmHNB5chVUUYFCOYmHOd3tzh86Ht+D+Ai37CAR22LKHMgQoRngHUfOMH/i
         n7yNFZXiWWIv2FtL4ddtg5oNja6R8RSP3HG78fHmEt6lRgpSlI0ZkIsaXLNR5jDN2M3U
         XYXj8bffQFaLima/ulzY5ZId19makCFaFYMmZTQR7LxAY7mqZTM9C0ObH5iu6K5B5ZnJ
         PEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mnrf+Q0CQZ3IArFfmE9Op5GKTEhvNo2IzKK88RxVwEQ=;
        b=uF63FhQFPcQ49SAYEe6tYPqGB+Cnq4dnS/5ritfE7ETw8dQwXEor+FLtvTDgjd0res
         RXPmTcRivgiT7qf239kNemqTEYZLsZA2nejpSDiOGC02gKjT/7KFbDf/Y8Zbt8KyyeGd
         RDxoxTq2hBExLhcrRwCy8FpSuRSqzi3zODgN8Ei5msguW0bEHv8nEXQucehA07XpFAR7
         ntSgCOVn/P8KXW5fc6k748gii1/ON5KVRlc8S15sa9FJmpy7VusaaiRKiktnCglJ7IqR
         tpZfsk3IMBBNpg1rgL6KxInovX7fCp89nb6iducAfkwhGn9+WlgORSHbrcz2uzWoTot3
         WnUA==
X-Gm-Message-State: AOAM5309IGwZg3CK6yqSYtIa2YbEkF13K2IJjw82p8Czh4rnXKBgiNCX
        F9UcjwTXa/ZzE6prURSl+wE=
X-Google-Smtp-Source: ABdhPJzAYE8WvS5EX9DGu9QdWc2Ec1R/52AWeebUEsa5MV00l1IM+hIixKOMxNyb5Vpkzaes5eb7Ow==
X-Received: by 2002:a62:31c5:0:b0:447:b30c:9a79 with SMTP id x188-20020a6231c5000000b00447b30c9a79mr23016487pfx.67.1632741237886;
        Mon, 27 Sep 2021 04:13:57 -0700 (PDT)
Received: from localhost.localdomain ([153.37.224.179])
        by smtp.gmail.com with ESMTPSA id b2sm17139686pfr.58.2021.09.27.04.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 04:13:57 -0700 (PDT)
From:   Jinli Zheng <zhengdbu@gmail.com>
To:     paul.walmsley@sifive.com
Cc:     palmer@dabbelt.com, aou@eecs.berkeley.edu, anup.patel@wdc.com,
        sunnanyong@huawei.com, alex@ghiti.fr, jszhang@kernel.org,
        penberg@kernel.org, guoren@linux.alibaba.com, zhengdbu@gmail.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] Add support for mm->mmap_legacy_base in legacy layout
Date:   Mon, 27 Sep 2021 19:11:50 +0800
Message-Id: <20210927111150.3518-1-zhengdbu@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mm->mmap_legacy_base in the legacy layout
of the process memory space for the riscv architecture

Signed-off-by: Jinli Zheng <zhengdbu@gmail.com>
---
 arch/riscv/Kconfig                 |   2 +-
 arch/riscv/include/asm/pgtable.h   |   3 +
 arch/riscv/include/asm/processor.h |   1 +
 arch/riscv/mm/Makefile             |   2 +-
 arch/riscv/mm/mmap.c               | 165 +++++++++++++++++++++++++++++
 5 files changed, 171 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/mm/mmap.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 301a54233c7e..e64231592227 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -37,7 +37,7 @@ config RISCV
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
 	select ARCH_USE_MEMTEST
-	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
+	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 39b550310ec6..107d61371272 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -700,6 +700,9 @@ void misc_mem_init(void);
 extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
 
+#define HAVE_ARCH_UNMAPPED_AREA
+#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PGTABLE_H */
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 46b492c78cbb..e7dc7c1f820a 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -56,6 +56,7 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->epc)
 #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->sp)
 
+#define HAVE_ARCH_PICK_MMAP_LAYOUT	1
 
 /* Do necessary setup to start up a newly executed thread. */
 extern void start_thread(struct pt_regs *regs,
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 7ebaef10ea1b..123c67a2c24a 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -10,7 +10,7 @@ KCOV_INSTRUMENT_init.o := n
 
 obj-y += init.o
 obj-y += extable.o
-obj-$(CONFIG_MMU) += fault.o pageattr.o
+obj-$(CONFIG_MMU) += fault.o pageattr.o mmap.o
 obj-y += cacheflush.o
 obj-y += context.o
 
diff --git a/arch/riscv/mm/mmap.c b/arch/riscv/mm/mmap.c
new file mode 100644
index 000000000000..6c5818db5a65
--- /dev/null
+++ b/arch/riscv/mm/mmap.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Legacy and flexible mmap layout support
+ *
+ * Copyright (C) 2021 Jinli Zheng <zhengdbu@gmail.com>
+ */
+
+#include <linux/personality.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/random.h>
+#include <linux/limits.h>
+#include <linux/security.h>
+#include <linux/compat.h>
+#include <linux/sched/mm.h>
+#include <linux/sched.h>
+#include <linux/elf-randomize.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+
+#define SIZE_128M	(128*1024*1024UL)
+
+/*gap between MMAP and STACK*/
+#define GAP_MIN		SIZE_128M
+#define GAP_MAX		(((TASK_SIZE)/6)*5)
+
+static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
+{
+	unsigned long gap = rlim_stack->rlim_cur;
+
+	if (gap < GAP_MIN)
+		gap = GAP_MIN;
+	else if (gap > GAP_MAX)
+		gap = GAP_MAX;
+
+	return PAGE_ALIGN(TASK_SIZE - gap - rnd);
+}
+
+unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma, *prev;
+	struct vm_unmapped_area_info info;
+
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	if (flags & MAP_FIXED)
+		return addr;
+
+	if (addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma_prev(mm, addr, &prev);
+		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
+		     (!vma || addr + len <= vm_start_gap(vma)) &&
+		     (!prev || addr >= vm_end_gap(prev)))
+			return addr;
+	}
+
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = mm->mmap_legacy_base;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = 0;
+	info.align_offset = 0;
+	return vm_unmapped_area(&info);
+}
+
+unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma, *prev;
+	struct vm_unmapped_area_info info;
+
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	if (flags & MAP_FIXED)
+		return addr;
+
+	if (addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma_prev(mm, addr, &prev);
+		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
+		     (!vma || addr + len <= vm_start_gap(vma)) &&
+		     (!prev || addr >= vm_end_gap(prev)))
+			return addr;
+	}
+
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	info.high_limit = mm->mmap_base;
+	info.align_mask = 0;
+	info.align_offset = 0;
+	addr = vm_unmapped_area(&info);
+
+	if (offset_in_page(addr)) {
+		VM_BUG_ON(addr != -ENOMEM);
+		info.flags = 0;
+		info.low_limit = TASK_UNMAPPED_BASE;
+		info.high_limit = TASK_SIZE;
+		addr = vm_unmapped_area(&info);
+	}
+
+	return addr;
+}
+
+unsigned long arch_mmap_rnd(void)
+{
+	unsigned long rnd;
+
+#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
+	if (is_compat_task())
+		rnd = get_random_int() & ((1UL << mmap_rnd_compat_bits) - 1);
+	else
+#endif /*CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS*/
+		rnd = get_random_int() & ((1UL << mmap_rnd_bits) - 1);
+
+	return rnd << PAGE_SHIFT;
+}
+
+static int mmap_is_legacy(struct rlimit *rlim_stack)
+{
+	if (current->personality & ADDR_COMPAT_LAYOUT)
+		return 1;
+
+	if (rlim_stack->rlim_cur == RLIM_INFINITY)
+		return 1;
+
+	return sysctl_legacy_va_layout;
+}
+
+static void arch_pick_mmap_base(struct mm_struct *mm, struct rlimit *rlim_stack)
+{
+	unsigned long random;
+
+	random = (current->flags & PF_RANDOMIZE) ?
+		arch_mmap_rnd() : 0UL;
+
+	if (mmap_is_legacy(rlim_stack))
+		mm->mmap_legacy_base = TASK_UNMAPPED_BASE + random;
+	else
+		mm->mmap_base = mmap_base(random, rlim_stack);
+}
+
+void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+{
+	if (mmap_is_legacy(rlim_stack))
+		mm->get_unmapped_area = arch_get_unmapped_area;
+	else
+		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
+
+	arch_pick_mmap_base(mm, rlim_stack);
+}
+
+unsigned long arch_randomize_brk(struct mm_struct *mm)
+{
+	if (!IS_ENABLED(CONFIG_64BIT) || is_compat_task())
+		return randomize_page(mm->brk, SZ_32M);
+
+	return randomize_page(mm->brk, SZ_1G);
+}
-- 
2.17.1

