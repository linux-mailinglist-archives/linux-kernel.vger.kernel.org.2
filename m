Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A49F38FC4A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhEYILa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:11:30 -0400
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:47292 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232075AbhEYIJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:09:32 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id ABBE2CAC77
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:01:50 +0100 (IST)
Received: (qmail 5375 invoked from network); 25 May 2021 08:01:50 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 25 May 2021 08:01:50 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/6] mm/page_alloc: Disassociate the pcp->high from pcp->batch
Date:   Tue, 25 May 2021 09:01:15 +0100
Message-Id: <20210525080119.5455-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210525080119.5455-1-mgorman@techsingularity.net>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcp high watermark is based on the batch size but there is no
relationship between them other than it is convenient to use early in
boot.

This patch takes the first step and bases pcp->high on the zone low
watermark split across the number of CPUs local to a zone while the batch
size remains the same to avoid increasing allocation latencies. The intent
behind the default pcp->high is "set the number of PCP pages such that
if they are all full that background reclaim is not started prematurely".

Note that in this patch the pcp->high values are adjusted after memory
hotplug events, min_free_kbytes adjustments and watermark scale factor
adjustments but not CPU hotplug events which is handled later in the
series.

On a test KVM instance;

Before grep -E "high:|batch" /proc/zoneinfo | tail -2
              high:  378
              batch: 63

After grep -E "high:|batch" /proc/zoneinfo | tail -2
              high:  649
              batch: 63

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 60 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a48f305f0381..c0536e5d088a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2163,14 +2163,6 @@ void __init page_alloc_init_late(void)
 	/* Block until all are initialised */
 	wait_for_completion(&pgdat_init_all_done_comp);
 
-	/*
-	 * The number of managed pages has changed due to the initialisation
-	 * so the pcpu batch and high limits needs to be updated or the limits
-	 * will be artificially small.
-	 */
-	for_each_populated_zone(zone)
-		zone_pcp_update(zone);
-
 	/*
 	 * We initialized the rest of the deferred pages.  Permanently disable
 	 * on-demand struct page initialization.
@@ -6594,13 +6586,12 @@ static int zone_batchsize(struct zone *zone)
 	int batch;
 
 	/*
-	 * The per-cpu-pages pools are set to around 1000th of the
-	 * size of the zone.
+	 * The number of pages to batch allocate is either ~0.1%
+	 * of the zone or 1MB, whichever is smaller. The batch
+	 * size is striking a balance between allocation latency
+	 * and zone lock contention.
 	 */
-	batch = zone_managed_pages(zone) / 1024;
-	/* But no more than a meg. */
-	if (batch * PAGE_SIZE > 1024 * 1024)
-		batch = (1024 * 1024) / PAGE_SIZE;
+	batch = min(zone_managed_pages(zone) >> 10, (1024 * 1024) / PAGE_SIZE);
 	batch /= 4;		/* We effectively *= 4 below */
 	if (batch < 1)
 		batch = 1;
@@ -6637,6 +6628,34 @@ static int zone_batchsize(struct zone *zone)
 #endif
 }
 
+static int zone_highsize(struct zone *zone, int batch)
+{
+#ifdef CONFIG_MMU
+	int high;
+	int nr_local_cpus;
+
+	/*
+	 * The high value of the pcp is based on the zone low watermark
+	 * so that if they are full then background reclaim will not be
+	 * started prematurely. The value is split across all online CPUs
+	 * local to the zone. Note that early in boot that CPUs may not be
+	 * online yet.
+	 */
+	nr_local_cpus = max(1U, cpumask_weight(cpumask_of_node(zone_to_nid(zone))));
+	high = low_wmark_pages(zone) / nr_local_cpus;
+
+	/*
+	 * Ensure high is at least batch*4. The multiple is based on the
+	 * historical relationship between high and batch.
+	 */
+	high = max(high, batch << 2);
+
+	return high;
+#else
+	return 0;
+#endif
+}
+
 /*
  * pcp->high and pcp->batch values are related and generally batch is lower
  * than high. They are also related to pcp->count such that count is lower
@@ -6698,11 +6717,10 @@ static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long h
  */
 static void zone_set_pageset_high_and_batch(struct zone *zone)
 {
-	unsigned long new_high, new_batch;
+	int new_high, new_batch;
 
-	new_batch = zone_batchsize(zone);
-	new_high = 6 * new_batch;
-	new_batch = max(1UL, 1 * new_batch);
+	new_batch = max(1, zone_batchsize(zone));
+	new_high = zone_highsize(zone, new_batch);
 
 	if (zone->pageset_high == new_high &&
 	    zone->pageset_batch == new_batch)
@@ -8170,6 +8188,12 @@ static void __setup_per_zone_wmarks(void)
 		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
 		zone->_watermark[WMARK_HIGH] = min_wmark_pages(zone) + tmp * 2;
 
+		/*
+		 * The watermark size have changed so update the pcpu batch
+		 * and high limits or the limits may be inappropriate.
+		 */
+		zone_set_pageset_high_and_batch(zone);
+
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 
-- 
2.26.2

