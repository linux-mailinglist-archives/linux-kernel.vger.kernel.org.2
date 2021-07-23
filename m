Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601003D384A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 12:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhGWJUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:20:33 -0400
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:46360 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231574AbhGWJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:20:32 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 37B45CAFC1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 11:01:05 +0100 (IST)
Received: (qmail 9456 invoked from network); 23 Jul 2021 10:01:04 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 23 Jul 2021 10:01:04 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/2] mm/vmstat: Protect per cpu variables with preempt disable on RT
Date:   Fri, 23 Jul 2021 11:00:34 +0100
Message-Id: <20210723100034.13353-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210723100034.13353-1-mgorman@techsingularity.net>
References: <20210723100034.13353-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Disable preemption on -RT for the vmstat code. On vanila the code runs
in IRQ-off regions while on -RT it may not when stats are updated under
a local_lock. "preempt_disable" ensures that the same resources is not
updated in parallel due to preemption.

This patch differs from the preempt-rt version where __count_vm_event and
__count_vm_events are also protected. The counters are explicitly "allowed
to be to be racy" so there is no need to protect them from preemption. Only
the accurate page stats that are updated by a read-modify-write need
protection.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/vmstat.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index b0534e068166..d06332c221b1 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -319,6 +319,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 	long x;
 	long t;
 
+	preempt_disable_rt();
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -328,6 +329,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	preempt_enable_rt();
 }
 EXPORT_SYMBOL(__mod_zone_page_state);
 
@@ -350,6 +352,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 		delta >>= PAGE_SHIFT;
 	}
 
+	preempt_disable_rt();
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -359,6 +362,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	preempt_enable_rt();
 }
 EXPORT_SYMBOL(__mod_node_page_state);
 
@@ -391,6 +395,7 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	s8 v, t;
 
+	preempt_disable_rt();
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v > t)) {
@@ -399,6 +404,7 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 		zone_page_state_add(v + overstep, zone, item);
 		__this_cpu_write(*p, -overstep);
 	}
+	preempt_enable_rt();
 }
 
 void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -409,6 +415,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
+	preempt_disable_rt();
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v > t)) {
@@ -417,6 +424,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 		node_page_state_add(v + overstep, pgdat, item);
 		__this_cpu_write(*p, -overstep);
 	}
+	preempt_enable_rt();
 }
 
 void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
@@ -437,6 +445,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	s8 v, t;
 
+	preempt_disable_rt();
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v < - t)) {
@@ -445,6 +454,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 		zone_page_state_add(v - overstep, zone, item);
 		__this_cpu_write(*p, overstep);
 	}
+	preempt_enable_rt();
 }
 
 void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -455,6 +465,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
+	preempt_disable_rt();
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v < - t)) {
@@ -463,6 +474,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 		node_page_state_add(v - overstep, pgdat, item);
 		__this_cpu_write(*p, overstep);
 	}
+	preempt_enable_rt();
 }
 
 void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
-- 
2.26.2

