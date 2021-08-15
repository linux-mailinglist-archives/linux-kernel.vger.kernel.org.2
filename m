Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F68E3EC7AE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 08:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhHOGYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 02:24:15 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:34861 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235251AbhHOGYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 02:24:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Uj0frwc_1629008593;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uj0frwc_1629008593)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 15 Aug 2021 14:23:13 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     apopple@nvidia.com, shy828301@gmail.com, willy@infradead.org,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] mm: migrate: Introduce a local variable to get the number of pages
Date:   Sun, 15 Aug 2021 14:23:04 +0800
Message-Id: <5773b519dce512e6c296afc249f5efc689c68525.1629008158.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1629008158.git.baolin.wang@linux.alibaba.com>
References: <cover.1629008158.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1629008158.git.baolin.wang@linux.alibaba.com>
References: <cover.1629008158.git.baolin.wang@linux.alibaba.com>
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
index 8e9282f..9b162c0e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2106,6 +2106,7 @@ static struct page *alloc_misplaced_dst_page_thp(struct page *page,
 static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 {
 	int page_lru;
+	int nr_pages = thp_nr_pages(page);
 
 	VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
 
@@ -2114,7 +2115,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 		return 0;
 
 	/* Avoid migrating to a node that is nearly full */
-	if (!migrate_balanced_pgdat(pgdat, compound_nr(page)))
+	if (!migrate_balanced_pgdat(pgdat, nr_pages))
 		return 0;
 
 	if (isolate_lru_page(page))
@@ -2122,7 +2123,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 
 	page_lru = page_is_file_lru(page);
 	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_lru,
-				thp_nr_pages(page));
+			    nr_pages);
 
 	/*
 	 * Isolating the page has taken another reference, so the
-- 
1.8.3.1

