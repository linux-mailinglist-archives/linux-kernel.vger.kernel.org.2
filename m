Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0B8315E09
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 05:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhBJEIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 23:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhBJEIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 23:08:16 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E663EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 20:07:36 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b8so470728plh.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 20:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LFLEeAHf3NnDtX99DT6C1nH3sQcxKPp7NS/lps/Xmys=;
        b=q3lsjjg1AnJAntU5hoT/NBL7cjz6M0hT5rw4LWPs57kFOHzYlvIooF5i+mIUqEcw41
         2JZ4V4SaL45UckjoJrVVUlZ25LYpkAST5+5x2ceBloLvcHcY308IGBfL0CZmOP2CeIzc
         ZyU/DejRFc4aFxpLtTNFli1bx6y/rJmdnb4luXpFwPbPFngyOLb8OEHTRagXrcAjpYj9
         xSMXaG2dzeDbGtZIyh3CPqZPce4VwiwMLKeotTZ8hlPsDTuvS4z7VD0o90Ewn6uY1iX9
         Br62n7/PSIjLxuBhhX6x1V4hHioP5iSz0i0mPOzs7AKjvI62SuLbXgonOfF2fwwofMQT
         MpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LFLEeAHf3NnDtX99DT6C1nH3sQcxKPp7NS/lps/Xmys=;
        b=Y6oNDXYRFm9l2IftT+NrRqbJ1hY67OJdl6We46a0qEfqJGCVaaYGT00w7Y/M7dtFwk
         ZwlkQJ/85DD0W4LGHIr1QfbPBWiI6UFTe8SKRiXMNSCSlZ3CjMDC4k7v0DooxmDdkMPq
         0Zmz9nzTQW6o+RMxVLZe9MNALRDj6KMmbxOht9TNHiun/SpMoo8lvW+S4QKS1u3BvrWD
         CbTvIsJ0R5ITZ49YevfS9uHbcqxnRDcPFFlNLbZ4tgKPnH/VZWq46E03Oo/F0LTfSewr
         FMwLyTYjUcZzR94S7lzx53mJBBMNfZVWu06Sghw6QncLuMjHplTI0Qs68DTVEfI24uAD
         z1Sg==
X-Gm-Message-State: AOAM533U4CxMgW1ANrlXfgGUqoaAn/Lp3fvxIwGEamh/vw9Jh4nko+Ew
        5t+dkm3lO4uM6wXnBO7IOJndBQ==
X-Google-Smtp-Source: ABdhPJxTucpaLAIbkYk1ZGh11xpe9hlhmIWgyeWomVm8lg3I3a8j6vl9AvkQcE3WswaFkAsF01MWrw==
X-Received: by 2002:a17:90a:ce03:: with SMTP id f3mr1203645pju.44.1612930056466;
        Tue, 09 Feb 2021 20:07:36 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id m23sm405463pgv.14.2021.02.09.20.07.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 20:07:35 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
Subject: [PATCH] psi: Use ONCPU state tracking machinery to detect reclaim
Date:   Wed, 10 Feb 2021 12:06:05 +0800
Message-Id: <20210210040605.38973-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the reclaim detection from the timer tick to the task state
tracking machinery using the recently added ONCPU state. And we
also add memstall state changes checking in the psi_task_switch()
optimization to update the parents properly.

Thanks to Johannes Weiner for pointing out the psi_task_switch()
optimization things and the clearer changelog.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/psi.h  |  1 -
 kernel/sched/core.c  |  1 -
 kernel/sched/psi.c   | 52 ++++++++++++++++------------------------------------
 kernel/sched/stats.h |  9 ---------
 4 files changed, 16 insertions(+), 47 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 7361023f3fdd..65eb1476ac70 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -20,7 +20,6 @@ void psi_task_change(struct task_struct *task, int clear, int set);
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
 
-void psi_memstall_tick(struct task_struct *task, int cpu);
 void psi_memstall_enter(unsigned long *flags);
 void psi_memstall_leave(unsigned long *flags);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 15d2562118d1..31788a9b335b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4533,7 +4533,6 @@ void scheduler_tick(void)
 	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
 	calc_global_load_tick(rq);
-	psi_task_tick(rq);
 
 	rq_unlock(rq, &rf);
 
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 2293c45d289d..11449fb8141e 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -644,8 +644,7 @@ static void poll_timer_fn(struct timer_list *t)
 	wake_up_interruptible(&group->poll_wait);
 }
 
-static void record_times(struct psi_group_cpu *groupc, int cpu,
-			 bool memstall_tick)
+static void record_times(struct psi_group_cpu *groupc, int cpu)
 {
 	u32 delta;
 	u64 now;
@@ -664,23 +663,6 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
 		groupc->times[PSI_MEM_SOME] += delta;
 		if (groupc->state_mask & (1 << PSI_MEM_FULL))
 			groupc->times[PSI_MEM_FULL] += delta;
-		else if (memstall_tick) {
-			u32 sample;
-			/*
-			 * Since we care about lost potential, a
-			 * memstall is FULL when there are no other
-			 * working tasks, but also when the CPU is
-			 * actively reclaiming and nothing productive
-			 * could run even if it were runnable.
-			 *
-			 * When the timer tick sees a reclaiming CPU,
-			 * regardless of runnable tasks, sample a FULL
-			 * tick (or less if it hasn't been a full tick
-			 * since the last state change).
-			 */
-			sample = min(delta, (u32)jiffies_to_nsecs(1));
-			groupc->times[PSI_MEM_FULL] += sample;
-		}
 	}
 
 	if (groupc->state_mask & (1 << PSI_CPU_SOME)) {
@@ -714,7 +696,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	 */
 	write_seqcount_begin(&groupc->seq);
 
-	record_times(groupc, cpu, false);
+	record_times(groupc, cpu);
 
 	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
 		if (!(m & (1 << t)))
@@ -738,6 +720,18 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		if (test_state(groupc->tasks, s))
 			state_mask |= (1 << s);
 	}
+
+	/*
+	 * Since we care about lost potential, a memstall is FULL
+	 * when there are no other working tasks, but also when
+	 * the CPU is actively reclaiming and nothing productive
+	 * could run even if it were runnable. So when the current
+	 * task in a cgroup is in_memstall, the corresponding groupc
+	 * on that cpu is in PSI_MEM_FULL state.
+	 */
+	if (groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall)
+		state_mask |= (1 << PSI_MEM_FULL);
+
 	groupc->state_mask = state_mask;
 
 	write_seqcount_end(&groupc->seq);
@@ -833,7 +827,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 */
 		iter = NULL;
 		while ((group = iterate_groups(next, &iter))) {
-			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
+			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU] &&
+			    next->in_memstall == prev->in_memstall) {
 				common = group;
 				break;
 			}
@@ -859,21 +854,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	}
 }
 
-void psi_memstall_tick(struct task_struct *task, int cpu)
-{
-	struct psi_group *group;
-	void *iter = NULL;
-
-	while ((group = iterate_groups(task, &iter))) {
-		struct psi_group_cpu *groupc;
-
-		groupc = per_cpu_ptr(group->pcpu, cpu);
-		write_seqcount_begin(&groupc->seq);
-		record_times(groupc, cpu, true);
-		write_seqcount_end(&groupc->seq);
-	}
-}
-
 /**
  * psi_memstall_enter - mark the beginning of a memory stall section
  * @flags: flags to handle nested sections
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 33d0daf83842..9e4e67a94731 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -144,14 +144,6 @@ static inline void psi_sched_switch(struct task_struct *prev,
 	psi_task_switch(prev, next, sleep);
 }
 
-static inline void psi_task_tick(struct rq *rq)
-{
-	if (static_branch_likely(&psi_disabled))
-		return;
-
-	if (unlikely(rq->curr->in_memstall))
-		psi_memstall_tick(rq->curr, cpu_of(rq));
-}
 #else /* CONFIG_PSI */
 static inline void psi_enqueue(struct task_struct *p, bool wakeup) {}
 static inline void psi_dequeue(struct task_struct *p, bool sleep) {}
@@ -159,7 +151,6 @@ static inline void psi_ttwu_dequeue(struct task_struct *p) {}
 static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
 				    bool sleep) {}
-static inline void psi_task_tick(struct rq *rq) {}
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO
-- 
2.11.0

