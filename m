Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF89320AF3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 15:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBUOXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 09:23:22 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:49589 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhBUOXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 09:23:20 -0500
X-Originating-IP: 2.7.49.219
Received: from debian.home (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C6A621BF207;
        Sun, 21 Feb 2021 14:22:34 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] riscv: Get rid of MAX_EARLY_MAPPING_SIZE
Date:   Sun, 21 Feb 2021 09:22:33 -0500
Message-Id: <20210221142233.3661-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At early boot stage, we have a whole PGDIR to map the kernel, so there
is no need to restrict the early mapping size to 128MB. Removing this
define also allows us to simplify some compile time logic.

This fixes large kernel mappings with a size greater than 128MB, as it
is the case for syzbot kernels whose size was just ~130MB.

Note that on rv64, for now, we are then limited to PGDIR size for early
mapping as we can't use PGD mappings (see [1]). That should be enough
given the relative small size of syzbot kernels compared to PGDIR_SIZE
which is 1GB.

[1] https://lore.kernel.org/lkml/20200603153608.30056-1-alex@ghiti.fr/

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/init.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f9f9568d689e..f81f813b9603 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -226,8 +226,6 @@ pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
 
-#define MAX_EARLY_MAPPING_SIZE	SZ_128M
-
 pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 
 void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
@@ -302,13 +300,7 @@ static void __init create_pte_mapping(pte_t *ptep,
 
 pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
 pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
-
-#if MAX_EARLY_MAPPING_SIZE < PGDIR_SIZE
-#define NUM_EARLY_PMDS		1UL
-#else
-#define NUM_EARLY_PMDS		(1UL + MAX_EARLY_MAPPING_SIZE / PGDIR_SIZE)
-#endif
-pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
+pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
 static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
@@ -330,11 +322,9 @@ static pmd_t *get_pmd_virt_late(phys_addr_t pa)
 
 static phys_addr_t __init alloc_pmd_early(uintptr_t va)
 {
-	uintptr_t pmd_num;
+	BUG_ON((va - PAGE_OFFSET) >> PGDIR_SHIFT);
 
-	pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
-	BUG_ON(pmd_num >= NUM_EARLY_PMDS);
-	return (uintptr_t)&early_pmd[pmd_num * PTRS_PER_PMD];
+	return (uintptr_t)early_pmd;
 }
 
 static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
@@ -452,7 +442,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	uintptr_t va, pa, end_va;
 	uintptr_t load_pa = (uintptr_t)(&_start);
 	uintptr_t load_sz = (uintptr_t)(&_end) - load_pa;
-	uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
+	uintptr_t map_size;
 #ifndef __PAGETABLE_PMD_FOLDED
 	pmd_t fix_bmap_spmd, fix_bmap_epmd;
 #endif
@@ -464,12 +454,11 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	 * Enforce boot alignment requirements of RV32 and
 	 * RV64 by only allowing PMD or PGD mappings.
 	 */
-	BUG_ON(map_size == PAGE_SIZE);
+	map_size = PMD_SIZE;
 
 	/* Sanity check alignment and size */
 	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
 	BUG_ON((load_pa % map_size) != 0);
-	BUG_ON(load_sz > MAX_EARLY_MAPPING_SIZE);
 
 	pt_ops.alloc_pte = alloc_pte_early;
 	pt_ops.get_pte_virt = get_pte_virt_early;
-- 
2.20.1

