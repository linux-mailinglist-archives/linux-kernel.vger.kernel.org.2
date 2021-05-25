Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E7738FC62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhEYIPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:15:05 -0400
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:39953 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232000AbhEYIOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:14:33 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id 41CB4134001
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:02:11 +0100 (IST)
Received: (qmail 6155 invoked from network); 25 May 2021 08:02:10 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 25 May 2021 08:02:10 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/6] mm/page_alloc: Scale the number of pages that are batch freed
Date:   Tue, 25 May 2021 09:01:17 +0100
Message-Id: <20210525080119.5455-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210525080119.5455-1-mgorman@techsingularity.net>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task is freeing a large number of order-0 pages, it may acquire
the zone->lock multiple times freeing pages in batches. This may
unnecessarily contend on the zone lock when freeing very large number
of pages. This patch adapts the size of the batch based on the recent
pattern to scale the batch size for subsequent frees.

As the machines I used were not large enough to test this are not large
enough to illustrate a problem, a debugging patch shows patterns like
the following (slightly editted for clarity)

Baseline vanilla kernel
  time-unmap-14426   [...] free_pcppages_bulk: free   63 count  378 high  378
  time-unmap-14426   [...] free_pcppages_bulk: free   63 count  378 high  378
  time-unmap-14426   [...] free_pcppages_bulk: free   63 count  378 high  378
  time-unmap-14426   [...] free_pcppages_bulk: free   63 count  378 high  378
  time-unmap-14426   [...] free_pcppages_bulk: free   63 count  378 high  378

With patches
  time-unmap-7724    [...] free_pcppages_bulk: free  126 count  814 high  814
  time-unmap-7724    [...] free_pcppages_bulk: free  252 count  814 high  814
  time-unmap-7724    [...] free_pcppages_bulk: free  504 count  814 high  814
  time-unmap-7724    [...] free_pcppages_bulk: free  751 count  814 high  814
  time-unmap-7724    [...] free_pcppages_bulk: free  751 count  814 high  814

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 include/linux/mmzone.h |  3 ++-
 mm/page_alloc.c        | 41 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b449151745d7..92182e0299b2 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -343,8 +343,9 @@ struct per_cpu_pages {
 	int count;		/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
+	short free_factor;	/* batch scaling factor during free */
 #ifdef CONFIG_NUMA
-	int expire;		/* When 0, remote pagesets are drained */
+	short expire;		/* When 0, remote pagesets are drained */
 #endif
 
 	/* Lists of pages, one per migrate type stored on the pcp-lists */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dc4ac309bc21..89e60005dd27 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3267,18 +3267,47 @@ static bool free_unref_page_prepare(struct page *page, unsigned long pfn)
 	return true;
 }
 
+static int nr_pcp_free(struct per_cpu_pages *pcp, int high, int batch)
+{
+	int min_nr_free, max_nr_free;
+
+	/* Check for PCP disabled or boot pageset */
+	if (unlikely(high < batch))
+		return 1;
+
+	/* Leave at least pcp->batch pages on the list */
+	min_nr_free = batch;
+	max_nr_free = high - batch;
+
+	/*
+	 * Double the number of pages freed each time there is subsequent
+	 * freeing of pages without any allocation.
+	 */
+	batch <<= pcp->free_factor;
+	if (batch < max_nr_free)
+		pcp->free_factor++;
+	batch = clamp(batch, min_nr_free, max_nr_free);
+
+	return batch;
+}
+
 static void free_unref_page_commit(struct page *page, unsigned long pfn,
 				   int migratetype)
 {
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
+	int high;
 
 	__count_vm_event(PGFREE);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	list_add(&page->lru, &pcp->lists[migratetype]);
 	pcp->count++;
-	if (pcp->count >= READ_ONCE(pcp->high))
-		free_pcppages_bulk(zone, READ_ONCE(pcp->batch), pcp);
+	high = READ_ONCE(pcp->high);
+	if (pcp->count >= high) {
+		int batch = READ_ONCE(pcp->batch);
+
+		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch), pcp);
+	}
 }
 
 /*
@@ -3530,7 +3559,14 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	unsigned long flags;
 
 	local_lock_irqsave(&pagesets.lock, flags);
+
+	/*
+	 * On allocation, reduce the number of pages that are batch freed.
+	 * See nr_pcp_free() where free_factor is increased for subsequent
+	 * frees.
+	 */
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
+	pcp->free_factor >>= 1;
 	list = &pcp->lists[migratetype];
 	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
 	local_unlock_irqrestore(&pagesets.lock, flags);
@@ -6698,6 +6734,7 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 	 */
 	pcp->high = BOOT_PAGESET_HIGH;
 	pcp->batch = BOOT_PAGESET_BATCH;
+	pcp->free_factor = 0;
 }
 
 static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high,
-- 
2.26.2

