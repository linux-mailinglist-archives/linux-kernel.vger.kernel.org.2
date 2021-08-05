Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697903E1785
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241603AbhHEPG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:06:29 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:37379 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240044AbhHEPGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:06:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ui3E80K_1628175968;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ui3E80K_1628175968)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Aug 2021 23:06:08 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] mm: migrate: Introduce a local variable to get the number of pages
Date:   Thu,  5 Aug 2021 23:05:57 +0800
Message-Id: <b06c1515a4520f8d8259c991320a44c54c56edfa.1628174413.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use thp_nr_pages() instead of compound_nr() to get the number of pages
for THP page, meanwhile introducing a local variable 'nr_pages' to
avoid getting the number of pages repeatedly.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 5559571..eeba4c6 100644
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

