Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A84393091
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbhE0ORW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:17:22 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:2320 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhE0ORV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:17:21 -0400
Received: from dggeml752-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FrV960Blwz1BFcL;
        Thu, 27 May 2021 22:11:06 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggeml752-chm.china.huawei.com (10.1.199.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 22:15:41 +0800
Received: from huawei.com (10.175.113.32) by dggpemm000001.china.huawei.com
 (7.185.36.245) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 27 May
 2021 22:15:40 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <anup.patel@wdc.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH -next] riscv: mm: remove redundant trampoline PGD for 64bit
Date:   Thu, 27 May 2021 22:48:19 +0800
Message-ID: <20210527144819.12101-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
---
 arch/riscv/kernel/head.S | 13 +++++++++++--
 arch/riscv/mm/init.c     | 21 +++++++--------------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 89cc58ab52b4..1897b17c5fcc 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -93,12 +93,18 @@ relocate:
 	add a2, a2, a1
 	csrw CSR_TVEC, a2
 
-	/* Compute satp for kernel page tables, but don't load it yet */
+	/* Compute satp for kernel page tables */
 	srl a2, a0, PAGE_SHIFT
 	li a1, SATP_MODE
 	or a2, a2, a1
-
+#ifdef CONFIG_64BIT
+	/* Load kernel page directory */
+	sfence.vma
+	csrw CSR_SATP, a2
+#else
 	/*
+	 * 32bit system need a trampoline to handle a corner case where
+	 * load address range overlaps kernel virtual address range.
 	 * Load trampoline page directory, which will cause us to trap to
 	 * stvec if VA != PA, or simply fall through if VA == PA.  We need a
 	 * full fence here because setup_vm() just wrote these PTEs and we need
@@ -110,6 +116,7 @@ relocate:
 	or a0, a0, a1
 	sfence.vma
 	csrw CSR_SATP, a0
+#endif /* CONFIG_64BIT */
 .align 2
 1:
 	/* Set trap vector to spin forever to help debug */
@@ -122,6 +129,7 @@ relocate:
 	la gp, __global_pointer$
 .option pop
 
+#ifdef CONFIG_32BIT
 	/*
 	 * Switch to kernel page tables.  A full fence is necessary in order to
 	 * avoid using the trampoline translations, which are only correct for
@@ -130,6 +138,7 @@ relocate:
 	 */
 	csrw CSR_SATP, a2
 	sfence.vma
+#endif /* CONFIG_32BIT */
 
 	ret
 #endif /* CONFIG_MMU */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 11b61bea0c4d..b7226ac2d04f 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -210,13 +210,17 @@ unsigned long pfn_base __ro_after_init;
 EXPORT_SYMBOL(pfn_base);
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
+#ifdef CONFIG_32BIT
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
+#endif /* CONFIG_32BIT */
 pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
 
 pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_XIP_KERNEL
+#ifdef CONFIG_32BIT
 #define trampoline_pg_dir      ((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
+#endif /* CONFIG_32BIT */
 #define fixmap_pte             ((pte_t *)XIP_FIXUP(fixmap_pte))
 #define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
 #endif /* CONFIG_XIP_KERNEL */
@@ -291,13 +295,11 @@ static void __init create_pte_mapping(pte_t *ptep,
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
-pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
 pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
 pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_XIP_KERNEL
-#define trampoline_pmd ((pmd_t *)XIP_FIXUP(trampoline_pmd))
 #define fixmap_pmd     ((pmd_t *)XIP_FIXUP(fixmap_pmd))
 #define early_pmd      ((pmd_t *)XIP_FIXUP(early_pmd))
 #endif /* CONFIG_XIP_KERNEL */
@@ -543,21 +545,12 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	/* Setup fixmap PMD */
 	create_pmd_mapping(fixmap_pmd, FIXADDR_START,
 			   (uintptr_t)fixmap_pte, PMD_SIZE, PAGE_TABLE);
-	/* Setup trampoline PGD and PMD */
-	create_pgd_mapping(trampoline_pg_dir, kernel_virt_addr,
-			   (uintptr_t)trampoline_pmd, PGDIR_SIZE, PAGE_TABLE);
-#ifdef CONFIG_XIP_KERNEL
-	create_pmd_mapping(trampoline_pmd, kernel_virt_addr,
-			   xiprom, PMD_SIZE, PAGE_KERNEL_EXEC);
-#else
-	create_pmd_mapping(trampoline_pmd, kernel_virt_addr,
-			   load_pa, PMD_SIZE, PAGE_KERNEL_EXEC);
-#endif
-#else
+#endif /* __PAGETABLE_PMD_FOLDED */
+#ifdef CONFIG_32BIT
 	/* Setup trampoline PGD */
 	create_pgd_mapping(trampoline_pg_dir, kernel_virt_addr,
 			   load_pa, PGDIR_SIZE, PAGE_KERNEL_EXEC);
-#endif
+#endif /* CONFIG_32BIT */
 
 	/*
 	 * Setup early PGD covering entire kernel which will allow
-- 
2.18.0.huawei.25

