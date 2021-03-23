Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FFF345E60
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhCWMmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:42:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14849 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhCWMlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:41:55 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F4WCt0HgDz92nR;
        Tue, 23 Mar 2021 20:39:54 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Tue, 23 Mar 2021
 20:41:46 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] mm, page_alloc: avoid page_to_pfn() in move_freepages()
Date:   Tue, 23 Mar 2021 21:12:15 +0800
Message-ID: <20210323131215.934472-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

The start_pfn and end_pfn are already available in move_freepages_block(),
there is no need to go back and forth between page and pfn in move_freepages
and move_freepages_block, and pfn_valid_within() should validate pfn first
before touching the page.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/page_alloc.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c53fe4fa10bf..ccfaa8158862 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2425,19 +2425,21 @@ static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
  * boundary. If alignment is required, use move_freepages_block()
  */
 static int move_freepages(struct zone *zone,
-			  struct page *start_page, struct page *end_page,
+			  unsigned long start_pfn, unsigned long end_pfn,
 			  int migratetype, int *num_movable)
 {
 	struct page *page;
+	unsigned long pfn;
 	unsigned int order;
 	int pages_moved = 0;
 
-	for (page = start_page; page <= end_page;) {
-		if (!pfn_valid_within(page_to_pfn(page))) {
-			page++;
+	for (pfn = start_pfn; pfn <= end_pfn;) {
+		if (!pfn_valid_within(pfn)) {
+			pfn++;
 			continue;
 		}
 
+		page = pfn_to_page(pfn);
 		if (!PageBuddy(page)) {
 			/*
 			 * We assume that pages that could be isolated for
@@ -2447,8 +2449,7 @@ static int move_freepages(struct zone *zone,
 			if (num_movable &&
 					(PageLRU(page) || __PageMovable(page)))
 				(*num_movable)++;
-
-			page++;
+			pfn++;
 			continue;
 		}
 
@@ -2458,7 +2459,7 @@ static int move_freepages(struct zone *zone,
 
 		order = buddy_order(page);
 		move_to_free_list(page, zone, order, migratetype);
-		page += 1 << order;
+		pfn += 1 << order;
 		pages_moved += 1 << order;
 	}
 
@@ -2468,25 +2469,22 @@ static int move_freepages(struct zone *zone,
 int move_freepages_block(struct zone *zone, struct page *page,
 				int migratetype, int *num_movable)
 {
-	unsigned long start_pfn, end_pfn;
-	struct page *start_page, *end_page;
+	unsigned long start_pfn, end_pfn, pfn;
 
 	if (num_movable)
 		*num_movable = 0;
 
-	start_pfn = page_to_pfn(page);
-	start_pfn = start_pfn & ~(pageblock_nr_pages-1);
-	start_page = pfn_to_page(start_pfn);
-	end_page = start_page + pageblock_nr_pages - 1;
+	pfn = page_to_pfn(page);
+	start_pfn = pfn & ~(pageblock_nr_pages - 1);
 	end_pfn = start_pfn + pageblock_nr_pages - 1;
 
 	/* Do not cross zone boundaries */
 	if (!zone_spans_pfn(zone, start_pfn))
-		start_page = page;
+		start_pfn = pfn;
 	if (!zone_spans_pfn(zone, end_pfn))
 		return 0;
 
-	return move_freepages(zone, start_page, end_page, migratetype,
+	return move_freepages(zone, start_pfn, end_pfn, migratetype,
 								num_movable);
 }
 
-- 
2.25.1

