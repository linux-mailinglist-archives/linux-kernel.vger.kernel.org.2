Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1723D85D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 04:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhG1CSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 22:18:55 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12413 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhG1CSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 22:18:55 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GZHLZ6STJzcjJ6;
        Wed, 28 Jul 2021 10:15:18 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 10:18:47 +0800
Received: from huawei.com (10.175.113.32) by dggpemm000001.china.huawei.com
 (7.185.36.245) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Jul
 2021 10:18:46 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <anup.patel@wdc.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        <tiantao6@hisilicon.com>, <qiuwenbo@phytium.com.cn>,
        <rppt@kernel.org>, <jszhang@kernel.org>, <mick@ics.forth.gr>
Subject: [PATCH v2 -next] riscv: mm: remove redundant trampoline PGD for 64bit
Date:   Wed, 28 Jul 2021 10:49:10 +0800
Message-ID: <20210728024910.1417720-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant trampoline PGD for 64bit and add more comment
for why 32bit systems need trampoline PGD.

There was a patch and discussion similar to this,refer to
the link [1][2].

The trampoline PGD is redundant for 64bit systems because:
1. The early PGD covers the entire kernel mapping. Directly
loading early PGD can achieve the result in boot stage.
A more trampoline PGD makes code hard to understand.
2. Directly loading early PGD is safe in 64bit systems since
the kernel virtual address starts as 0xFFFFxxxxxxxxxxxx,
which has a very big gap with RAM address.It won't fall into
the corner case that 32bit system worrys.
3. Remove redundant trampoline PGD can benefit to code maintaince,
because 64bit systems have more page table levels.For example:
If we want to support SV48 which has 4 page table levels, we have
to add a trampoline_pud and insert it before trampoline_pmd.

Reference link:
[1]https://lore.kernel.org/linux-riscv/20190325092234.5451-4-anup.patel@wdc.com/
[2]https://lkml.org/lkml/2019/3/28/147

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: weiyongjun <weiyongjun1@huawei.com>
---
v2 changes:
  Adjust codes based on the review suggestions from Alex Ghiti,
  make codes more readable.
---
 arch/riscv/kernel/head.S | 46 ++++++++++++++++++++++++++--------------
 arch/riscv/mm/init.c     | 16 ++++----------
 2 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index fce5184b22c3..3816aa5edc69 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -89,29 +89,52 @@ relocate:
 	add ra, ra, a1
 
 	/* Point stvec to virtual address of intruction after satp write */
-	la a2, 1f
+#ifdef CONFIG_64BIT
+	la a2, load_done
+#else
+	la a2, load_kernel_pgd
+#endif
 	add a2, a2, a1
 	csrw CSR_TVEC, a2
 
-	/* Compute satp for kernel page tables, but don't load it yet */
+	/* Compute satp for kernel page tables.
+	 * For 64bit systems, load it and trap to stvec.
+	 * For 32bit systems, don't load it yet.
+	 */
 	srl a2, a0, PAGE_SHIFT
 	li a1, SATP_MODE
 	or a2, a2, a1
 
 	/*
+	 * Before writing satp, we need a full fence here because setup_vm() just
+	 * wrote these PTEs and we need to ensure the new translations are in use.
+	 */
+	sfence.vma
+#ifndef CONFIG_64BIT
+	/*
+	 * 32bit systems need firstly loading a trampoline to handle a corner
+	 * case where load address range overlaps kernel virtual address range.
 	 * Load trampoline page directory, which will cause us to trap to
-	 * stvec if VA != PA, or simply fall through if VA == PA.  We need a
-	 * full fence here because setup_vm() just wrote these PTEs and we need
-	 * to ensure the new translations are in use.
+	 * stvec if VA != PA, or simply fall through if VA == PA.
 	 */
 	la a0, trampoline_pg_dir
 	XIP_FIXUP_OFFSET a0
 	srl a0, a0, PAGE_SHIFT
 	or a0, a0, a1
-	sfence.vma
 	csrw CSR_SATP, a0
+#endif
 .align 2
-1:
+load_kernel_pgd:
+        /*
+         * Switch to kernel page tables.  A full fence is necessary in order to
+         * avoid using the trampoline translations, which are only correct for
+         * the first superpage.  Fetching the fence is guarnteed to work
+         * because that first superpage is translated the same way.
+         */
+        csrw CSR_SATP, a2
+        sfence.vma
+
+load_done:
 	/* Set trap vector to spin forever to help debug */
 	la a0, .Lsecondary_park
 	csrw CSR_TVEC, a0
@@ -122,15 +145,6 @@ relocate:
 	la gp, __global_pointer$
 .option pop
 
-	/*
-	 * Switch to kernel page tables.  A full fence is necessary in order to
-	 * avoid using the trampoline translations, which are only correct for
-	 * the first superpage.  Fetching the fence is guarnteed to work
-	 * because that first superpage is translated the same way.
-	 */
-	csrw CSR_SATP, a2
-	sfence.vma
-
 	ret
 #endif /* CONFIG_MMU */
 #ifdef CONFIG_SMP
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index ac48742fa6fc..306fcb2334fa 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -219,13 +219,17 @@ unsigned long pfn_base __ro_after_init;
 EXPORT_SYMBOL(pfn_base);
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
+#ifndef CONFIG_64BIT
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
+#endif /* CONFIG_64BIT */
 static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
 
 pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_XIP_KERNEL
+#ifndef CONFIG_64BIT
 #define trampoline_pg_dir      ((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
+#endif /* CONFIG_64BIT */
 #define fixmap_pte             ((pte_t *)XIP_FIXUP(fixmap_pte))
 #define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
 #endif /* CONFIG_XIP_KERNEL */
@@ -300,13 +304,11 @@ static void __init create_pte_mapping(pte_t *ptep,
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
-static pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
 static pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
 static pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 static pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_XIP_KERNEL
-#define trampoline_pmd ((pmd_t *)XIP_FIXUP(trampoline_pmd))
 #define fixmap_pmd     ((pmd_t *)XIP_FIXUP(fixmap_pmd))
 #define early_pmd      ((pmd_t *)XIP_FIXUP(early_pmd))
 #endif /* CONFIG_XIP_KERNEL */
@@ -585,16 +587,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	/* Setup fixmap PMD */
 	create_pmd_mapping(fixmap_pmd, FIXADDR_START,
 			   (uintptr_t)fixmap_pte, PMD_SIZE, PAGE_TABLE);
-	/* Setup trampoline PGD and PMD */
-	create_pgd_mapping(trampoline_pg_dir, kernel_map.virt_addr,
-			   (uintptr_t)trampoline_pmd, PGDIR_SIZE, PAGE_TABLE);
-#ifdef CONFIG_XIP_KERNEL
-	create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
-			   kernel_map.xiprom, PMD_SIZE, PAGE_KERNEL_EXEC);
-#else
-	create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
-			   kernel_map.phys_addr, PMD_SIZE, PAGE_KERNEL_EXEC);
-#endif
 #else
 	/* Setup trampoline PGD */
 	create_pgd_mapping(trampoline_pg_dir, kernel_map.virt_addr,
-- 
2.18.0.huawei.25

