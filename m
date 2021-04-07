Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304A83575F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356303AbhDGU0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:26:51 -0400
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:45903 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356143AbhDGUZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:25:59 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id CB767C0D7A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:25:46 +0100 (IST)
Received: (qmail 16972 invoked from network); 7 Apr 2021 20:25:46 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 7 Apr 2021 20:25:46 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 07/11] mm/page_alloc: Reduce duration that IRQs are disabled for VM counters
Date:   Wed,  7 Apr 2021 21:24:19 +0100
Message-Id: <20210407202423.16022-8-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210407202423.16022-1-mgorman@techsingularity.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQs are left disabled for the zone and node VM event counters. This is
unnecessary as the affected counters are allowed to race for preemmption
and IRQs.

This patch reduces the scope of IRQs being disabled
via local_[lock|unlock]_irq on !PREEMPT_RT kernels. One
__mod_zone_freepage_state is still called with IRQs disabled. While this
could be moved out, it's not free on all architectures as some require
IRQs to be disabled for mod_zone_page_state on !PREEMPT_RTkernels.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index defb0e436fac..bd75102ef1e1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3474,11 +3474,11 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	list = &pcp->lists[migratetype];
 	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
+	local_unlock_irqrestore(&pagesets.lock, flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
 		zone_statistics(preferred_zone, zone, 1);
 	}
-	local_unlock_irqrestore(&pagesets.lock, flags);
 	return page;
 }
 
@@ -3530,15 +3530,15 @@ struct page *rmqueue(struct zone *preferred_zone,
 		if (!page)
 			page = __rmqueue(zone, order, migratetype, alloc_flags);
 	} while (page && check_new_pages(page, order));
-	spin_unlock(&zone->lock);
 	if (!page)
 		goto failed;
+
 	__mod_zone_freepage_state(zone, -(1 << order),
 				  get_pcppage_migratetype(page));
+	spin_unlock_irqrestore(&zone->lock, flags);
 
 	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
 	zone_statistics(preferred_zone, zone, 1);
-	local_irq_restore(flags);
 
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
@@ -3551,7 +3551,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 	return page;
 
 failed:
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&zone->lock, flags);
 	return NULL;
 }
 
@@ -5103,11 +5103,11 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
+	local_unlock_irqrestore(&pagesets.lock, flags);
+
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
 
-	local_unlock_irqrestore(&pagesets.lock, flags);
-
 	return nr_populated;
 
 failed_irq:
-- 
2.26.2

