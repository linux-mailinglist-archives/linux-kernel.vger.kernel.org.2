Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320B6379AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 01:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhEJXYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 19:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhEJXYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 19:24:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD622C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 16:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=51Wn8BgpY6B/FquYPHIDi/BWH4QuZKocF09gIvVuJmw=; b=edTIbwmy6uCa+hOgSy7amodN2B
        Sa/I1aJpvEk1DxAsZi2VwG8+mtZScerFcPiWCEgnQJeblj68OfR2pQcVxZRsj0pwI3VLdFfyA2kri
        Fo2XWxElrv95Oa7/9noTIg8tmA/hxL4jLIGzeIwvlixuG57TOEXYvn2xfa12FfmhyZCHmwTJFygip
        JHL0EQYM8PAEHcRQc2C6dfxRPn8Se4oJrrOC7eu9FAmGKdabTtcEQWev7P0SPVjRdsVom9tT/uNwN
        H9rhXnAKHccUpvSWDRlhEFRZ1RX8+Xc/vmcCAHMIwCBB2vP5dTyndRkMbuPmhKKv0Q4iN7p/ytrFT
        GmKQ/1jg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgFFB-006gMz-9z; Mon, 10 May 2021 23:23:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] mm/migrate: Add folio_migrate_mapping
Date:   Tue, 11 May 2021 00:23:06 +0100
Message-Id: <20210510232308.1592750-2-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510232308.1592750-1-willy@infradead.org>
References: <20210510232308.1592750-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reimplement migrate_page_move_mapping() as a wrapper around
folio_migrate_mapping().  Saves 193 bytes of kernel text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/migrate.h |  2 +
 mm/folio-compat.c       | 11 ++++++
 mm/migrate.c            | 85 +++++++++++++++++++++--------------------
 3 files changed, 57 insertions(+), 41 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 4bb4e519e3f5..a4ff65e9c1e3 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -51,6 +51,8 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 				  struct page *newpage, struct page *page);
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, int extra_count);
+int folio_migrate_mapping(struct address_space *mapping,
+		struct folio *newfolio, struct folio *folio, int extra_count);
 #else
 
 static inline void putback_movable_pages(struct list_head *l) {}
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index d229b979b00d..25c2269655f4 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -4,6 +4,7 @@
  * eventually.
  */
 
+#include <linux/migrate.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 
@@ -60,3 +61,13 @@ void mem_cgroup_uncharge(struct page *page)
 	folio_uncharge_cgroup(page_folio(page));
 }
 #endif
+
+#ifdef CONFIG_MIGRATION
+int migrate_page_move_mapping(struct address_space *mapping,
+		struct page *newpage, struct page *page, int extra_count)
+{
+	return folio_migrate_mapping(mapping, page_folio(newpage),
+					page_folio(page), extra_count);
+}
+EXPORT_SYMBOL(migrate_page_move_mapping);
+#endif
diff --git a/mm/migrate.c b/mm/migrate.c
index fff63e139767..b668970acd11 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -355,7 +355,7 @@ static int expected_page_refs(struct address_space *mapping, struct page *page)
 	 */
 	expected_count += is_device_private_page(page);
 	if (mapping)
-		expected_count += thp_nr_pages(page) + page_has_private(page);
+		expected_count += compound_nr(page) + page_has_private(page);
 
 	return expected_count;
 }
@@ -368,74 +368,75 @@ static int expected_page_refs(struct address_space *mapping, struct page *page)
  * 2 for pages with a mapping
  * 3 for pages with a mapping and PagePrivate/PagePrivate2 set.
  */
-int migrate_page_move_mapping(struct address_space *mapping,
-		struct page *newpage, struct page *page, int extra_count)
+int folio_migrate_mapping(struct address_space *mapping,
+		struct folio *newfolio, struct folio *folio, int extra_count)
 {
-	XA_STATE(xas, &mapping->i_pages, page_index(page));
+	XA_STATE(xas, &mapping->i_pages, folio_index(folio));
 	struct zone *oldzone, *newzone;
 	int dirty;
-	int expected_count = expected_page_refs(mapping, page) + extra_count;
-	int nr = thp_nr_pages(page);
+	int expected_count = expected_page_refs(mapping, &folio->page) + extra_count;
+	int nr = folio_nr_pages(folio);
 
 	if (!mapping) {
 		/* Anonymous page without mapping */
-		if (page_count(page) != expected_count)
+		if (folio_ref_count(folio) != expected_count)
 			return -EAGAIN;
 
 		/* No turning back from here */
-		newpage->index = page->index;
-		newpage->mapping = page->mapping;
-		if (PageSwapBacked(page))
-			__SetPageSwapBacked(newpage);
+		newfolio->index = folio->index;
+		newfolio->mapping = folio->mapping;
+		if (folio_swapbacked(folio))
+			__folio_set_swapbacked_flag(newfolio);
 
 		return MIGRATEPAGE_SUCCESS;
 	}
 
-	oldzone = page_zone(page);
-	newzone = page_zone(newpage);
+	oldzone = folio_zone(folio);
+	newzone = folio_zone(newfolio);
 
 	xas_lock_irq(&xas);
-	if (page_count(page) != expected_count || xas_load(&xas) != page) {
+	if (folio_ref_count(folio) != expected_count ||
+	    xas_load(&xas) != folio) {
 		xas_unlock_irq(&xas);
 		return -EAGAIN;
 	}
 
-	if (!page_ref_freeze(page, expected_count)) {
+	if (!folio_ref_freeze(folio, expected_count)) {
 		xas_unlock_irq(&xas);
 		return -EAGAIN;
 	}
 
 	/*
-	 * Now we know that no one else is looking at the page:
+	 * Now we know that no one else is looking at the folio:
 	 * no turning back from here.
 	 */
-	newpage->index = page->index;
-	newpage->mapping = page->mapping;
-	page_ref_add(newpage, nr); /* add cache reference */
-	if (PageSwapBacked(page)) {
-		__SetPageSwapBacked(newpage);
-		if (PageSwapCache(page)) {
-			SetPageSwapCache(newpage);
-			set_page_private(newpage, page_private(page));
+	newfolio->index = folio->index;
+	newfolio->mapping = folio->mapping;
+	folio_ref_add(newfolio, nr); /* add cache reference */
+	if (folio_swapbacked(folio)) {
+		__folio_set_swapbacked_flag(newfolio);
+		if (folio_swapcache(folio)) {
+			folio_set_swapcache_flag(newfolio);
+			newfolio->private = folio_get_private(folio);
 		}
 	} else {
-		VM_BUG_ON_PAGE(PageSwapCache(page), page);
+		VM_BUG_ON_FOLIO(folio_swapcache(folio), folio);
 	}
 
 	/* Move dirty while page refs frozen and newpage not yet exposed */
-	dirty = PageDirty(page);
+	dirty = folio_dirty(folio);
 	if (dirty) {
-		ClearPageDirty(page);
-		SetPageDirty(newpage);
+		folio_clear_dirty_flag(folio);
+		folio_set_dirty_flag(newfolio);
 	}
 
-	xas_store(&xas, newpage);
-	if (PageTransHuge(page)) {
+	xas_store(&xas, newfolio);
+	if (nr > 1) {
 		int i;
 
 		for (i = 1; i < nr; i++) {
 			xas_next(&xas);
-			xas_store(&xas, newpage);
+			xas_store(&xas, newfolio);
 		}
 	}
 
@@ -444,7 +445,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	 * to one less reference.
 	 * We know this isn't the last reference.
 	 */
-	page_ref_unfreeze(page, expected_count - nr);
+	folio_ref_unfreeze(folio, expected_count - nr);
 
 	xas_unlock(&xas);
 	/* Leave irq disabled to prevent preemption while updating stats */
@@ -463,18 +464,18 @@ int migrate_page_move_mapping(struct address_space *mapping,
 		struct lruvec *old_lruvec, *new_lruvec;
 		struct mem_cgroup *memcg;
 
-		memcg = page_memcg(page);
+		memcg = folio_memcg(folio);
 		old_lruvec = mem_cgroup_lruvec(memcg, oldzone->zone_pgdat);
 		new_lruvec = mem_cgroup_lruvec(memcg, newzone->zone_pgdat);
 
 		__mod_lruvec_state(old_lruvec, NR_FILE_PAGES, -nr);
 		__mod_lruvec_state(new_lruvec, NR_FILE_PAGES, nr);
-		if (PageSwapBacked(page) && !PageSwapCache(page)) {
+		if (folio_swapbacked(folio) && !folio_swapcache(folio)) {
 			__mod_lruvec_state(old_lruvec, NR_SHMEM, -nr);
 			__mod_lruvec_state(new_lruvec, NR_SHMEM, nr);
 		}
 #ifdef CONFIG_SWAP
-		if (PageSwapCache(page)) {
+		if (folio_swapcache(folio)) {
 			__mod_lruvec_state(old_lruvec, NR_SWAPCACHE, -nr);
 			__mod_lruvec_state(new_lruvec, NR_SWAPCACHE, nr);
 		}
@@ -490,11 +491,11 @@ int migrate_page_move_mapping(struct address_space *mapping,
 
 	return MIGRATEPAGE_SUCCESS;
 }
-EXPORT_SYMBOL(migrate_page_move_mapping);
+EXPORT_SYMBOL(folio_migrate_mapping);
 
 /*
  * The expected number of remaining references is the same as that
- * of migrate_page_move_mapping().
+ * of folio_migrate_mapping().
  */
 int migrate_huge_page_move_mapping(struct address_space *mapping,
 				   struct page *newpage, struct page *page)
@@ -603,7 +604,7 @@ void migrate_page_states(struct page *newpage, struct page *page)
 	if (PageMappedToDisk(page))
 		SetPageMappedToDisk(newpage);
 
-	/* Move dirty on pages not done by migrate_page_move_mapping() */
+	/* Move dirty on pages not done by folio_migrate_mapping() */
 	if (PageDirty(page))
 		SetPageDirty(newpage);
 
@@ -676,11 +677,13 @@ int migrate_page(struct address_space *mapping,
 		struct page *newpage, struct page *page,
 		enum migrate_mode mode)
 {
+	struct folio *newfolio = page_folio(newpage);
+	struct folio *folio = page_folio(page);
 	int rc;
 
-	BUG_ON(PageWriteback(page));	/* Writeback must be complete */
+	BUG_ON(folio_writeback(folio));	/* Writeback must be complete */
 
-	rc = migrate_page_move_mapping(mapping, newpage, page, 0);
+	rc = folio_migrate_mapping(mapping, newfolio, folio, 0);
 
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
@@ -2536,7 +2539,7 @@ static void migrate_vma_collect(struct migrate_vma *migrate)
  * @page: struct page to check
  *
  * Pinned pages cannot be migrated. This is the same test as in
- * migrate_page_move_mapping(), except that here we allow migration of a
+ * folio_migrate_mapping(), except that here we allow migration of a
  * ZONE_DEVICE page.
  */
 static bool migrate_vma_check_page(struct page *page)
-- 
2.30.2

