Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6B33D3AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 15:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbhGWMXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:23:11 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:64241 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbhGWMXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:23:09 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 5D2F840003;
        Fri, 23 Jul 2021 13:03:38 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 2/5] riscv: Get rid of map_size parameter to create_kernel_page_table
Date:   Fri, 23 Jul 2021 15:01:25 +0200
Message-Id: <20210723130128.47664-3-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210723130128.47664-1-alex@ghiti.fr>
References: <20210723130128.47664-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel must always be mapped using PMD_SIZE, and this is already the
case, this just simplifies create_kernel_page_table.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/init.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 9668867e2702..e35df3e1c9a3 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -501,36 +501,35 @@ static __init pgprot_t pgprot_from_va(uintptr_t va)
 #endif
 
 #ifdef CONFIG_XIP_KERNEL
-static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size,
+static void __init create_kernel_page_table(pgd_t *pgdir,
 					    __always_unused bool early)
 {
 	uintptr_t va, end_va;
 
 	/* Map the flash resident part */
 	end_va = kernel_map.virt_addr + kernel_map.xiprom_sz;
-	for (va = kernel_map.virt_addr; va < end_va; va += map_size)
+	for (va = kernel_map.virt_addr; va < end_va; va += PMD_SIZE)
 		create_pgd_mapping(pgdir, va,
 				   kernel_map.xiprom + (va - kernel_map.virt_addr),
-				   map_size, PAGE_KERNEL_EXEC);
+				   PMD_SIZE, PAGE_KERNEL_EXEC);
 
 	/* Map the data in RAM */
 	end_va = kernel_map.virt_addr + XIP_OFFSET + kernel_map.size;
-	for (va = kernel_map.virt_addr + XIP_OFFSET; va < end_va; va += map_size)
+	for (va = kernel_map.virt_addr + XIP_OFFSET; va < end_va; va += PMD_SIZE)
 		create_pgd_mapping(pgdir, va,
 				   kernel_map.phys_addr + (va - (kernel_map.virt_addr + XIP_OFFSET)),
-				   map_size, PAGE_KERNEL);
+				   PMD_SIZE, PAGE_KERNEL);
 }
 #else
-static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size,
-					    bool early)
+static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
 {
 	uintptr_t va, end_va;
 
 	end_va = kernel_map.virt_addr + kernel_map.size;
-	for (va = kernel_map.virt_addr; va < end_va; va += map_size)
+	for (va = kernel_map.virt_addr; va < end_va; va += PMD_SIZE)
 		create_pgd_mapping(pgdir, va,
 				   kernel_map.phys_addr + (va - kernel_map.virt_addr),
-				   map_size,
+				   PMD_SIZE,
 				   early ?
 					PAGE_KERNEL_EXEC : pgprot_from_va(va));
 }
@@ -539,7 +538,6 @@ static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size,
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
 	uintptr_t __maybe_unused pa;
-	uintptr_t map_size;
 #ifndef __PAGETABLE_PMD_FOLDED
 	pmd_t fix_bmap_spmd, fix_bmap_epmd;
 #endif
@@ -564,15 +562,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 
 	pfn_base = PFN_DOWN(kernel_map.phys_addr);
 
-	/*
-	 * Enforce boot alignment requirements of RV32 and
-	 * RV64 by only allowing PMD or PGD mappings.
-	 */
-	map_size = PMD_SIZE;
-
 	/* Sanity check alignment and size */
 	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
-	BUG_ON((kernel_map.phys_addr % map_size) != 0);
+	BUG_ON((kernel_map.phys_addr % PMD_SIZE) != 0);
 
 	pt_ops.alloc_pte = alloc_pte_early;
 	pt_ops.get_pte_virt = get_pte_virt_early;
@@ -609,7 +601,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	 * us to reach paging_init(). We map all memory banks later
 	 * in setup_vm_final() below.
 	 */
-	create_kernel_page_table(early_pg_dir, map_size, true);
+	create_kernel_page_table(early_pg_dir, true);
 
 #ifndef __PAGETABLE_PMD_FOLDED
 	/* Setup early PMD for DTB */
@@ -725,7 +717,7 @@ static void __init setup_vm_final(void)
 
 #ifdef CONFIG_64BIT
 	/* Map the kernel */
-	create_kernel_page_table(swapper_pg_dir, PMD_SIZE, false);
+	create_kernel_page_table(swapper_pg_dir, false);
 #endif
 
 	/* Clear fixmap PTE and PMD mappings */
-- 
2.30.2

