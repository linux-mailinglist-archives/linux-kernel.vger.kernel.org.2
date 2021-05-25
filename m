Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AED38FC61
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhEYIOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:14:54 -0400
Received: from outbound-smtp30.blacknight.com ([81.17.249.61]:48823 "EHLO
        outbound-smtp30.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231982AbhEYIOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:14:32 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id 9A9ADBABD8
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:02:31 +0100 (IST)
Received: (qmail 6803 invoked from network); 25 May 2021 08:02:31 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 25 May 2021 08:02:31 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 6/6] mm/page_alloc: Introduce vm.percpu_pagelist_high_fraction
Date:   Tue, 25 May 2021 09:01:19 +0100
Message-Id: <20210525080119.5455-7-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210525080119.5455-1-mgorman@techsingularity.net>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a new sysctl vm.percpu_pagelist_high_fraction. It is
similar to the old vm.percpu_pagelist_fraction. The old sysctl increased
both pcp->batch and pcp->high with the higher pcp->high potentially
reducing zone->lock contention. However, the higher pcp->batch value also
potentially increased allocation latency while the PCP was refilled.
This sysctl only adjusts pcp->high so that zone->lock contention is
potentially reduced but allocation latency during a PCP refill remains
the same.

  # grep -E "high:|batch" /proc/zoneinfo | tail -2
              high:  649
              batch: 63

  # sysctl vm.percpu_pagelist_high_fraction=8
  # grep -E "high:|batch" /proc/zoneinfo | tail -2
              high:  35071
              batch: 63

  # sysctl vm.percpu_pagelist_high_fraction=64
              high:  4383
              batch: 63

  # sysctl vm.percpu_pagelist_high_fraction=0
              high:  649
              batch: 63

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 20 +++++++
 include/linux/mmzone.h                  |  3 ++
 kernel/sysctl.c                         |  8 +++
 mm/page_alloc.c                         | 69 ++++++++++++++++++++++---
 4 files changed, 93 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 2fcafccb53a8..e85c2f21d209 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -64,6 +64,7 @@ files can be found in mm/swap.c.
 - overcommit_ratio
 - page-cluster
 - panic_on_oom
+- percpu_pagelist_high_fraction
 - stat_interval
 - stat_refresh
 - numa_stat
@@ -789,6 +790,25 @@ panic_on_oom=2+kdump gives you very strong tool to investigate
 why oom happens. You can get snapshot.
 
 
+percpu_pagelist_high_fraction
+=============================
+
+This is the fraction of pages in each zone that are allocated for each
+per cpu page list.  The min value for this is 8.  It means that we do
+not allow more than 1/8th of pages in each zone to be allocated in any
+single per_cpu_pagelist.  This entry only changes the value of hot per
+cpu pagelists. User can specify a number like 100 to allocate 1/100th
+of each zone to each per cpu page list.
+
+The batch value of each per cpu pagelist remains the same regardless of the
+value of the high fraction so allocation latencies are unaffected.
+
+The initial value is zero. Kernel uses this value to set the high pcp->high
+mark based on the low watermark for the zone and the number of local
+online CPUs.  If the user writes '0' to this sysctl, it will revert to
+this default behavior.
+
+
 stat_interval
 =============
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a0606239a167..e20d98c62beb 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1040,12 +1040,15 @@ int watermark_scale_factor_sysctl_handler(struct ctl_table *, int, void *,
 extern int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES];
 int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *, int, void *,
 		size_t *, loff_t *);
+int percpu_pagelist_high_fraction_sysctl_handler(struct ctl_table *, int,
+		void *, size_t *, loff_t *);
 int sysctl_min_unmapped_ratio_sysctl_handler(struct ctl_table *, int,
 		void *, size_t *, loff_t *);
 int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *, int,
 		void *, size_t *, loff_t *);
 int numa_zonelist_order_handler(struct ctl_table *, int,
 		void *, size_t *, loff_t *);
+extern int percpu_pagelist_high_fraction;
 extern char numa_zonelist_order[];
 #define NUMA_ZONELIST_ORDER_LEN	16
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 4e5ac50a1af0..9eb9d1f987d9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2889,6 +2889,14 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= &one_thousand,
 	},
+	{
+		.procname	= "percpu_pagelist_high_fraction",
+		.data		= &percpu_pagelist_high_fraction,
+		.maxlen		= sizeof(percpu_pagelist_high_fraction),
+		.mode		= 0644,
+		.proc_handler	= percpu_pagelist_high_fraction_sysctl_handler,
+		.extra1		= SYSCTL_ZERO,
+	},
 	{
 		.procname	= "page_lock_unfairness",
 		.data		= &sysctl_page_lock_unfairness,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9144b0c4b6c9..07e09b3c2bcf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -120,6 +120,7 @@ typedef int __bitwise fpi_t;
 
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
+#define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
 
 struct pagesets {
 	local_lock_t lock;
@@ -181,6 +182,7 @@ EXPORT_SYMBOL(_totalram_pages);
 unsigned long totalreserve_pages __read_mostly;
 unsigned long totalcma_pages __read_mostly;
 
+int percpu_pagelist_high_fraction;
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
 EXPORT_SYMBOL(init_on_alloc);
@@ -6686,17 +6688,32 @@ static int zone_highsize(struct zone *zone, int batch, int cpu_online)
 #ifdef CONFIG_MMU
 	int high;
 	int nr_local_cpus;
+	unsigned long total_pages;
+
+	if (!percpu_pagelist_high_fraction) {
+		/*
+		 * By default, the high value of the pcp is based on the zone
+		 * low watermark so that if they are full then background
+		 * reclaim will not be started prematurely.
+		 */
+		total_pages = low_wmark_pages(zone);
+	} else {
+		/*
+		 * If percpu_pagelist_high_fraction is configured, the high
+		 * value is based on a fraction of the managed pages in the
+		 * zone.
+		 */
+		total_pages = zone_managed_pages(zone) / percpu_pagelist_high_fraction;
+	}
 
 	/*
-	 * The high value of the pcp is based on the zone low watermark
-	 * so that if they are full then background reclaim will not be
-	 * started prematurely. The value is split across all online CPUs
-	 * local to the zone. Note that early in boot that CPUs may not be
-	 * online yet and that during CPU hotplug that the cpumask is not
-	 * yet updated when a CPU is being onlined.
+	 * Split the high value across all online CPUs local to the zone. Note
+	 * that early in boot that CPUs may not be online yet and that during
+	 * CPU hotplug that the cpumask is not yet updated when a CPU is being
+	 * onlined.
 	 */
 	nr_local_cpus = max(1U, cpumask_weight(cpumask_of_node(zone_to_nid(zone)))) + cpu_online;
-	high = low_wmark_pages(zone) / nr_local_cpus;
+	high = total_pages / nr_local_cpus;
 
 	/*
 	 * Ensure high is at least batch*4. The multiple is based on the
@@ -8462,6 +8479,44 @@ int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
+/*
+ * percpu_pagelist_high_fraction - changes the pcp->high for each zone on each
+ * cpu. It is the fraction of total pages in each zone that a hot per cpu
+ * pagelist can have before it gets flushed back to buddy allocator.
+ */
+int percpu_pagelist_high_fraction_sysctl_handler(struct ctl_table *table,
+		int write, void *buffer, size_t *length, loff_t *ppos)
+{
+	struct zone *zone;
+	int old_percpu_pagelist_high_fraction;
+	int ret;
+
+	mutex_lock(&pcp_batch_high_lock);
+	old_percpu_pagelist_high_fraction = percpu_pagelist_high_fraction;
+
+	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
+	if (!write || ret < 0)
+		goto out;
+
+	/* Sanity checking to avoid pcp imbalance */
+	if (percpu_pagelist_high_fraction &&
+	    percpu_pagelist_high_fraction < MIN_PERCPU_PAGELIST_HIGH_FRACTION) {
+		percpu_pagelist_high_fraction = old_percpu_pagelist_high_fraction;
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* No change? */
+	if (percpu_pagelist_high_fraction == old_percpu_pagelist_high_fraction)
+		goto out;
+
+	for_each_populated_zone(zone)
+		zone_set_pageset_high_and_batch(zone, 0);
+out:
+	mutex_unlock(&pcp_batch_high_lock);
+	return ret;
+}
+
 #ifndef __HAVE_ARCH_RESERVED_KERNEL_PAGES
 /*
  * Returns the number of pages that arch has reserved but
-- 
2.26.2

