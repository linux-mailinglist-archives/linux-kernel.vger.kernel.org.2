Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBED359F3D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhDIMs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:48:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:37322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231756AbhDIMs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:48:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617972493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/cklqRtaAoBxj6T8zaOYaeYthIiew+7URzqJWSDV+A4=;
        b=nH5uQ/hzVZLcswwNjsuRUB8vnnaKjiKfQtjZmowow1wDF0qUEGQCeCAR60WiOWkCTvKm+n
        4v2khlPRms4RgZrOmITu1wvBJGjG/gAETYXCvKez8A9Hpip+O40YRbRoFBFiLY0yCMJWQs
        HrwzP2axM2tCz+jYqaZ8ocm//DUGev0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3916DAFD8;
        Fri,  9 Apr 2021 12:48:13 +0000 (UTC)
Date:   Fri, 9 Apr 2021 14:48:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm/memory_hotplug: Make unpopulated zones PCP structures
 unreachable during hot remove
Message-ID: <YHBNDEAw1OqIWwb5@dhcp22.suse.cz>
References: <20210409120957.GM3697@techsingularity.net>
 <YHBL0e8s+EesIyDl@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHBL0e8s+EesIyDl@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-04-21 14:42:58, Michal Hocko wrote:
> On Fri 09-04-21 13:09:57, Mel Gorman wrote:
> > zone_pcp_reset allegedly protects against a race with drain_pages
> > using local_irq_save but this is bogus. local_irq_save only operates
> > on the local CPU. If memory hotplug is running on CPU A and drain_pages
> > is running on CPU B, disabling IRQs on CPU A does not affect CPU B and
> > offers no protection.
> 
> Yes, the synchronization aspect is bogus indeed.
> 
> > This patch reorders memory hotremove such that the PCP structures
> > relevant to the zone are no longer reachable by the time the structures
> > are freed.  With this reordering, no protection is required to prevent
> > a use-after-free and the IRQs can be left enabled. zone_pcp_reset is
> > renamed to zone_pcp_destroy to make it clear that the per-cpu structures
> > are deleted when the function returns.
> 
> Wouldn't it be much easier to simply not destroy/reset pcp of an empty
> zone at all? The whole point of this exercise seems to be described in
> 340175b7d14d5. setup_zone_pageset can check for an already allocated pcp
> and simply reinitialize it. 

I meant this

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 754026a9164d..7169342f5474 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1810,7 +1818,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	init_per_zone_wmark_min();
 
 	if (!populated_zone(zone)) {
-		zone_pcp_reset(zone);
 		build_all_zonelists(NULL);
 	} else
 		zone_pcp_update(zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e6a602e82860..b0fdda77e570 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6496,7 +6496,13 @@ void __meminit setup_zone_pageset(struct zone *zone)
 	struct per_cpu_pageset *p;
 	int cpu;
 
-	zone->pageset = alloc_percpu(struct per_cpu_pageset);
+	/*
+	 * zone could have gone completely offline during memory hotplug
+	 * when the pgdat is left behind for simplicity. On a next onlining
+	 * we do not need to reallocate pcp state.
+	 */
+	if (!zone->pageset)
+		zone->pageset = alloc_percpu(struct per_cpu_pageset);
 	for_each_possible_cpu(cpu) {
 		p = per_cpu_ptr(zone->pageset, cpu);
 		pageset_init(p);
@@ -8803,25 +8809,6 @@ void zone_pcp_enable(struct zone *zone)
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
-void zone_pcp_reset(struct zone *zone)
-{
-	unsigned long flags;
-	int cpu;
-	struct per_cpu_pageset *pset;
-
-	/* avoid races with drain_pages()  */
-	local_irq_save(flags);
-	if (zone->pageset != &boot_pageset) {
-		for_each_online_cpu(cpu) {
-			pset = per_cpu_ptr(zone->pageset, cpu);
-			drain_zonestat(zone, pset);
-		}
-		free_percpu(zone->pageset);
-		zone->pageset = &boot_pageset;
-	}
-	local_irq_restore(flags);
-}
-
 #ifdef CONFIG_MEMORY_HOTREMOVE
 /*
  * All pages in the range must be in a single zone, must not contain holes,
-- 
Michal Hocko
SUSE Labs
