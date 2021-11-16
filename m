Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109F945316E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhKPLyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:54:51 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:60733 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235642AbhKPLym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:54:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UwtYol._1637063500;
Received: from localhost(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0UwtYol._1637063500)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Nov 2021 19:51:40 +0800
From:   Peng Wang <rocking@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/idle: support busy loop polling on idle SMT cpus
Date:   Tue, 16 Nov 2021 19:51:36 +0800
Message-Id: <487180cde91b5de55f013c0294743908fd46e358.1637062971.git.rocking@linux.alibaba.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1637062971.git.rocking@linux.alibaba.com>
References: <cover.1637062971.git.rocking@linux.alibaba.com>
In-Reply-To: <cover.1637062971.git.rocking@linux.alibaba.com>
References: <cover.1637062971.git.rocking@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hardware SMT is enabled, the switching between one cpu's idle and busy
state will cause performance fluctuation of sibling cpus on the same core.

Consistent noise is needed when requiring stable performance on one SMT cpu
regardless of whether the sibling cpus on the same core is idle.

The orginal cpu_idle_force_poll uses cpu_relax() waiting an arriving IPI,
while this smt_idle_force_poll uses busy loop to provide consistent SMT
pipeline interference.

Use a CGroup config to enable busy loop polling for specific tasks.

Interface: cgroup/cpu.smt_idle_poll
 0: default behavior
 1: SMT idle sibling cpus will do busy loop polling

Co-developed-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
---
 arch/Kconfig         | 10 ++++++
 kernel/sched/core.c  | 39 ++++++++++++++++++++++
 kernel/sched/idle.c  | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h | 18 +++++++++++
 4 files changed, 158 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 26b8ed1..805c3b9 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -233,6 +233,16 @@ config GENERIC_SMP_IDLE_THREAD
 config GENERIC_IDLE_POLL_SETUP
 	bool
 
+config SMT_IDLE_POLL
+	bool "SMT idle poll"
+	depends on SCHED_SMT
+	help
+	  When hardware SMT is enabled, the switching between idle or busy
+	  state of one cpu will cause performance fluctuation of other
+	  cpus on the same core. This provides a way to support consistent
+	  SMT noise.
+	  If in doubt, say "N".
+
 config ARCH_HAS_FORTIFY_SOURCE
 	bool
 	help
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3c9b0fd..ef478d6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4845,6 +4845,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	prev_state = READ_ONCE(prev->__state);
 	vtime_task_switch(prev);
 	perf_event_task_sched_in(prev, current);
+	smt_idle_poll_switch(rq);
 	finish_task(prev);
 	tick_nohz_task_switch();
 	finish_lock_switch(rq);
@@ -10189,6 +10190,30 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
 	return (u64) scale_load_down(tg->shares);
 }
 
+#ifdef CONFIG_SMT_IDLE_POLL
+static atomic_t smt_idle_poll_count;
+static int smt_idle_poll_write_u64(struct cgroup_subsys_state *css,
+				struct cftype *cftype, u64 smt_idle_poll)
+{
+	if (smt_idle_poll == 1) {
+		if (atomic_inc_return(&smt_idle_poll_count) == 1)
+			static_branch_enable(&__smt_idle_poll_enabled);
+	} else if (smt_idle_poll == 0) {
+		if (atomic_dec_return(&smt_idle_poll_count) == 0)
+			static_branch_disable(&__smt_idle_poll_enabled);
+	} else
+		return -EINVAL;
+	css_tg(css)->need_smt_idle_poll = smt_idle_poll;
+	return 0;
+}
+
+static u64 smt_idle_poll_read_u64(struct cgroup_subsys_state *css,
+			       struct cftype *cft)
+{
+	return (u64)css_tg(css)->need_smt_idle_poll;
+}
+#endif
+
 #ifdef CONFIG_CFS_BANDWIDTH
 static DEFINE_MUTEX(cfs_constraints_mutex);
 
@@ -10565,6 +10590,13 @@ static struct cftype cpu_legacy_files[] = {
 		.read_s64 = cpu_idle_read_s64,
 		.write_s64 = cpu_idle_write_s64,
 	},
+#ifdef CONFIG_SMT_IDLE_POLL
+	{
+		.name = "smt_idle_poll",
+		.read_u64 = smt_idle_poll_read_u64,
+		.write_u64 = smt_idle_poll_write_u64,
+	},
+#endif
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
@@ -10782,6 +10814,13 @@ static struct cftype cpu_files[] = {
 		.read_s64 = cpu_idle_read_s64,
 		.write_s64 = cpu_idle_write_s64,
 	},
+#ifdef CONFIG_SMT_IDLE_POLL
+	{
+		.name = "smt_idle_poll",
+		.read_u64 = smt_idle_poll_read_u64,
+		.write_u64 = smt_idle_poll_write_u64,
+	},
+#endif
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d17b0a5..bfb8f56 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -52,6 +52,90 @@ static int __init cpu_idle_nopoll_setup(char *__unused)
 __setup("hlt", cpu_idle_nopoll_setup);
 #endif
 
+#ifdef CONFIG_SMT_IDLE_POLL
+DEFINE_STATIC_KEY_FALSE(__smt_idle_poll_enabled);
+
+void smt_idle_poll_switch(struct rq *rq)
+{
+	struct rq *smt_rq;
+	struct task_group *tg;
+	int smt, cpu;
+
+	if (!static_branch_unlikely(&__smt_idle_poll_enabled))
+		return;
+
+	if (rq->idle == current) {
+		rq->need_smt_idle_poll = false;
+		return;
+	}
+
+	rcu_read_lock();
+	tg = container_of(task_css_check(current, cpu_cgrp_id, true),
+		struct task_group, css);
+	rq->need_smt_idle_poll = tg->need_smt_idle_poll;
+	rcu_read_unlock();
+
+	if (!rq->need_smt_idle_poll)
+		return;
+
+	cpu = rq->cpu;
+	for_each_cpu(smt, cpu_smt_mask(cpu)) {
+		if (cpu == smt || !cpu_online(smt))
+			continue;
+		smt_rq = cpu_rq(smt);
+		if (smt_rq->idle == smt_rq->curr && !smt_rq->in_smt_idle_poll)
+			smp_send_reschedule(smt);
+	}
+}
+
+/**
+ * need_smt_idle_poll - Decide whether to continue SMT idle polling.
+ */
+static bool need_smt_idle_poll(void)
+{
+	int cpu, ht;
+	struct rq *rq;
+
+	if (!static_branch_unlikely(&__smt_idle_poll_enabled))
+		return false;
+
+	if (tif_need_resched())
+		return false;
+
+	cpu = smp_processor_id();
+	for_each_cpu(ht, cpu_smt_mask(cpu)) {
+		if (cpu == ht || !cpu_online(ht))
+			continue;
+
+		rq = cpu_rq(ht);
+		if (rq->need_smt_idle_poll)
+			return true;
+	}
+
+	return false;
+}
+
+static noinline int __cpuidle smt_idle_poll(void)
+{
+	trace_cpu_idle(0, smp_processor_id());
+	stop_critical_timings();
+	rcu_idle_enter();
+	local_irq_enable();
+
+	this_rq()->in_smt_idle_poll = true;
+	while (need_smt_idle_poll())
+		;
+	this_rq()->in_smt_idle_poll = false;
+
+	rcu_idle_exit();
+	start_critical_timings();
+	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
+
+	return 1;
+}
+
+#endif
+
 static noinline int __cpuidle cpu_idle_poll(void)
 {
 	trace_cpu_idle(0, smp_processor_id());
@@ -293,6 +377,13 @@ static void do_idle(void)
 		arch_cpu_idle_enter();
 		rcu_nocb_flush_deferred_wakeup();
 
+#ifdef CONFIG_SMT_IDLE_POLL
+		if (need_smt_idle_poll()) {
+			tick_nohz_idle_restart_tick();
+			smt_idle_poll();
+		}
+#endif
+
 		/*
 		 * In poll mode we reenable interrupts and spin. Also if we
 		 * detected in the wakeup from idle path that the tick
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0e66749..58b3af3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -401,6 +401,10 @@ struct task_group {
 	/* A positive value indicates that this is a SCHED_IDLE group. */
 	int			idle;
 
+#ifdef CONFIG_SMT_IDLE_POLL
+	bool			need_smt_idle_poll;
+#endif
+
 #ifdef	CONFIG_SMP
 	/*
 	 * load_avg can be heavily contended at clock tick time, so put
@@ -1114,6 +1118,11 @@ struct rq {
 	unsigned char		core_forceidle;
 	unsigned int		core_forceidle_seq;
 #endif
+
+#ifdef CONFIG_SMT_IDLE_POLL
+	bool			need_smt_idle_poll;
+	bool			in_smt_idle_poll;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -1302,6 +1311,15 @@ static inline bool sched_group_cookie_match(struct rq *rq,
 }
 #endif /* CONFIG_SCHED_CORE */
 
+#ifdef CONFIG_SMT_IDLE_POLL
+DECLARE_STATIC_KEY_FALSE(__smt_idle_poll_enabled);
+extern void smt_idle_poll_switch(struct rq *rq);
+#else
+static inline void smt_idle_poll_switch(struct rq *rq)
+{
+}
+#endif
+
 static inline void lockdep_assert_rq_held(struct rq *rq)
 {
 	lockdep_assert_held(__rq_lockp(rq));
-- 
2.9.5

