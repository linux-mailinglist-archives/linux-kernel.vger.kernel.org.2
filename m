Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F5B395841
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhEaJlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:41:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48588 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhEaJlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:41:42 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 118A81FD2E;
        Mon, 31 May 2021 09:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622454002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=B6vJGCeBItbMKITVN84NRMnJUjGJul8S8oWcxChU3SQ=;
        b=Gk8mfx1UTwzLBSB5QB8QSdZ1pR1CtOobl5+Km6YbI6WMo0AY3xdBEqQVnac01UnL3Bc3cF
        fEWj3bEyA0WLQ3D3rwPB2+Cl+4E0kuiOocfphQYkwGp4LHZr5uK08z/LmCE+M6Px3AjZ/n
        V7SiHaYdhs2TlEHlID3K79ccrlQAtrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622454002;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=B6vJGCeBItbMKITVN84NRMnJUjGJul8S8oWcxChU3SQ=;
        b=p3btLM6/sV9fM6QeKf3/rnQKKwnWLH+ki7770KlwF3qfTFXWwDjSAYAqF6NOxjP148+Og1
        hZ98jnj393dZahAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 4A461118DD;
        Mon, 31 May 2021 09:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622454001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=B6vJGCeBItbMKITVN84NRMnJUjGJul8S8oWcxChU3SQ=;
        b=UYCLo9SH2hEgfz5NPnVXejCb7vvH4k1px8oaEQe/dgcKXk56Xx7p7FAda2Sy0qnxXS3Crk
        aA0kwVjyB2jjW2sq6u5M1xD/SM13lWrlxE9wo0gIxOPSbUqjxJefgS8+8eAHlFihVhXVSc
        ORoLgEkQaK4p7YYkoOTkxzuz0R0V0OU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622454001;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=B6vJGCeBItbMKITVN84NRMnJUjGJul8S8oWcxChU3SQ=;
        b=DwZmGWx95oQ44tuUq/OKRpox3ty1G1XR4m7zqmku0fWcXu4iTP4kO3Jzaon3a/VRnj1cGK
        NGJY40Nu+2d4cdCw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id R0PJDvGutGD9XgAALh3uQQ
        (envelope-from <osalvador@suse.de>); Mon, 31 May 2021 09:40:01 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm,memory_hotplug: Drop unneeded locking
Date:   Mon, 31 May 2021 11:39:58 +0200
Message-Id: <20210531093958.15021-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Authentication-Results: imap.suse.de;
        none
X-Spam-Level: *
X-Spam-Score: 1.00
X-Spamd-Result: default: False [1.00 / 100.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         RCPT_COUNT_SEVEN(0.00)[9];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2]
X-Spam-Flag: NO
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
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 075b34803fec..9edbc57055bf 100644
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
@@ -638,15 +634,10 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 
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
@@ -739,9 +730,7 @@ void adjust_present_page_count(struct zone *zone, long nr_pages)
 	unsigned long flags;
 
 	zone->present_pages += nr_pages;
-	pgdat_resize_lock(zone->zone_pgdat, &flags);
 	zone->zone_pgdat->node_present_pages += nr_pages;
-	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 }
 
 int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
-- 
2.16.3

