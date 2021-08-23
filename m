Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1633F4BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbhHWN00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237417AbhHWN0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:26:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32E69613A8;
        Mon, 23 Aug 2021 13:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629725136;
        bh=wHY5asjBvC6i81jr0kWM8yyaRjwrHmkLuVMc5AO0gWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cNGcPddjPG6InnmHiJA0s6eIT5EoD/qa7rkp+qXX8rTWg5oWeIfHZW3rfrDtp06X8
         grNG8saBbacxU3gSjmIiBbkiiLcWSOPZaRtwLxVn71RHgGWTqULQ+HVItvSg5tRtq8
         hHXsJvqCpZ4S7nvl3cdF75iABB5+21MrzYGzss4m5i6zMgs2w589/pTTe6ZiUWdrPJ
         OVRkOtYSZJabd2ae+dvH+NpZGf/yAkQRRtHcg4C1HopCqd1+hX2SvgfewuvmIrq/6K
         5wZ4h+/ZtLGySNVHUcDJm2UhX+s2nNt4SCom6n9R2aPH0PoqtXx7+iEF4evqugE+dr
         +gpiRjuH57o6A==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/4] x86/mm: write protect (most) page tables
Date:   Mon, 23 Aug 2021 16:25:13 +0300
Message-Id: <20210823132513.15836-5-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210823132513.15836-1-rppt@kernel.org>
References: <20210823132513.15836-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Allocate page table using __GFP_PTE_MAPPED so that they will have 4K PTEs
in the direct map. This allows to switch _PAGE_RW bit each time a page
table page needs to be made writable or read-only.

The writability of the page tables is toggled only in the lowest level page
table modifiction functions and immediately switched off.

The page tables created early in the boot (including the direct map page
table) are not write protected.

Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/boot/compressed/ident_map_64.c |  3 ++
 arch/x86/include/asm/pgalloc.h          |  2 +
 arch/x86/include/asm/pgtable.h          | 21 +++++++-
 arch/x86/include/asm/pgtable_64.h       | 33 ++++++++++--
 arch/x86/mm/init.c                      |  2 +-
 arch/x86/mm/pgtable.c                   | 72 +++++++++++++++++++++++--
 include/asm-generic/pgalloc.h           |  2 +-
 7 files changed, 125 insertions(+), 10 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index f7213d0943b8..4f7d17970688 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -349,3 +349,6 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 	 */
 	add_identity_map(address, end);
 }
+
+void enable_pgtable_write(void *p) {}
+void disable_pgtable_write(void *p) {}
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index c7ec5bb88334..a9e2d77697a7 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -6,6 +6,8 @@
 #include <linux/mm.h>		/* for struct page */
 #include <linux/pagemap.h>
 
+#define STATIC_TABLE_KEY	1
+
 #define __HAVE_ARCH_PTE_ALLOC_ONE
 #define __HAVE_ARCH_PGD_FREE
 #include <asm-generic/pgalloc.h>
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01eb3ec..0cc5753983ab 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -117,6 +117,9 @@ extern pmdval_t early_pmd_flags;
 #define arch_end_context_switch(prev)	do {} while(0)
 #endif	/* CONFIG_PARAVIRT_XXL */
 
+void enable_pgtable_write(void *pg_table);
+void disable_pgtable_write(void *pg_table);
+
 /*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
@@ -1073,7 +1076,9 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
 {
+	enable_pgtable_write(ptep);
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
+	disable_pgtable_write(ptep);
 }
 
 #define flush_tlb_fix_spurious_fault(vma, address) do { } while (0)
@@ -1123,7 +1128,9 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pmd_t *pmdp)
 {
+	enable_pgtable_write(pmdp);
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
+	disable_pgtable_write(pmdp);
 }
 
 #define pud_write pud_write
@@ -1138,10 +1145,18 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
 	if (IS_ENABLED(CONFIG_SMP)) {
-		return xchg(pmdp, pmd);
+		pmd_t ret;
+
+		enable_pgtable_write(pmdp);
+		ret = xchg(pmdp, pmd);
+		disable_pgtable_write(pmdp);
+
+		return ret;
 	} else {
 		pmd_t old = *pmdp;
+		enable_pgtable_write(pmdp);
 		WRITE_ONCE(*pmdp, pmd);
+		disable_pgtable_write(pmdp);
 		return old;
 	}
 }
@@ -1224,13 +1239,17 @@ static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
  */
 static inline void clone_pgd_range(pgd_t *dst, pgd_t *src, int count)
 {
+	enable_pgtable_write(dst);
 	memcpy(dst, src, count * sizeof(pgd_t));
+	disable_pgtable_write(dst);
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
 	/* Clone the user space pgd as well */
+	enable_pgtable_write(kernel_to_user_pgdp(dst));
 	memcpy(kernel_to_user_pgdp(dst), kernel_to_user_pgdp(src),
 	       count * sizeof(pgd_t));
+	disable_pgtable_write(kernel_to_user_pgdp(dst));
 #endif
 }
 
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 56d0399a0cd1..5dfcf7dbe6ac 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -64,7 +64,9 @@ void set_pte_vaddr_pud(pud_t *pud_page, unsigned long vaddr, pte_t new_pte);
 
 static inline void native_set_pte(pte_t *ptep, pte_t pte)
 {
+	enable_pgtable_write(ptep);
 	WRITE_ONCE(*ptep, pte);
+	disable_pgtable_write(ptep);
 }
 
 static inline void native_pte_clear(struct mm_struct *mm, unsigned long addr,
@@ -80,7 +82,9 @@ static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
 
 static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
+	enable_pgtable_write(pmdp);
 	WRITE_ONCE(*pmdp, pmd);
+	disable_pgtable_write(pmdp);
 }
 
 static inline void native_pmd_clear(pmd_t *pmd)
@@ -91,7 +95,12 @@ static inline void native_pmd_clear(pmd_t *pmd)
 static inline pte_t native_ptep_get_and_clear(pte_t *xp)
 {
 #ifdef CONFIG_SMP
-	return native_make_pte(xchg(&xp->pte, 0));
+	pteval_t pte_val;
+
+	enable_pgtable_write(xp);
+	pte_val = xchg(&xp->pte, 0);
+	disable_pgtable_write(xp);
+	return native_make_pte(pte_val);
 #else
 	/* native_local_ptep_get_and_clear,
 	   but duplicated because of cyclic dependency */
@@ -104,7 +113,12 @@ static inline pte_t native_ptep_get_and_clear(pte_t *xp)
 static inline pmd_t native_pmdp_get_and_clear(pmd_t *xp)
 {
 #ifdef CONFIG_SMP
-	return native_make_pmd(xchg(&xp->pmd, 0));
+	pteval_t pte_val;
+
+	enable_pgtable_write(xp);
+	pte_val = xchg(&xp->pmd, 0);
+	disable_pgtable_write(xp);
+	return native_make_pmd(pte_val);
 #else
 	/* native_local_pmdp_get_and_clear,
 	   but duplicated because of cyclic dependency */
@@ -116,7 +130,9 @@ static inline pmd_t native_pmdp_get_and_clear(pmd_t *xp)
 
 static inline void native_set_pud(pud_t *pudp, pud_t pud)
 {
+	enable_pgtable_write(pudp);
 	WRITE_ONCE(*pudp, pud);
+	disable_pgtable_write(pudp);
 }
 
 static inline void native_pud_clear(pud_t *pud)
@@ -127,7 +143,12 @@ static inline void native_pud_clear(pud_t *pud)
 static inline pud_t native_pudp_get_and_clear(pud_t *xp)
 {
 #ifdef CONFIG_SMP
-	return native_make_pud(xchg(&xp->pud, 0));
+	pteval_t pte_val;
+
+	enable_pgtable_write(xp);
+	pte_val = xchg(&xp->pud, 0);
+	disable_pgtable_write(xp);
+	return native_make_pud(pte_val);
 #else
 	/* native_local_pudp_get_and_clear,
 	 * but duplicated because of cyclic dependency
@@ -144,13 +165,17 @@ static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 	pgd_t pgd;
 
 	if (pgtable_l5_enabled() || !IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION)) {
+		enable_pgtable_write(p4dp);
 		WRITE_ONCE(*p4dp, p4d);
+		disable_pgtable_write(p4dp);
 		return;
 	}
 
 	pgd = native_make_pgd(native_p4d_val(p4d));
 	pgd = pti_set_user_pgtbl((pgd_t *)p4dp, pgd);
+	enable_pgtable_write(p4dp);
 	WRITE_ONCE(*p4dp, native_make_p4d(native_pgd_val(pgd)));
+	disable_pgtable_write(p4dp);
 }
 
 static inline void native_p4d_clear(p4d_t *p4d)
@@ -160,7 +185,9 @@ static inline void native_p4d_clear(p4d_t *p4d)
 
 static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
+	enable_pgtable_write(pgdp);
 	WRITE_ONCE(*pgdp, pti_set_user_pgtbl(pgdp, pgd));
+	disable_pgtable_write(pgdp);
 }
 
 static inline void native_pgd_clear(pgd_t *pgd)
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 75ef19aa8903..5c7e70e15199 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -120,7 +120,7 @@ __ref void *alloc_low_pages(unsigned int num)
 		unsigned int order;
 
 		order = get_order((unsigned long)num << PAGE_SHIFT);
-		return (void *)__get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
+		return (void *)__get_free_pages(GFP_ATOMIC | __GFP_ZERO | __GFP_PTE_MAPPED, order);
 	}
 
 	if ((pgt_buf_end + num) > pgt_buf_top || !can_use_brk_pgt) {
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3481b35cb4ec..fd6bfa361865 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -2,10 +2,13 @@
 #include <linux/mm.h>
 #include <linux/gfp.h>
 #include <linux/hugetlb.h>
+#include <linux/printk.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/fixmap.h>
 #include <asm/mtrr.h>
+#include <asm/set_memory.h>
+#include "mm_internal.h"
 
 #ifdef CONFIG_DYNAMIC_PHYSICAL_MASK
 phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
@@ -52,6 +55,7 @@ early_param("userpte", setup_userpte);
 
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
+	enable_pgtable_write(page_address(pte));
 	pgtable_pte_page_dtor(pte);
 	paravirt_release_pte(page_to_pfn(pte));
 	paravirt_tlb_remove_table(tlb, pte);
@@ -69,6 +73,7 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #ifdef CONFIG_X86_PAE
 	tlb->need_flush_all = 1;
 #endif
+	enable_pgtable_write(pmd);
 	pgtable_pmd_page_dtor(page);
 	paravirt_tlb_remove_table(tlb, page);
 }
@@ -76,6 +81,7 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #if CONFIG_PGTABLE_LEVELS > 3
 void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 {
+	enable_pgtable_write(pud);
 	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
 	paravirt_tlb_remove_table(tlb, virt_to_page(pud));
 }
@@ -83,6 +89,7 @@ void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
+	enable_pgtable_write(p4d);
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
 	paravirt_tlb_remove_table(tlb, virt_to_page(p4d));
 }
@@ -145,6 +152,7 @@ static void pgd_dtor(pgd_t *pgd)
 	if (SHARED_KERNEL_PMD)
 		return;
 
+	enable_pgtable_write(pgd);
 	spin_lock(&pgd_lock);
 	pgd_list_del(pgd);
 	spin_unlock(&pgd_lock);
@@ -543,9 +551,12 @@ int ptep_test_and_clear_young(struct vm_area_struct *vma,
 {
 	int ret = 0;
 
-	if (pte_young(*ptep))
+	if (pte_young(*ptep)) {
+		enable_pgtable_write(ptep);
 		ret = test_and_clear_bit(_PAGE_BIT_ACCESSED,
 					 (unsigned long *) &ptep->pte);
+		disable_pgtable_write(ptep);
+	}
 
 	return ret;
 }
@@ -556,9 +567,12 @@ int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 {
 	int ret = 0;
 
-	if (pmd_young(*pmdp))
+	if (pmd_young(*pmdp)) {
+		enable_pgtable_write(pmdp);
 		ret = test_and_clear_bit(_PAGE_BIT_ACCESSED,
 					 (unsigned long *)pmdp);
+		disable_pgtable_write(pmdp);
+	}
 
 	return ret;
 }
@@ -567,9 +581,12 @@ int pudp_test_and_clear_young(struct vm_area_struct *vma,
 {
 	int ret = 0;
 
-	if (pud_young(*pudp))
+	if (pud_young(*pudp)) {
+		enable_pgtable_write(pudp);
 		ret = test_and_clear_bit(_PAGE_BIT_ACCESSED,
 					 (unsigned long *)pudp);
+		disable_pgtable_write(pudp);
+	}
 
 	return ret;
 }
@@ -578,6 +595,7 @@ int pudp_test_and_clear_young(struct vm_area_struct *vma,
 int ptep_clear_flush_young(struct vm_area_struct *vma,
 			   unsigned long address, pte_t *ptep)
 {
+	int ret;
 	/*
 	 * On x86 CPUs, clearing the accessed bit without a TLB flush
 	 * doesn't cause data corruption. [ It could cause incorrect
@@ -591,7 +609,10 @@ int ptep_clear_flush_young(struct vm_area_struct *vma,
 	 * shouldn't really matter because there's no real memory
 	 * pressure for swapout to react to. ]
 	 */
-	return ptep_test_and_clear_young(vma, address, ptep);
+	enable_pgtable_write(ptep);
+	ret = ptep_test_and_clear_young(vma, address, ptep);
+	disable_pgtable_write(ptep);
+	return ret;
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -602,7 +623,9 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
+	enable_pgtable_write(pmdp);
 	young = pmdp_test_and_clear_young(vma, address, pmdp);
+	disable_pgtable_write(pmdp);
 	if (young)
 		flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 
@@ -851,6 +874,47 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 	return 1;
 }
 
+static void pgtable_write_set(void *pg_table, bool set)
+{
+	int level = 0;
+	pte_t *pte;
+
+	/*
+	 * Skip the page tables allocated from pgt_buf break area and from
+	 * memblock
+	 */
+	if (!after_bootmem)
+		return;
+	if (!PageTable(virt_to_page(pg_table)))
+		return;
+
+	pte = lookup_address((unsigned long)pg_table, &level);
+	if (!pte || level != PG_LEVEL_4K)
+		return;
+
+	if (set) {
+		if (pte_write(*pte))
+			return;
+
+		WRITE_ONCE(*pte, pte_mkwrite(*pte));
+	} else {
+		if (!pte_write(*pte))
+			return;
+
+		WRITE_ONCE(*pte, pte_wrprotect(*pte));
+	}
+}
+
+void enable_pgtable_write(void *pg_table)
+{
+	pgtable_write_set(pg_table, true);
+}
+
+void disable_pgtable_write(void *pg_table)
+{
+	pgtable_write_set(pg_table, false);
+}
+
 #else /* !CONFIG_X86_64 */
 
 /*
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 02932efad3ab..bc71d529552e 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -4,7 +4,7 @@
 
 #ifdef CONFIG_MMU
 
-#define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
+#define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO | __GFP_PTE_MAPPED)
 #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
 
 /**
-- 
2.28.0

