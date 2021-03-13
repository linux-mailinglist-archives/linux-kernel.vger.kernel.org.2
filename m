Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23024339D19
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 09:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhCMIrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 03:47:35 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:36009 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbhCMIrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 03:47:23 -0500
Received: from debian.home (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A4B27200005;
        Sat, 13 Mar 2021 08:47:19 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nylon Chen <nylon7@andestech.com>,
        Nick Hu <nickhu@andestech.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v3 2/2] riscv: Cleanup KASAN_VMALLOC support
Date:   Sat, 13 Mar 2021 03:45:05 -0500
Message-Id: <20210313084505.16132-3-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210313084505.16132-1-alex@ghiti.fr>
References: <20210313084505.16132-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When KASAN vmalloc region is populated, there is no userspace process and
the page table in use is swapper_pg_dir, so there is no need to read
SATP. Then we can use the same scheme used by kasan_populate_p*d
functions to go through the page table, which harmonizes the code.

In addition, make use of set_pgd that goes through all unused page table
levels, contrary to p*d_populate functions, which makes this function work
whatever the number of page table levels.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/mm/kasan_init.c | 59 ++++++++++++--------------------------
 1 file changed, 18 insertions(+), 41 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 57bf4ae09361..c16178918239 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -11,18 +11,6 @@
 #include <asm/fixmap.h>
 #include <asm/pgalloc.h>
 
-static __init void *early_alloc(size_t size, int node)
-{
-	void *ptr = memblock_alloc_try_nid(size, size,
-		__pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, node);
-
-	if (!ptr)
-		panic("%pS: Failed to allocate %zu bytes align=%zx nid=%d from=%llx\n",
-			__func__, size, size, node, (u64)__pa(MAX_DMA_ADDRESS));
-
-	return ptr;
-}
-
 extern pgd_t early_pg_dir[PTRS_PER_PGD];
 asmlinkage void __init kasan_early_init(void)
 {
@@ -155,38 +143,27 @@ static void __init kasan_populate(void *start, void *end)
 	memset(start, KASAN_SHADOW_INIT, end - start);
 }
 
-void __init kasan_shallow_populate(void *start, void *end)
+static void __init kasan_shallow_populate_pgd(unsigned long vaddr, unsigned long end)
 {
-	unsigned long vaddr = (unsigned long)start & PAGE_MASK;
-	unsigned long vend = PAGE_ALIGN((unsigned long)end);
-	unsigned long pfn;
-	int index;
+	unsigned long next;
 	void *p;
-	pud_t *pud_dir, *pud_k;
-	pgd_t *pgd_dir, *pgd_k;
-	p4d_t *p4d_dir, *p4d_k;
-
-	while (vaddr < vend) {
-		index = pgd_index(vaddr);
-		pfn = csr_read(CSR_SATP) & SATP_PPN;
-		pgd_dir = (pgd_t *)pfn_to_virt(pfn) + index;
-		pgd_k = init_mm.pgd + index;
-		pgd_dir = pgd_offset_k(vaddr);
-		set_pgd(pgd_dir, *pgd_k);
-
-		p4d_dir = p4d_offset(pgd_dir, vaddr);
-		p4d_k  = p4d_offset(pgd_k, vaddr);
-
-		vaddr = (vaddr + PUD_SIZE) & PUD_MASK;
-		pud_dir = pud_offset(p4d_dir, vaddr);
-		pud_k = pud_offset(p4d_k, vaddr);
-
-		if (pud_present(*pud_dir)) {
-			p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
-			pud_populate(&init_mm, pud_dir, p);
+	pgd_t *pgd_k = pgd_offset_k(vaddr);
+
+	do {
+		next = pgd_addr_end(vaddr, end);
+		if (pgd_page_vaddr(*pgd_k) == (unsigned long)lm_alias(kasan_early_shadow_pmd)) {
+			p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+			set_pgd(pgd_k, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TABLE));
 		}
-		vaddr += PAGE_SIZE;
-	}
+	} while (pgd_k++, vaddr = next, vaddr != end);
+}
+
+static void __init kasan_shallow_populate(void *start, void *end)
+{
+	unsigned long vaddr = (unsigned long)start & PAGE_MASK;
+	unsigned long vend = PAGE_ALIGN((unsigned long)end);
+
+	kasan_shallow_populate_pgd(vaddr, vend);
 
 	local_flush_tlb_all();
 }
-- 
2.20.1

