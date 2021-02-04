Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3659A30F03B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbhBDKNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:13:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:13159 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235352AbhBDKNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:13:00 -0500
IronPort-SDR: qa2IisTGy9qPqcHUELbJS9krIavPQlhCse17hxY7bQnhkXFgFhPTxnLlgZxO4PFbO8r8X8LndD
 KEmoax0Kgy5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="245283992"
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="245283992"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:12:00 -0800
IronPort-SDR: yj+V3x/E63CHEFzp8mUl3NIkhumEEbSE1G1+9pYDybFLGhC33brwP5mDdKbxCSZAVpIq1CWYd5
 /o6X52IIV7sg==
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="393093495"
Received: from qwang9-mobl.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.213.123])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:11:57 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC -V5 4/6] memory tiering: rate limit NUMA migration throughput
Date:   Thu,  4 Feb 2021 18:10:54 +0800
Message-Id: <20210204101056.89336-5-ying.huang@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210204101056.89336-1-ying.huang@intel.com>
References: <20210204101056.89336-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In NUMA balancing memory tiering mode, the hot slow memory pages could
be promoted to the fast memory node via NUMA balancing.  But this
incurs some overhead too.  So that sometimes the workload performance
may be hurt.  To avoid too much disturbing to the workload in these
situations, we should make it possible to rate limit the promotion
throughput.

So, in this patch, we implement a simple rate limit algorithm as
follows.  The number of the candidate pages to be promoted to the fast
memory node via NUMA balancing is counted, if the count exceeds the
limit specified by the users, the NUMA balancing promotion will be
stopped until the next second.

Test the patch with the pmbench memory accessing benchmark with 80:20
read/write ratio and normal access address distribution on a 2 socket
Intel server with Optane DC Persistent Memory Model.  In the test, the
page promotion throughput decreases 51.4% (from 213.0 MB/s to 103.6
MB/s) with the patch, while the benchmark score decreases only 1.8%.

A new sysctl knob kernel.numa_balancing_rate_limit_mbps is added for
the users to specify the limit.

TODO: Add ABI document for new sysctl knob.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mmzone.h       |  7 +++++++
 include/linux/sched/sysctl.h |  6 ++++++
 kernel/sched/fair.c          | 29 +++++++++++++++++++++++++++--
 kernel/sysctl.c              |  8 ++++++++
 mm/vmstat.c                  |  3 +++
 5 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fb3bf696c05e..81a67d9cc7db 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -206,6 +206,9 @@ enum node_stat_item {
 	NR_KERNEL_STACK_KB,	/* measured in KiB */
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
 #endif
 	NR_VM_NODE_STAT_ITEMS
 };
@@ -810,6 +813,10 @@ typedef struct pglist_data {
 	struct deferred_split deferred_split_queue;
 #endif
 
+#ifdef CONFIG_NUMA_BALANCING
+	unsigned long numa_ts;
+	unsigned long numa_nr_candidate;
+#endif
 	/* Fields commonly accessed by the page reclaim scanner */
 
 	/*
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 574d25d6f051..c0cae68e5da0 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -50,6 +50,12 @@ extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
 extern unsigned int sysctl_numa_balancing_hot_threshold;
 
+#ifdef CONFIG_NUMA_BALANCING
+extern unsigned int sysctl_numa_balancing_rate_limit;
+#else
+#define sysctl_numa_balancing_rate_limit	0
+#endif
+
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
 extern __read_mostly unsigned int sysctl_sched_nr_migrate;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b03ee0e540ff..18e287997a90 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1076,6 +1076,11 @@ unsigned int sysctl_numa_balancing_scan_delay = 1000;
 
 /* The page with hint page fault latency < threshold in ms is considered hot */
 unsigned int sysctl_numa_balancing_hot_threshold = 1000;
+/*
+ * Restrict the NUMA migration per second in MB for each target node
+ * if no enough free space in target node
+ */
+unsigned int sysctl_numa_balancing_rate_limit = 65536;
 
 struct numa_group {
 	refcount_t refcount;
@@ -1448,6 +1453,23 @@ static int numa_hint_fault_latency(struct page *page)
 	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
 }
 
+static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
+					    unsigned long rate_limit, int nr)
+{
+	unsigned long nr_candidate;
+	unsigned long now = jiffies, last_ts;
+
+	mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE, nr);
+	nr_candidate = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
+	last_ts = pgdat->numa_ts;
+	if (now > last_ts + HZ &&
+	    cmpxchg(&pgdat->numa_ts, last_ts, now) == last_ts)
+		pgdat->numa_nr_candidate = nr_candidate;
+	if (nr_candidate - pgdat->numa_nr_candidate > rate_limit)
+		return false;
+	return true;
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu)
 {
@@ -1462,7 +1484,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 	    !node_is_toptier(src_nid)) {
 		struct pglist_data *pgdat;
-		unsigned long latency, th;
+		unsigned long rate_limit, latency, th;
 
 		pgdat = NODE_DATA(dst_nid);
 		if (pgdat_free_space_enough(pgdat))
@@ -1473,7 +1495,10 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 		if (latency > th)
 			return false;
 
-		return true;
+		rate_limit =
+			sysctl_numa_balancing_rate_limit << (20 - PAGE_SHIFT);
+		return numa_migration_check_rate_limit(pgdat, rate_limit,
+						       thp_nr_pages(page));
 	}
 
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1efbb0ac73c7..4b25fab849ae 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1761,6 +1761,14 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "numa_balancing_rate_limit_mbps",
+		.data		= &sysctl_numa_balancing_rate_limit,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
 	{
 		.procname	= "numa_balancing",
 		.data		= &sysctl_numa_balancing_mode,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index a15f2243f1c8..0678da1db47a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1215,6 +1215,9 @@ const char * const vmstat_text[] = {
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	"nr_shadow_call_stack",
 #endif
+#ifdef CONFIG_NUMA_BALANCING
+	"pgpromote_candidate",
+#endif
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
-- 
2.29.2

