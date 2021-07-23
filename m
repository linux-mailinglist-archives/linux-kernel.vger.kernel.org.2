Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5221C3D3ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 15:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbhGWM0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:26:19 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:36415 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhGWM0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:26:18 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 16FB8100016;
        Fri, 23 Jul 2021 13:06:48 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 5/5] riscv: Move early fdt mapping creation in its own function
Date:   Fri, 23 Jul 2021 15:01:28 +0200
Message-Id: <20210723130128.47664-6-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210723130128.47664-1-alex@ghiti.fr>
References: <20210723130128.47664-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code that handles the early fdt mapping is hard to read and does not
create the same mapping size depending on the kernel:

- for 64-bit, 2 PMD entries are used which amounts to a 4MB mapping
- for 32-bit, 2 PGDIR entries are used which amounts to a 8MB mapping

So keep using 2 PMD entries for 64-bit and use only one PGD entry for
32-bit needed to cover 4MB. Move that into a new function called
create_fdt_early_page_table which, using the same naming as
create_kernel_page_table.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/init.c | 76 +++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 36 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 1b30ad7e3ebc..e2c8f188ad95 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -228,6 +228,7 @@ pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
 
 pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
+static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_XIP_KERNEL
 #define trampoline_pg_dir      ((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
@@ -308,7 +309,6 @@ static void __init create_pte_mapping(pte_t *ptep,
 static pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
 static pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
 static pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
-static pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_XIP_KERNEL
 #define trampoline_pmd ((pmd_t *)XIP_FIXUP(trampoline_pmd))
@@ -394,6 +394,7 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
 #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
 	create_pte_mapping(__nextp, __va, __pa, __sz, __prot)
 #define fixmap_pgd_next		fixmap_pte
+#define create_pmd_mapping(__pmdp, __va, __pa, __sz, __prot)
 #endif
 
 void __init create_pgd_mapping(pgd_t *pgdp,
@@ -535,9 +536,44 @@ static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
 }
 #endif
 
+/*
+ * Setup a 4MB mapping that encompasses the device tree: for 64-bit kernel,
+ * this means 2 PMD entries whereas for 32-bit kernel, this is only 1 PGDIR
+ * entry.
+ */
+static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
+{
+#ifndef CONFIG_BUILTIN_DTB
+	uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
+
+	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
+			   IS_ENABLED(CONFIG_64BIT) ? (uintptr_t)early_dtb_pmd : pa,
+			   PGDIR_SIZE,
+			   IS_ENABLED(CONFIG_64BIT) ? PAGE_TABLE : PAGE_KERNEL);
+
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
+				   pa, PMD_SIZE, PAGE_KERNEL);
+		create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
+				   pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
+	}
+
+	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
+#else
+	/*
+	 * For 64-bit kernel, __va can't be used since it would return a linear
+	 * mapping address whereas dtb_early_va will be used before
+	 * setup_vm_final installs the linear mapping. For 32-bit kernel, as the
+	 * kernel is mapped in the linear mapping, that makes no difference.
+	 */
+	dtb_early_va = kernel_mapping_pa_to_va(XIP_FIXUP(dtb_pa));
+#endif
+
+	dtb_early_pa = dtb_pa;
+}
+
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
-	uintptr_t __maybe_unused pa;
 	pmd_t __maybe_unused fix_bmap_spmd, fix_bmap_epmd;
 
 	kernel_map.virt_addr = KERNEL_LINK_ADDR;
@@ -601,40 +637,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	 */
 	create_kernel_page_table(early_pg_dir, true);
 
-#ifndef __PAGETABLE_PMD_FOLDED
-	/* Setup early PMD for DTB */
-	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
-			   (uintptr_t)early_dtb_pmd, PGDIR_SIZE, PAGE_TABLE);
-#ifndef CONFIG_BUILTIN_DTB
-	/* Create two consecutive PMD mappings for FDT early scan */
-	pa = dtb_pa & ~(PMD_SIZE - 1);
-	create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
-			   pa, PMD_SIZE, PAGE_KERNEL);
-	create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
-			   pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
-	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
-#else /* CONFIG_BUILTIN_DTB */
-	/*
-	 * __va can't be used since it would return a linear mapping address
-	 * whereas dtb_early_va will be used before setup_vm_final installs
-	 * the linear mapping.
-	 */
-	dtb_early_va = kernel_mapping_pa_to_va(XIP_FIXUP(dtb_pa));
-#endif /* CONFIG_BUILTIN_DTB */
-#else /* __PAGETABLE_PMD_FOLDED */
-#ifndef CONFIG_BUILTIN_DTB
-	/* Create two consecutive PGD mappings for FDT early scan */
-	pa = dtb_pa & ~(PGDIR_SIZE - 1);
-	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
-			   pa, PGDIR_SIZE, PAGE_KERNEL);
-	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA + PGDIR_SIZE,
-			   pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
-	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
-#else /* CONFIG_BUILTIN_DTB */
-	dtb_early_va = __va(dtb_pa);
-#endif /* CONFIG_BUILTIN_DTB */
-#endif /* __PAGETABLE_PMD_FOLDED */
-	dtb_early_pa = dtb_pa;
+	/* Setup early mapping for FDT early scan */
+	create_fdt_early_page_table(early_pg_dir, dtb_pa);
 
 	/*
 	 * Bootime fixmap only can handle PMD_SIZE mapping. Thus, boot-ioremap
-- 
2.30.2

