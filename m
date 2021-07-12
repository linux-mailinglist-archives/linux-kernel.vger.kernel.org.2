Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10643C5F53
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 17:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbhGLPfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhGLPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 11:35:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9558C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UqSBiPBWvQkGsGddLuJ6EsC6uCAofX3Z25Dzx+ZuAPY=; b=Srh+X3DLaZJN5Y7FvaOnwLbMk+
        DeGu7savhf57frJ2AAhxLbNs4E6ZyI8VGiZTKTh8Kns51ibLDbC5j/9TqF+K960SE8QGdCJtuV7h9
        +Yqea28Bnsx3/ntEzFOA408r20SzRqXfhTnBZ0a16yXSd3DyI09fChAxU402+EyPNf8MTqnoygUwd
        Jkq7D5puU4yOwGeo5453rMKL3WG6dNR9dGeNeiwgpuUZHWUWJTaXJbmckByijWn7Bwy0aUnRqkAie
        bYvxI0b1/CALh+NXv9pt4pypFuVd3DEP1IzkXnpL8dZwbdSnnc/4l8P2EpNMXlAVUxTVGGN6Rv9pF
        +8ydItig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2xuk-000AEd-B2; Mon, 12 Jul 2021 15:32:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Make copy_huge_page() always available
Date:   Mon, 12 Jul 2021 16:32:07 +0100
Message-Id: <20210712153207.39302-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite copy_huge_page() and move it into mm/util.c so it's always
available.  Fixes an exposure of uninitialised memory on configurations
with HUGETLB and UFFD enabled and MIGRATION disabled.

Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/migrate.h |  5 -----
 include/linux/mm.h      |  1 +
 mm/migrate.c            | 48 -----------------------------------------
 mm/util.c               | 10 +++++++++
 4 files changed, 11 insertions(+), 53 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 9b7b7cd3bae9..23dadf7aeba8 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -51,7 +51,6 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 				  struct page *newpage, struct page *page);
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, int extra_count);
-extern void copy_huge_page(struct page *dst, struct page *src);
 #else
 
 static inline void putback_movable_pages(struct list_head *l) {}
@@ -77,10 +76,6 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 {
 	return -ENOSYS;
 }
-
-static inline void copy_huge_page(struct page *dst, struct page *src)
-{
-}
 #endif /* CONFIG_MIGRATION */
 
 #ifdef CONFIG_COMPACTION
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8f8e9d8a8489..629df6a24527 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -874,6 +874,7 @@ void __put_page(struct page *page);
 void put_pages_list(struct list_head *pages);
 
 void split_page(struct page *page, unsigned int order);
+void copy_huge_page(struct page *dst, struct page *src);
 
 /*
  * Compound pages have a destructor function.  Provide a
diff --git a/mm/migrate.c b/mm/migrate.c
index 23cbd9de030b..34a9ad3e0a4f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -536,54 +536,6 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
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
-void copy_huge_page(struct page *dst, struct page *src)
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
  * Copy the page to its new location
  */
diff --git a/mm/util.c b/mm/util.c
index 99c6cc77de9e..9043d03750a7 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -731,6 +731,16 @@ int __page_mapcount(struct page *page)
 }
 EXPORT_SYMBOL_GPL(__page_mapcount);
 
+void copy_huge_page(struct page *dst, struct page *src)
+{
+	unsigned i, nr = compound_nr(src);
+
+	for (i = 0; i < nr; i++) {
+		cond_resched();
+		copy_highpage(nth_page(dst, i), nth_page(src, i));
+	}
+}
+
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
 int sysctl_overcommit_ratio __read_mostly = 50;
 unsigned long sysctl_overcommit_kbytes __read_mostly;
-- 
2.30.2

