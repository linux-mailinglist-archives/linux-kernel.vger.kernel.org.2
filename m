Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1032398E61
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhFBPVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:21:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60906 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhFBPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:20:14 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E64FD21996;
        Wed,  2 Jun 2021 15:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622647110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         in-reply-to:in-reply-to:references:references;
        bh=Ov4ZcasJmGJkSNHBnIiGrTxrqHwuVMl6yhUHWLdDnFs=;
        b=1FCeLGtlmqY97MfoBMskRYl7Vl67U/XlkuHhMZKTwZbESucXPUh0c+lfMx65G4yeGLZXvv
        LyHhQQLeWKe/KuBA1mTcUxdAWWyP0He6Y1eWot9iXOjn2ky3OpUgWj/hgaK2ZbJHRY0vte
        TehzqV3tz0szGx36kSCr2wzR8k8bgGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622647110;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         in-reply-to:in-reply-to:references:references;
        bh=Ov4ZcasJmGJkSNHBnIiGrTxrqHwuVMl6yhUHWLdDnFs=;
        b=mXVIx5/P8ZrKKL5kxs8XqdT/SIZEuWeoJT9lgiZp8RoGEQIWxJpaEDb+ShhLDNvZGSUmGq
        v2i1VZy39QUyOHDQ==
Received: by imap.suse.de (Postfix, from userid 51)
        id DE78111CD4; Wed,  2 Jun 2021 15:28:32 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id CFA1111D1E;
        Wed,  2 Jun 2021 09:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622625310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         in-reply-to:in-reply-to:references:references;
        bh=Ov4ZcasJmGJkSNHBnIiGrTxrqHwuVMl6yhUHWLdDnFs=;
        b=SDfzjOnHuxTEQxVDk+BUJSBm9VP4Oc0kDwmRcgoHXOrId0p//7IgoKPj8uSB3nu8OYUlS9
        Ut549dkOmAdxgSd7JDqUK7fmZV1yk42nVpMxBJbIQB5vbZOBL0M6IyuGjnVYTqc38wlz48
        cOjw/z3KTzi6WglXR8TELbcoRQYDAc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622625310;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         in-reply-to:in-reply-to:references:references;
        bh=Ov4ZcasJmGJkSNHBnIiGrTxrqHwuVMl6yhUHWLdDnFs=;
        b=Tq/TwiW76IDjzxwQu1QrWCHopBbgDNU1CI8dK3WQVXygPh0iDOrMlYBzaqmN/DeO4JO5ub
        s9AV6sGPwA4ahJCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 6KNsLx1Mt2A6HgAALh3uQQ
        (envelope-from <osalvador@suse.de>); Wed, 02 Jun 2021 09:15:09 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 2/3] mm,memory_hotplug: Drop unneeded locking
Date:   Wed,  2 Jun 2021 11:14:56 +0200
Message-Id: <20210602091457.17772-3-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210602091457.17772-1-osalvador@suse.de>
References: <20210602091457.17772-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, memory-hotplug code takes zone's span_writelock
and pgdat's resize_lock when resizing the node/zone's spanned
pages via {move_pfn_range_to_zone(),remove_pfn_range_from_zone()}
and when resizing node and zone's present pages via
adjust_present_page_count().

These locks are also taken during the initialization of the system
at boot time, where it protects parallel struct page initialization,
but they should not really be needed in memory-hotplug where all
operations are a) synchronized on device level and b) serialized by
the mem_hotplug_lock lock.

Given that there are no users of span_seqlock, rip out all related
functions.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/memory_hotplug.h | 35 -----------------------------------
 include/linux/mmzone.h         | 23 +++++------------------
 mm/memory_hotplug.c            | 16 +---------------
 mm/page_alloc.c                |  1 -
 4 files changed, 6 insertions(+), 69 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 28f32fd00fe9..0d837ce6ec11 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -79,31 +79,7 @@ struct range mhp_get_pluggable_range(bool need_mapping);
 
 /*
  * Zone resizing functions
- *
- * Note: any attempt to resize a zone should has pgdat_resize_lock()
- * zone_span_writelock() both held. This ensure the size of a zone
- * can't be changed while pgdat_resize_lock() held.
  */
-static inline unsigned zone_span_seqbegin(struct zone *zone)
-{
-	return read_seqbegin(&zone->span_seqlock);
-}
-static inline int zone_span_seqretry(struct zone *zone, unsigned iv)
-{
-	return read_seqretry(&zone->span_seqlock, iv);
-}
-static inline void zone_span_writelock(struct zone *zone)
-{
-	write_seqlock(&zone->span_seqlock);
-}
-static inline void zone_span_writeunlock(struct zone *zone)
-{
-	write_sequnlock(&zone->span_seqlock);
-}
-static inline void zone_seqlock_init(struct zone *zone)
-{
-	seqlock_init(&zone->span_seqlock);
-}
 extern int zone_grow_free_lists(struct zone *zone, unsigned long new_nr_pages);
 extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
 extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
@@ -248,17 +224,6 @@ void mem_hotplug_done(void);
 	___page;				\
  })
 
-static inline unsigned zone_span_seqbegin(struct zone *zone)
-{
-	return 0;
-}
-static inline int zone_span_seqretry(struct zone *zone, unsigned iv)
-{
-	return 0;
-}
-static inline void zone_span_writelock(struct zone *zone) {}
-static inline void zone_span_writeunlock(struct zone *zone) {}
-static inline void zone_seqlock_init(struct zone *zone) {}
 
 static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
 {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0d53eba1c383..29cd230a383c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -13,7 +13,6 @@
 #include <linux/threads.h>
 #include <linux/numa.h>
 #include <linux/init.h>
-#include <linux/seqlock.h>
 #include <linux/nodemask.h>
 #include <linux/pageblock-flags.h>
 #include <linux/page-flags-layout.h>
@@ -528,18 +527,11 @@ struct zone {
 	 *
 	 * Locking rules:
 	 *
-	 * zone_start_pfn and spanned_pages are protected by span_seqlock.
-	 * It is a seqlock because it has to be read outside of zone->lock,
-	 * and it is done in the main allocator path.  But, it is written
-	 * quite infrequently.
-	 *
-	 * The span_seq lock is declared along with zone->lock because it is
-	 * frequently read in proximity to zone->lock.  It's good to
-	 * give them a chance of being in the same cacheline.
-	 *
-	 * Write access to present_pages at runtime should be protected by
-	 * mem_hotplug_begin/end(). Any reader who can't tolerant drift of
-	 * present_pages should get_online_mems() to get a stable value.
+	 * Besides system initialization functions, memory-hotplug is the only
+	 * user that can change zone's {spanned,present} pages at runtime, and
+	 * it does so by holding the mem_hotplug_lock lock. Any readers who
+	 * can't tolerate drift values should use {get,put}_online_mems to get
+	 * a stable value.
 	 */
 	atomic_long_t		managed_pages;
 	unsigned long		spanned_pages;
@@ -559,11 +551,6 @@ struct zone {
 	unsigned long		nr_isolate_pageblock;
 #endif
 
-#ifdef CONFIG_MEMORY_HOTPLUG
-	/* see spanned/present_pages for more description */
-	seqlock_t		span_seqlock;
-#endif
-
 	int initialized;
 
 	/* Write-intensive fields used from the page allocator */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 70620d0dd923..62d5dc2c01de 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -445,7 +445,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 	unsigned long pfn;
 	int nid = zone_to_nid(zone);
 
-	zone_span_writelock(zone);
 	if (zone->zone_start_pfn == start_pfn) {
 		/*
 		 * If the section is smallest section in the zone, it need
@@ -478,7 +477,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 			zone->spanned_pages = 0;
 		}
 	}
-	zone_span_writeunlock(zone);
 }
 
 static void update_pgdat_span(struct pglist_data *pgdat)
@@ -515,7 +513,7 @@ void __ref remove_pfn_range_from_zone(struct zone *zone,
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
 	struct pglist_data *pgdat = zone->zone_pgdat;
-	unsigned long pfn, cur_nr_pages, flags;
+	unsigned long pfn, cur_nr_pages;
 
 	/* Poison struct pages because they are now uninitialized again. */
 	for (pfn = start_pfn; pfn < end_pfn; pfn += cur_nr_pages) {
@@ -540,10 +538,8 @@ void __ref remove_pfn_range_from_zone(struct zone *zone,
 
 	clear_zone_contiguous(zone);
 
-	pgdat_resize_lock(zone->zone_pgdat, &flags);
 	shrink_zone_span(zone, start_pfn, start_pfn + nr_pages);
 	update_pgdat_span(pgdat);
-	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 
 	set_zone_contiguous(zone);
 }
@@ -750,19 +746,13 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	int nid = pgdat->node_id;
-	unsigned long flags;
 
 	clear_zone_contiguous(zone);
 
-	/* TODO Huh pgdat is irqsave while zone is not. It used to be like that before */
-	pgdat_resize_lock(pgdat, &flags);
-	zone_span_writelock(zone);
 	if (zone_is_empty(zone))
 		init_currently_empty_zone(zone, start_pfn, nr_pages);
 	resize_zone_range(zone, start_pfn, nr_pages);
-	zone_span_writeunlock(zone);
 	resize_pgdat_range(pgdat, start_pfn, nr_pages);
-	pgdat_resize_unlock(pgdat, &flags);
 
 	/*
 	 * Subsection population requires care in pfn_to_online_page().
@@ -852,12 +842,8 @@ struct zone *zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
  */
 void adjust_present_page_count(struct zone *zone, long nr_pages)
 {
-	unsigned long flags;
-
 	zone->present_pages += nr_pages;
-	pgdat_resize_lock(zone->zone_pgdat, &flags);
 	zone->zone_pgdat->node_present_pages += nr_pages;
-	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 }
 
 int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 296cb00802b4..27483245384c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7156,7 +7156,6 @@ static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx,
 	zone->name = zone_names[idx];
 	zone->zone_pgdat = NODE_DATA(nid);
 	spin_lock_init(&zone->lock);
-	zone_seqlock_init(zone);
 	zone_pcp_init(zone);
 }
 
-- 
2.16.3

