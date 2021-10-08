Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B8A4260F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 02:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbhJHAKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 20:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhJHAKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 20:10:42 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B85C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 17:08:48 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z10-20020ac83e0a000000b002a732692afaso6514525qtf.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 17:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UITQT8TF1r4H9nymqxx6K0UTFdHue2SpI8VTwCIPYRo=;
        b=EomG6JX9zOIGoq3702neUSbKG70mkijAGb53DtVNrkDt0fhgq5VSScjqIoPUn3CMPx
         Lhq2sx7xSQRwDC7a993gsPA0oKrbb1zUEM7o2kjtBlpB54c5XXEoAXO7hZCQeb6p83eW
         q0UlSwiHJc6ayBEvMhy1I3Qq+2AO7zEIZvIHNNVYfboIB6fgVQQt/X8yNWMNGoa3jyzB
         0Gw176F+VKDhlDKNudBlDrZPImDq733N5zq/YJ0Gr+Hf9951nbK3mizCjmq+1yzYTtos
         zBJI8C+3OGkTrx8YGBiylwXCwBKRzA1Vd/4qml80t0vqh7RrOsT2nM3YMpMfHSuaa1T2
         4umA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UITQT8TF1r4H9nymqxx6K0UTFdHue2SpI8VTwCIPYRo=;
        b=OnlHg5Dya6OM4Wz2R8Qlu/XBv74ReeujcWRn8xghVsS2tlBHYlZlml5RCoRB7UAnqO
         4pwL5pfYX45IbngggZg6qZiPnvJS3xo4dwLEwIP+YVSwAPzK9K3zOz1FdVZQxoUFzRq3
         /6njs9WBCd/WLgEGzbaUCxJo1jCGbVcRnkHIMqt0yMZdSIu0+CPEUd/aFabrjofxx81e
         hU9y4mMUtVgR0nAhP4HsXqjkT81HM6Cpcv6w9tGGRP6bo4yLd40u8YB+6hwNhwaiyPpf
         7zwbrx1Gt/NNwFf5AWiuxOweVxGZ3qDeYcvb2u/8QnByCc6ptofBftKXgbV3k2z6S9t0
         IqrA==
X-Gm-Message-State: AOAM532WWSYz0d7RjGRi5urpcGDPLNTaU1Ns0E+ImbtDPtcJQAn+/YFS
        8Ef/H9T6yF/EBH0fG2/z/jAeu8a4klze
X-Google-Smtp-Source: ABdhPJxPbMFQUOoqvL1oLa7DcKS6WwWYlLyfvTxxvbo5C85ZM0uVnUPAIJV6udtThJQXkd9mzu8W0HXGintl
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:d93e:5864:88af:1c02])
 (user=joshdon job=sendgmr) by 2002:ac8:5392:: with SMTP id
 x18mr8578350qtp.180.1633651727183; Thu, 07 Oct 2021 17:08:47 -0700 (PDT)
Date:   Thu,  7 Oct 2021 17:08:25 -0700
Message-Id: <20211008000825.1364224-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH] sched/core: forced idle accounting
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Hao Luo <haoluo@google.com>, linux-kernel@vger.kernel.org,
        Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds accounting for "forced idle" time, which is time where a cookie'd
task forces its SMT sibling to idle, despite the presence of runnable
tasks.

Forced idle time is one means to measure the cost of enabling core
scheduling (ie. the capacity lost due to the need to force idle).

Signed-off-by: Josh Don <joshdon@google.com>
---
 include/linux/sched.h     |  1 +
 kernel/sched/core.c       | 46 ++++++++++++++++-----
 kernel/sched/core_sched.c | 85 ++++++++++++++++++++++++++++++++++++++-
 kernel/sched/debug.c      |  3 ++
 kernel/sched/sched.h      | 11 ++++-
 5 files changed, 135 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2aa30e8e1440..d114ba350802 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -784,6 +784,7 @@ struct task_struct {
 	struct rb_node			core_node;
 	unsigned long			core_cookie;
 	unsigned int			core_occupation;
+	u64				core_forceidle_sum;
 #endif
 
 #ifdef CONFIG_CGROUP_SCHED
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ada028e579b0..baa4f48cacff 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -181,15 +181,23 @@ void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 	rb_add(&p->core_node, &rq->core_tree, rb_sched_core_less);
 }
 
-void sched_core_dequeue(struct rq *rq, struct task_struct *p)
+void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
 {
 	rq->core->core_task_seq++;
 
-	if (!sched_core_enqueued(p))
-		return;
+	if (sched_core_enqueued(p)) {
+		rb_erase(&p->core_node, &rq->core_tree);
+		RB_CLEAR_NODE(&p->core_node);
+	}
 
-	rb_erase(&p->core_node, &rq->core_tree);
-	RB_CLEAR_NODE(&p->core_node);
+	/*
+	 * Migrating the last task off the cpu, with the cpu in forced idle
+	 * state. Reschedule to create an accounting edge for forced idle,
+	 * and re-examine whether the core is still in forced idle state.
+	 */
+	if (!(flags & DEQUEUE_SAVE) && rq->nr_running == 1 &&
+	    rq->core->core_forceidle && rq->curr == rq->idle)
+		resched_curr(rq);
 }
 
 /*
@@ -364,7 +372,8 @@ void sched_core_put(void)
 #else /* !CONFIG_SCHED_CORE */
 
 static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
-static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+static inline void
+sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
 
 #endif /* CONFIG_SCHED_CORE */
 
@@ -2020,7 +2029,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (sched_core_enabled(rq))
-		sched_core_dequeue(rq, p);
+		sched_core_dequeue(rq, p, flags);
 
 	if (!(flags & DEQUEUE_NOCLOCK))
 		update_rq_clock(rq);
@@ -5256,6 +5265,7 @@ void scheduler_tick(void)
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
+	sched_core_tick(rq);
 
 	rq_unlock(rq, &rf);
 
@@ -5668,6 +5678,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	struct task_struct *next, *p, *max = NULL;
 	const struct cpumask *smt_mask;
 	bool fi_before = false;
+	bool core_clock_updated = (rq == rq->core);
 	unsigned long cookie;
 	int i, cpu, occ = 0;
 	struct rq *rq_i;
@@ -5721,9 +5732,15 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	/* reset state */
 	rq->core->core_cookie = 0UL;
 	if (rq->core->core_forceidle) {
+		if (!core_clock_updated) {
+			update_rq_clock(rq->core);
+			core_clock_updated = true;
+		}
+		sched_core_account_forceidle(rq);
+		rq->core->core_forceidle = false;
+		rq->core->core_forceidle_start = 0;
 		need_sync = true;
 		fi_before = true;
-		rq->core->core_forceidle = false;
 	}
 
 	/*
@@ -5765,7 +5782,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	for_each_cpu_wrap(i, smt_mask, cpu) {
 		rq_i = cpu_rq(i);
 
-		if (i != cpu)
+		if (i != cpu && (rq_i != rq->core || !core_clock_updated))
 			update_rq_clock(rq_i);
 
 		p = rq_i->core_pick = pick_task(rq_i);
@@ -5804,6 +5821,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		}
 	}
 
+	if (rq->core->core_forceidle && cookie)
+		rq->core->core_forceidle_start = rq_clock(rq->core);
+
 	rq->core->core_pick_seq = rq->core->core_task_seq;
 	next = rq->core_pick;
 	rq->core_sched_seq = rq->core->core_pick_seq;
@@ -6051,6 +6071,13 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
 	core_rq->core_forceidle     = rq->core_forceidle;
 	core_rq->core_forceidle_seq = rq->core_forceidle_seq;
 
+	/*
+	 * Accounting edge for forced idle is handled in pick_next_task().
+	 * Don't need another one here, since the hotplug thread shouldn't
+	 * have a cookie.
+	 */
+	core_rq->core_forceidle_start = 0;
+
 	/* install new leader */
 	for_each_cpu(t, smt_mask) {
 		rq = cpu_rq(t);
@@ -9424,6 +9451,7 @@ void __init sched_init(void)
 		rq->core_enabled = 0;
 		rq->core_tree = RB_ROOT;
 		rq->core_forceidle = false;
+		rq->core_forceidle_start = 0;
 
 		rq->core_cookie = 0UL;
 #endif
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 48ac72696012..aae4ac2ac7ec 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -73,7 +73,7 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
 
 	enqueued = sched_core_enqueued(p);
 	if (enqueued)
-		sched_core_dequeue(rq, p);
+		sched_core_dequeue(rq, p, DEQUEUE_SAVE);
 
 	old_cookie = p->core_cookie;
 	p->core_cookie = cookie;
@@ -85,6 +85,10 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
 	 * If task is currently running, it may not be compatible anymore after
 	 * the cookie change, so enter the scheduler on its CPU to schedule it
 	 * away.
+	 *
+	 * Note that it is possible that as a result of this cookie change, the
+	 * core has now entered/left forced idle state. Defer accounting to the
+	 * next scheduling edge, rather than always forcing a reschedule here.
 	 */
 	if (task_running(rq, p))
 		resched_curr(rq);
@@ -109,6 +113,7 @@ void sched_core_fork(struct task_struct *p)
 {
 	RB_CLEAR_NODE(&p->core_node);
 	p->core_cookie = sched_core_clone_cookie(current);
+	p->core_forceidle_sum = 0;
 }
 
 void sched_core_free(struct task_struct *p)
@@ -228,3 +233,81 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 	return err;
 }
 
+/* REQUIRES: rq->core's clock recently updated. */
+void sched_core_account_forceidle(struct rq *rq)
+{
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
+	unsigned int smt_count;
+	u64 delta, now = rq_clock(rq->core);
+	struct rq *rq_i;
+	struct task_struct *p;
+	int i;
+
+	lockdep_assert_rq_held(rq);
+
+	WARN_ON_ONCE(!rq->core->core_forceidle);
+
+	if (rq->core->core_forceidle_start == 0)
+		return;
+
+	delta = now - rq->core->core_forceidle_start;
+	if (unlikely((s64)delta <= 0))
+		return;
+
+	rq->core->core_forceidle_start = now;
+
+	/*
+	 * For larger SMT configurations, we need to scale the charged
+	 * forced idle amount since there can be more than one forced idle
+	 * sibling and more than one running cookied task.
+	 */
+	smt_count = cpumask_weight(smt_mask);
+	if (smt_count > 2) {
+		unsigned int nr_forced_idle = 0, nr_running = 0;
+
+		for_each_cpu(i, smt_mask) {
+			rq_i = cpu_rq(i);
+			p = rq_i->core_pick ?: rq_i->curr;
+
+			if (p != rq_i->idle)
+				nr_running++;
+			else if (rq_i->nr_running)
+				nr_forced_idle++;
+		}
+
+		if (WARN_ON_ONCE(!nr_running)) {
+			/* can't be forced idle without a running task */
+		} else {
+			delta *= nr_forced_idle;
+			delta /= nr_running;
+		}
+	}
+
+	for_each_cpu(i, smt_mask) {
+		rq_i = cpu_rq(i);
+		p = rq_i->core_pick ?: rq_i->curr;
+
+		if (!p->core_cookie)
+			continue;
+
+		p->core_forceidle_sum += delta;
+
+		/* Optimize for common case. */
+		if (smt_count == 2)
+			break;
+	}
+}
+
+void sched_core_tick(struct rq *rq)
+{
+	if (!sched_core_enabled(rq))
+		return;
+
+	if (!rq->core->core_forceidle)
+		return;
+
+	if (rq != rq->core)
+		update_rq_clock(rq->core);
+	sched_core_account_forceidle(rq);
+}
+
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 26fac5e28bc0..0fe6a1bb8b60 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1045,6 +1045,9 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	__PS("uclamp.max", p->uclamp_req[UCLAMP_MAX].value);
 	__PS("effective uclamp.min", uclamp_eff_value(p, UCLAMP_MIN));
 	__PS("effective uclamp.max", uclamp_eff_value(p, UCLAMP_MAX));
+#endif
+#ifdef CONFIG_SCHED_CORE
+	PN(core_forceidle_sum);
 #endif
 	P(policy);
 	P(prio);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a00fc7057d97..4678b85754f2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1113,6 +1113,7 @@ struct rq {
 	unsigned long		core_cookie;
 	unsigned char		core_forceidle;
 	unsigned int		core_forceidle_seq;
+	u64			core_forceidle_start;
 #endif
 };
 
@@ -1253,11 +1254,15 @@ static inline bool sched_core_enqueued(struct task_struct *p)
 }
 
 extern void sched_core_enqueue(struct rq *rq, struct task_struct *p);
-extern void sched_core_dequeue(struct rq *rq, struct task_struct *p);
+extern void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags);
 
 extern void sched_core_get(void);
 extern void sched_core_put(void);
 
+extern void sched_core_account_forceidle(struct rq *rq);
+
+extern void sched_core_tick(struct rq *rq);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
@@ -1300,6 +1305,10 @@ static inline bool sched_group_cookie_match(struct rq *rq,
 {
 	return true;
 }
+
+static inline void sched_core_account_forceidle(struct rq *rq) {}
+
+static inline void sched_core_tick(struct rq *rq) {}
 #endif /* CONFIG_SCHED_CORE */
 
 static inline void lockdep_assert_rq_held(struct rq *rq)
-- 
2.33.0.882.g93a45727a2-goog

