Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EFB4505B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhKONmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:42:05 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26314 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbhKONk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:40:29 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ht99357WXzbhDY;
        Mon, 15 Nov 2021 21:32:23 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 21:37:17 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 21:37:17 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <glider@google.com>, <elver@google.com>, <dvyukov@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH Resend v2 3/3] ARM: Support KFENCE for ARM
Date:   Mon, 15 Nov 2021 21:48:48 +0800
Message-ID: <20211115134848.171098-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211115134848.171098-1-wangkefeng.wang@huawei.com>
References: <20211115134848.171098-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/Kconfig              |  1 +
 arch/arm/include/asm/kfence.h | 53 +++++++++++++++++++++++++++++++++++
 arch/arm/mm/fault.c           |  9 ++++--
 3 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/kfence.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f0f9e8bec83a..321b0a1c2820 100644
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
index 1207ed925039..49148b675b43 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -17,6 +17,7 @@
 #include <linux/sched/debug.h>
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
+#include <linux/kfence.h>
 
 #include <asm/system_misc.h>
 #include <asm/system_info.h>
@@ -136,10 +137,14 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
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
-- 
2.26.2

