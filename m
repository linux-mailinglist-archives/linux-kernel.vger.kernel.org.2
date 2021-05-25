Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B48E38FC5A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhEYIOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:14:11 -0400
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:38163 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232106AbhEYINZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:13:25 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 691581C3B38
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:02:21 +0100 (IST)
Received: (qmail 6574 invoked from network); 25 May 2021 08:02:21 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 25 May 2021 08:02:21 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 5/6] mm/page_alloc: Limit the number of pages on PCP lists when reclaim is active
Date:   Tue, 25 May 2021 09:01:18 +0100
Message-Id: <20210525080119.5455-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210525080119.5455-1-mgorman@techsingularity.net>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kswapd is active then direct reclaim is potentially active. In
either case, it is possible that a zone would be balanced if pages were
not trapped on PCP lists. Instead of draining remote pages, simply limit
the size of the PCP lists while kswapd is active.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mmzone.h |  1 +
 mm/page_alloc.c        | 19 ++++++++++++++++++-
 mm/vmscan.c            | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 92182e0299b2..a0606239a167 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -647,6 +647,7 @@ enum zone_flags {
 	ZONE_BOOSTED_WATERMARK,		/* zone recently boosted watermarks.
 					 * Cleared when kswapd is woken.
 					 */
+	ZONE_RECLAIM_ACTIVE,		/* kswapd may be scanning the zone. */
 };
 
 static inline unsigned long zone_managed_pages(struct zone *zone)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 89e60005dd27..9144b0c4b6c9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3291,6 +3291,23 @@ static int nr_pcp_free(struct per_cpu_pages *pcp, int high, int batch)
 	return batch;
 }
 
+static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone)
+{
+	int high = READ_ONCE(pcp->high);
+
+	if (unlikely(!high))
+		return 0;
+
+	if (!test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags))
+		return high;
+
+	/*
+	 * If reclaim is active, limit the number of pages that can be
+	 * stored on pcp lists
+	 */
+	return min(READ_ONCE(pcp->batch) << 2, high);
+}
+
 static void free_unref_page_commit(struct page *page, unsigned long pfn,
 				   int migratetype)
 {
@@ -3302,7 +3319,7 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn,
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	list_add(&page->lru, &pcp->lists[migratetype]);
 	pcp->count++;
-	high = READ_ONCE(pcp->high);
+	high = nr_pcp_high(pcp, zone);
 	if (pcp->count >= high) {
 		int batch = READ_ONCE(pcp->batch);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5199b9696bab..c3c2100a80b8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3722,6 +3722,38 @@ static bool kswapd_shrink_node(pg_data_t *pgdat,
 	return sc->nr_scanned >= sc->nr_to_reclaim;
 }
 
+/* Page allocator PCP high watermark is lowered if reclaim is active. */
+static inline void
+update_reclaim_active(pg_data_t *pgdat, int highest_zoneidx, bool active)
+{
+	int i;
+	struct zone *zone;
+
+	for (i = 0; i <= highest_zoneidx; i++) {
+		zone = pgdat->node_zones + i;
+
+		if (!managed_zone(zone))
+			continue;
+
+		if (active)
+			set_bit(ZONE_RECLAIM_ACTIVE, &zone->flags);
+		else
+			clear_bit(ZONE_RECLAIM_ACTIVE, &zone->flags);
+	}
+}
+
+static inline void
+set_reclaim_active(pg_data_t *pgdat, int highest_zoneidx)
+{
+	update_reclaim_active(pgdat, highest_zoneidx, true);
+}
+
+static inline void
+clear_reclaim_active(pg_data_t *pgdat, int highest_zoneidx)
+{
+	update_reclaim_active(pgdat, highest_zoneidx, false);
+}
+
 /*
  * For kswapd, balance_pgdat() will reclaim pages across a node from zones
  * that are eligible for use by the caller until at least one zone is
@@ -3774,6 +3806,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	boosted = nr_boost_reclaim;
 
 restart:
+	set_reclaim_active(pgdat, highest_zoneidx);
 	sc.priority = DEF_PRIORITY;
 	do {
 		unsigned long nr_reclaimed = sc.nr_reclaimed;
@@ -3907,6 +3940,8 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		pgdat->kswapd_failures++;
 
 out:
+	clear_reclaim_active(pgdat, highest_zoneidx);
+
 	/* If reclaim was boosted, account for the reclaim done in this pass */
 	if (boosted) {
 		unsigned long flags;
-- 
2.26.2

