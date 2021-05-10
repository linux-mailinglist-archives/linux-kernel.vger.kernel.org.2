Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B0E379AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 01:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhEJX0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 19:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhEJX0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 19:26:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C8EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TeUuXq9To8lgcl1o5k4sCzqTpRU5GNmM8WZRtq2XAHM=; b=i7uMGqhjU70AcV3rLCnq7FFUGZ
        Xaas7OmrkB8xq7IRzd5gsQXfdaop46lQO1e+iWm84pCZsW/JAxRLTbOZYIVvfadTMGJ3BWGps0AZC
        JxH6zk/zdtQF4fnctsrEw+hQmEZjM1XTRy0pDjJXwwDQG2cR6REdmIbdoE1w3ZNUuyGZxs7UQ6zVW
        ldWxgUcAN7z9CNHSsc3yw3E7IHsomSOi2ardBJ1+RMnm36srL6GaIru8abEGso82zISVoMuUdGpQE
        9eKlzCzbHLxV/squSMK3iYBK7HhQPgpQDya+D87qFKhki5y/Vdoy55lW1VpPtfIE+QvCY6iCO6RY8
        9drN44qw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgFFf-006gOK-8T; Mon, 10 May 2021 23:24:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] mm/migrate: Add folio_migrate_copy
Date:   Tue, 11 May 2021 00:23:08 +0100
Message-Id: <20210510232308.1592750-4-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510232308.1592750-1-willy@infradead.org>
References: <20210510232308.1592750-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine the THP, hugetlb and base page routines together into a simple
loop.  It does iterate the pages backwards, but real CPUs can prefetch
a backwards walk.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/migrate.h |  1 +
 mm/folio-compat.c       |  6 ++++
 mm/migrate.c            | 68 ++++++++---------------------------------
 3 files changed, 19 insertions(+), 56 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 7993faffa46d..cb67692e659a 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -52,6 +52,7 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, int extra_count);
 void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
+void folio_migrate_copy(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int extra_count);
 #else
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index f0ac904d396f..316c912e49e0 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -76,4 +76,10 @@ void migrate_page_states(struct page *newpage, struct page *page)
 	folio_migrate_flags(page_folio(newpage), page_folio(page));
 }
 EXPORT_SYMBOL(migrate_page_states);
+
+void migrate_page_copy(struct page *newpage, struct page *page)
+{
+	folio_migrate_copy(page_folio(newpage), page_folio(page));
+}
+EXPORT_SYMBOL(migrate_page_copy);
 #endif
diff --git a/mm/migrate.c b/mm/migrate.c
index 38006cdece60..ee1220d6b40a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -529,54 +529,6 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 	return MIGRATEPAGE_SUCCESS;
 }
 
-/*
- * Gigantic pages are so large that we do not guarantee that page++ pointer
- * arithmetic will work across the entire page.  We need something more
- * specialized.
- */
-static void __copy_gigantic_page(struct page *dst, struct page *src,
-				int nr_pages)
-{
-	int i;
-	struct page *dst_base = dst;
-	struct page *src_base = src;
-
-	for (i = 0; i < nr_pages; ) {
-		cond_resched();
-		copy_highpage(dst, src);
-
-		i++;
-		dst = mem_map_next(dst, dst_base, i);
-		src = mem_map_next(src, src_base, i);
-	}
-}
-
-static void copy_huge_page(struct page *dst, struct page *src)
-{
-	int i;
-	int nr_pages;
-
-	if (PageHuge(src)) {
-		/* hugetlbfs page */
-		struct hstate *h = page_hstate(src);
-		nr_pages = pages_per_huge_page(h);
-
-		if (unlikely(nr_pages > MAX_ORDER_NR_PAGES)) {
-			__copy_gigantic_page(dst, src, nr_pages);
-			return;
-		}
-	} else {
-		/* thp page */
-		BUG_ON(!PageTransHuge(src));
-		nr_pages = thp_nr_pages(src);
-	}
-
-	for (i = 0; i < nr_pages; i++) {
-		cond_resched();
-		copy_highpage(dst + i, src + i);
-	}
-}
-
 /*
  * Copy the flags and some other ancillary information
  */
@@ -650,16 +602,20 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 }
 EXPORT_SYMBOL(folio_migrate_flags);
 
-void migrate_page_copy(struct page *newpage, struct page *page)
+void folio_migrate_copy(struct folio *newfolio, struct folio *folio)
 {
-	if (PageHuge(page) || PageTransHuge(page))
-		copy_huge_page(newpage, page);
-	else
-		copy_highpage(newpage, page);
+	unsigned int i = folio_nr_pages(folio) - 1;
 
-	migrate_page_states(newpage, page);
+	copy_highpage(folio_page(newfolio, i), folio_page(folio, i));
+	while (i-- > 0) {
+		cond_resched();
+		/* folio_page() handles discontinuities in memmap */
+		copy_highpage(folio_page(newfolio, i), folio_page(folio, i));
+	}
+
+	folio_migrate_flags(newfolio, folio);
 }
-EXPORT_SYMBOL(migrate_page_copy);
+EXPORT_SYMBOL(folio_migrate_copy);
 
 /************************************************************
  *                    Migration functions
@@ -687,7 +643,7 @@ int migrate_page(struct address_space *mapping,
 		return rc;
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
-		migrate_page_copy(newpage, page);
+		folio_migrate_copy(newfolio, folio);
 	else
 		folio_migrate_flags(newfolio, folio);
 	return MIGRATEPAGE_SUCCESS;
-- 
2.30.2

