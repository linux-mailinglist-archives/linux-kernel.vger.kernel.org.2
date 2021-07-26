Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A673D5763
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhGZJnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:43:35 -0400
Received: from outbound-smtp38.blacknight.com ([46.22.139.221]:56849 "EHLO
        outbound-smtp38.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232619AbhGZJnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:43:32 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id 4C2331A1B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 11:24:00 +0100 (IST)
Received: (qmail 23587 invoked from network); 26 Jul 2021 10:24:00 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 26 Jul 2021 10:23:59 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 6/9] sched/fair: Make select_idle_cpu() proportional to cores
Date:   Mon, 26 Jul 2021 11:22:44 +0100
Message-Id: <20210726102247.21437-7-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726102247.21437-1-mgorman@techsingularity.net>
References: <20210726102247.21437-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra (Intel) <peterz@infradead.org>

Instead of calculating how many (logical) CPUs to scan, compute how
many cores to scan.

This changes behaviour for anything !SMT2.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/core.c  | 17 ++++++++++++-----
 kernel/sched/fair.c  | 11 +++++++++--
 kernel/sched/sched.h |  2 ++
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d9ff40f4661..7c073b67f1ea 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8647,11 +8647,18 @@ int sched_cpu_activate(unsigned int cpu)
 	balance_push_set(cpu, false);
 
 #ifdef CONFIG_SCHED_SMT
-	/*
-	 * When going up, increment the number of cores with SMT present.
-	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
-		static_branch_inc_cpuslocked(&sched_smt_present);
+	do {
+		int weight = cpumask_weight(cpu_smt_mask(cpu));
+
+		if (weight > sched_smt_weight)
+			sched_smt_weight = weight;
+
+		/*
+		 * When going up, increment the number of cores with SMT present.
+		 */
+		if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+			static_branch_inc_cpuslocked(&sched_smt_present);
+	} while (0);
 #endif
 	set_cpu_active(cpu, true);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 125c020746b8..20b9255ebf97 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6076,6 +6076,8 @@ static inline int __select_idle_cpu(int cpu, struct task_struct *p)
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 EXPORT_SYMBOL_GPL(sched_smt_present);
 
+int __read_mostly sched_smt_weight = 1;
+
 static inline void set_idle_cores(int cpu, int val)
 {
 	struct sched_domain_shared *sds;
@@ -6194,6 +6196,8 @@ static inline bool test_idle_cores(int cpu, bool def)
 	return def;
 }
 
+#define sched_smt_weight 1
+
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
 	return __select_idle_cpu(core, p);
@@ -6206,6 +6210,8 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 
 #endif /* CONFIG_SCHED_SMT */
 
+#define sis_min_cores	2
+
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
@@ -6246,11 +6252,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		avg_cost = this_sd->avg_scan_cost + 1;
 
 		span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
+		if (span_avg > sis_min_cores * avg_cost)
 			nr = div_u64(span_avg, avg_cost);
 		else
-			nr = 4;
+			nr = sis_min_cores;
 
+		nr *= sched_smt_weight;
 		time = cpu_clock(this);
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e31179e6c6ff..4d47a0969710 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1351,6 +1351,8 @@ do {						\
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
 
+extern int sched_smt_weight;
+
 static inline void update_idle_core(struct rq *rq)
 {
 	if (static_branch_unlikely(&sched_smt_present))
-- 
2.26.2

