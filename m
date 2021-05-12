Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC2F37B9C5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhELJ5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:57:33 -0400
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:44915 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230202AbhELJ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:57:31 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id D81FBC0B50
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:56:21 +0100 (IST)
Received: (qmail 30019 invoked from network); 12 May 2021 09:56:21 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 12 May 2021 09:56:21 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 7/9] mm/page_alloc: Explicitly acquire the zone lock in __free_pages_ok
Date:   Wed, 12 May 2021 10:54:56 +0100
Message-Id: <20210512095458.30632-8-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210512095458.30632-1-mgorman@techsingularity.net>
References: <20210512095458.30632-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__free_pages_ok() disables IRQs before calling a common helper
free_one_page() that acquires the zone lock. This is not safe according
to Documentation/locking/locktypes.rst and in this context, IRQ disabling
is not protecting a per_cpu_pages structure either or a local_lock would
be used.

This patch explicitly acquires the lock with spin_lock_irqsave instead of
relying on a helper. This removes the last instance of local_irq_save()
in page_alloc.c.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5879b595b74b..7da70b404f4e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1579,21 +1579,21 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	unsigned long flags;
 	int migratetype;
 	unsigned long pfn = page_to_pfn(page);
+	struct zone *zone = page_zone(page);
 
 	if (!free_pages_prepare(page, order, true, fpi_flags))
 		return;
 
 	migratetype = get_pfnblock_migratetype(page, pfn);
 
-	/*
-	 * TODO FIX: Disable IRQs before acquiring IRQ-safe zone->lock
-	 * and protect vmstat updates.
-	 */
-	local_irq_save(flags);
+	spin_lock_irqsave(&zone->lock, flags);
 	__count_vm_events(PGFREE, 1 << order);
-	free_one_page(page_zone(page), page, pfn, order, migratetype,
-		      fpi_flags);
-	local_irq_restore(flags);
+	if (unlikely(has_isolate_pageblock(zone) ||
+		is_migrate_isolate(migratetype))) {
+		migratetype = get_pfnblock_migratetype(page, pfn);
+	}
+	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
+	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
 void __free_pages_core(struct page *page, unsigned int order)
-- 
2.26.2

