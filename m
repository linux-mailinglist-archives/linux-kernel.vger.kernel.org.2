Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EB53C6BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhGMIDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234503AbhGMIDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:03:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 283B261279;
        Tue, 13 Jul 2021 08:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626163244;
        bh=hoC1Z6JF56R7sDVOpfCHqvdYQX1isHwRan2uZwB/kMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9P1JZ7qW0hRJdjuiKf7Wo6vWBufemhnUg2ieIhpBvvVY3iP62OKzteTjRTHYzNL+
         T6G0ZG40zX2Zx8uXDomvzl1By4XMihz4hzogtgKwimdT249av7tm4hrNoadolwCtA2
         zkrIKqBsz8f2oRzbbYrFPCrVAItMCSgU+OT+xDL5u2v+WUob1yvemNynTwie1eOObg
         DUqY3/BAo2kn5nUtUMO9dCcibmXPDTFk2oRvLtSWFWroAQi/Ax4q0CzQrD4LiS/mbD
         WyiSxgzrUyEkuHFcerCwpd+isJ0J3CV/eiXfpk88X0UP4rKPPOpGyiH3Z555/vwBUI
         idM7RBp753xag==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/2] mm: remove pfn_valid_within() and CONFIG_HOLES_IN_ZONE
Date:   Tue, 13 Jul 2021 11:00:34 +0300
Message-Id: <20210713080035.7464-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210713080035.7464-1-rppt@kernel.org>
References: <20210713080035.7464-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

After recent changes in freeing of the unused parts of the memory map and
rework of pfn_valid() in arm and arm64 there are no architectures that can
have holes in the memory map within a pageblock and so nothing can enable
CONFIG_HOLES_IN_ZONE which guards non trivial implementation of
pfn_valid_within().

With that, pfn_valid_within() is always hardwired to 1 and can be
completely removed.

Remove calls to pfn_valid_within() and CONFIG_HOLES_IN_ZONE.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 drivers/base/node.c    |  2 --
 include/linux/mmzone.h | 12 ------------
 mm/Kconfig             |  3 ---
 mm/compaction.c        | 20 +++++++-------------
 mm/memory_hotplug.c    |  4 ----
 mm/page_alloc.c        | 24 ++----------------------
 mm/page_isolation.c    |  7 +------
 mm/page_owner.c        | 14 +-------------
 8 files changed, 11 insertions(+), 75 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 4a4ae868ad9f..8ec6b7dfbb0f 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -768,8 +768,6 @@ int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
 static int __ref get_nid_for_pfn(unsigned long pfn)
 {
-	if (!pfn_valid_within(pfn))
-		return -1;
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 	if (system_state < SYSTEM_RUNNING)
 		return early_pfn_to_nid(pfn);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fcb535560028..ee3a86830519 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1525,18 +1525,6 @@ void sparse_init(void);
 #define subsection_map_init(_pfn, _nr_pages) do {} while (0)
 #endif /* CONFIG_SPARSEMEM */
 
-/*
- * If it is possible to have holes within a MAX_ORDER_NR_PAGES, then we
- * need to check pfn validity within that MAX_ORDER_NR_PAGES block.
- * pfn_valid_within() should be used in this case; we optimise this away
- * when we have no holes within a MAX_ORDER_NR_PAGES block.
- */
-#ifdef CONFIG_HOLES_IN_ZONE
-#define pfn_valid_within(pfn) pfn_valid(pfn)
-#else
-#define pfn_valid_within(pfn) (1)
-#endif
-
 #endif /* !__GENERATING_BOUNDS.H */
 #endif /* !__ASSEMBLY__ */
 #endif /* _LINUX_MMZONE_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 40a9bfcd5062..14d5d2837737 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -96,9 +96,6 @@ config HAVE_FAST_GUP
 	depends on MMU
 	bool
 
-config HOLES_IN_ZONE
-	bool
-
 # Don't discard allocated memory used to track "memory" and "reserved" memblocks
 # after early boot, so it can still be used to test for validity of memory.
 # Also, memblocks are updated with memory hot(un)plug.
diff --git a/mm/compaction.c b/mm/compaction.c
index 621508e0ecd5..ed37e1cb4369 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -306,16 +306,14 @@ __reset_isolation_pfn(struct zone *zone, unsigned long pfn, bool check_source,
 	 * is necessary for the block to be a migration source/target.
 	 */
 	do {
-		if (pfn_valid_within(pfn)) {
-			if (check_source && PageLRU(page)) {
-				clear_pageblock_skip(page);
-				return true;
-			}
+		if (check_source && PageLRU(page)) {
+			clear_pageblock_skip(page);
+			return true;
+		}
 
-			if (check_target && PageBuddy(page)) {
-				clear_pageblock_skip(page);
-				return true;
-			}
+		if (check_target && PageBuddy(page)) {
+			clear_pageblock_skip(page);
+			return true;
 		}
 
 		page += (1 << PAGE_ALLOC_COSTLY_ORDER);
@@ -585,8 +583,6 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 			break;
 
 		nr_scanned++;
-		if (!pfn_valid_within(blockpfn))
-			goto isolate_fail;
 
 		/*
 		 * For compound pages such as THP and hugetlbfs, we can save
@@ -885,8 +881,6 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			cond_resched();
 		}
 
-		if (!pfn_valid_within(low_pfn))
-			goto isolate_fail;
 		nr_scanned++;
 
 		page = pfn_to_page(low_pfn);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8cb75b26ea4f..1085bd03ecba 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1308,10 +1308,6 @@ struct zone *test_pages_in_a_zone(unsigned long start_pfn,
 		for (; pfn < sec_end_pfn && pfn < end_pfn;
 		     pfn += MAX_ORDER_NR_PAGES) {
 			i = 0;
-			/* This is just a CONFIG_HOLES_IN_ZONE check.*/
-			while ((i < MAX_ORDER_NR_PAGES) &&
-				!pfn_valid_within(pfn + i))
-				i++;
 			if (i == MAX_ORDER_NR_PAGES || pfn + i >= end_pfn)
 				continue;
 			/* Check if we got outside of the zone */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3b97e17806be..5bd37d49da79 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -594,8 +594,6 @@ static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 
 static int page_is_consistent(struct zone *zone, struct page *page)
 {
-	if (!pfn_valid_within(page_to_pfn(page)))
-		return 0;
 	if (zone != page_zone(page))
 		return 0;
 
@@ -1022,16 +1020,12 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
 	if (order >= MAX_ORDER - 2)
 		return false;
 
-	if (!pfn_valid_within(buddy_pfn))
-		return false;
-
 	combined_pfn = buddy_pfn & pfn;
 	higher_page = page + (combined_pfn - pfn);
 	buddy_pfn = __find_buddy_pfn(combined_pfn, order + 1);
 	higher_buddy = higher_page + (buddy_pfn - combined_pfn);
 
-	return pfn_valid_within(buddy_pfn) &&
-	       page_is_buddy(higher_page, higher_buddy, order + 1);
+	return page_is_buddy(higher_page, higher_buddy, order + 1);
 }
 
 /*
@@ -1092,8 +1086,6 @@ static inline void __free_one_page(struct page *page,
 		buddy_pfn = __find_buddy_pfn(pfn, order);
 		buddy = page + (buddy_pfn - pfn);
 
-		if (!pfn_valid_within(buddy_pfn))
-			goto done_merging;
 		if (!page_is_buddy(page, buddy, order))
 			goto done_merging;
 		/*
@@ -1751,9 +1743,7 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 /*
  * Check that the whole (or subset of) a pageblock given by the interval of
  * [start_pfn, end_pfn) is valid and within the same zone, before scanning it
- * with the migration of free compaction scanner. The scanners then need to
- * use only pfn_valid_within() check for arches that allow holes within
- * pageblocks.
+ * with the migration of free compaction scanner.
  *
  * Return struct page pointer of start_pfn, or NULL if checks were not passed.
  *
@@ -1869,8 +1859,6 @@ static inline void __init pgdat_init_report_one_done(void)
  */
 static inline bool __init deferred_pfn_valid(unsigned long pfn)
 {
-	if (!pfn_valid_within(pfn))
-		return false;
 	if (!(pfn & (pageblock_nr_pages - 1)) && !pfn_valid(pfn))
 		return false;
 	return true;
@@ -2517,11 +2505,6 @@ static int move_freepages(struct zone *zone,
 	int pages_moved = 0;
 
 	for (pfn = start_pfn; pfn <= end_pfn;) {
-		if (!pfn_valid_within(pfn)) {
-			pfn++;
-			continue;
-		}
-
 		page = pfn_to_page(pfn);
 		if (!PageBuddy(page)) {
 			/*
@@ -8798,9 +8781,6 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 	}
 
 	for (; iter < pageblock_nr_pages - offset; iter++) {
-		if (!pfn_valid_within(pfn + iter))
-			continue;
-
 		page = pfn_to_page(pfn + iter);
 
 		/*
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index bddf788f45bf..471e3a13b541 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -93,8 +93,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
 			buddy_pfn = __find_buddy_pfn(pfn, order);
 			buddy = page + (buddy_pfn - pfn);
 
-			if (pfn_valid_within(buddy_pfn) &&
-			    !is_migrate_isolate_page(buddy)) {
+			if (!is_migrate_isolate_page(buddy)) {
 				__isolate_free_page(page, order);
 				isolated_page = true;
 			}
@@ -250,10 +249,6 @@ __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
 	struct page *page;
 
 	while (pfn < end_pfn) {
-		if (!pfn_valid_within(pfn)) {
-			pfn++;
-			continue;
-		}
 		page = pfn_to_page(pfn);
 		if (PageBuddy(page))
 			/*
diff --git a/mm/page_owner.c b/mm/page_owner.c
index f51a57e92aa3..62402d22539b 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -276,9 +276,6 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 		pageblock_mt = get_pageblock_migratetype(page);
 
 		for (; pfn < block_end_pfn; pfn++) {
-			if (!pfn_valid_within(pfn))
-				continue;
-
 			/* The pageblock is online, no need to recheck. */
 			page = pfn_to_page(pfn);
 
@@ -479,10 +476,6 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			continue;
 		}
 
-		/* Check for holes within a MAX_ORDER area */
-		if (!pfn_valid_within(pfn))
-			continue;
-
 		page = pfn_to_page(pfn);
 		if (PageBuddy(page)) {
 			unsigned long freepage_order = buddy_order_unsafe(page);
@@ -560,14 +553,9 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
 		block_end_pfn = min(block_end_pfn, end_pfn);
 
 		for (; pfn < block_end_pfn; pfn++) {
-			struct page *page;
+			struct page *page = pfn_to_page(pfn);
 			struct page_ext *page_ext;
 
-			if (!pfn_valid_within(pfn))
-				continue;
-
-			page = pfn_to_page(pfn);
-
 			if (page_zone(page) != zone)
 				continue;
 
-- 
2.28.0

