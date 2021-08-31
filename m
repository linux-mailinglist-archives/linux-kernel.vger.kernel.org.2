Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA0B3FBFC6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 02:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbhHaABG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 20:01:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:50152 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239169AbhHaAAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 20:00:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218381519"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="218381519"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 17:00:00 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="530712827"
Received: from ajinkyak-mobl2.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.240.95])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 17:00:00 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
        shakeelb@google.com, vbabka@suse.cz, rppt@kernel.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 05/19] x86, mm: Use cache of page tables
Date:   Mon, 30 Aug 2021 16:59:13 -0700
Message-Id: <20210830235927.6443-6-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the page table allocation functions defined in pgalloc.h to use
a cache of physically grouped pages. This will let the page tables be set
with PKS permissions later.

For userspace page tables, they are gathered up using mmu gather, and
freed along with other types of pages in swap.c. Move setting/clearing of
the PageTable page flag to the allocators so that swap can know to return
this page to the cache of page tables, and not free it to the page
allocator. Where it currently is, in the ctor/dtors, causes it to be
cleared before the page gets to swap.

Do not set PKS permissions on the page tables, because the page table
setting functions cannot handle it yet. This will be done in later
patches.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/pgalloc.h |  6 ++-
 arch/x86/include/asm/pgtable.h |  6 +++
 arch/x86/mm/pgtable.c          | 79 ++++++++++++++++++++++++++++++++++
 include/asm-generic/pgalloc.h  | 44 ++++++++++++++-----
 include/linux/mm.h             | 11 +++--
 mm/swap.c                      |  6 +++
 mm/swap_state.c                |  5 +++
 7 files changed, 142 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index c7ec5bb88334..1ff308ea76cd 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -7,6 +7,10 @@
 #include <linux/pagemap.h>
 
 #define __HAVE_ARCH_PTE_ALLOC_ONE
+#ifdef CONFIG_PKS_PG_TABLES
+#define __HAVE_ARCH_FREE_TABLE
+#define __HAVE_ARCH_ALLOC_TABLE
+#endif
 #define __HAVE_ARCH_PGD_FREE
 #include <asm-generic/pgalloc.h>
 
@@ -162,7 +166,7 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 		return;
 
 	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
-	free_page((unsigned long)p4d);
+	free_table(virt_to_page(p4d));
 }
 
 extern void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d);
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01eb3ec..3c119ef49062 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -117,6 +117,12 @@ extern pmdval_t early_pmd_flags;
 #define arch_end_context_switch(prev)	do {} while(0)
 #endif	/* CONFIG_PARAVIRT_XXL */
 
+#ifdef CONFIG_PKS_PG_TABLES
+bool pks_tables_inited(void);
+#else /* CONFIG_PKS_PG_TABLES */
+#define pks_tables_inited() 0
+#endif /* CONFIG_PKS_PG_TABLES */
+
 /*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3481b35cb4ec..81b767a5d6ef 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -6,6 +6,8 @@
 #include <asm/tlb.h>
 #include <asm/fixmap.h>
 #include <asm/mtrr.h>
+#include <asm/set_memory.h>
+#include <linux/page-flags.h>
 
 #ifdef CONFIG_DYNAMIC_PHYSICAL_MASK
 phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
@@ -33,6 +35,55 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 	return __pte_alloc_one(mm, __userpte_alloc_gfp);
 }
 
+#ifdef CONFIG_PKS_PG_TABLES
+static struct grouped_page_cache gpc_pks;
+static bool __ro_after_init pks_tables_inited_val;
+
+
+struct page *alloc_table(gfp_t gfp)
+{
+	struct page *table;
+
+	if (!pks_tables_inited()) {
+		table = alloc_page(gfp);
+		if (table)
+			__SetPageTable(table);
+		return table;
+	}
+
+	table = get_grouped_page(numa_node_id(), &gpc_pks);
+	if (!table)
+		return NULL;
+	__SetPageTable(table);
+
+	if (gfp & __GFP_ZERO)
+		memset(page_address(table), 0, PAGE_SIZE);
+
+	if (memcg_kmem_enabled() &&
+	    gfp & __GFP_ACCOUNT &&
+	    !__memcg_kmem_charge_page(table, gfp, 0)) {
+		free_table(table);
+		return NULL;
+	}
+
+	return table;
+}
+
+void free_table(struct page *table_page)
+{
+	__ClearPageTable(table_page);
+
+	if (!pks_tables_inited()) {
+		__free_pages(table_page, 0);
+		return;
+	}
+
+	if (memcg_kmem_enabled() && PageMemcgKmem(table_page))
+		__memcg_kmem_uncharge_page(table_page, 0);
+	free_grouped_page(&gpc_pks, table_page);
+}
+#endif /* CONFIG_PKS_PG_TABLES */
+
 static int __init setup_userpte(char *arg)
 {
 	if (!arg)
@@ -411,12 +462,24 @@ static inline void _pgd_free(pgd_t *pgd)
 
 static inline pgd_t *_pgd_alloc(void)
 {
+	if (pks_tables_inited()) {
+		struct page *page = alloc_table(GFP_PGTABLE_USER);
+
+		if (!page)
+			return NULL;
+		return page_address(page);
+	}
+
 	return (pgd_t *)__get_free_pages(GFP_PGTABLE_USER,
 					 PGD_ALLOCATION_ORDER);
 }
 
 static inline void _pgd_free(pgd_t *pgd)
 {
+	if (pks_tables_inited()) {
+		free_table(virt_to_page(pgd));
+		return;
+	}
 	free_pages((unsigned long)pgd, PGD_ALLOCATION_ORDER);
 }
 #endif /* CONFIG_X86_PAE */
@@ -851,6 +914,22 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 	return 1;
 }
 
+#ifdef CONFIG_PKS_PG_TABLES
+bool pks_tables_inited(void)
+{
+	return pks_tables_inited_val;
+}
+
+static int __init pks_page_init(void)
+{
+	pks_tables_inited_val = !init_grouped_page_cache(&gpc_pks, GFP_KERNEL | PGTABLE_HIGHMEM);
+
+out:
+	return !pks_tables_inited_val;
+}
+
+device_initcall(pks_page_init);
+#endif /* CONFIG_PKS_PG_TABLES */
 #else /* !CONFIG_X86_64 */
 
 /*
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 02932efad3ab..e576c19abc8c 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -2,11 +2,26 @@
 #ifndef __ASM_GENERIC_PGALLOC_H
 #define __ASM_GENERIC_PGALLOC_H
 
+#include <linux/mm.h>
+
 #ifdef CONFIG_MMU
 
 #define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
 #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
 
+#ifndef __HAVE_ARCH_ALLOC_TABLE
+static inline struct page *alloc_table(gfp_t gfp)
+{
+	return alloc_page(gfp);
+}
+#else /* __HAVE_ARCH_ALLOC_TABLE */
+extern struct page *alloc_table(gfp_t gfp);
+#endif /* __HAVE_ARCH_ALLOC_TABLE */
+
+#ifdef __HAVE_ARCH_FREE_TABLE
+extern void free_table(struct page *);
+#endif /* __HAVE_ARCH_FREE_TABLE */
+
 /**
  * __pte_alloc_one_kernel - allocate a page for PTE-level kernel page table
  * @mm: the mm_struct of the current context
@@ -18,7 +33,12 @@
  */
 static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	return (pte_t *)__get_free_page(GFP_PGTABLE_KERNEL);
+	struct page *page = alloc_table(GFP_PGTABLE_KERNEL);
+
+	if (!page)
+		return NULL;
+
+	return (pte_t *)page_address(page);
 }
 
 #ifndef __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
@@ -41,7 +61,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
  */
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	free_page((unsigned long)pte);
+	free_table(virt_to_page(pte));
 }
 
 /**
@@ -60,11 +80,11 @@ static inline pgtable_t __pte_alloc_one(struct mm_struct *mm, gfp_t gfp)
 {
 	struct page *pte;
 
-	pte = alloc_page(gfp);
+	pte = alloc_table(gfp);
 	if (!pte)
 		return NULL;
 	if (!pgtable_pte_page_ctor(pte)) {
-		__free_page(pte);
+		free_table(pte);
 		return NULL;
 	}
 
@@ -99,7 +119,7 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
 {
 	pgtable_pte_page_dtor(pte_page);
-	__free_page(pte_page);
+	free_table(pte_page);
 }
 
 
@@ -123,11 +143,11 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 
 	if (mm == &init_mm)
 		gfp = GFP_PGTABLE_KERNEL;
-	page = alloc_pages(gfp, 0);
+	page = alloc_table(gfp);
 	if (!page)
 		return NULL;
 	if (!pgtable_pmd_page_ctor(page)) {
-		__free_pages(page, 0);
+		free_table(page);
 		return NULL;
 	}
 	return (pmd_t *)page_address(page);
@@ -139,7 +159,7 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
 	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
 	pgtable_pmd_page_dtor(virt_to_page(pmd));
-	free_page((unsigned long)pmd);
+	free_table(virt_to_page(pmd));
 }
 #endif
 
@@ -160,17 +180,21 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	gfp_t gfp = GFP_PGTABLE_USER;
+	struct page *table;
 
 	if (mm == &init_mm)
 		gfp = GFP_PGTABLE_KERNEL;
-	return (pud_t *)get_zeroed_page(gfp);
+	table = alloc_table(gfp);
+	if (!table)
+		return NULL;
+	return (pud_t *)page_address(table);
 }
 #endif
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 {
 	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
-	free_page((unsigned long)pud);
+	free_table(virt_to_page(pud));
 }
 
 #endif /* CONFIG_PGTABLE_LEVELS > 3 */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c13c7af7cad3..ab63d5a201cb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2327,6 +2327,13 @@ static inline bool ptlock_init(struct page *page) { return true; }
 static inline void ptlock_free(struct page *page) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
+#ifndef CONFIG_PKS_PG_TABLES
+static inline void free_table(struct page *table_page)
+{
+	__free_pages(table_page, 0);
+}
+#endif /* CONFIG_PKS_PG_TABLES */
+
 static inline void pgtable_init(void)
 {
 	ptlock_cache_init();
@@ -2337,7 +2344,6 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 {
 	if (!ptlock_init(page))
 		return false;
-	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
 	return true;
 }
@@ -2345,7 +2351,6 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
 	ptlock_free(page);
-	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
 
@@ -2432,7 +2437,6 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
 	if (!pmd_ptlock_init(page))
 		return false;
-	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
 	return true;
 }
@@ -2440,7 +2444,6 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
 	pmd_ptlock_free(page);
-	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index 19600430e536..234bb339ad57 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -37,6 +37,7 @@
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
 #include <linux/buffer_head.h>
+#include <asm/pgalloc.h>
 
 #include "internal.h"
 
@@ -937,6 +938,11 @@ void release_pages(struct page **pages, int nr)
 			continue;
 		}
 
+		if (PageTable(page)) {
+			free_table(page);
+			continue;
+		}
+
 		if (!put_page_testzero(page))
 			continue;
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index c56aa9ac050d..49f267a5f05c 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -22,6 +22,7 @@
 #include <linux/swap_slots.h>
 #include <linux/huge_mm.h>
 #include <linux/shmem_fs.h>
+#include <asm/pgalloc.h>
 #include "internal.h"
 
 /*
@@ -301,6 +302,10 @@ void free_swap_cache(struct page *page)
 void free_page_and_swap_cache(struct page *page)
 {
 	free_swap_cache(page);
+	if (PageTable(page)) {
+		free_table(page);
+		return;
+	}
 	if (!is_huge_zero_page(page))
 		put_page(page);
 }
-- 
2.17.1

