Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BB83F3970
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 09:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhHUH4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 03:56:19 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:40075 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232992AbhHUH4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 03:56:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UkcmzYF_1629532532;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UkcmzYF_1629532532)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 21 Aug 2021 15:55:32 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     shy828301@gmail.com, willy@infradead.org,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] mm: migrate: Introduce a local variable to get the number of pages
Date:   Sat, 21 Aug 2021 15:54:57 +0800
Message-Id: <a8e331ac04392ee230c79186330fb05e86a2aa77.1629447552.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
References: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
References: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use thp_nr_pages() instead of compound_nr() to get the number of pages
for THP page, meanwhile introducing a local variable 'nr_pages' to
avoid getting the number of pages repeatedly.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4c93d98..9520d2f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2102,6 +2102,7 @@ static struct page *alloc_misplaced_dst_page_thp(struct page *page,
 static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 {
 	int page_lru;
+	int nr_pages = thp_nr_pages(page);
 
 	VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
 
@@ -2110,7 +2111,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 		return 0;
 
 	/* Avoid migrating to a node that is nearly full */
-	if (!migrate_balanced_pgdat(pgdat, compound_nr(page)))
+	if (!migrate_balanced_pgdat(pgdat, nr_pages))
 		return 0;
 
 	if (isolate_lru_page(page))
@@ -2118,7 +2119,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 
 	page_lru = page_is_file_lru(page);
 	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_lru,
-				thp_nr_pages(page));
+			    nr_pages);
 
 	/*
 	 * Isolating the page has taken another reference, so the
-- 
1.8.3.1

