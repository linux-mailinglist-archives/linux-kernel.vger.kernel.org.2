Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E33E35F51B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351484AbhDNNk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:40:58 -0400
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:46805 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351483AbhDNNkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:40:46 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id CD5C91C620C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 14:40:22 +0100 (IST)
Received: (qmail 29638 invoked from network); 14 Apr 2021 13:40:22 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 14 Apr 2021 13:40:22 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 04/11] mm/vmstat: Inline NUMA event counter updates
Date:   Wed, 14 Apr 2021 14:39:24 +0100
Message-Id: <20210414133931.4555-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210414133931.4555-1-mgorman@techsingularity.net>
References: <20210414133931.4555-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__count_numa_event is small enough to be treated similarly to
__count_vm_event so inline it.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/vmstat.h | 9 +++++++++
 mm/vmstat.c            | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index fc14415223c5..dde4dec4e7dd 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -237,6 +237,15 @@ static inline unsigned long zone_page_state_snapshot(struct zone *zone,
 }
 
 #ifdef CONFIG_NUMA
+/* See __count_vm_event comment on why raw_cpu_inc is used. */
+static inline void
+__count_numa_event(struct zone *zone, enum numa_stat_item item)
+{
+	struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
+
+	raw_cpu_inc(pzstats->vm_numa_event[item]);
+}
+
 extern void __count_numa_event(struct zone *zone, enum numa_stat_item item);
 extern unsigned long sum_zone_node_page_state(int node,
 					      enum zone_stat_item item);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 63bd84d122c0..b853df95ed0c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -902,15 +902,6 @@ void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *pzstats)
 #endif
 
 #ifdef CONFIG_NUMA
-/* See __count_vm_event comment on why raw_cpu_inc is used. */
-void __count_numa_event(struct zone *zone,
-				 enum numa_stat_item item)
-{
-	struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
-
-	raw_cpu_inc(pzstats->vm_numa_event[item]);
-}
-
 /*
  * Determine the per node value of a stat item. This function
  * is called frequently in a NUMA machine, so try to be as
-- 
2.26.2

