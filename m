Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE7B30A2F2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhBAIBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 03:01:17 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:36847 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhBAIBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:01:15 -0500
X-Originating-IP: 82.65.183.113
Received: from debian.internal.upmem.com (82-65-183-113.subs.proxad.net [82.65.183.113])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 481CE2000E;
        Mon,  1 Feb 2021 08:00:26 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, kasan-dev@googlegroups.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] riscv: Improve kasan population by using hugepages when possible
Date:   Mon,  1 Feb 2021 03:00:24 -0500
Message-Id: <20210201080024.844-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kasan function that populates the shadow regions used to allocate them
page by page and did not take advantage of hugepages, so fix this by
trying to allocate hugepages of 1GB and fallback to 2MB hugepages or 4K
pages in case it fails.

This reduces the page table memory consumption and improves TLB usage,
as shown below:

Before this patch:

---[ Kasan shadow start ]---
0xffffffc000000000-0xffffffc400000000    0x00000000818ef000        16G PTE     . A . . . . R V
0xffffffc400000000-0xffffffc447fc0000    0x00000002b7f4f000   1179392K PTE     D A . . . W R V
0xffffffc480000000-0xffffffc800000000    0x00000000818ef000        14G PTE     . A . . . . R V
---[ Kasan shadow end ]---

After this patch:

---[ Kasan shadow start ]---
0xffffffc000000000-0xffffffc400000000    0x00000000818ef000        16G PTE     . A . . . . R V
0xffffffc400000000-0xffffffc440000000    0x0000000240000000         1G PGD     D A . . . W R V
0xffffffc440000000-0xffffffc447e00000    0x00000002b7e00000       126M PMD     D A . . . W R V
0xffffffc447e00000-0xffffffc447fc0000    0x00000002b818f000      1792K PTE     D A . . . W R V
0xffffffc480000000-0xffffffc800000000    0x00000000818ef000        14G PTE     . A . . . . R V
---[ Kasan shadow end ]---

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/kasan_init.c | 101 +++++++++++++++++++++++++++----------
 1 file changed, 73 insertions(+), 28 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index a8a2ffd9114a..8f11b73018b1 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -47,37 +47,82 @@ asmlinkage void __init kasan_early_init(void)
 	local_flush_tlb_all();
 }
 
-static void __init populate(void *start, void *end)
+static void kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned long end)
+{
+	phys_addr_t phys_addr;
+	pte_t *ptep = memblock_alloc(PTRS_PER_PTE * sizeof(pte_t), PAGE_SIZE);
+
+	do {
+		phys_addr = memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
+		set_pte(ptep, pfn_pte(PFN_DOWN(phys_addr), PAGE_KERNEL));
+	} while (ptep++, vaddr += PAGE_SIZE, vaddr != end);
+
+	set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa(ptep)), PAGE_TABLE));
+}
+
+static void kasan_populate_pmd(pgd_t *pgd, unsigned long vaddr, unsigned long end)
+{
+	phys_addr_t phys_addr;
+	pmd_t *pmdp = memblock_alloc(PTRS_PER_PMD * sizeof(pmd_t), PAGE_SIZE);
+	unsigned long next;
+
+	do {
+		next = pmd_addr_end(vaddr, end);
+
+		if (IS_ALIGNED(vaddr, PMD_SIZE) && (next - vaddr) >= PMD_SIZE) {
+			phys_addr = memblock_phys_alloc(PMD_SIZE, PMD_SIZE);
+			if (phys_addr) {
+				set_pmd(pmdp, pfn_pmd(PFN_DOWN(phys_addr), PAGE_KERNEL));
+				continue;
+			}
+		}
+
+		kasan_populate_pte(pmdp, vaddr, end);
+	} while (pmdp++, vaddr = next, vaddr != end);
+
+	/*
+	 * Wait for the whole PGD to be populated before setting the PGD in
+	 * the page table, otherwise, if we did set the PGD before populating
+	 * it entirely, memblock could allocate a page at a physical address
+	 * where KASAN is not populated yet and then we'd get a page fault.
+	 */
+	set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(pmdp)), PAGE_TABLE));
+}
+
+static void kasan_populate_pgd(unsigned long vaddr, unsigned long end)
+{
+	phys_addr_t phys_addr;
+	pgd_t *pgdp = pgd_offset_k(vaddr);
+	unsigned long next;
+
+	do {
+		next = pgd_addr_end(vaddr, end);
+
+		if (IS_ALIGNED(vaddr, PGDIR_SIZE) && (next - vaddr) >= PGDIR_SIZE) {
+			phys_addr = memblock_phys_alloc(PGDIR_SIZE, PGDIR_SIZE);
+			if (phys_addr) {
+				set_pgd(pgdp, pfn_pgd(PFN_DOWN(phys_addr), PAGE_KERNEL));
+				continue;
+			}
+		}
+
+		kasan_populate_pmd(pgdp, vaddr, end);
+	} while (pgdp++, vaddr = next, vaddr != end);
+}
+
+/*
+ * This function populates KASAN shadow region focusing on hugepages in
+ * order to minimize the page table cost and TLB usage too.
+ * Note that start must be PGDIR_SIZE-aligned in SV39 which amounts to be
+ * 1G aligned (that represents a 8G alignment constraint on virtual address
+ * ranges because of KASAN_SHADOW_SCALE_SHIFT).
+ */
+static void __init kasan_populate(void *start, void *end)
 {
-	unsigned long i, offset;
 	unsigned long vaddr = (unsigned long)start & PAGE_MASK;
 	unsigned long vend = PAGE_ALIGN((unsigned long)end);
-	unsigned long n_pages = (vend - vaddr) / PAGE_SIZE;
-	unsigned long n_ptes =
-	    ((n_pages + PTRS_PER_PTE) & -PTRS_PER_PTE) / PTRS_PER_PTE;
-	unsigned long n_pmds =
-	    ((n_ptes + PTRS_PER_PMD) & -PTRS_PER_PMD) / PTRS_PER_PMD;
-
-	pte_t *pte =
-	    memblock_alloc(n_ptes * PTRS_PER_PTE * sizeof(pte_t), PAGE_SIZE);
-	pmd_t *pmd =
-	    memblock_alloc(n_pmds * PTRS_PER_PMD * sizeof(pmd_t), PAGE_SIZE);
-	pgd_t *pgd = pgd_offset_k(vaddr);
-
-	for (i = 0; i < n_pages; i++) {
-		phys_addr_t phys = memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
-		set_pte(&pte[i], pfn_pte(PHYS_PFN(phys), PAGE_KERNEL));
-	}
-
-	for (i = 0, offset = 0; i < n_ptes; i++, offset += PTRS_PER_PTE)
-		set_pmd(&pmd[i],
-			pfn_pmd(PFN_DOWN(__pa(&pte[offset])),
-				__pgprot(_PAGE_TABLE)));
 
-	for (i = 0, offset = 0; i < n_pmds; i++, offset += PTRS_PER_PMD)
-		set_pgd(&pgd[i],
-			pfn_pgd(PFN_DOWN(__pa(&pmd[offset])),
-				__pgprot(_PAGE_TABLE)));
+	kasan_populate_pgd(vaddr, vend);
 
 	local_flush_tlb_all();
 	memset(start, 0, end - start);
@@ -99,7 +144,7 @@ void __init kasan_init(void)
 		if (start >= end)
 			break;
 
-		populate(kasan_mem_to_shadow(start), kasan_mem_to_shadow(end));
+		kasan_populate(kasan_mem_to_shadow(start), kasan_mem_to_shadow(end));
 	};
 
 	for (i = 0; i < PTRS_PER_PTE; i++)
-- 
2.20.1

