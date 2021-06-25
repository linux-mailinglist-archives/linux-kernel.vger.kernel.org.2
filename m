Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935B03B455E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhFYOSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231215AbhFYOSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:18:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B65F16162F;
        Fri, 25 Jun 2021 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624630585;
        bh=x+Ksevend6iLWWoL4Ug+OWCuj9KF4gZxnXk4b3z8ZTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I4QvZXty8j1JIZuQ3jb/KvLoaqjNQlnovJYKVBCvsmV9+0IEWdpAsU1Xi50debSU5
         yb5x0jr6iQTbtrLcb3hWue3L2dUT5SwsW6+CDa4L99OG9dXLlv8/dvSNIxUUGk2cVL
         WMOPWKl5fuvfAY3n9J0uZ0Fw9n7Opragc5y42negez8g4GGQ7OTOhNlemyObf2oEFi
         jpMjdW0fRahmN83ktORzIHeuPYLUeqlzC1nz7Gt90Odtsh0ztTDCcsgdpQ+pjlMXbb
         SxEoNyZh1mnQQdJm49G06lIbd1lODQlfLOldEAF0fw4SxMDRvwIjkQbyWnWr1tgcF9
         9e5DAkCsabsew==
Date:   Fri, 25 Jun 2021 17:16:18 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     alfalco@gmail.com, Borislav Petkov <bp@alien8.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        robert.shteynfeld@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: fix memory map initialization for
 descending nodes
Message-ID: <YNXlMqBbL+tBG7yq@kernel.org>
References: <20210624062305.10940-1-rppt@kernel.org>
 <20210624135723.3b2b25de43e22ab4275ea273@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624135723.3b2b25de43e22ab4275ea273@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 01:57:23PM -0700, Andrew Morton wrote:
> On Thu, 24 Jun 2021 09:23:05 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > On systems with memory nodes sorted in descending order, for instance
> > Dell Precision WorkStation T5500, the struct pages for higher PFNs and
> > respectively lower nodes, could be overwritten by the initialization of
> > struct pages corresponding to the holes in the memory sections.
> > 
> > For example for the below memory layout
> > 
> > [    0.245624] Early memory node ranges
> > [    0.248496]   node   1: [mem 0x0000000000001000-0x0000000000090fff]
> > [    0.251376]   node   1: [mem 0x0000000000100000-0x00000000dbdf8fff]
> > [    0.254256]   node   1: [mem 0x0000000100000000-0x0000001423ffffff]
> > [    0.257144]   node   0: [mem 0x0000001424000000-0x0000002023ffffff]
> > 
> > the range 0x1424000000 - 0x1428000000 in the beginning of node 0 starts in
> > the middle of a section and will be considered as a hole during the
> > initialization of the last section in node 1.
> > 
> > Reorder order of the memory map initialization so that the outer loop will
> > always iterate over populated memory regions in the ascending order and the
> > inner loop will select the zone corresponding to the PFN range.
> > 
> > This way initialization of the struct pages for the memory holes will
> > be always done for the ranges that are actually not populated.
> 
> Changelog doesn't tell us what are the user-visible effects of the bug.
> 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=213073
> 
> But that does.  Panic during boot.

Below is v2 with a sentence about the panic added to the changelog, and the
fix of "is is" typo. 
 
> > Fixes: 0740a50b9baa ("mm/page_alloc.c: refactor initialization of struct page for holes in memory layout")
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> So I think we want a cc:stable here?

Right, I've added cc:stable to the patch. Considering how close we are to
the merge window I think this is anyway v5.14 material.

From bec1b8fe385487928b4be720dc2ac88af7d36e74 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Wed, 23 Jun 2021 09:24:01 +0300
Subject: [PATCH v2] mm/page_alloc: fix memory map initialization for
 descending nodes

On systems with memory nodes sorted in descending order, for instance
Dell Precision WorkStation T5500, the struct pages for higher PFNs and
respectively lower nodes, could be overwritten by the initialization of
struct pages corresponding to the holes in the memory sections.

For example for the below memory layout

[    0.245624] Early memory node ranges
[    0.248496]   node   1: [mem 0x0000000000001000-0x0000000000090fff]
[    0.251376]   node   1: [mem 0x0000000000100000-0x00000000dbdf8fff]
[    0.254256]   node   1: [mem 0x0000000100000000-0x0000001423ffffff]
[    0.257144]   node   0: [mem 0x0000001424000000-0x0000002023ffffff]

the range 0x1424000000 - 0x1428000000 in the beginning of node 0 starts in
the middle of a section and will be considered as a hole during the
initialization of the last section in node 1.

The wrong initialization of the memory map causes panic on boot when
CONFIG_DEBUG_VM is enabled.

Reorder loop order of the memory map initialization so that the outer loop
will always iterate over populated memory regions in the ascending order
and the inner loop will select the zone corresponding to the PFN range.

This way initialization of the struct pages for the memory holes will
be always done for the ranges that are actually not populated.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=213073
Fixes: 0740a50b9baa ("mm/page_alloc.c: refactor initialization of struct page for holes in memory layout")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/mm.h |  1 -
 mm/page_alloc.c    | 94 ++++++++++++++++++++++++++++------------------
 2 files changed, 58 insertions(+), 37 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ae31622deef..9afb8998e7e5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2474,7 +2474,6 @@ extern void set_dma_reserve(unsigned long new_dma_reserve);
 extern void memmap_init_range(unsigned long, int, unsigned long,
 		unsigned long, unsigned long, enum meminit_context,
 		struct vmem_altmap *, int migratetype);
-extern void memmap_init_zone(struct zone *zone);
 extern void setup_per_zone_wmarks(void);
 extern int __meminit init_per_zone_wmark_min(void);
 extern void mem_init(void);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d1f5de1c1283..992abb682acb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6396,7 +6396,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		return;
 
 	/*
-	 * The call to memmap_init_zone should have already taken care
+	 * The call to memmap_init should have already taken care
 	 * of the pages reserved for the memmap, so we can just jump to
 	 * the end of that region and start processing the device pages.
 	 */
@@ -6461,7 +6461,7 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 /*
  * Only struct pages that correspond to ranges defined by memblock.memory
  * are zeroed and initialized by going through __init_single_page() during
- * memmap_init_zone().
+ * memmap_init_zone_range().
  *
  * But, there could be struct pages that correspond to holes in
  * memblock.memory. This can happen because of the following reasons:
@@ -6480,9 +6480,9 @@ static void __meminit zone_init_free_lists(struct zone *zone)
  *   zone/node above the hole except for the trailing pages in the last
  *   section that will be appended to the zone/node below.
  */
-static u64 __meminit init_unavailable_range(unsigned long spfn,
-					    unsigned long epfn,
-					    int zone, int node)
+static void __init init_unavailable_range(unsigned long spfn,
+					  unsigned long epfn,
+					  int zone, int node)
 {
 	unsigned long pfn;
 	u64 pgcnt = 0;
@@ -6498,56 +6498,77 @@ static u64 __meminit init_unavailable_range(unsigned long spfn,
 		pgcnt++;
 	}
 
-	return pgcnt;
+	if (pgcnt)
+		pr_info("On node %d, zone %s: %lld pages in unavailable ranges",
+			node, zone_names[zone], pgcnt);
 }
 #else
-static inline u64 init_unavailable_range(unsigned long spfn, unsigned long epfn,
-					 int zone, int node)
+static inline void init_unavailable_range(unsigned long spfn,
+					  unsigned long epfn,
+					  int zone, int node)
 {
-	return 0;
 }
 #endif
 
-void __meminit __weak memmap_init_zone(struct zone *zone)
+static void __init memmap_init_zone_range(struct zone *zone,
+					  unsigned long start_pfn,
+					  unsigned long end_pfn,
+					  unsigned long *hole_pfn)
 {
 	unsigned long zone_start_pfn = zone->zone_start_pfn;
 	unsigned long zone_end_pfn = zone_start_pfn + zone->spanned_pages;
-	int i, nid = zone_to_nid(zone), zone_id = zone_idx(zone);
-	static unsigned long hole_pfn;
+	int nid = zone_to_nid(zone), zone_id = zone_idx(zone);
+
+	start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
+	end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
+
+	if (start_pfn >= end_pfn)
+		return;
+
+	memmap_init_range(end_pfn - start_pfn, nid, zone_id, start_pfn,
+			  zone_end_pfn, MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
+
+	if (*hole_pfn < start_pfn)
+		init_unavailable_range(*hole_pfn, start_pfn, zone_id, nid);
+
+	*hole_pfn = end_pfn;
+}
+
+static void __init memmap_init(void)
+{
 	unsigned long start_pfn, end_pfn;
-	u64 pgcnt = 0;
+	unsigned long hole_pfn = 0;
+	int i, j, zone_id, nid;
 
-	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
-		start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
-		end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
+		struct pglist_data *node = NODE_DATA(nid);
+
+		for (j = 0; j < MAX_NR_ZONES; j++) {
+			struct zone *zone = node->node_zones + j;
 
-		if (end_pfn > start_pfn)
-			memmap_init_range(end_pfn - start_pfn, nid,
-					zone_id, start_pfn, zone_end_pfn,
-					MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
+			if (!populated_zone(zone))
+				continue;
 
-		if (hole_pfn < start_pfn)
-			pgcnt += init_unavailable_range(hole_pfn, start_pfn,
-							zone_id, nid);
-		hole_pfn = end_pfn;
+			memmap_init_zone_range(zone, start_pfn, end_pfn,
+					       &hole_pfn);
+			zone_id = j;
+		}
 	}
 
 #ifdef CONFIG_SPARSEMEM
 	/*
-	 * Initialize the hole in the range [zone_end_pfn, section_end].
-	 * If zone boundary falls in the middle of a section, this hole
-	 * will be re-initialized during the call to this function for the
-	 * higher zone.
+	 * Initialize the memory map for hole in the range [memory_end,
+	 * section_end].
+	 * Append the pages in this hole to the highest zone in the last
+	 * node.
+	 * The call to init_unavailable_range() is outside the ifdef to
+	 * silence the compiler warining about zone_id set but not used;
+	 * for FLATMEM it is nop anyway
 	 */
-	end_pfn = round_up(zone_end_pfn, PAGES_PER_SECTION);
+	end_pfn = round_up(end_pfn, PAGES_PER_SECTION);
 	if (hole_pfn < end_pfn)
-		pgcnt += init_unavailable_range(hole_pfn, end_pfn,
-						zone_id, nid);
 #endif
-
-	if (pgcnt)
-		pr_info("  %s zone: %llu pages in unavailable ranges\n",
-			zone->name, pgcnt);
+		init_unavailable_range(hole_pfn, end_pfn, zone_id, nid);
 }
 
 static int zone_batchsize(struct zone *zone)
@@ -7250,7 +7271,6 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		set_pageblock_order();
 		setup_usemap(zone);
 		init_currently_empty_zone(zone, zone->zone_start_pfn, size);
-		memmap_init_zone(zone);
 	}
 }
 
@@ -7776,6 +7796,8 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 			node_set_state(nid, N_MEMORY);
 		check_for_memory(pgdat, nid);
 	}
+
+	memmap_init();
 }
 
 static int __init cmdline_parse_core(char *p, unsigned long *core,
-- 
2.28.0

 

-- 
Sincerely yours,
Mike.
