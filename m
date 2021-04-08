Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C394435831A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhDHMSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:18:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:39438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231426AbhDHMSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:18:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E4A56B10B;
        Thu,  8 Apr 2021 12:18:19 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v7 3/8] mm,memory_hotplug: Factor out adjusting present pages into adjust_present_page_count()
Date:   Thu,  8 Apr 2021 14:17:59 +0200
Message-Id: <20210408121804.10440-4-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210408121804.10440-1-osalvador@suse.de>
References: <20210408121804.10440-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 25e59d5dc13c..d05056b3c173 100644
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
@@ -882,11 +892,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
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
@@ -1701,11 +1707,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 
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

