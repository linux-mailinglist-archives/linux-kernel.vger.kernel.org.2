Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B6C3FC681
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 13:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbhHaLWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 07:22:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15234 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbhHaLWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 07:22:42 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GzPrb15pnz1DFPc;
        Tue, 31 Aug 2021 19:21:03 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 31 Aug 2021 19:21:44 +0800
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 31 Aug
 2021 19:21:43 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next v2] riscv: Enable HAVE_ARCH_HUGE_VMAP for 64BIT
Date:   Tue, 31 Aug 2021 19:50:44 +0800
Message-ID: <20210831115044.1109635-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sets the HAVE_ARCH_HUGE_VMAP option. Enable pmd vmap support and
define the required page table functions(Currently, riscv has only
three-level page tables support for 64BIT).

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 .../features/vm/huge-vmap/arch-support.txt    |  2 +-
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/include/asm/vmalloc.h              | 12 ++++++
 arch/riscv/mm/Makefile                        |  1 +
 arch/riscv/mm/pgtable.c                       | 38 +++++++++++++++++++
 include/linux/pgtable.h                       | 14 ++++++-
 6 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/mm/pgtable.c

diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index 439fd9069b8b..0ff394acc9cf 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -22,7 +22,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 820313bf3a9d..48418e71dfea 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -62,6 +62,7 @@ config RISCV
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
 	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
 	select HAVE_ARCH_KASAN if MMU && 64BIT
diff --git a/arch/riscv/include/asm/vmalloc.h b/arch/riscv/include/asm/vmalloc.h
index ff9abc00d139..8f17f421f80c 100644
--- a/arch/riscv/include/asm/vmalloc.h
+++ b/arch/riscv/include/asm/vmalloc.h
@@ -1,4 +1,16 @@
 #ifndef _ASM_RISCV_VMALLOC_H
 #define _ASM_RISCV_VMALLOC_H
 
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
+
+#define IOREMAP_MAX_ORDER (PMD_SHIFT)
+
+#define arch_vmap_pmd_supported	arch_vmap_pmd_supported
+static inline bool __init arch_vmap_pmd_supported(pgprot_t prot)
+{
+	return true;
+}
+
+#endif
+
 #endif /* _ASM_RISCV_VMALLOC_H */
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 7ebaef10ea1b..f932b4d69946 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -13,6 +13,7 @@ obj-y += extable.o
 obj-$(CONFIG_MMU) += fault.o pageattr.o
 obj-y += cacheflush.o
 obj-y += context.o
+obj-y += pgtable.o
 
 ifeq ($(CONFIG_MMU),y)
 obj-$(CONFIG_SMP) += tlbflush.o
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
new file mode 100644
index 000000000000..1d2182c2c508
--- /dev/null
+++ b/arch/riscv/mm/pgtable.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/pgalloc.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/pgtable.h>
+
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
+
+int pmd_set_huge(pmd_t *pmd, phys_addr_t phys, pgprot_t prot)
+{
+	pmd_t new_pmd = pfn_pmd(__phys_to_pfn(phys), prot);
+
+	set_pmd(pmd, new_pmd);
+	return 1;
+}
+
+int pmd_clear_huge(pmd_t *pmd)
+{
+	if (!pmd_leaf(READ_ONCE(*pmd)))
+		return 0;
+	pmd_clear(pmd);
+	return 1;
+}
+
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
+{
+	pte_t *pte;
+
+	pte = (pte_t *)pmd_page_vaddr(*pmd);
+	pmd_clear(pmd);
+
+	flush_tlb_kernel_range(addr, addr + PMD_SIZE);
+	pte_free_kernel(NULL, pte);
+	return 1;
+}
+
+#endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e24d2c992b11..382072c8f996 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1397,9 +1397,21 @@ static inline int p4d_clear_huge(p4d_t *p4d)
 }
 #endif /* !__PAGETABLE_P4D_FOLDED */
 
+#ifndef __PAGETABLE_PUD_FOLDED
 int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot);
-int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
 int pud_clear_huge(pud_t *pud);
+#else
+static inline int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
+{
+	return 0;
+}
+static inline int pud_clear_huge(pud_t *pud)
+{
+	return 0;
+}
+#endif /* !__PAGETABLE_PUD_FOLDED */
+
+int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
 int pmd_clear_huge(pmd_t *pmd);
 int p4d_free_pud_page(p4d_t *p4d, unsigned long addr);
 int pud_free_pmd_page(pud_t *pud, unsigned long addr);
-- 
2.18.0.huawei.25

