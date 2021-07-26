Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34043D5761
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhGZJnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:43:20 -0400
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:37172 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232099AbhGZJnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:43:06 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 0BB61CAC8D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 11:23:29 +0100 (IST)
Received: (qmail 22516 invoked from network); 26 Jul 2021 10:23:28 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 26 Jul 2021 10:23:28 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/9] sched/fair: Track efficiency of select_idle_core
Date:   Mon, 26 Jul 2021 11:22:41 +0100
Message-Id: <20210726102247.21437-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726102247.21437-1-mgorman@techsingularity.net>
References: <20210726102247.21437-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add efficiency tracking for select_idle_core.

MMTests uses this to generate additional metrics.

SIS Core Search: The number of times a domain was searched for an idle core

SIS Core Hit: Idle core search success.

SIS Core Miss: Idle core search miss.

SIS Core Search Eff: The percentage of searches that were successful

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/debug.c | 2 ++
 kernel/sched/fair.c  | 2 ++
 kernel/sched/sched.h | 2 ++
 kernel/sched/stats.c | 7 ++++---
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1ec87b7bb6a9..26bdc455e4f4 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -744,6 +744,8 @@ do {									\
 		P(sis_failed);
 		P(sis_recent_hit);
 		P(sis_recent_miss);
+		P(sis_core_search);
+		P(sis_core_failed);
 	}
 #undef P
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4d48dc08a49b..4e2979b73cec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6138,6 +6138,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 	if (!static_branch_likely(&sched_smt_present))
 		return __select_idle_cpu(core, p);
 
+	schedstat_inc(this_rq()->sis_core_search);
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
 		schedstat_inc(this_rq()->sis_scanned);
 		if (!available_idle_cpu(cpu)) {
@@ -6158,6 +6159,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 	if (idle)
 		return core;
 
+	schedstat_inc(this_rq()->sis_core_failed);
 	cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 	return -1;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1c04d7a97dbe..e31179e6c6ff 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1080,6 +1080,8 @@ struct rq {
 	unsigned int		sis_failed;
 	unsigned int		sis_recent_hit;
 	unsigned int		sis_recent_miss;
+	unsigned int		sis_core_search;
+	unsigned int		sis_core_failed;
 #endif
 
 #ifdef CONFIG_CPU_IDLE
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 1aa648edb88b..5672f3dc7002 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -10,7 +10,7 @@
  * Bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 17
+#define SCHEDSTAT_VERSION 18
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -30,7 +30,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u %u %u %u %u %u",
+		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u %u %u %u %u %u %u %u",
 		    cpu, rq->yld_count,
 		    rq->sched_count, rq->sched_goidle,
 		    rq->ttwu_count, rq->ttwu_local,
@@ -38,7 +38,8 @@ static int show_schedstat(struct seq_file *seq, void *v)
 		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount,
 		    rq->sis_search, rq->sis_domain_search,
 		    rq->sis_scanned, rq->sis_failed,
-		    rq->sis_recent_hit, rq->sis_recent_miss);
+		    rq->sis_recent_hit, rq->sis_recent_miss,
+		    rq->sis_core_search, rq->sis_core_failed);
 
 		seq_printf(seq, "\n");
 
-- 
2.26.2

