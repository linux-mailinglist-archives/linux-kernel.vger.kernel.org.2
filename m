Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2542A394191
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbhE1LBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:01:15 -0400
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:60647 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236170AbhE1LBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:01:03 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id 831DAC0B7C
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 11:59:26 +0100 (IST)
Received: (qmail 11325 invoked from network); 28 May 2021 10:59:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 May 2021 10:59:26 -0000
Date:   Fri, 28 May 2021 11:59:25 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: [PATCH] mm/page_alloc: Disassociate the pcp->high from pcp->batch
 -fix
Message-ID: <20210528105925.GN30378@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vlastimil Babka noted that __setup_per_zone_wmarks updating
pcp->high did not protect watermark-related sysctl handlers from a
parallel memory hotplug operations. This patch moves the PCP update to
setup_per_zone_wmarks and updates the PCP high value while protected by
the pcp_batch_high_lock mutex. As a side-effect, the zone_pcp_update calls
during memory hotplug operations becomes redundant and can be removed.

This is a fix to the mmotm patch
mm-page_alloc-disassociate-the-pcp-high-from-pcp-batch.patch.
It'll cause a conflict with
mm-page_alloc-adjust-pcp-high-after-cpu-hotplug-events.patch
but the resolution is simple as the zone_pcp_update callers in
setup_per_zone_wmarks no longer exist.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memory_hotplug.c |  6 +++---
 mm/page_alloc.c     | 14 ++++++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 70620d0dd923..974a565797d8 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -961,7 +961,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, struct zone *z
 	node_states_set_node(nid, &arg);
 	if (need_zonelists_rebuild)
 		build_all_zonelists(NULL);
-	zone_pcp_update(zone);
 
 	/* Basic onlining is complete, allow allocation of onlined pages. */
 	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
@@ -974,6 +973,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, struct zone *z
 	 */
 	shuffle_zone(zone);
 
+	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
 
 	kswapd_run(nid);
@@ -1829,13 +1829,13 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
 	adjust_present_page_count(zone, -nr_pages);
 
+	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
 
 	if (!populated_zone(zone)) {
 		zone_pcp_reset(zone);
 		build_all_zonelists(NULL);
-	} else
-		zone_pcp_update(zone);
+	}
 
 	node_states_clear_node(node, &arg);
 	if (arg.status_change_nid >= 0) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c0536e5d088a..b686344e3889 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8188,12 +8188,6 @@ static void __setup_per_zone_wmarks(void)
 		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
 		zone->_watermark[WMARK_HIGH] = min_wmark_pages(zone) + tmp * 2;
 
-		/*
-		 * The watermark size have changed so update the pcpu batch
-		 * and high limits or the limits may be inappropriate.
-		 */
-		zone_set_pageset_high_and_batch(zone);
-
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 
@@ -8210,11 +8204,19 @@ static void __setup_per_zone_wmarks(void)
  */
 void setup_per_zone_wmarks(void)
 {
+	struct zone *zone;
 	static DEFINE_SPINLOCK(lock);
 
 	spin_lock(&lock);
 	__setup_per_zone_wmarks();
 	spin_unlock(&lock);
+
+	/*
+	 * The watermark size have changed so update the pcpu batch
+	 * and high limits or the limits may be inappropriate.
+	 */
+	for_each_zone(zone)
+		zone_pcp_update(zone);
 }
 
 /*

-- 
Mel Gorman
SUSE Labs
