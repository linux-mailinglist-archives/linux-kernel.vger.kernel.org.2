Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2263A4F0D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 15:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhFLNEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 09:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhFLNEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 09:04:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC81CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 06:02:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f2so8959886wri.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 06:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hJKEiQPNZ7j2+ZWJ98CQw+tQ1YBauO1QIr+oKSe1Ga4=;
        b=FllLtMKBB/JlfBtrmamKNPWi3y+vhB/VY8YizzfjQCXVIPgs3lO1B4DTqxTxqy1Jub
         EbP9L7G5i6X35gt/JFSK8tNCri95Vw6VPDOxWw+28s9XMH8ezX80UwQYqcPfT7GfXG4M
         kO+Ac3GKxQIf06Ck0iRLbbQdmypmyY/+Oab7g/OWn8YMYWMqznftRcjzXdzskBWLRIeY
         bnU5BYY5UpgnztEh2GMXgnDYl5AF3nw9psLiVE1MfmIcNcGxtJvUi5Xlmt1Qtm5D12Q2
         nvvk0XsOXEFeu05cBLS2Ck/HfVGfIaPFT3LQiXDDWevbU4enVHOuUbbN9oC/O4SZll51
         pkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=hJKEiQPNZ7j2+ZWJ98CQw+tQ1YBauO1QIr+oKSe1Ga4=;
        b=bjaM26aBapEK7xd7Sd6VajDIviPqOTwh0ozO6aMF0pgqFFp8BRM4Nze6ky/fJ+KLyI
         t+3dz6ciXej0acT6FrbxUqO5ekilRbybrvBxfNgcT1nMGN5OdeTGZiuJgYWEwb+o4NEg
         uHOWp/ePmPgsZxYHgID4xImTKoij4CJr10Qzl4Rkn9wq0EHgD9zzBjqP+x4f4y2DKtiK
         EZwWxxkwsO0YIwGwezBjffDYqlenfHrNfYVKfqfqpMVSrQBk+GEeo7ASTwvMvl3nNh3Q
         Ysrf09DpEWc4pKOBV7l1bxqOkhXdtl06rSVcP/2NizkVYvfBfOvTTItAdu/OllzXfBo3
         Z4Tg==
X-Gm-Message-State: AOAM530nrO2crndZav/H/gJ4WEsprq727WN2Px0G6bTXWTBQmX+LCJNQ
        FReKFTKJkIrrYhO328mj4TY=
X-Google-Smtp-Source: ABdhPJwbkl3c65HnGnRvC5LZqvJPXLeXaQLOKRyooAK1JkHciMHUFJxbOg76HU6yN/xiO5B6UC2gGA==
X-Received: by 2002:a5d:5752:: with SMTP id q18mr9074533wrw.419.1623502928258;
        Sat, 12 Jun 2021 06:02:08 -0700 (PDT)
Received: from gmail.com (77-234-80-172.pool.digikabel.hu. [77.234.80.172])
        by smtp.gmail.com with ESMTPSA id m21sm14596354wms.42.2021.06.12.06.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 06:02:07 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 12 Jun 2021 15:02:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <YMSwTuTE97YiP3cd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-06-12

   # HEAD: 68d7a190682aa4eb02db477328088ebad15acc83 sched/fair: Fix util_est UTIL_AVG_UNCHANGED handling

Misc fixes:

 - Fix performance regression caused by lack of intended
   batching of RCU callbacks by over-eager NOHZ-full code.

 - Fix cgroups related corruption of load_avg and load_sum metrics.

 - Three fixes to fix blocked load, util_sum/runnable_sum and
   util_est tracking bugs.

 Thanks,

	Ingo

------------------>
Dietmar Eggemann (1):
      sched/fair: Fix util_est UTIL_AVG_UNCHANGED handling

Frederic Weisbecker (1):
      tick/nohz: Only check for RCU deferred wakeup on user/guest entry when needed

Vincent Guittot (3):
      sched/fair: Keep load_avg and load_sum synced
      sched/fair: Make sure to update tg contrib for blocked load
      sched/pelt: Ensure that *_sum is always synced with *_avg


 include/linux/entry-kvm.h |  3 ++-
 include/linux/sched.h     |  8 ++++++++
 include/linux/tick.h      |  7 +++++++
 kernel/entry/common.c     |  5 +++--
 kernel/sched/debug.c      |  3 ++-
 kernel/sched/fair.c       | 28 +++++++++++++++++-----------
 kernel/sched/pelt.h       | 11 +----------
 kernel/time/tick-sched.c  |  1 +
 8 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 8b2b1d68b954..136b8d97d8c0 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -3,6 +3,7 @@
 #define __LINUX_ENTRYKVM_H
 
 #include <linux/entry-common.h>
+#include <linux/tick.h>
 
 /* Transfer to guest mode work */
 #ifdef CONFIG_KVM_XFER_TO_GUEST_WORK
@@ -57,7 +58,7 @@ int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu);
 static inline void xfer_to_guest_mode_prepare(void)
 {
 	lockdep_assert_irqs_disabled();
-	rcu_nocb_flush_deferred_wakeup();
+	tick_nohz_user_enter_prepare();
 }
 
 /**
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2c881384517..28a98fc4ded4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -350,11 +350,19 @@ struct load_weight {
  * Only for tasks we track a moving average of the past instantaneous
  * estimated utilization. This allows to absorb sporadic drops in utilization
  * of an otherwise almost periodic task.
+ *
+ * The UTIL_AVG_UNCHANGED flag is used to synchronize util_est with util_avg
+ * updates. When a task is dequeued, its util_est should not be updated if its
+ * util_avg has not been updated in the meantime.
+ * This information is mapped into the MSB bit of util_est.enqueued at dequeue
+ * time. Since max value of util_est.enqueued for a task is 1024 (PELT util_avg
+ * for a task) it is safe to use MSB.
  */
 struct util_est {
 	unsigned int			enqueued;
 	unsigned int			ewma;
 #define UTIL_EST_WEIGHT_SHIFT		2
+#define UTIL_AVG_UNCHANGED		0x80000000
 } __attribute__((__aligned__(sizeof(u64))));
 
 /*
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 7340613c7eff..1a0ff88fa107 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -11,6 +11,7 @@
 #include <linux/context_tracking_state.h>
 #include <linux/cpumask.h>
 #include <linux/sched.h>
+#include <linux/rcupdate.h>
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 extern void __init tick_init(void);
@@ -300,4 +301,10 @@ static inline void tick_nohz_task_switch(void)
 		__tick_nohz_task_switch();
 }
 
+static inline void tick_nohz_user_enter_prepare(void)
+{
+	if (tick_nohz_full_cpu(smp_processor_id()))
+		rcu_nocb_flush_deferred_wakeup();
+}
+
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index a0b3b04fb596..bf16395b9e13 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -5,6 +5,7 @@
 #include <linux/highmem.h>
 #include <linux/livepatch.h>
 #include <linux/audit.h>
+#include <linux/tick.h>
 
 #include "common.h"
 
@@ -186,7 +187,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		local_irq_disable_exit_to_user();
 
 		/* Check if any of the above work has queued a deferred wakeup */
-		rcu_nocb_flush_deferred_wakeup();
+		tick_nohz_user_enter_prepare();
 
 		ti_work = READ_ONCE(current_thread_info()->flags);
 	}
@@ -202,7 +203,7 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
 	lockdep_assert_irqs_disabled();
 
 	/* Flush pending rcuog wakeup before the last need_resched() check */
-	rcu_nocb_flush_deferred_wakeup();
+	tick_nohz_user_enter_prepare();
 
 	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
 		ti_work = exit_to_user_mode_loop(regs, ti_work);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 9c882f20803e..c5aacbd492a1 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -885,6 +885,7 @@ static const struct seq_operations sched_debug_sops = {
 #define __PS(S, F) SEQ_printf(m, "%-45s:%21Ld\n", S, (long long)(F))
 #define __P(F) __PS(#F, F)
 #define   P(F) __PS(#F, p->F)
+#define   PM(F, M) __PS(#F, p->F & (M))
 #define __PSN(S, F) SEQ_printf(m, "%-45s:%14Ld.%06ld\n", S, SPLIT_NS((long long)(F)))
 #define __PN(F) __PSN(#F, F)
 #define   PN(F) __PSN(#F, p->F)
@@ -1011,7 +1012,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.util_avg);
 	P(se.avg.last_update_time);
 	P(se.avg.util_est.ewma);
-	P(se.avg.util_est.enqueued);
+	PM(se.avg.util_est.enqueued, ~UTIL_AVG_UNCHANGED);
 #endif
 #ifdef CONFIG_UCLAMP_TASK
 	__PS("uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3248e24a90b0..2c8a9352590d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3499,10 +3499,9 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
 static inline void
 update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
-	long delta_avg, running_sum, runnable_sum = gcfs_rq->prop_runnable_sum;
+	long delta, running_sum, runnable_sum = gcfs_rq->prop_runnable_sum;
 	unsigned long load_avg;
 	u64 load_sum = 0;
-	s64 delta_sum;
 	u32 divider;
 
 	if (!runnable_sum)
@@ -3549,13 +3548,13 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	load_sum = (s64)se_weight(se) * runnable_sum;
 	load_avg = div_s64(load_sum, divider);
 
-	delta_sum = load_sum - (s64)se_weight(se) * se->avg.load_sum;
-	delta_avg = load_avg - se->avg.load_avg;
+	delta = load_avg - se->avg.load_avg;
 
 	se->avg.load_sum = runnable_sum;
 	se->avg.load_avg = load_avg;
-	add_positive(&cfs_rq->avg.load_avg, delta_avg);
-	add_positive(&cfs_rq->avg.load_sum, delta_sum);
+
+	add_positive(&cfs_rq->avg.load_avg, delta);
+	cfs_rq->avg.load_sum = cfs_rq->avg.load_avg * divider;
 }
 
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum)
@@ -3766,11 +3765,17 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
  */
 static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	/*
+	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * See ___update_load_avg() for details.
+	 */
+	u32 divider = get_pelt_divider(&cfs_rq->avg);
+
 	dequeue_load_avg(cfs_rq, se);
 	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
-	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
+	cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
 	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
-	sub_positive(&cfs_rq->avg.runnable_sum, se->avg.runnable_sum);
+	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * divider;
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
@@ -3902,7 +3907,7 @@ static inline unsigned long _task_util_est(struct task_struct *p)
 {
 	struct util_est ue = READ_ONCE(p->se.avg.util_est);
 
-	return (max(ue.ewma, ue.enqueued) | UTIL_AVG_UNCHANGED);
+	return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
 }
 
 static inline unsigned long task_util_est(struct task_struct *p)
@@ -4002,7 +4007,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	 * Reset EWMA on utilization increases, the moving average is used only
 	 * to smooth utilization decreases.
 	 */
-	ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
+	ue.enqueued = task_util(p);
 	if (sched_feat(UTIL_EST_FASTUP)) {
 		if (ue.ewma < ue.enqueued) {
 			ue.ewma = ue.enqueued;
@@ -4051,6 +4056,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	ue.ewma  += last_ewma_diff;
 	ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
 done:
+	ue.enqueued |= UTIL_AVG_UNCHANGED;
 	WRITE_ONCE(p->se.avg.util_est, ue);
 
 	trace_sched_util_est_se_tp(&p->se);
@@ -8030,7 +8036,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 		/* Propagate pending load changes to the parent, if any: */
 		se = cfs_rq->tg->se[cpu];
 		if (se && !skip_blocked_update(se))
-			update_load_avg(cfs_rq_of(se), se, 0);
+			update_load_avg(cfs_rq_of(se), se, UPDATE_TG);
 
 		/*
 		 * There can be a lot of idle CPU cgroups.  Don't let fully
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 1462846d244e..cfe94ffd2b38 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -42,15 +42,6 @@ static inline u32 get_pelt_divider(struct sched_avg *avg)
 	return LOAD_AVG_MAX - 1024 + avg->period_contrib;
 }
 
-/*
- * When a task is dequeued, its estimated utilization should not be update if
- * its util_avg has not been updated at least once.
- * This flag is used to synchronize util_avg updates with util_est updates.
- * We map this information into the LSB bit of the utilization saved at
- * dequeue time (i.e. util_est.dequeued).
- */
-#define UTIL_AVG_UNCHANGED 0x1
-
 static inline void cfs_se_util_change(struct sched_avg *avg)
 {
 	unsigned int enqueued;
@@ -58,7 +49,7 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
 	if (!sched_feat(UTIL_EST))
 		return;
 
-	/* Avoid store if the flag has been already set */
+	/* Avoid store if the flag has been already reset */
 	enqueued = avg->util_est.enqueued;
 	if (!(enqueued & UTIL_AVG_UNCHANGED))
 		return;
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 828b091501ca..6784f27a3099 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -230,6 +230,7 @@ static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 
 #ifdef CONFIG_NO_HZ_FULL
 cpumask_var_t tick_nohz_full_mask;
+EXPORT_SYMBOL_GPL(tick_nohz_full_mask);
 bool tick_nohz_full_running;
 EXPORT_SYMBOL_GPL(tick_nohz_full_running);
 static atomic_t tick_dep_mask;
