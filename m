Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE8236692B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239389AbhDUK1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:27:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:38094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238780AbhDUK1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:27:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DA865B00E;
        Wed, 21 Apr 2021 10:27:07 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v10 3/8] mm,memory_hotplug: Factor out adjusting present pages into adjust_present_page_count()
Date:   Wed, 21 Apr 2021 12:26:56 +0200
Message-Id: <20210421102701.25051-4-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210421102701.25051-1-osalvador@suse.de>
References: <20210421102701.25051-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

Let's have a single place (inspired by adjust_managed_page_count()) where
we adjust present pages.
In contrast to adjust_managed_page_count(), only memory onlining/offlining
is allowed to modify the number of present pages.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e6aafd17a01a..b954fd10474e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -829,6 +829,16 @@ struct zone * zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
 	return default_zone_for_pfn(nid, start_pfn, nr_pages);
 }
 
+static void adjust_present_page_count(struct zone *zone, long nr_pages)
+{
+	unsigned long flags;
+
+	zone->present_pages += nr_pages;
+	pgdat_resize_lock(zone->zone_pgdat, &flags);
+	zone->zone_pgdat->node_present_pages += nr_pages;
+	pgdat_resize_unlock(zone->zone_pgdat, &flags);
+}
+
 int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		       int online_type, int nid)
 {
@@ -884,11 +894,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	}
 
 	online_pages_range(pfn, nr_pages);
-	zone->present_pages += nr_pages;
-
-	pgdat_resize_lock(zone->zone_pgdat, &flags);
-	zone->zone_pgdat->node_present_pages += nr_pages;
-	pgdat_resize_unlock(zone->zone_pgdat, &flags);
+	adjust_present_page_count(zone, nr_pages);
 
 	node_states_set_node(nid, &arg);
 	if (need_zonelists_rebuild)
@@ -1705,11 +1711,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 
 	/* removal success */
 	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
-	zone->present_pages -= nr_pages;
-
-	pgdat_resize_lock(zone->zone_pgdat, &flags);
-	zone->zone_pgdat->node_present_pages -= nr_pages;
-	pgdat_resize_unlock(zone->zone_pgdat, &flags);
+	adjust_present_page_count(zone, -nr_pages);
 
 	init_per_zone_wmark_min();
 
-- 
2.16.3

