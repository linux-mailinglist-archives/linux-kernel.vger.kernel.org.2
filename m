Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58840444264
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 14:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhKCN3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 09:29:17 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:30914 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhKCN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 09:29:15 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HknVQ3mllzcZyZ;
        Wed,  3 Nov 2021 21:21:50 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 21:26:34 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 21:26:34 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 3/3] ARM: Support KFENCE for ARM
Date:   Wed, 3 Nov 2021 21:38:45 +0800
Message-ID: <20211103133845.78528-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211103133845.78528-1-wangkefeng.wang@huawei.com>
References: <20211103133845.78528-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add architecture specific implementation details for KFENCE and enable
KFENCE on ARM. In particular, this implements the required interface in
 <asm/kfence.h>.

KFENCE requires that attributes for pages from its memory pool can
individually be set. Therefore, force the kfence pool to be mapped
at page granularity.

Testing this patch using the testcases in kfence_test.c and all passed
with or without ARM_LPAE.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/Kconfig              |  1 +
 arch/arm/include/asm/kfence.h | 53 +++++++++++++++++++++++++++++++++++
 arch/arm/mm/fault.c           | 19 ++++++++-----
 3 files changed, 66 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/include/asm/kfence.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b9f72337224c..6d1f6f48995c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -69,6 +69,7 @@ config ARM
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
+	select HAVE_ARCH_KFENCE if MMU && !XIP_KERNEL
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
diff --git a/arch/arm/include/asm/kfence.h b/arch/arm/include/asm/kfence.h
new file mode 100644
index 000000000000..7980d0f2271f
--- /dev/null
+++ b/arch/arm/include/asm/kfence.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_ARM_KFENCE_H
+#define __ASM_ARM_KFENCE_H
+
+#include <linux/kfence.h>
+
+#include <asm/pgalloc.h>
+#include <asm/set_memory.h>
+
+static inline int split_pmd_page(pmd_t *pmd, unsigned long addr)
+{
+	int i;
+	unsigned long pfn = PFN_DOWN(__pa(addr));
+	pte_t *pte = pte_alloc_one_kernel(&init_mm);
+
+	if (!pte)
+		return -ENOMEM;
+
+	for (i = 0; i < PTRS_PER_PTE; i++)
+		set_pte_ext(pte + i, pfn_pte(pfn + i, PAGE_KERNEL), 0);
+	pmd_populate_kernel(&init_mm, pmd, pte);
+
+	flush_tlb_kernel_range(addr, addr + PMD_SIZE);
+	return 0;
+}
+
+static inline bool arch_kfence_init_pool(void)
+{
+	unsigned long addr;
+	pmd_t *pmd;
+
+	for (addr = (unsigned long)__kfence_pool; is_kfence_address((void *)addr);
+	     addr += PAGE_SIZE) {
+		pmd = pmd_off_k(addr);
+
+		if (pmd_leaf(*pmd)) {
+			if (split_pmd_page(pmd, addr & PMD_MASK))
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static inline bool kfence_protect_page(unsigned long addr, bool protect)
+{
+	set_memory_valid(addr, 1, !protect);
+
+	return true;
+}
+
+#endif /* __ASM_ARM_KFENCE_H */
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index f7ab6dabe89f..49148b675b43 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -17,6 +17,7 @@
 #include <linux/sched/debug.h>
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
+#include <linux/kfence.h>
 
 #include <asm/system_misc.h>
 #include <asm/system_info.h>
@@ -99,6 +100,11 @@ void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
 { }
 #endif					/* CONFIG_MMU */
 
+static inline bool is_write_fault(unsigned int fsr)
+{
+	return (fsr & FSR_WRITE) && !(fsr & FSR_CM);
+}
+
 static void die_kernel_fault(const char *msg, struct mm_struct *mm,
 			     unsigned long addr, unsigned int fsr,
 			     struct pt_regs *regs)
@@ -131,10 +137,14 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 	/*
 	 * No handler, we'll have to terminate things with extreme prejudice.
 	 */
-	if (addr < PAGE_SIZE)
+	if (addr < PAGE_SIZE) {
 		msg = "NULL pointer dereference";
-	else
+	} else {
+		if (kfence_handle_page_fault(addr, is_write_fault(fsr), regs))
+			return;
+
 		msg = "paging request";
+	}
 
 	die_kernel_fault(msg, mm, addr, fsr, regs);
 }
@@ -207,11 +217,6 @@ static inline bool is_permission_fault(unsigned int fsr)
 	return false;
 }
 
-static inline bool is_write_fault(unsigned int fsr)
-{
-	return (fsr & FSR_WRITE) && !(fsr & FSR_CM);
-}
-
 static vm_fault_t __kprobes
 __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int flags,
 		unsigned long vma_flags, struct pt_regs *regs)
-- 
2.26.2

