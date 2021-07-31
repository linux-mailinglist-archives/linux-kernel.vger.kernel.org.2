Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572CD3DC413
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 08:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhGaGjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 02:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhGaGju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 02:39:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFE5C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:39:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f3-20020a25cf030000b029055a2303fc2dso13074201ybg.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BM+FE+/TiUx2OjFlRwtIO4yCUv9GYAVqgfjFJ6CUhoU=;
        b=WsYJB5oepFO3Wnd6PD+UXgOWzwQ85U4gvNUBQPL78jtZrSF4sTHPbyiNtqUk23nQhz
         c1/PYP5BlzvA/wilIXGO7/qINCd35Q73p17mn2jO/lk5M7RAh5BmffbH+ZRzbwuLlOAF
         8HjeTu+PZBemftmZiO7WaTDU6M4xV0XSWMl1BXM0uHxPkwGsk578T+Uz5CQFs9IxGrHm
         jTmnq7qqKeYJz/kOeyz5dSHQoXn9qlKmIq8em5IZo+2APiFd8KgFFxvciDyawbOIwJ87
         LeRs/nPRsn22A18v740Ymk2mMfcVnytiNyiQK5P0kmVBL/s19JKAYoiLqpdZyt3QI6uJ
         ok6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BM+FE+/TiUx2OjFlRwtIO4yCUv9GYAVqgfjFJ6CUhoU=;
        b=Dz0Fh3Yff1M5VvitFAmaHaRCcAphXTRnkeIzLSItTrILj+QmHOz6jH591ttdjqXckJ
         sMM6z6nAVWMV4ZgHFKE9DkbZG0NBIzVQcYQUNIU7F65g4QXRRfX5z+ikuocqf/ACTj+i
         6xZ48j/rZIlvKo2HWdji/LltF9u9FrHPRkrFeyWCuBkpAkM6NlWOszsklhhITwO/MhZs
         SYWunZgZLIS58IaIJVMO1Cz6mzT0Fh6M05XzKweOVu0trWzT/+bagkPc5MxJcbr0/tZ1
         cHq29XrUaSkDOEBvHK28Y5hDLJcYvreFtA1I6VGGAbVJbsnQBx7o9AAzJi5Rj5AsSOXy
         hKMA==
X-Gm-Message-State: AOAM532YVSozdw2HJUrsXI5p9f2md/g7hjFi+CMGZBzMOiAxeV0RtFwh
        DOWlsH0ZK5QUEOPBIQSjchHAA0L4aDE=
X-Google-Smtp-Source: ABdhPJxiboigXtft6Tow9VLWZOsDXlaor5MrVjIBKJWd0LwIdCmmJ7JyIMMmMlT45SzkfdIze2fknU1vGMg=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:2b92:c131:b08a:84c7])
 (user=yuzhao job=sendgmr) by 2002:a25:bc0f:: with SMTP id i15mr8025092ybh.233.1627713583285;
 Fri, 30 Jul 2021 23:39:43 -0700 (PDT)
Date:   Sat, 31 Jul 2021 00:39:36 -0600
In-Reply-To: <20210731063938.1391602-1-yuzhao@google.com>
Message-Id: <20210731063938.1391602-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20210731063938.1391602-1-yuzhao@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH 1/3] mm: don't take lru lock when splitting isolated thp
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Shuang Zhai <zhais@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We won't put its tail pages on lru when splitting an isolated thp
under reclaim or migration, and therefore we don't need to take the
lru lock.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Shuang Zhai <zhais@google.com>
---
 mm/huge_memory.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index afff3ac87067..d8b655856e79 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2342,17 +2342,14 @@ static void remap_page(struct page *page, unsigned int nr)
 	}
 }
 
-static void lru_add_page_tail(struct page *head, struct page *tail,
-		struct lruvec *lruvec, struct list_head *list)
+static void lru_add_page_tail(struct page *head, struct page *tail, struct list_head *list)
 {
 	VM_BUG_ON_PAGE(!PageHead(head), head);
 	VM_BUG_ON_PAGE(PageCompound(tail), head);
 	VM_BUG_ON_PAGE(PageLRU(tail), head);
-	lockdep_assert_held(&lruvec->lru_lock);
 
 	if (list) {
-		/* page reclaim is reclaiming a huge page */
-		VM_WARN_ON(PageLRU(head));
+		/* page reclaim or migration is splitting an isolated thp */
 		get_page(tail);
 		list_add_tail(&tail->lru, list);
 	} else {
@@ -2363,8 +2360,7 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
 	}
 }
 
-static void __split_huge_page_tail(struct page *head, int tail,
-		struct lruvec *lruvec, struct list_head *list)
+static void __split_huge_page_tail(struct page *head, int tail, struct list_head *list)
 {
 	struct page *page_tail = head + tail;
 
@@ -2425,19 +2421,21 @@ static void __split_huge_page_tail(struct page *head, int tail,
 	 * pages to show after the currently processed elements - e.g.
 	 * migrate_pages
 	 */
-	lru_add_page_tail(head, page_tail, lruvec, list);
+	lru_add_page_tail(head, page_tail, list);
 }
 
 static void __split_huge_page(struct page *page, struct list_head *list,
 		pgoff_t end)
 {
 	struct page *head = compound_head(page);
-	struct lruvec *lruvec;
+	struct lruvec *lruvec = NULL;
 	struct address_space *swap_cache = NULL;
 	unsigned long offset = 0;
 	unsigned int nr = thp_nr_pages(head);
 	int i;
 
+	VM_BUG_ON_PAGE(list && PageLRU(head), head);
+
 	/* complete memcg works before add pages to LRU */
 	split_page_memcg(head, nr);
 
@@ -2450,10 +2448,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	}
 
 	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
-	lruvec = lock_page_lruvec(head);
+	if (!list)
+		lruvec = lock_page_lruvec(head);
 
 	for (i = nr - 1; i >= 1; i--) {
-		__split_huge_page_tail(head, i, lruvec, list);
+		__split_huge_page_tail(head, i, list);
 		/* Some pages can be beyond i_size: drop them from page cache */
 		if (head[i].index >= end) {
 			ClearPageDirty(head + i);
@@ -2471,7 +2470,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	}
 
 	ClearPageCompound(head);
-	unlock_page_lruvec(lruvec);
+	if (lruvec)
+		unlock_page_lruvec(lruvec);
 	/* Caller disabled irqs, so they are still disabled here */
 
 	split_page_owner(head, nr);
@@ -2645,6 +2645,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
 	VM_BUG_ON_PAGE(!PageLocked(head), head);
 	VM_BUG_ON_PAGE(!PageCompound(head), head);
+	VM_BUG_ON_PAGE(list && PageLRU(head), head);
 
 	if (PageWriteback(head))
 		return -EBUSY;
-- 
2.32.0.554.ge1b32706d8-goog

