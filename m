Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A641393E32
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 09:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbhE1Hxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 03:53:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59372 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhE1Hxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 03:53:35 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A2501218B3;
        Fri, 28 May 2021 07:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622188320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=ejLAcKBj1HyRFBYRWQnOnTKNhRyWpmjRKdoHUgHMJok=;
        b=f9IDGY3BeU24qZ062IbdDfIBaMHHTwjCNwmqWtX63p5JHTyXbFUQUtEhmiyjVCt1hJ7mMk
        OlA42usaLiMTpAPtt17RF0Zvxn7aqVHMQodUxBCjyE7Kc1ajUYQ5S6kgI4LZ7btr/j/p38
        EjxFaNVfNBoUANFwbrgUOKHtZM2ka/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622188320;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=ejLAcKBj1HyRFBYRWQnOnTKNhRyWpmjRKdoHUgHMJok=;
        b=zPIJPgNdhx/aM2DNwYygCG9WHZYaa0X4JQbYBSJZMYDW0vDkCQYiJYP6bZQJ5HcdiQDHh9
        vH1i6zGYMmcj0aCA==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id CD1EF11A98;
        Fri, 28 May 2021 07:51:59 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH RFC] mm,memory_hotplug: Drop unneeded locking
Date:   Fri, 28 May 2021 09:51:55 +0200
Message-Id: <20210528075155.358-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
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

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
During the review of [1], it was brought up that we might need to revisit
the locking scheme in memory-hotplug code wrt. node and zone locks.
Given that memory-hotplug is serialized and synchronized by memory-hotplug lock
and the device, I do not think we need to hold zone/node's resize lock anymore.
After the system has been brought up, memory-hotplug is the only code allow to
touch {spanned,present}_pages, so it cannot really go off when serialized by its
own lock. Or am I missing something?
The only think I am not really sure is: if the from remove_pfn_range_from_zone,
shrink_zone_span, update_pgdat_span and move_pfn_range_to_zone can really go
(because those functions are already serialized by the memory-hotplug lock),
what about mhp_(de)init_memmap_on_memory that calls those functions?
Those are not protected by the lock. I have to confess that when it comes to locking
in this code, I always have to scratch my head.

[1] https://patchwork.kernel.org/project/linux-mm/patch/20210416112411.9826-4-osalvador@suse.de/

 mm/memory_hotplug.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 075b34803fec..6edd7e267cad 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -329,7 +329,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 	unsigned long pfn;
 	int nid = zone_to_nid(zone);
 
-	zone_span_writelock(zone);
 	if (zone->zone_start_pfn == start_pfn) {
 		/*
 		 * If the section is smallest section in the zone, it need
@@ -362,7 +361,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 			zone->spanned_pages = 0;
 		}
 	}
-	zone_span_writeunlock(zone);
 }
 
 static void update_pgdat_span(struct pglist_data *pgdat)
@@ -424,10 +422,8 @@ void __ref remove_pfn_range_from_zone(struct zone *zone,
 
 	clear_zone_contiguous(zone);
 
-	pgdat_resize_lock(zone->zone_pgdat, &flags);
 	shrink_zone_span(zone, start_pfn, start_pfn + nr_pages);
 	update_pgdat_span(pgdat);
-	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 
 	set_zone_contiguous(zone);
 }
@@ -639,14 +635,10 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 	clear_zone_contiguous(zone);
 
 	/* TODO Huh pgdat is irqsave while zone is not. It used to be like that before */
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
@@ -739,9 +731,7 @@ void adjust_present_page_count(struct zone *zone, long nr_pages)
 	unsigned long flags;
 
 	zone->present_pages += nr_pages;
-	pgdat_resize_lock(zone->zone_pgdat, &flags);
 	zone->zone_pgdat->node_present_pages += nr_pages;
-	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 }
 
 int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
-- 
2.16.3

