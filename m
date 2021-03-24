Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15653347AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbhCXOmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:42:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:51852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236277AbhCXOmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:42:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616596933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p3BH4iH92NViRIgwJ7taVMwGIIzHlwzCXFTKjqZA9zc=;
        b=M/KAUWtmbCcq6owIc+rR+ZAnDxOLWNNyPWFkWTMOSxD9cdKf2U0k57RJsFls9/4Pvwcxfw
        R8DLCJMmr5hxJJEgsqxTgMOFnWJBOZbijtT+ztN04KIXtRoxvqb+jqn5QgyflWjk0TiZIj
        xzFIqEE62tWqj4/HVhyNjDAF58P3Ag4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 72D13AF44;
        Wed, 24 Mar 2021 14:42:13 +0000 (UTC)
Date:   Wed, 24 Mar 2021 15:42:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YFtPxH0CT5QZsnR1@dhcp22.suse.cz>
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-2-osalvador@suse.de>
 <YFm+7ifpyzm6eNy8@dhcp22.suse.cz>
 <20210324101259.GB16560@linux>
 <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-03-21 13:03:29, Michal Hocko wrote:
> On Wed 24-03-21 11:12:59, Oscar Salvador wrote:
[...]
> > I kind of understand to be reluctant to use vmemmap_pages terminology here, but
> > unfortunately we need to know about it.
> > We could rename nr_vmemmap_pages to offset_buddy_pages or something like that.
> 
> I am not convinced. It seems you are justr trying to graft the new
> functionality in. But I still believe that {on,off}lining shouldn't care
> about where their vmemmaps come from at all. It should be a
> responsibility of the code which reserves that space to compansate for
> accounting. Otherwise we will end up with a hard to maintain code
> because expectations would be spread at way too many places. Not to
> mention different pfns that the code should care about.

The below is a quick hack on top of this patch to illustrate my
thinking. I have dug out all the vmemmap pieces out of the
{on,off}lining and hooked all the accounting when the space is reserved.
This just compiles without any deeper look so there are likely some
minor problems but I haven't really encountered any major problems or
hacks to introduce into the code. The separation seems to be possible.
The diffstat also looks promising. Am I missing something fundamental in
this?

--- 
 drivers/base/memory.c          |   8 +--
 include/linux/memory_hotplug.h |   6 +-
 mm/memory_hotplug.c            | 151 ++++++++++++++++++++---------------------
 3 files changed, 80 insertions(+), 85 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 5ea2b3fbce02..9697acfe96eb 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -181,15 +181,15 @@ memory_block_action(unsigned long start_section_nr, unsigned long action,
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	int ret;
 
-	start_pfn = section_nr_to_pfn(start_section_nr);
+	start_pfn = section_nr_to_pfn(start_section_nr) + nr_vmemmap_pages;
+	nr_pages -= nr_vmemmap_pages;
 
 	switch (action) {
 	case MEM_ONLINE:
-		ret = online_pages(start_pfn, nr_pages, nr_vmemmap_pages,
-				   online_type, nid);
+		ret = online_pages(start_pfn, nr_pages, online_type, nid);
 		break;
 	case MEM_OFFLINE:
-		ret = offline_pages(start_pfn, nr_pages, nr_vmemmap_pages);
+		ret = offline_pages(start_pfn, nr_pages);
 		break;
 	default:
 		WARN(1, KERN_WARNING "%s(%ld, %ld) unknown action: "
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index a85d4b7d15c2..673d2d4a8443 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -109,8 +109,7 @@ extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
 extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
 /* VM interface that may be used by firmware interface */
 extern int online_pages(unsigned long pfn, unsigned long nr_pages,
-			unsigned long nr_vmemmap_pages, int online_type,
-			int nid);
+			int online_type, int nid);
 extern struct zone *test_pages_in_a_zone(unsigned long start_pfn,
 					 unsigned long end_pfn);
 extern void __offline_isolated_pages(unsigned long start_pfn,
@@ -317,8 +316,7 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
 #ifdef CONFIG_MEMORY_HOTREMOVE
 
 extern void try_offline_node(int nid);
-extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
-			 unsigned long nr_vmemmap_pages);
+extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
 extern int remove_memory(int nid, u64 start, u64 size);
 extern void __remove_memory(int nid, u64 start, u64 size);
 extern int offline_and_remove_memory(int nid, u64 start, u64 size);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0c3a98cb8cde..754026a9164d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -844,30 +844,19 @@ struct zone * zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
 }
 
 int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
-		       unsigned long nr_vmemmap_pages, int online_type, int nid)
+		       int online_type, int nid)
 {
-	unsigned long flags, buddy_start_pfn, buddy_nr_pages;
+	unsigned long flags;
 	struct zone *zone;
 	int need_zonelists_rebuild = 0;
 	int ret;
 	struct memory_notify arg;
 
-	/* We can only online full sections (e.g., SECTION_IS_ONLINE) */
-	if (WARN_ON_ONCE(!nr_pages ||
-			 !IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION)))
-		return -EINVAL;
-
-	buddy_start_pfn = pfn + nr_vmemmap_pages;
-	buddy_nr_pages = nr_pages - nr_vmemmap_pages;
-
 	mem_hotplug_begin();
 
 	/* associate pfn range with the zone */
 	zone = zone_for_pfn_range(online_type, nid, pfn, nr_pages);
-	if (nr_vmemmap_pages)
-		move_pfn_range_to_zone(zone, pfn, nr_vmemmap_pages, NULL,
-				       MIGRATE_UNMOVABLE);
-	move_pfn_range_to_zone(zone, buddy_start_pfn, buddy_nr_pages, NULL,
+	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL,
 			       MIGRATE_ISOLATE);
 
 	arg.start_pfn = pfn;
@@ -884,7 +873,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	 * onlining, such that undo_isolate_page_range() works correctly.
 	 */
 	spin_lock_irqsave(&zone->lock, flags);
-	zone->nr_isolate_pageblock += buddy_nr_pages / pageblock_nr_pages;
+	zone->nr_isolate_pageblock += nr_pages / pageblock_nr_pages;
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	/*
@@ -897,7 +886,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		setup_zone_pageset(zone);
 	}
 
-	online_pages_range(pfn, nr_pages, buddy_start_pfn);
+	online_pages_range(pfn, nr_pages, pfn);
 	zone->present_pages += nr_pages;
 
 	pgdat_resize_lock(zone->zone_pgdat, &flags);
@@ -910,9 +899,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	zone_pcp_update(zone);
 
 	/* Basic onlining is complete, allow allocation of onlined pages. */
-	undo_isolate_page_range(buddy_start_pfn,
-				buddy_start_pfn + buddy_nr_pages,
-				MIGRATE_MOVABLE);
+	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
 
 	/*
 	 * Freshly onlined pages aren't shuffled (e.g., all pages are placed to
@@ -1126,6 +1113,59 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
 	       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
 }
 
+static void reserve_vmmemmap_space(int nid, unsigned long pfn, unsigned long nr_pages, struct vmem_altmap *altmap)
+{
+	struct zone *zone = &NODE_DATA(nid)->node_zones[ZONE_NORMAL];
+
+	altmap->free = nr_pages;
+	altmap->base_pfn = pfn;
+
+	/* initialize struct pages and account for this space */
+	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
+}
+
+static void unaccount_vmemmap_space(int nid, unsigned long start_pfn, unsigned long nr_pages)
+{
+	struct zone *zone = &NODE_DATA(nid)->node_zones[ZONE_NORMAL];
+	unsigned long flags;
+
+	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
+	zone->present_pages -= nr_pages;
+
+	pgdat_resize_lock(zone->zone_pgdat, &flags);
+	zone->zone_pgdat->node_present_pages -= nr_pages;
+	pgdat_resize_unlock(zone->zone_pgdat, &flags);
+
+	remove_pfn_range_from_zone(zone, start_pfn, nr_pages);
+}
+
+static int remove_memory_block_cb(struct memory_block *mem, void *arg)
+{
+	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
+	struct vmem_altmap mhp_altmap = {};
+	struct vmem_altmap *altmap = NULL;
+	u64 start = PFN_PHYS(section_nr_to_pfn(mem->start_section_nr));
+	u64 size = memory_block_size_bytes();
+
+	if (!mem->nr_vmemmap_pages) {
+		arch_remove_memory(mem->nid, start, size, NULL);
+		return 0;
+	}
+
+	/*
+	 * Let remove_pmd_table->free_hugepage_table
+	 * do the right thing if we used vmem_altmap
+	 * when hot-adding the range.
+	 */
+	mhp_altmap.alloc = nr_vmemmap_pages;
+	altmap = &mhp_altmap;
+
+	unaccount_vmemmap_space(mem->nid, PHYS_PFN(start), nr_vmemmap_pages);
+	arch_remove_memory(mem->nid, start, size, altmap);
+
+	return 0;
+}
+
 /*
  * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
  * and online/offline operations (triggered e.g. by sysfs).
@@ -1170,8 +1210,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 			ret = -EINVAL;
 			goto error;
 		}
-		mhp_altmap.free = PHYS_PFN(size);
-		mhp_altmap.base_pfn = PHYS_PFN(start);
+		reserve_vmmemmap_space(nid, PHYS_PFN(start), PHYS_PFN(size), &mhp_altmap);
 		params.altmap = &mhp_altmap;
 	}
 
@@ -1639,25 +1678,16 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
 	return 0;
 }
 
-int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
-			unsigned long nr_vmemmap_pages)
+int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
-	unsigned long pfn, buddy_start_pfn, buddy_nr_pages, system_ram_pages = 0;
+	unsigned long pfn, system_ram_pages = 0;
 	unsigned long flags;
 	struct zone *zone;
 	struct memory_notify arg;
 	int ret, node;
 	char *reason;
 
-	/* We can only offline full sections (e.g., SECTION_IS_ONLINE) */
-	if (WARN_ON_ONCE(!nr_pages ||
-			 !IS_ALIGNED(start_pfn | nr_pages, PAGES_PER_SECTION)))
-		return -EINVAL;
-
-	buddy_start_pfn = start_pfn + nr_vmemmap_pages;
-	buddy_nr_pages = nr_pages - nr_vmemmap_pages;
-
 	mem_hotplug_begin();
 
 	/*
@@ -1693,7 +1723,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	zone_pcp_disable(zone);
 
 	/* set above range as isolated */
-	ret = start_isolate_page_range(buddy_start_pfn, end_pfn,
+	ret = start_isolate_page_range(start_pfn, end_pfn,
 				       MIGRATE_MOVABLE,
 				       MEMORY_OFFLINE | REPORT_FAILURE);
 	if (ret) {
@@ -1713,7 +1743,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	}
 
 	do {
-		pfn = buddy_start_pfn;
+		pfn = start_pfn;
 		do {
 			if (signal_pending(current)) {
 				ret = -EINTR;
@@ -1744,18 +1774,18 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 		 * offlining actually in order to make hugetlbfs's object
 		 * counting consistent.
 		 */
-		ret = dissolve_free_huge_pages(buddy_start_pfn, end_pfn);
+		ret = dissolve_free_huge_pages(start_pfn, end_pfn);
 		if (ret) {
 			reason = "failure to dissolve huge pages";
 			goto failed_removal_isolated;
 		}
 
-		ret = test_pages_isolated(buddy_start_pfn, end_pfn, MEMORY_OFFLINE);
+		ret = test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE);
 
 	} while (ret);
 
 	/* Mark all sections offline and remove free pages from the buddy. */
-	__offline_isolated_pages(start_pfn, end_pfn, buddy_start_pfn);
+	__offline_isolated_pages(start_pfn, end_pfn, start_pfn);
 	pr_debug("Offlined Pages %ld\n", nr_pages);
 
 	/*
@@ -1764,13 +1794,13 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	 * of isolated pageblocks, memory onlining will properly revert this.
 	 */
 	spin_lock_irqsave(&zone->lock, flags);
-	zone->nr_isolate_pageblock -= buddy_nr_pages / pageblock_nr_pages;
+	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	zone_pcp_enable(zone);
 
 	/* removal success */
-	adjust_managed_page_count(pfn_to_page(start_pfn), -buddy_nr_pages);
+	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
 	zone->present_pages -= nr_pages;
 
 	pgdat_resize_lock(zone->zone_pgdat, &flags);
@@ -1799,7 +1829,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	return 0;
 
 failed_removal_isolated:
-	undo_isolate_page_range(buddy_start_pfn, end_pfn, MIGRATE_MOVABLE);
+	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
 	memory_notify(MEM_CANCEL_OFFLINE, &arg);
 failed_removal_pcplists_disabled:
 	zone_pcp_enable(zone);
@@ -1830,14 +1860,6 @@ static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
 	return 0;
 }
 
-static int get_nr_vmemmap_pages_cb(struct memory_block *mem, void *arg)
-{
-	/*
-	 * If not set, continue with the next block.
-	 */
-	return mem->nr_vmemmap_pages;
-}
-
 static int check_cpu_on_node(pg_data_t *pgdat)
 {
 	int cpu;
@@ -1912,9 +1934,6 @@ EXPORT_SYMBOL(try_offline_node);
 static int __ref try_remove_memory(int nid, u64 start, u64 size)
 {
 	int rc = 0;
-	struct vmem_altmap mhp_altmap = {};
-	struct vmem_altmap *altmap = NULL;
-	unsigned long nr_vmemmap_pages = 0;
 
 	BUG_ON(check_hotplug_memory_range(start, size));
 
@@ -1927,31 +1946,6 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
 	if (rc)
 		return rc;
 
-	/*
-	 * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
-	 * the same granularity it was added - a single memory block.
-	 */
-	if (memmap_on_memory) {
-		nr_vmemmap_pages = walk_memory_blocks(start, size, NULL,
-						      get_nr_vmemmap_pages_cb);
-		if (nr_vmemmap_pages) {
-			if (size != memory_block_size_bytes()) {
-				pr_warn("Refuse to remove %#llx - %#llx,"
-					"wrong granularity\n",
-					 start, start + size);
-				return -EINVAL;
-			}
-
-			/*
-			 * Let remove_pmd_table->free_hugepage_table
-			 * do the right thing if we used vmem_altmap
-			 * when hot-adding the range.
-			 */
-			mhp_altmap.alloc = nr_vmemmap_pages;
-			altmap = &mhp_altmap;
-		}
-	}
-
 	/* remove memmap entry */
 	firmware_map_remove(start, start + size, "System RAM");
 
@@ -1963,7 +1957,10 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
 
 	mem_hotplug_begin();
 
-	arch_remove_memory(nid, start, size, altmap);
+	if (!memmap_on_memory)
+		arch_remove_memory(nid, start, size, NULL);
+	else
+		walk_memory_blocks(start, size, NULL, remove_memory_block_cb);
 
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
 		memblock_free(start, size);
-- 
Michal Hocko
SUSE Labs
