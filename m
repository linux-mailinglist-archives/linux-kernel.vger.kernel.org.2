Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6243F0DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbhHRWNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 18:13:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:44025 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234106AbhHRWND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 18:13:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="213318029"
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="213318029"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 15:12:28 -0700
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="531870684"
Received: from dballa1x-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.156.71])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 15:12:28 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, peterz@infradead.org, luto@kernel.org,
        dave.hansen@linux.intel.com
Cc:     rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
        wency@cn.fujitsu.com
Subject: [PATCH] x86/mm: Flush before free in remove_pagetable()
Date:   Wed, 18 Aug 2021 15:10:26 -0700
Message-Id: <20210818221026.10794-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In remove_pagetable(), page tables may be freed before the TLB is
flushed. The upper page tables are zapped before freeing the lower
levels. However, without the flush the lower tables can still remain in
paging-structure caches and so data that is written to the re-allocated
page can control these mappings. For some reason there is only a flush
lower down in remove_pte_table(), however, this will not be hit in the
case of large pages on the direct map which is common.

Currently remove_pagetable() is called from a few places in the
hot unplug codepath and memremap unmapping operations.

To properly tear down these mappings, gather the page tables using a
simple linked list based in the table's struct page. Then flush the TLB
before actually freeing the pages.

Cc: stable@vger.kernel.org
Fixes: ae9aae9eda2d ("memory-hotplug: common APIs to support page tables hot-remove")
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

This wasn't observed causing any functional problem in normal runtime. AFAICT it
can't be triggered from unprivileged userspace.

 arch/x86/mm/init_64.c | 60 ++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ddeaba947eb3..3c0323ad99da 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -992,6 +992,23 @@ static void __meminit free_pagetable(struct page *page, int order)
 		free_pages((unsigned long)page_address(page), order);
 }
 
+static void __meminit gather_table(struct page *page, struct list_head *tables)
+{
+	list_add(&page->lru, tables);
+}
+
+static void __meminit gather_table_finish(struct list_head *tables)
+{
+	struct page *page, *next;
+
+	flush_tlb_all();
+
+	list_for_each_entry_safe(page, next, tables, lru) {
+		list_del(&page->lru);
+		free_pagetable(page, 0);
+	}
+}
+
 static void __meminit free_hugepage_table(struct page *page,
 		struct vmem_altmap *altmap)
 {
@@ -1001,7 +1018,7 @@ static void __meminit free_hugepage_table(struct page *page,
 		free_pagetable(page, get_order(PMD_SIZE));
 }
 
-static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
+static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd, struct list_head *tables)
 {
 	pte_t *pte;
 	int i;
@@ -1012,14 +1029,14 @@ static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
 			return;
 	}
 
-	/* free a pte talbe */
-	free_pagetable(pmd_page(*pmd), 0);
+	/* gather a pte table */
+	gather_table(pmd_page(*pmd), tables);
 	spin_lock(&init_mm.page_table_lock);
 	pmd_clear(pmd);
 	spin_unlock(&init_mm.page_table_lock);
 }
 
-static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
+static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud, struct list_head *tables)
 {
 	pmd_t *pmd;
 	int i;
@@ -1030,14 +1047,14 @@ static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
 			return;
 	}
 
-	/* free a pmd talbe */
-	free_pagetable(pud_page(*pud), 0);
+	/* gather a pmd table */
+	gather_table(pud_page(*pud), tables);
 	spin_lock(&init_mm.page_table_lock);
 	pud_clear(pud);
 	spin_unlock(&init_mm.page_table_lock);
 }
 
-static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
+static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d, struct list_head *tables)
 {
 	pud_t *pud;
 	int i;
@@ -1048,8 +1065,8 @@ static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
 			return;
 	}
 
-	/* free a pud talbe */
-	free_pagetable(p4d_page(*p4d), 0);
+	/* gather a pud table */
+	gather_table(p4d_page(*p4d), tables);
 	spin_lock(&init_mm.page_table_lock);
 	p4d_clear(p4d);
 	spin_unlock(&init_mm.page_table_lock);
@@ -1057,7 +1074,7 @@ static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
 
 static void __meminit
 remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
-		 bool direct)
+		 bool direct, struct list_head *tables)
 {
 	unsigned long next, pages = 0;
 	pte_t *pte;
@@ -1100,7 +1117,7 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
 
 static void __meminit
 remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
-		 bool direct, struct vmem_altmap *altmap)
+		 bool direct, struct vmem_altmap *altmap, struct list_head *tables)
 {
 	unsigned long next, pages = 0;
 	pte_t *pte_base;
@@ -1138,8 +1155,8 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
 		}
 
 		pte_base = (pte_t *)pmd_page_vaddr(*pmd);
-		remove_pte_table(pte_base, addr, next, direct);
-		free_pte_table(pte_base, pmd);
+		remove_pte_table(pte_base, addr, next, direct, tables);
+		free_pte_table(pte_base, pmd, tables);
 	}
 
 	/* Call free_pmd_table() in remove_pud_table(). */
@@ -1149,7 +1166,7 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
 
 static void __meminit
 remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
-		 struct vmem_altmap *altmap, bool direct)
+		 struct vmem_altmap *altmap, bool direct, struct list_head *tables)
 {
 	unsigned long next, pages = 0;
 	pmd_t *pmd_base;
@@ -1173,8 +1190,8 @@ remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
 		}
 
 		pmd_base = pmd_offset(pud, 0);
-		remove_pmd_table(pmd_base, addr, next, direct, altmap);
-		free_pmd_table(pmd_base, pud);
+		remove_pmd_table(pmd_base, addr, next, direct, altmap, tables);
+		free_pmd_table(pmd_base, pud, tables);
 	}
 
 	if (direct)
@@ -1183,7 +1200,7 @@ remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
 
 static void __meminit
 remove_p4d_table(p4d_t *p4d_start, unsigned long addr, unsigned long end,
-		 struct vmem_altmap *altmap, bool direct)
+		 struct vmem_altmap *altmap, bool direct, struct list_head *tables)
 {
 	unsigned long next, pages = 0;
 	pud_t *pud_base;
@@ -1199,14 +1216,14 @@ remove_p4d_table(p4d_t *p4d_start, unsigned long addr, unsigned long end,
 		BUILD_BUG_ON(p4d_large(*p4d));
 
 		pud_base = pud_offset(p4d, 0);
-		remove_pud_table(pud_base, addr, next, altmap, direct);
+		remove_pud_table(pud_base, addr, next, altmap, direct, tables);
 		/*
 		 * For 4-level page tables we do not want to free PUDs, but in the
 		 * 5-level case we should free them. This code will have to change
 		 * to adapt for boot-time switching between 4 and 5 level page tables.
 		 */
 		if (pgtable_l5_enabled())
-			free_pud_table(pud_base, p4d);
+			free_pud_table(pud_base, p4d, tables);
 	}
 
 	if (direct)
@@ -1220,6 +1237,7 @@ remove_pagetable(unsigned long start, unsigned long end, bool direct,
 {
 	unsigned long next;
 	unsigned long addr;
+	LIST_HEAD(tables);
 	pgd_t *pgd;
 	p4d_t *p4d;
 
@@ -1231,10 +1249,10 @@ remove_pagetable(unsigned long start, unsigned long end, bool direct,
 			continue;
 
 		p4d = p4d_offset(pgd, 0);
-		remove_p4d_table(p4d, addr, next, altmap, direct);
+		remove_p4d_table(p4d, addr, next, altmap, direct, &tables);
 	}
 
-	flush_tlb_all();
+	gather_table_finish(&tables);
 }
 
 void __ref vmemmap_free(unsigned long start, unsigned long end,
-- 
2.17.1

