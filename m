Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF22338FC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhEYIOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:14:16 -0400
Received: from outbound-smtp18.blacknight.com ([46.22.139.245]:39937 "EHLO
        outbound-smtp18.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232035AbhEYIN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:13:26 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp18.blacknight.com (Postfix) with ESMTPS id 7E75C1C3C8A
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:01:40 +0100 (IST)
Received: (qmail 5068 invoked from network); 25 May 2021 08:01:40 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 25 May 2021 08:01:40 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/6] mm/page_alloc: Delete vm.percpu_pagelist_fraction
Date:   Tue, 25 May 2021 09:01:14 +0100
Message-Id: <20210525080119.5455-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210525080119.5455-1-mgorman@techsingularity.net>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vm.percpu_pagelist_fraction is used to increase the batch and high
limits for the per-cpu page allocator (PCP). The intent behind the sysctl
is to reduce zone lock acquisition when allocating/freeing pages but it has
a problem. While it can decrease contention, it can also increase latency
on the allocation side due to unreasonably large batch sizes. This leads
to games where an administrator adjusts percpu_pagelist_fraction on the
fly to work around contention and allocation latency problems.

This series aims to alleviate the problems with zone lock contention while
avoiding the allocation-side latency problems. For the purposes of review,
it's easier to remove this sysctl now and reintroduce a similar sysctl
later in the series that deals only with pcp->high.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 19 ---------
 include/linux/mmzone.h                  |  3 --
 kernel/sysctl.c                         |  8 ----
 mm/page_alloc.c                         | 55 ++-----------------------
 4 files changed, 4 insertions(+), 81 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 586cd4b86428..2fcafccb53a8 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -64,7 +64,6 @@ files can be found in mm/swap.c.
 - overcommit_ratio
 - page-cluster
 - panic_on_oom
-- percpu_pagelist_fraction
 - stat_interval
 - stat_refresh
 - numa_stat
@@ -790,24 +789,6 @@ panic_on_oom=2+kdump gives you very strong tool to investigate
 why oom happens. You can get snapshot.
 
 
-percpu_pagelist_fraction
-========================
-
-This is the fraction of pages at most (high mark pcp->high) in each zone that
-are allocated for each per cpu page list.  The min value for this is 8.  It
-means that we don't allow more than 1/8th of pages in each zone to be
-allocated in any single per_cpu_pagelist.  This entry only changes the value
-of hot per cpu pagelists.  User can specify a number like 100 to allocate
-1/100th of each zone to each per cpu page list.
-
-The batch value of each per cpu pagelist is also updated as a result.  It is
-set to pcp->high/4.  The upper limit of batch is (PAGE_SHIFT * 8)
-
-The initial value is zero.  Kernel does not use this value at boot time to set
-the high water marks for each per cpu page list.  If the user writes '0' to this
-sysctl, it will revert to this default behavior.
-
-
 stat_interval
 =============
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d7740c97b87e..b449151745d7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1038,15 +1038,12 @@ int watermark_scale_factor_sysctl_handler(struct ctl_table *, int, void *,
 extern int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES];
 int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *, int, void *,
 		size_t *, loff_t *);
-int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *, int,
-		void *, size_t *, loff_t *);
 int sysctl_min_unmapped_ratio_sysctl_handler(struct ctl_table *, int,
 		void *, size_t *, loff_t *);
 int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *, int,
 		void *, size_t *, loff_t *);
 int numa_zonelist_order_handler(struct ctl_table *, int,
 		void *, size_t *, loff_t *);
-extern int percpu_pagelist_fraction;
 extern char numa_zonelist_order[];
 #define NUMA_ZONELIST_ORDER_LEN	16
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 14edf84cc571..4e5ac50a1af0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2889,14 +2889,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= &one_thousand,
 	},
-	{
-		.procname	= "percpu_pagelist_fraction",
-		.data		= &percpu_pagelist_fraction,
-		.maxlen		= sizeof(percpu_pagelist_fraction),
-		.mode		= 0644,
-		.proc_handler	= percpu_pagelist_fraction_sysctl_handler,
-		.extra1		= SYSCTL_ZERO,
-	},
 	{
 		.procname	= "page_lock_unfairness",
 		.data		= &sysctl_page_lock_unfairness,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ff8f706839ea..a48f305f0381 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -120,7 +120,6 @@ typedef int __bitwise fpi_t;
 
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
-#define MIN_PERCPU_PAGELIST_FRACTION	(8)
 
 struct pagesets {
 	local_lock_t lock;
@@ -182,7 +181,6 @@ EXPORT_SYMBOL(_totalram_pages);
 unsigned long totalreserve_pages __read_mostly;
 unsigned long totalcma_pages __read_mostly;
 
-int percpu_pagelist_fraction;
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
 EXPORT_SYMBOL(init_on_alloc);
@@ -6696,22 +6694,15 @@ static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long h
 
 /*
  * Calculate and set new high and batch values for all per-cpu pagesets of a
- * zone, based on the zone's size and the percpu_pagelist_fraction sysctl.
+ * zone based on the zone's size.
  */
 static void zone_set_pageset_high_and_batch(struct zone *zone)
 {
 	unsigned long new_high, new_batch;
 
-	if (percpu_pagelist_fraction) {
-		new_high = zone_managed_pages(zone) / percpu_pagelist_fraction;
-		new_batch = max(1UL, new_high / 4);
-		if ((new_high / 4) > (PAGE_SHIFT * 8))
-			new_batch = PAGE_SHIFT * 8;
-	} else {
-		new_batch = zone_batchsize(zone);
-		new_high = 6 * new_batch;
-		new_batch = max(1UL, 1 * new_batch);
-	}
+	new_batch = zone_batchsize(zone);
+	new_high = 6 * new_batch;
+	new_batch = max(1UL, 1 * new_batch);
 
 	if (zone->pageset_high == new_high &&
 	    zone->pageset_batch == new_batch)
@@ -8377,44 +8368,6 @@ int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
-/*
- * percpu_pagelist_fraction - changes the pcp->high for each zone on each
- * cpu.  It is the fraction of total pages in each zone that a hot per cpu
- * pagelist can have before it gets flushed back to buddy allocator.
- */
-int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
-{
-	struct zone *zone;
-	int old_percpu_pagelist_fraction;
-	int ret;
-
-	mutex_lock(&pcp_batch_high_lock);
-	old_percpu_pagelist_fraction = percpu_pagelist_fraction;
-
-	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
-	if (!write || ret < 0)
-		goto out;
-
-	/* Sanity checking to avoid pcp imbalance */
-	if (percpu_pagelist_fraction &&
-	    percpu_pagelist_fraction < MIN_PERCPU_PAGELIST_FRACTION) {
-		percpu_pagelist_fraction = old_percpu_pagelist_fraction;
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/* No change? */
-	if (percpu_pagelist_fraction == old_percpu_pagelist_fraction)
-		goto out;
-
-	for_each_populated_zone(zone)
-		zone_set_pageset_high_and_batch(zone);
-out:
-	mutex_unlock(&pcp_batch_high_lock);
-	return ret;
-}
-
 #ifndef __HAVE_ARCH_RESERVED_KERNEL_PAGES
 /*
  * Returns the number of pages that arch has reserved but
-- 
2.26.2

