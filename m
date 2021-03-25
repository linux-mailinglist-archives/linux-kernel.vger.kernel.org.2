Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5C4349C18
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 23:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhCYWHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 18:07:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:35228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhCYWGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 18:06:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A01EAC16;
        Thu, 25 Mar 2021 22:06:53 +0000 (UTC)
Date:   Thu, 25 Mar 2021 23:06:50 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YF0JerCFXzcmMKzp@localhost.localdomain>
References: <062bc5d7-a83c-1c1a-7b77-9f043643f4fa@redhat.com>
 <YFyfdDAoWON6IoPL@dhcp22.suse.cz>
 <31c3e6f7-f631-7b00-2c33-518b0f24a75f@redhat.com>
 <YFyoU/rkEPK3VPlN@dhcp22.suse.cz>
 <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
 <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz>
 <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
 <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
 <YFy8ARml4R7/snVs@dhcp22.suse.cz>
 <YFy+olsdS4iwrovN@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFy+olsdS4iwrovN@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 05:47:30PM +0100, Michal Hocko wrote:
> On Thu 25-03-21 17:36:22, Michal Hocko wrote:
> > If all it takes is to make pfn_to_online_page work (and my
> > previous attempt is incorrect because it should consult block rather
> > than section pfn range)
> 
> This should work.

Sorry, but while this solves some of the issues with that approach, I really
think that overcomplicates things and buys us not so much in return.
To me it seems that we are just patching things to make it work that
way.

To be honest, I dislike this, and I guess we can only agree to disagree
here.

I find the following much easier, cleaner, and less risky to encounter
pitfalls in the future:

(!!!It is untested and incomplete, and I would be surprised if it even
compiles, but it is enough as a PoC !!!)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 5ea2b3fbce02..799d14fc2f9b 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -169,6 +169,60 @@ int memory_notify(unsigned long val, void *v)
 	return blocking_notifier_call_chain(&memory_chain, val, v);
 }

+static int memory_block_online(unsigned long start_pfn, unsigned long nr_pages,
+			       unsigned long nr_vmemmap_pages, int online_type,
+			       int nid)
+{
+	int ret;
+	/*
+	 * Despite vmemmap pages having a different lifecycle than the pages
+	 * they describe, initialiating and accounting vmemmap pages at the
+	 * online/offline stage eases things a lot.
+	 * We do it out of {online,offline}_pages, so those routines only have
+	 * to deal with pages that are actual usable memory.
+	 */
+	if (nr_vmemmap_pages) {
+		struct zone *z;
+
+		z = zone_for_pfn_range(online_type, nid, start_pfn, nr_pages);
+		move_pfn_range_to_zone(z, start_pfn, nr_vmemmap_pages, NULL,
+				       MIGRATE_UNMOVABLE);
+		/*
+		 * The below could go to a helper to make it less bulky here,
+		 * so {online,offline}_pages could also use it.
+		 */
+		z->present_pages += nr_pages;
+		pgdat_resize_lock(z->zone_pgdat, &flags);
+		z->zone_pgdat->node_present_pages += nr_pages;
+		pgdat_resize_unlock(z->zone_pgdat, &flags);
+	}
+
+	ret = online_pages(start_pfn + nr_vmemmap_pages, nr_pages - nr_vmemmap_pages,
+			   online_type);
+
+	/*
+	 * In case online_pages() failed for some reason, we should cleanup vmemmap
+	 * accounting as well.
+	 */
+	return ret;
+}
+
+static int memory_block_offline(unsigned long start_pfn, unsigned long nr_pages,
+				unsigned long nr_vmemmap_pages)
+{
+	int ret;
+
+	if (nr_vmemmap_pages) {
+		/*
+		 * Do the opposite of memory_block_online
+		 */
+	}
+
+	ret = offline_pages(start_pfn, nr_pages);
+
+	return ret;
+}
+
 /*
  * MEMORY_HOTPLUG depends on SPARSEMEM in mm/Kconfig, so it is
  * OK to have direct references to sparsemem variables in here.
@@ -185,11 +239,11 @@ memory_block_action(unsigned long start_section_nr, unsigned long action,

 	switch (action) {
 	case MEM_ONLINE:
-		ret = online_pages(start_pfn, nr_pages, nr_vmemmap_pages,
-				   online_type, nid);
+		ret = memory_block_online(start_pfn, nr_pages, nr_vmemmap_pages,
+					  online_type, nid);
 		break;
 	case MEM_OFFLINE:
-		ret = offline_pages(start_pfn, nr_pages, nr_vmemmap_pages);
+		ret = memory_block_offline(start_pfn, nr_pages, nr_vmemmap_pages);
 		break;
 	default:
 		WARN(1, KERN_WARNING "%s(%ld, %ld) unknown action: "
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index a85d4b7d15c2..d2c734eaccb4 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -109,13 +109,11 @@ extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
 extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
 /* VM interface that may be used by firmware interface */
 extern int online_pages(unsigned long pfn, unsigned long nr_pages,
-			unsigned long nr_vmemmap_pages, int online_type,
-			int nid);
+			int online_type, int nid);
 extern struct zone *test_pages_in_a_zone(unsigned long start_pfn,
 					 unsigned long end_pfn);
 extern void __offline_isolated_pages(unsigned long start_pfn,
-				     unsigned long end_pfn,
-				     unsigned long buddy_start_pfn);
+				     unsigned long end_pfn);

 typedef void (*online_page_callback_t)(struct page *page, unsigned int order);

@@ -317,8 +315,7 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
 #ifdef CONFIG_MEMORY_HOTREMOVE

 extern void try_offline_node(int nid);
-extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
-			 unsigned long nr_vmemmap_pages);
+extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
 extern int remove_memory(int nid, u64 start, u64 size);
 extern void __remove_memory(int nid, u64 start, u64 size);
 extern int offline_and_remove_memory(int nid, u64 start, u64 size);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 350cde69a97d..0d9ef34509bd 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -640,22 +640,10 @@ void generic_online_page(struct page *page, unsigned int order)
 }
 EXPORT_SYMBOL_GPL(generic_online_page);

-static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
-			       unsigned long buddy_start_pfn)
+static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
-	unsigned long pfn = buddy_start_pfn;
-
-	/*
-	 * When using memmap_on_memory, the range might be unaligned as the
-	 * first pfns are used for vmemmap pages. Align it in case we need to.
-	 */
-	VM_BUG_ON(!IS_ALIGNED(pfn, pageblock_nr_pages));
-
-	while (!IS_ALIGNED(pfn, MAX_ORDER_NR_PAGES)) {
-		(*online_page_callback)(pfn_to_page(pfn), pageblock_order);
-		pfn += pageblock_nr_pages;
-	}
+	unsigned long pfn = start_pfn;

 	/*
 	 * Online the pages in MAX_ORDER - 1 aligned chunks. The callback might
@@ -844,9 +832,9 @@ struct zone * zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
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
@@ -857,17 +845,11 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 			 !IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;

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
+	move_pfn_range_to_zone(zone, start_pfn, nr_pages, NULL,
 			       MIGRATE_ISOLATE);

 	arg.start_pfn = pfn;
@@ -884,7 +866,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	 * onlining, such that undo_isolate_page_range() works correctly.
 	 */
 	spin_lock_irqsave(&zone->lock, flags);
-	zone->nr_isolate_pageblock += buddy_nr_pages / pageblock_nr_pages;
+	zone->nr_isolate_pageblock += nr_pages / pageblock_nr_pages;
 	spin_unlock_irqrestore(&zone->lock, flags);

 	/*
@@ -897,7 +879,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		setup_zone_pageset(zone);
 	}

-	online_pages_range(pfn, nr_pages, buddy_start_pfn);
+	online_pages_range(pfn, nr_pages);
 	zone->present_pages += nr_pages;

 	pgdat_resize_lock(zone->zone_pgdat, &flags);
@@ -910,8 +892,8 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	zone_pcp_update(zone);

 	/* Basic onlining is complete, allow allocation of onlined pages. */
-	undo_isolate_page_range(buddy_start_pfn,
-				buddy_start_pfn + buddy_nr_pages,
+	undo_isolate_page_range(start_pfn,
+				start_pfn + nr_pages,
 				MIGRATE_MOVABLE);

 	/*
@@ -1639,11 +1621,10 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
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
@@ -1655,9 +1636,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 			 !IS_ALIGNED(start_pfn | nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;

-	buddy_start_pfn = start_pfn + nr_vmemmap_pages;
-	buddy_nr_pages = nr_pages - nr_vmemmap_pages;
-
 	mem_hotplug_begin();

 	/*
@@ -1693,7 +1671,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	zone_pcp_disable(zone);

 	/* set above range as isolated */
-	ret = start_isolate_page_range(buddy_start_pfn, end_pfn,
+	ret = start_isolate_page_range(start_pfn, end_pfn,
 				       MIGRATE_MOVABLE,
 				       MEMORY_OFFLINE | REPORT_FAILURE);
 	if (ret) {
@@ -1713,7 +1691,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	}

 	do {
-		pfn = buddy_start_pfn;
+		pfn = start_pfn;
 		do {
 			if (signal_pending(current)) {
 				ret = -EINTR;
@@ -1744,18 +1722,18 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
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
+	__offline_isolated_pages(start_pfn, end_pfn);
 	pr_debug("Offlined Pages %ld\n", nr_pages);

 	/*
@@ -1764,13 +1742,13 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
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
@@ -1799,7 +1777,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	return 0;

 failed_removal_isolated:
-	undo_isolate_page_range(buddy_start_pfn, end_pfn, MIGRATE_MOVABLE);
+	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
 	memory_notify(MEM_CANCEL_OFFLINE, &arg);
 failed_removal_pcplists_disabled:
 	zone_pcp_enable(zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 85c478e374d7..3e4b29ee2b1e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8830,8 +8830,7 @@ void zone_pcp_reset(struct zone *zone)
  * All pages in the range must be in a single zone, must not contain holes,
  * must span full sections, and must be isolated before calling this function.
  */
-void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn,
-			      unsigned long buddy_start_pfn)
+void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn = start_pfn;
 	struct page *page;
@@ -8842,7 +8841,6 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn,
 	offline_mem_sections(pfn, end_pfn);
 	zone = page_zone(pfn_to_page(pfn));
 	spin_lock_irqsave(&zone->lock, flags);
-	pfn = buddy_start_pfn;
 	while (pfn < end_pfn) {
 		page = pfn_to_page(pfn);
 		/*


-- 
Oscar Salvador
SUSE L3
