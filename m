Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EB93D575C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhGZJmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:42:53 -0400
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:42749 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232401AbhGZJmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:42:50 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id D1F4A1C39ED
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 11:23:18 +0100 (IST)
Received: (qmail 22186 invoked from network); 26 Jul 2021 10:23:18 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 26 Jul 2021 10:23:18 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/9] sched/fair: Track efficiency of task recent_used_cpu
Date:   Mon, 26 Jul 2021 11:22:40 +0100
Message-Id: <20210726102247.21437-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726102247.21437-1-mgorman@techsingularity.net>
References: <20210726102247.21437-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simply tracks the efficiency of the recent_used_cpu. The hit rate
of this matters as it can avoid a domain search. Similarly, the miss
rate matters because each miss is a penalty to the fast path. MMTests
uses this to generate three additional metrics

SIS Recent Used Hit: A recent CPU was eligible and used. Each hit is
	a domain search avoided.

SIS Recent Used Miss: A recent CPU was eligible but unavailable. Each
	time this is hit, there was a penalty to the fast path before
	a domain search happened.

SIS Recent Success Rate: A percentage of the number of hits versus
	the total attempts to use the recent CPU.

SIS Recent Attempts: The total number of times the recent CPU was examined.
	A high number of Recent Attempts with a low Success Rate implies
	the fast path is being punished severely. This could have been
	presented as a weighting of hits and misses but calculating an
	appropriate weight for misses is problematic.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/debug.c |  2 ++
 kernel/sched/fair.c  | 28 ++++++++++++++++------------
 kernel/sched/sched.h |  2 ++
 kernel/sched/stats.c |  7 ++++---
 4 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 603d4bc71612..1ec87b7bb6a9 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -742,6 +742,8 @@ do {									\
 		P(sis_domain_search);
 		P(sis_scanned);
 		P(sis_failed);
+		P(sis_recent_hit);
+		P(sis_recent_miss);
 	}
 #undef P
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cc0b451d1794..4d48dc08a49b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6388,18 +6388,22 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 
 	/* Check a recently used CPU as a potential idle candidate: */
 	recent_used_cpu = p->recent_used_cpu;
-	if (recent_used_cpu != prev &&
-	    recent_used_cpu != target &&
-	    cpus_share_cache(recent_used_cpu, target) &&
-	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
-	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
-	    asym_fits_capacity(task_util, recent_used_cpu)) {
-		/*
-		 * Replace recent_used_cpu with prev as it is a potential
-		 * candidate for the next wake:
-		 */
-		p->recent_used_cpu = prev;
-		return recent_used_cpu;
+	if (recent_used_cpu != prev && recent_used_cpu != target) {
+
+		if (cpus_share_cache(recent_used_cpu, target) &&
+		    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
+		    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
+		    asym_fits_capacity(task_util, recent_used_cpu)) {
+			/*
+			 * Replace recent_used_cpu with prev as it is a potential
+			 * candidate for the next wake:
+			 */
+			schedstat_inc(this_rq()->sis_recent_hit);
+			p->recent_used_cpu = prev;
+			return recent_used_cpu;
+		}
+
+		schedstat_inc(this_rq()->sis_recent_miss);
 	}
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4cf307763fe9..1c04d7a97dbe 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1078,6 +1078,8 @@ struct rq {
 	unsigned int		sis_domain_search;
 	unsigned int		sis_scanned;
 	unsigned int		sis_failed;
+	unsigned int		sis_recent_hit;
+	unsigned int		sis_recent_miss;
 #endif
 
 #ifdef CONFIG_CPU_IDLE
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 7dd9b0dec437..1aa648edb88b 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -10,7 +10,7 @@
  * Bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 16
+#define SCHEDSTAT_VERSION 17
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -30,14 +30,15 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u %u %u %u",
+		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u %u %u %u %u %u",
 		    cpu, rq->yld_count,
 		    rq->sched_count, rq->sched_goidle,
 		    rq->ttwu_count, rq->ttwu_local,
 		    rq->rq_cpu_time,
 		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount,
 		    rq->sis_search, rq->sis_domain_search,
-		    rq->sis_scanned, rq->sis_failed);
+		    rq->sis_scanned, rq->sis_failed,
+		    rq->sis_recent_hit, rq->sis_recent_miss);
 
 		seq_printf(seq, "\n");
 
-- 
2.26.2

