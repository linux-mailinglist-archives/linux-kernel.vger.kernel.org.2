Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2BE3D5764
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhGZJno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:43:44 -0400
Received: from outbound-smtp56.blacknight.com ([46.22.136.240]:58109 "EHLO
        outbound-smtp56.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232619AbhGZJnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:43:42 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp56.blacknight.com (Postfix) with ESMTPS id 78A0CFA8E5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 11:24:10 +0100 (IST)
Received: (qmail 23960 invoked from network); 26 Jul 2021 10:24:10 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 26 Jul 2021 10:24:10 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 7/9] sched/fair: Enforce proportional scan limits when scanning for an idle core
Date:   Mon, 26 Jul 2021 11:22:45 +0100
Message-Id: <20210726102247.21437-8-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726102247.21437-1-mgorman@techsingularity.net>
References: <20210726102247.21437-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When scanning for a single CPU, the scan is limited based on the estimated
average idle time for a domain to reduce the risk that more time is spent
scanning for idle CPUs than we are idle for.

With SMT, if an idle core is expected to exist there is no scan depth
limits so the scan depth may or may not be related to average idle time.
Unfortunately has_idle_cores can be very inaccurate when workloads are
rapidly entering/exiting idle (e.g. hackbench).

As the scan depth is now proportional to cores and not CPUs, enforce
SIS_PROP for idle core scans.

The performance impact of this is variable and is neither a universal
gain nor loss. In some cases, has_idle_cores will be cleared prematurely
because the whole domain was not scanned but has_idle_cores is already
known to be an inaccurate heuristic. There is also additional cost because
time calculations are made even for an idle core scan and the delta is
calculated for both scan successes and failures. Finally, SMT siblings
may be used prematurely due to scan depth limitations.

On the flip side, scan depth is now consistent for both core and smt
scans. The reduction in scan depth improves performance in some cases
and wakeup latency is reduced in some cases.

There were few changes identified in the SIS statistics but notably,
"SIS Core Hit" was slightly reduced in tbench as thread counts increased,
presumably due to the core search depth being throttled.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 20b9255ebf97..b180205e6b25 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6232,7 +6232,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	if (sched_feat(SIS_PROP) && !has_idle_core) {
+	if (sched_feat(SIS_PROP)) {
 		u64 avg_cost, avg_idle, span_avg;
 		unsigned long now = jiffies;
 
@@ -6265,30 +6265,35 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
 			if ((unsigned int)i < nr_cpumask_bits)
-				return i;
+				break;
 
+			nr -= sched_smt_weight;
 		} else {
-			if (!--nr)
-				return -1;
 			idle_cpu = __select_idle_cpu(cpu, p);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
 				break;
+			nr--;
 		}
+
+		if (nr < 0)
+			break;
 	}
 
-	if (has_idle_core)
-		set_idle_cores(target, false);
+	if ((unsigned int)idle_cpu < nr_cpumask_bits) {
+		if (has_idle_core)
+			set_idle_cores(target, false);
 
-	if (sched_feat(SIS_PROP) && !has_idle_core) {
-		time = cpu_clock(this) - time;
+		if (sched_feat(SIS_PROP)) {
+			time = cpu_clock(this) - time;
 
-		/*
-		 * Account for the scan cost of wakeups against the average
-		 * idle time.
-		 */
-		this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
+			/*
+			 * Account for the scan cost of wakeups against the average
+			 * idle time.
+			 */
+			this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
 
-		update_avg(&this_sd->avg_scan_cost, time);
+			update_avg(&this_sd->avg_scan_cost, time);
+		}
 	}
 
 	return idle_cpu;
-- 
2.26.2

