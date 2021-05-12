Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6608737B9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhELJ54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:57:56 -0400
Received: from outbound-smtp47.blacknight.com ([46.22.136.64]:36147 "EHLO
        outbound-smtp47.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230114AbhELJ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:57:50 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id 4AB84FA956
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:56:42 +0100 (IST)
Received: (qmail 31206 invoked from network); 12 May 2021 09:56:42 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 12 May 2021 09:56:42 -0000
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
Subject: [PATCH 9/9] mm/page_alloc: Update PGFREE outside the zone lock in __free_pages_ok
Date:   Wed, 12 May 2021 10:54:58 +0100
Message-Id: <20210512095458.30632-10-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210512095458.30632-1-mgorman@techsingularity.net>
References: <20210512095458.30632-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM events do not need explicit protection by disabling IRQs so
update the counter with IRQs enabled in __free_pages_ok.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 83268f7b3ded..ff8f706839ea 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1589,13 +1589,14 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	migratetype = get_pfnblock_migratetype(page, pfn);
 
 	spin_lock_irqsave(&zone->lock, flags);
-	__count_vm_events(PGFREE, 1 << order);
 	if (unlikely(has_isolate_pageblock(zone) ||
 		is_migrate_isolate(migratetype))) {
 		migratetype = get_pfnblock_migratetype(page, pfn);
 	}
 	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
 	spin_unlock_irqrestore(&zone->lock, flags);
+
+	__count_vm_events(PGFREE, 1 << order);
 }
 
 void __free_pages_core(struct page *page, unsigned int order)
-- 
2.26.2

