Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B6841DF1F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 18:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352022AbhI3QgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 12:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350921AbhI3QgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 12:36:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A9BC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=dGRVuVHbzksQmbzJlQOqYbJI1FUMHbOyKl7nGX1/loQ=; b=gK4ZdfX8FmPi5KpCz29ShyheUC
        g2gwIY4nbVPa1HUbgwM0XTb/YC1yUVdHsJzut0smgk6b471+UULwDI5DnRXWOFkTYNkuSqNqYjCik
        bkRN8Vbdosul7jlVD6znOnZa98NX+WmVJ6R3wICFOYOWPjx6ipMI/6tzPsxDwTm8GFRvnz4x18W8Z
        wku78QJr2r3uTH21eBqUDqtwe+QUefjWoWfjZvwM6dyQbBOnW0tVImlR7gmrEJdzS6WV8s26LjpQj
        ZJh8Ggl6jxEJr0z0M3OEhCUxJrJJCYJqvE2uSF3Qf1YGnxLxewjdEjPk2ThWrG+HcT1Zufgx5t/lY
        MUdXqvQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVyzW-00D4DU-Tm; Thu, 30 Sep 2021 16:33:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [RFC] mm: Optimise put_pages_list()
Date:   Thu, 30 Sep 2021 17:32:58 +0100
Message-Id: <20210930163258.3114404-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calling put_page() one page at a time, pop pages off
the list if there are other refcounts and pass the remainder
to free_unref_page_list().  This should be a speed improvement,
but I have no measurements to support that.  It's also not very
widely used today, so I can't say I've really tested it.  I'm only
bothering with this patch because I'd like the IOMMU code to use it
https://lore.kernel.org/lkml/20210930162043.3111119-1-willy@infradead.org/

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/swap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index af3cad4e5378..f6b38398fa6f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -139,13 +139,14 @@ EXPORT_SYMBOL(__put_page);
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
+		if (!put_page_testzero(page))
+			list_del(&page->lru);
 	}
+
+	free_unref_page_list(pages);
 }
 EXPORT_SYMBOL(put_pages_list);
 
-- 
2.32.0
