Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD58425B71
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 21:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243882AbhJGTZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 15:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbhJGTZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 15:25:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9205FC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 12:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=c5biXh/53+5ikGkxdoYWgJx/1z0TuA4942Vbwiwif9s=; b=ox6Ij/PGO7Xmz11xbtdnFc3Oc7
        VgXQvCFaeMuxPLLIWeh9kVO2f43f5lAqFXOcetl5CshpBprgVceWsLTO6iKPjIKQ0eKPgqbm6hj+H
        dGME8R20hJO8a4/U7j0mJqK4tV9SCLYBvKEelSiUJSD1M3zzrAEuZo8a20gcBj8CkUKtmfDPXV0b0
        lZc9VrMmdJ29e223w/Wba1aia2au8ErsUlWlfVPatW7nk/C0p395jmjPzqknTj6AIZuRb9M4tGv4B
        Z0hz2SsWu3NB6PoXzJHPxMkYb2ApSL3LztrJUl09IOtyVaZc4L7j//TNpeyuH+g7NvBcdUjlk+C+p
        Wja0cYCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYYxZ-002M81-1H; Thu, 07 Oct 2021 19:21:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2] mm: Optimise put_pages_list()
Date:   Thu,  7 Oct 2021 20:21:37 +0100
Message-Id: <20211007192138.561673-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calling put_page() one page at a time, pop pages off
the list if their refcount was too high and pass the remainder to
put_unref_page_list().  This should be a speed improvement, but I have
no measurements to support that.  Current callers do not care about
performance, but I hope to add some which do.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
v2:
 - Handle compound pages (Mel)
 - Comment why we don't need to handle PageLRU
 - Added call to __ClearPageWaiters(), matching that in release_pages()

 mm/swap.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index af3cad4e5378..9f334d503fd2 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -134,18 +134,27 @@ EXPORT_SYMBOL(__put_page);
  * put_pages_list() - release a list of pages
  * @pages: list of pages threaded on page->lru
  *
- * Release a list of pages which are strung together on page.lru.  Currently
- * used by read_cache_pages() and related error recovery code.
+ * Release a list of pages which are strung together on page.lru.
  */
 void put_pages_list(struct list_head *pages)
 {
-	while (!list_empty(pages)) {
-		struct page *victim;
+	struct page *page, *next;
 
-		victim = lru_to_page(pages);
-		list_del(&victim->lru);
-		put_page(victim);
+	list_for_each_entry_safe(page, next, pages, lru) {
+		if (!put_page_testzero(page)) {
+			list_del(&page->lru);
+			continue;
+		}
+		if (PageHead(page)) {
+			list_del(&page->lru);
+			__put_compound_page(page);
+			continue;
+		}
+		/* Cannot be PageLRU because it's passed to us using the lru */
+		__ClearPageWaiters(page);
 	}
+
+	free_unref_page_list(pages);
 }
 EXPORT_SYMBOL(put_pages_list);
 
-- 
2.32.0

