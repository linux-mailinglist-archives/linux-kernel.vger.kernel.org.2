Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3126C373332
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 02:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhEEAdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 20:33:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:19824 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231350AbhEEAd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 20:33:29 -0400
IronPort-SDR: qgzZpsqKUKJUcKjrxFrw4D9GUAR/qD/V0hOgTYH0dLQ1vP5nuEjbB4x73YXsnBIFQdgS5OxQGF
 gbv/JMjLihYg==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="196058605"
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="196058605"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 17:32:31 -0700
IronPort-SDR: 9jaRCRcl6okr9+JOD13qox6fKBXSe1YqF3sqPuT8obwPy/HaMHajGCyXLLAOTd5q/UqvUxIxNp
 dKMrvu6eQBvQ==
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="429490833"
Received: from rpedgeco-mobl3.amr.corp.intel.com (HELO localhost.intel.com) ([10.209.26.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 17:32:31 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Cc:     ira.weiny@intel.com, rppt@kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC 9/9] x86, cpa: PKS protect direct map page tables
Date:   Tue,  4 May 2021 17:30:32 -0700
Message-Id: <20210505003032.489164-10-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Protecting direct map page tables is a bit more difficult because a page
table may be needed for a page split as part new setting the PKS
permission the new page table. So in the case of an empty cache of page
tables the page table allocator could get into a situation where it cannot
create any more page tables.

Several solutions were looked at:

1. Break the direct map with pages allocated from the large page being
converted to PKS. This would result in a window where the table could be
written to right before it was linked into the page tables. It also
depends on high order pages being available, and so would regress from
the un-protecteed behavior in that respect.
2. Hold some page tables in reserve to be able to break the large page
for a new 2MB page, but if there are no 2MB page's available we may need
to add a single page to the cache, in which case we would use up the
reserve of page tables needed to break a new page, but not get enough
page tables back to replenish the resereve.
3. Always map the direct map at 4k when protecting page tables so that
pages don't need to be broken to map them with a PKS key. This would have
undesirable performance.

4. Lastly, the strategy employed in this patch, have a separate cache of
page tables just used for the direct map. Early in boot, squirrel away
enough page tables to map the direct map at 4k. This comes with the same
memory overhead of mapping the direct map at 4k, but gets the other
benefits of mapping the direct map as large pages.

Some direct map page tables currently still escape protection, so there
are a few todos. It is a rough sketch of the idea.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/set_memory.h |   2 +
 arch/x86/mm/init.c                |  40 +++++++++
 arch/x86/mm/pat/set_memory.c      | 134 +++++++++++++++++++++++++++++-
 3 files changed, 172 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index b370a20681db..55e2add0452b 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -90,6 +90,8 @@ bool kernel_page_present(struct page *page);
 
 extern int kernel_set_to_readonly;
 
+void add_pks_table(unsigned long addr);
+
 #ifdef CONFIG_X86_64
 /*
  * Prevent speculative access to the page by either unmapping
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index dd694fb93916..09ae02003151 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -26,6 +26,7 @@
 #include <asm/pti.h>
 #include <asm/text-patching.h>
 #include <asm/memtype.h>
+#include <asm/pgalloc.h>
 
 /*
  * We need to define the tracepoints somewhere, and tlb.c
@@ -119,6 +120,8 @@ __ref void *alloc_low_pages(unsigned int num)
 	if (after_bootmem) {
 		unsigned int order;
 
+		WARN_ON(IS_ENABLED(CONFIG_PKS_PG_TABLES));
+		/* TODO: When does this happen, how to deal with the order? */
 		order = get_order((unsigned long)num << PAGE_SHIFT);
 		return (void *)__get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
 	}
@@ -153,6 +156,11 @@ __ref void *alloc_low_pages(unsigned int num)
 		clear_page(adr);
 	}
 
+	printk("Allocing un-protected page table: %lx\n", (unsigned long)__va(pfn << PAGE_SHIFT));
+	/*
+	 * TODO: Save the va of this table to PKS protect post boot, but we need a small allocation
+	 * for the list...
+	 */
 	return __va(pfn << PAGE_SHIFT);
 }
 
@@ -532,6 +540,36 @@ unsigned long __ref init_memory_mapping(unsigned long start,
 	return ret >> PAGE_SHIFT;
 }
 
+/* TODO: Check this math */
+static u64 calc_tables_needed(unsigned int size)
+{
+	unsigned int puds = size >> PUD_SHIFT;
+	unsigned int pmds = size >> PMD_SHIFT;
+	unsigned int needed_to_map_tables = 0; //??
+
+	return puds + pmds + needed_to_map_tables;
+}
+
+static void __init reserve_page_tables(u64 start, u64 end)
+{
+	u64 reserve_size = calc_tables_needed(end - start);
+	u64 reserved = 0;
+	u64 cur;
+	int i;
+
+	while (reserved < reserve_size) {
+		cur = memblock_find_in_range(start, end, HPAGE_SIZE, HPAGE_SIZE);
+		if (!cur) {
+			WARN(1, "Could not reserve HPAGE size page tables");
+			return;
+		}
+		memblock_reserve(cur, HPAGE_SIZE);
+		for (i = 0; i < HPAGE_SIZE; i += PAGE_SIZE)
+			add_pks_table((long unsigned int)__va(cur + i));
+		reserved += HPAGE_SIZE;
+	}
+}
+
 /*
  * We need to iterate through the E820 memory map and create direct mappings
  * for only E820_TYPE_RAM and E820_KERN_RESERVED regions. We cannot simply
@@ -568,6 +606,8 @@ static unsigned long __init init_range_memory_mapping(
 		init_memory_mapping(start, end, PAGE_KERNEL);
 		mapped_ram_size += end - start;
 		can_use_brk_pgt = true;
+		if (IS_ENABLED(CONFIG_PKS_PG_TABLES))
+			reserve_page_tables(start, end);
 	}
 
 	return mapped_ram_size;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 6387499c855d..a5d21a664c98 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -69,6 +69,90 @@ static DEFINE_SPINLOCK(cpa_lock);
 #define CPA_PAGES_ARRAY 4
 #define CPA_NO_CHECK_ALIAS 8 /* Do not search for aliases */
 
+#ifdef CONFIG_PKS_PG_TABLES
+static LLIST_HEAD(tables_cache);
+static LLIST_HEAD(tables_to_covert);
+static bool tables_inited;
+
+struct pks_table_llnode {
+	struct llist_node node;
+	void *table;
+};
+
+static void __add_dmap_table_to_convert(void *table, struct pks_table_llnode *ob)
+{
+	ob->table = table;
+	llist_add(&ob->node, &tables_to_covert);
+}
+
+static void add_dmap_table_to_convert(void *table)
+{
+	struct pks_table_llnode *ob;
+
+	ob = kmalloc(sizeof(*ob), GFP_KERNEL);
+
+	WARN(!ob, "Page table unprotected\n");
+
+	__add_dmap_table_to_convert(table, ob);
+}
+
+void add_pks_table(unsigned long addr)
+{
+	struct llist_node *node = (struct llist_node *)addr;
+
+	enable_pgtable_write();
+	llist_add(node, &tables_cache);
+	disable_pgtable_write();
+}
+
+static void *get_pks_table(void)
+{
+	return llist_del_first(&tables_cache);
+}
+
+static void *_alloc_dmap_table(void)
+{
+	struct page *page = alloc_pages(GFP_KERNEL, 0);
+
+	if (!page)
+		return NULL;
+
+	return page_address(page);
+}
+
+static struct page *alloc_dmap_table(void)
+{
+	void *tablep = get_pks_table();
+
+	/* Fall back to un-protected table is something went wrong */
+	if (!tablep) {
+		if (tables_inited)
+			WARN(1, "Allocating unprotected direct map table\n");
+		tablep = _alloc_dmap_table();
+	}
+
+	if (tablep && !tables_inited)
+		add_dmap_table_to_convert(tablep);
+
+	return virt_to_page(tablep);
+}
+
+static void free_dmap_table(struct page *table)
+{
+	add_pks_table((unsigned long)virt_to_page(table));
+}
+#else /* CONFIG_PKS_PG_TABLES */
+static struct page *alloc_dmap_table(void)
+{
+	return alloc_pages(GFP_KERNEL, 0);
+}
+
+static void free_dmap_table(struct page *table)
+{
+	__free_page(table);
+}
+#endif
+
 static inline pgprot_t cachemode2pgprot(enum page_cache_mode pcm)
 {
 	return __pgprot(cachemode2protval(pcm));
@@ -1068,14 +1152,15 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 
 	if (!debug_pagealloc_enabled())
 		spin_unlock(&cpa_lock);
-	base = alloc_pages(GFP_KERNEL, 0);
+	base = alloc_dmap_table();
+
 	if (!debug_pagealloc_enabled())
 		spin_lock(&cpa_lock);
 	if (!base)
 		return -ENOMEM;
 
 	if (__split_large_page(cpa, kpte, address, base))
-		__free_page(base);
+		free_dmap_table(base);
 
 	return 0;
 }
@@ -1088,7 +1173,7 @@ static bool try_to_free_pte_page(pte_t *pte)
 		if (!pte_none(pte[i]))
 			return false;
 
-	free_page((unsigned long)pte);
+	free_dmap_table(virt_to_page(pte));
 	return true;
 }
 
@@ -1100,7 +1185,7 @@ static bool try_to_free_pmd_page(pmd_t *pmd)
 		if (!pmd_none(pmd[i]))
 			return false;
 
-	free_page((unsigned long)pmd);
+	free_dmap_table(virt_to_page(pmd));
 	return true;
 }
 
@@ -2484,6 +2569,47 @@ void free_grouped_page(struct grouped_page_cache *gpc, struct page *page)
 	list_lru_add_node(&gpc->lru, &page->lru, page_to_nid(page));
 }
 #endif /* !HIGHMEM */
+
+#ifdef CONFIG_PKS_PG_TABLES
+/* PKS protect reserved dmap tables */
+static int __init init_pks_dmap_tables(void)
+{
+	struct pks_table_llnode *cur_entry;
+	static LLIST_HEAD(from_cache);
+	struct pks_table_llnode *tmp;
+	struct llist_node *cur, *next;
+
+	llist_for_each_safe(cur, next, llist_del_all(&tables_cache))
+		llist_add(cur, &from_cache);
+
+	while ((cur = llist_del_first(&from_cache))) {
+		llist_add(cur, &tables_cache);
+
+		tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
+		if (!tmp)
+			goto out_err;
+		tmp->table = cur;
+		llist_add(&tmp->node, &tables_to_covert);
+	}
+
+	tables_inited = true;
+
+	while ((cur = llist_del_first(&tables_to_covert))) {
+		cur_entry = llist_entry(cur, struct pks_table_llnode, node);
+		set_memory_pks((unsigned long)cur_entry->table, 1, STATIC_TABLE_KEY);
+		kfree(cur_entry);
+	}
+
+	return 0;
+out_err:
+	WARN(1, "Unable to protect all page tables\n");
+	llist_add(llist_del_all(&from_cache), &tables_cache);
+	return 0;
+}
+
+device_initcall(init_pks_dmap_tables);
+#endif
+
 /*
  * The testcases use internal knowledge of the implementation that shouldn't
  * be exposed to the rest of the kernel. Include these directly here.
-- 
2.30.2

