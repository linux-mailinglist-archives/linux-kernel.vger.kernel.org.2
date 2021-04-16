Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7803E362BD9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 01:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhDPXQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 19:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhDPXQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:16:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB1AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 16:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9BjCjqxwi6v9E4F0a+hexiRxdGm8wFs5BMpe9gfpLdo=; b=KDSY/zHM2rL1TUO2qytXciC7AU
        DY4Q0GokdsNfZd7X77plmE4qroTZPAureCViYnCS+XXzOUlnSYa07aPteEEdboXwAXiJMj/Cq0Nar
        fnch8Aofgz5OH7zd1V1Qi4PJw9Yr8c40X/X3vXAYhDy0kePzRmYO00N5yB5POT6ujC0frUT61v6e2
        W/AcN7iCeKpspfH6DguzVa83EGYRbGBlhui+gz+AW5TDGNGs7F7g5p0Jq62nFxjxAwVLi6kTZPLAY
        1n4KoH4qNs6ndnpD9GvPQ9O1dBVcXEIULgsuFQ6alTSj+IIm5yOt0lwTBMDw3BgaemsaUZSDXtSVR
        NDbFgo1g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXXgs-00AZx2-1Y; Fri, 16 Apr 2021 23:16:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] mm/debug: Factor PagePoisoned out of __dump_page
Date:   Sat, 17 Apr 2021 00:15:27 +0100
Message-Id: <20210416231531.2521383-3-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210416231531.2521383-1-willy@infradead.org>
References: <20210416231531.2521383-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PagePoisoned test into dump_page().  Skip the hex print
for poisoned pages -- we know they're full of ffffffff.  Move the
reason printing from __dump_page() to dump_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/debug.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index 84cdcd0f7bd3..e73fe0a8ec3d 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -42,11 +42,10 @@ const struct trace_print_flags vmaflag_names[] = {
 	{0, NULL}
 };
 
-static void __dump_page(struct page *page, const char *reason)
+static void __dump_page(struct page *page)
 {
 	struct page *head = compound_head(page);
 	struct address_space *mapping;
-	bool page_poisoned = PagePoisoned(page);
 	bool compound = PageCompound(page);
 	/*
 	 * Accessing the pageblock without the zone lock. It could change to
@@ -58,16 +57,6 @@ static void __dump_page(struct page *page, const char *reason)
 	int mapcount;
 	char *type = "";
 
-	/*
-	 * If struct page is poisoned don't access Page*() functions as that
-	 * leads to recursive loop. Page*() check for poisoned pages, and calls
-	 * dump_page() when detected.
-	 */
-	if (page_poisoned) {
-		pr_warn("page:%px is uninitialized and poisoned", page);
-		goto hex_only;
-	}
-
 	if (page < head || (page >= head + MAX_ORDER_NR_PAGES)) {
 		/*
 		 * Corrupt page, so we cannot call page_mapping. Instead, do a
@@ -173,8 +162,6 @@ static void __dump_page(struct page *page, const char *reason)
 
 	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, &head->flags,
 		page_cma ? " CMA" : "");
-
-hex_only:
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
 			sizeof(struct page), false);
@@ -182,14 +169,16 @@ static void __dump_page(struct page *page, const char *reason)
 		print_hex_dump(KERN_WARNING, "head: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), head,
 			sizeof(struct page), false);
-
-	if (reason)
-		pr_warn("page dumped because: %s\n", reason);
 }
 
 void dump_page(struct page *page, const char *reason)
 {
-	__dump_page(page, reason);
+	if (PagePoisoned(page))
+		pr_warn("page:%p is uninitialized and poisoned", page);
+	else
+		__dump_page(page);
+	if (reason)
+		pr_warn("page dumped because: %s\n", reason);
 	dump_page_owner(page);
 }
 EXPORT_SYMBOL(dump_page);
-- 
2.30.2

