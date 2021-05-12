Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B49A37B9C1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhELJ5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:57:03 -0400
Received: from outbound-smtp49.blacknight.com ([46.22.136.233]:56455 "EHLO
        outbound-smtp49.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230347AbhELJ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:57:01 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp49.blacknight.com (Postfix) with ESMTPS id 45361FA96C
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:55:51 +0100 (IST)
Received: (qmail 28153 invoked from network); 12 May 2021 09:55:51 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 12 May 2021 09:55:51 -0000
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
Subject: [PATCH 4/9] mm/vmstat: Inline NUMA event counter updates
Date:   Wed, 12 May 2021 10:54:53 +0100
Message-Id: <20210512095458.30632-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210512095458.30632-1-mgorman@techsingularity.net>
References: <20210512095458.30632-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__count_numa_event is small enough to be treated similarly to
__count_vm_event so inline it.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/vmstat.h | 10 +++++++++-
 mm/vmstat.c            |  9 ---------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 59748bbbba4c..fe32a2210e73 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -238,7 +238,15 @@ static inline unsigned long zone_page_state_snapshot(struct zone *zone,
 }
 
 #ifdef CONFIG_NUMA
-extern void __count_numa_event(struct zone *zone, enum numa_stat_item item);
+/* See __count_vm_event comment on why raw_cpu_inc is used. */
+static inline void
+__count_numa_event(struct zone *zone, enum numa_stat_item item)
+{
+	struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
+
+	raw_cpu_inc(pzstats->vm_numa_event[item]);
+}
+
 extern unsigned long sum_zone_node_page_state(int node,
 					      enum zone_stat_item item);
 extern unsigned long sum_zone_numa_event_state(int node, enum numa_stat_item item);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index c6434bab7feb..f71387aced32 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -938,15 +938,6 @@ void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *pzstats)
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

