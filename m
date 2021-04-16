Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D900A362A57
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344396AbhDPVaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245392AbhDPVaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:30:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D88C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:30:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v6so7607800ybk.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=U9tamRek+f4z2tELrXoSidH/IwPkK66LgQjWaBRSdrE=;
        b=dK9tzuquLhY4V61JGT5wBqFOvtpYpnz+sEopbQ45BNyZRJwqouCOqWITY6JJqoJ8B3
         4pn5ZMon7BK2lRvbS9byxIjE9SzPIPJxdoUmMu+VwtMO1OuJPLmNCYm5Orlaa1i3Rl+4
         4xdS6pOu4ZjKZOnpEy5eIVXONgNgXi8sNJWC1g13yFBI2jcZiy1HvZtX6+dCLKdAF/h3
         W5gwl4r1FaMFQ8EmF1UkZjMtC7ASqaUP8R9lBAG+0GKknhDS4+zltTwfrf2uJaj8fiYm
         +4/KG8Z329dAY3Qp9MGfqAO4IAN/3OzUA5vNVOZb++UU0qxZ1A2L4xbcCCQKzJuEYpt+
         iP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=U9tamRek+f4z2tELrXoSidH/IwPkK66LgQjWaBRSdrE=;
        b=EdoofWb/BJdZeQcyByr584vjB1P5faanuzD02f4mCHQIeWCM15a6jkMILtDt1JX/hi
         e8AsoWntWFZj70CVkQqgpV3+wMNN/nQncxsnuzyboRtISMRklhH6aMsCyoEa/m1/JITy
         f7VGalTDjrdw1uEJcUq00p57rAzMCrPU8J+1BULkiMJvNPP/LxNt46droOaWlQPzLZLu
         RT+GLxGRzG7IRHM7Bd86nuf4cF/ZHUOxMUsYPqvcjganoWf8IIJHwF6LYu4WLpEdoFcq
         V4uMA+IdWFfToCgsrlLSRJiXcLBd13bnfYQnwaMFBgIsFYvF8vxSlbCkilzdgbT1cOhi
         3pPA==
X-Gm-Message-State: AOAM530E+8quahYIf+URsB37xSSpvJOSuPUs/qGP/ZJ9ZwpkRHnRBXRL
        olxqpr+Z++ix8Cqfr12NppPZZZAeTqjN
X-Google-Smtp-Source: ABdhPJxFrvFO1fCCCc7PO1gSlfb/ne7U/i1wnkFMgU6JZDuWbAdOb6t7wOm0smOiAwYoSRo8nC7jda8Nayfi
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:565:26ba:7914:77e6])
 (user=joshdon job=sendgmr) by 2002:a25:dc8e:: with SMTP id
 y136mr1722997ybe.140.1618608626453; Fri, 16 Apr 2021 14:30:26 -0700 (PDT)
Date:   Fri, 16 Apr 2021 14:29:36 -0700
Message-Id: <20210416212936.390566-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v2 resubmit] sched: Warn on long periods of pending need_resched
From:   Josh Don <joshdon@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, Paul Turner <pjt@google.com>,
        Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Turner <pjt@google.com>

CPU scheduler marks need_resched flag to signal a schedule() on a
particular CPU. But, schedule() may not happen immediately in cases
where the current task is executing in the kernel mode (no
preemption state) for extended periods of time.

This patch adds a warn_on if need_resched is pending for more than the
time specified in sysctl resched_latency_warn_ms. If it goes off, it is
likely that there is a missing cond_resched() somewhere. Monitoring is
done via the tick and the accuracy is hence limited to jiffy scale. This
also means that we won't trigger the warning if the tick is disabled.

This feature (LATENCY_WARN) is default disabled.

Signed-off-by: Paul Turner <pjt@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210323035706.572953-1-joshdon@google.com
---
This squashes the fixup from https://lkml.org/lkml/2021/3/30/1309.

 include/linux/sched/sysctl.h |  3 ++
 kernel/sched/core.c          | 70 +++++++++++++++++++++++++++++++++++-
 kernel/sched/debug.c         | 13 +++++++
 kernel/sched/features.h      |  2 ++
 kernel/sched/sched.h         | 10 ++++++
 5 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 0a3f34638cf5..db2c0f34aaaf 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -48,6 +48,9 @@ extern unsigned int sysctl_numa_balancing_scan_size;
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
 extern __read_mostly unsigned int sysctl_sched_nr_migrate;
+
+extern int sysctl_resched_latency_warn_ms;
+extern int sysctl_resched_latency_warn_once;
 #endif
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9565f304ac46..c07a4c17205f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -58,7 +58,17 @@ const_debug unsigned int sysctl_sched_features =
 #include "features.h"
 	0;
 #undef SCHED_FEAT
-#endif
+
+/*
+ * Print a warning if need_resched is set for the given duration (if
+ * LATENCY_WARN is enabled).
+ *
+ * If sysctl_resched_latency_warn_once is set, only one warning will be shown
+ * per boot.
+ */
+__read_mostly int sysctl_resched_latency_warn_ms = 100;
+__read_mostly int sysctl_resched_latency_warn_once = 1;
+#endif /* CONFIG_SCHED_DEBUG */
 
 /*
  * Number of tasks to iterate in a single balance run.
@@ -4527,6 +4537,55 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	return ns;
 }
 
+#ifdef CONFIG_SCHED_DEBUG
+static u64 cpu_resched_latency(struct rq *rq)
+{
+	int latency_warn_ms = READ_ONCE(sysctl_resched_latency_warn_ms);
+	u64 resched_latency, now = rq_clock(rq);
+	static bool warned_once;
+
+	if (sysctl_resched_latency_warn_once && warned_once)
+		return 0;
+
+	if (!need_resched() || !latency_warn_ms)
+		return 0;
+
+	if (system_state == SYSTEM_BOOTING)
+		return 0;
+
+	if (!rq->last_seen_need_resched_ns) {
+		rq->last_seen_need_resched_ns = now;
+		rq->ticks_without_resched = 0;
+		return 0;
+	}
+
+	rq->ticks_without_resched++;
+	resched_latency = now - rq->last_seen_need_resched_ns;
+	if (resched_latency <= latency_warn_ms * NSEC_PER_MSEC)
+		return 0;
+
+	warned_once = true;
+
+	return resched_latency;
+}
+
+static int __init setup_resched_latency_warn_ms(char *str)
+{
+	long val;
+
+	if ((kstrtol(str, 0, &val))) {
+		pr_warn("Unable to set resched_latency_warn_ms\n");
+		return 1;
+	}
+
+	sysctl_resched_latency_warn_ms = val;
+	return 1;
+}
+__setup("resched_latency_warn_ms=", setup_resched_latency_warn_ms);
+#else
+static inline u64 cpu_resched_latency(struct rq *rq) { return 0; }
+#endif /* CONFIG_SCHED_DEBUG */
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -4538,6 +4597,7 @@ void scheduler_tick(void)
 	struct task_struct *curr = rq->curr;
 	struct rq_flags rf;
 	unsigned long thermal_pressure;
+	u64 resched_latency;
 
 	arch_scale_freq_tick();
 	sched_clock_tick();
@@ -4548,10 +4608,15 @@ void scheduler_tick(void)
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
+	if (sched_feat(LATENCY_WARN))
+		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
 
 	rq_unlock(rq, &rf);
 
+	if (sched_feat(LATENCY_WARN) && resched_latency)
+		resched_latency_warn(cpu, resched_latency);
+
 	perf_event_task_tick();
 
 #ifdef CONFIG_SMP
@@ -5046,6 +5111,9 @@ static void __sched notrace __schedule(bool preempt)
 	next = pick_next_task(rq, prev, &rf);
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
+#ifdef CONFIG_SCHED_DEBUG
+	rq->last_seen_need_resched_ns = 0;
+#endif
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8cad99038c03..de77a65e9524 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -309,6 +309,9 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_min_granularity);
 	debugfs_create_u32("wakeup_granularity_ns", 0644, debugfs_sched, &sysctl_sched_wakeup_granularity);
 
+	debugfs_create_u32("latency_warn_ms", 0644, debugfs_sched, &sysctl_resched_latency_warn_ms);
+	debugfs_create_u32("latency_warn_once", 0644, debugfs_sched, &sysctl_resched_latency_warn_once);
+
 #ifdef CONFIG_SMP
 	debugfs_create_file("tunable_scaling", 0644, debugfs_sched, NULL, &sched_scaling_fops);
 	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
@@ -1032,3 +1035,13 @@ void proc_sched_set_task(struct task_struct *p)
 	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
 #endif
 }
+
+void resched_latency_warn(int cpu, u64 latency)
+{
+	static DEFINE_RATELIMIT_STATE(latency_check_ratelimit, 60 * 60 * HZ, 1);
+
+	WARN(__ratelimit(&latency_check_ratelimit),
+	     "sched: CPU %d need_resched set for > %llu ns (%d ticks) "
+	     "without schedule\n",
+	     cpu, latency, cpu_rq(cpu)->ticks_without_resched);
+}
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 011c5ec7b7b5..7f8dace0964c 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -91,5 +91,7 @@ SCHED_FEAT(WA_BIAS, true)
 SCHED_FEAT(UTIL_EST, true)
 SCHED_FEAT(UTIL_EST_FASTUP, true)
 
+SCHED_FEAT(LATENCY_WARN, false)
+
 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0f4db0bb7692..563e77d2c0a2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -58,6 +58,7 @@
 #include <linux/prefetch.h>
 #include <linux/profile.h>
 #include <linux/psi.h>
+#include <linux/ratelimit.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/security.h>
 #include <linux/stop_machine.h>
@@ -971,6 +972,11 @@ struct rq {
 
 	atomic_t		nr_iowait;
 
+#ifdef CONFIG_SCHED_DEBUG
+	u64 last_seen_need_resched_ns;
+	int ticks_without_resched;
+#endif
+
 #ifdef CONFIG_MEMBARRIER
 	int membarrier_state;
 #endif
@@ -2376,6 +2382,8 @@ extern void print_dl_stats(struct seq_file *m, int cpu);
 extern void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq);
 extern void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
 extern void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq);
+
+extern void resched_latency_warn(int cpu, u64 latency);
 #ifdef CONFIG_NUMA_BALANCING
 extern void
 show_numa_stats(struct task_struct *p, struct seq_file *m);
@@ -2383,6 +2391,8 @@ extern void
 print_numa_stats(struct seq_file *m, int node, unsigned long tsf,
 	unsigned long tpf, unsigned long gsf, unsigned long gpf);
 #endif /* CONFIG_NUMA_BALANCING */
+#else
+static inline void resched_latency_warn(int cpu, u64 latency) {}
 #endif /* CONFIG_SCHED_DEBUG */
 
 extern void init_cfs_rq(struct cfs_rq *cfs_rq);
-- 
2.31.1.368.gbe11c130af-goog

