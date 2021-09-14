Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2539140A29F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 03:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbhINBjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 21:39:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:19838 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231210AbhINBiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:38:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="307395642"
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="307395642"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 18:37:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="543575536"
Received: from yhuang6-desk2.sh.intel.com ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 18:37:35 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org
Subject: [PATCH -V8 6/6] memory tiering: adjust hot threshold automatically
Date:   Tue, 14 Sep 2021 09:37:01 +0800
Message-Id: <20210914013701.344956-7-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914013701.344956-1-ying.huang@intel.com>
References: <20210914013701.344956-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It isn't easy for the administrator to determine the hot threshold.
So in this patch, a method to adjust the hot threshold automatically
is implemented.  The basic idea is to control the number of the
candidate promotion pages to match the promotion rate limit.  If the
hint page fault latency of a page is less than the hot threshold, we
will try to promote the page, and the page is called the candidate
promotion page.

If the number of the candidate promotion pages in the statistics
interval is much more than the promotion rate limit, the hot threshold
will be decreased to reduce the number of the candidate promotion
pages.  Otherwise, the hot threshold will be increased to increase the
number of the candidate promotion pages.

To make the above method works, in each statistics interval, the total
number of the pages to check (on which the hint page faults occur) and
the hot/cold distribution need to be stable.  Because the page tables
are scanned linearly in NUMA balancing, but the hot/cold distribution
isn't uniform along the address, the statistics interval should be
larger than the NUMA balancing scan period.  So in the patch, the max
scan period is used as statistics interval and it works well in our
tests.

The sysctl knob kernel.numa_balancing_hot_threshold_ms becomes the
initial value and max value of the hot threshold.

The patch improves the score of pmbench memory accessing benchmark
with 80:20 read/write ratio and normal access address distribution by
3.9% with 32.4% fewer NUMA page migrations on a 2 socket Intel server
with Optance DC Persistent Memory.  Because it improves the accuracy
of the hot page selection.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Wei Xu <weixugc@google.com>
Cc: osalvador <osalvador@suse.de>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mmzone.h       |  3 ++
 include/linux/sched/sysctl.h |  2 ++
 kernel/sched/fair.c          | 59 +++++++++++++++++++++++++++++++++---
 kernel/sysctl.c              |  3 +-
 4 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d6a0efd387bd..69bb672ea743 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -891,6 +891,9 @@ typedef struct pglist_data {
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned long numa_ts;
 	unsigned long numa_nr_candidate;
+	unsigned long numa_threshold_ts;
+	unsigned long numa_threshold_nr_candidate;
+	unsigned long numa_threshold;
 #endif
 	/* Fields commonly accessed by the page reclaim scanner */
 
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 7d937adaac0f..ff2c43e8ebac 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -84,6 +84,8 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
 int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
+int sysctl_numa_balancing_threshold(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos);
 int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ce8c620ed1f6..b1783708700a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1465,6 +1465,54 @@ static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
 	return true;
 }
 
+int sysctl_numa_balancing_threshold(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos)
+{
+	int err;
+	struct pglist_data *pgdat;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (err < 0 || !write)
+		return err;
+
+	for_each_online_pgdat(pgdat)
+		pgdat->numa_threshold = 0;
+
+	return err;
+}
+
+#define NUMA_MIGRATION_ADJUST_STEPS	16
+
+static void numa_migration_adjust_threshold(struct pglist_data *pgdat,
+					    unsigned long rate_limit,
+					    unsigned long ref_th)
+{
+	unsigned long now = jiffies, last_th_ts, th_period;
+	unsigned long unit_th, th;
+	unsigned long nr_cand, ref_cand, diff_cand;
+
+	th_period = msecs_to_jiffies(sysctl_numa_balancing_scan_period_max);
+	last_th_ts = pgdat->numa_threshold_ts;
+	if (now > last_th_ts + th_period &&
+	    cmpxchg(&pgdat->numa_threshold_ts, last_th_ts, now) == last_th_ts) {
+		ref_cand = rate_limit *
+			sysctl_numa_balancing_scan_period_max / 1000;
+		nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
+		diff_cand = nr_cand - pgdat->numa_threshold_nr_candidate;
+		unit_th = ref_th / NUMA_MIGRATION_ADJUST_STEPS;
+		th = pgdat->numa_threshold ? : ref_th;
+		if (diff_cand > ref_cand * 11 / 10)
+			th = max(th - unit_th, unit_th);
+		else if (diff_cand < ref_cand * 9 / 10)
+			th = min(th + unit_th, ref_th);
+		pgdat->numa_threshold_nr_candidate = nr_cand;
+		pgdat->numa_threshold = th;
+	}
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu)
 {
@@ -1479,19 +1527,22 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 	    !node_is_toptier(src_nid)) {
 		struct pglist_data *pgdat;
-		unsigned long rate_limit, latency, th;
+		unsigned long rate_limit, latency, th, def_th;
 
 		pgdat = NODE_DATA(dst_nid);
 		if (pgdat_free_space_enough(pgdat))
 			return true;
 
-		th = sysctl_numa_balancing_hot_threshold;
+		def_th = sysctl_numa_balancing_hot_threshold;
+		rate_limit =
+			sysctl_numa_balancing_rate_limit << (20 - PAGE_SHIFT);
+		numa_migration_adjust_threshold(pgdat, rate_limit, def_th);
+
+		th = pgdat->numa_threshold ? : def_th;
 		latency = numa_hint_fault_latency(page);
 		if (latency > th)
 			return false;
 
-		rate_limit =
-			sysctl_numa_balancing_rate_limit << (20 - PAGE_SHIFT);
 		return numa_migration_check_rate_limit(pgdat, rate_limit,
 						       thp_nr_pages(page));
 	}
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 0d89021bd66a..0a87d5877718 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1816,7 +1816,8 @@ static struct ctl_table kern_table[] = {
 		.data		= &sysctl_numa_balancing_hot_threshold,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= sysctl_numa_balancing_threshold,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "numa_balancing_rate_limit_mbps",
-- 
2.30.2

