Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712A131A158
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhBLPPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBLPP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:15:27 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F574C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 07:14:47 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id z21so6455995pgj.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 07:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EYCiO0FAhTmxDX1fPyXHVZ6/SbHmYSGTeHA0I798KT8=;
        b=Am7Ztbdp/+XBNAPpyetsD98C2ySi+gsRVo9Vlbol1GRkOc2UOBDyyFOMS0HVdbBQOq
         33jb5vx1vq/7AFCMMEAshhu6zcou0deRKhgb41INj4rXGOdsOelr9eFGGU+NM+D2B4z8
         rQQuEN0UdtlPnmxZs/a3CkTCa/jQgxRz3R+hQGI6WuPisfPYhWDFR4TKahBZUVP+0dlc
         LMSitHaruQyqMREBiI3xfoBnFdRU+zWEGdo+sUu2qCQpcJOhKuSezB0NK39/dEwX6LGm
         sFBqNNLHRQ3FbfLb/1c+x7u9nd+V8N0F2M8NYopFfSvF9J69vd27RmdM5UAaR9PUREWv
         hcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EYCiO0FAhTmxDX1fPyXHVZ6/SbHmYSGTeHA0I798KT8=;
        b=nnDR5JgL4jKzlKYd/ywbux07MN1sTiRda6p9Tn/8WjrPEeRx9agp3o2BiRmZrDqZ/g
         GjFd1gKBRlF+8oYEf/IdpWmcYbNks3BXBk830W5E8TDnGXBsIpiWfjzWk43wgnO3FOKd
         PhRgS0ccKqrbO3ywmhGwSvKUqQB2lXREzLNmszwCBYQ1q8EHhWeCoi55y98f1rXNaPKV
         fJeP7qSO7VDHILoFgDa3bzawhdAHTGhigLcY1rdvrJgW1c5xXqqVt9UnXCvKEtBCMToh
         CcyeexysivXFiyqe48C97JGoMmk+Ox8DoqAxBUkg7Nz7rh3rHmVJM2w5FTdeIMfmZ+uW
         YM3Q==
X-Gm-Message-State: AOAM5322C7Ek0RqnbCeFGOK9u3MRFsIC4rtmhQOfahkl7Yr1hPtQ3uBV
        uU6uXSQG3tezDYcUB868s+BiAg==
X-Google-Smtp-Source: ABdhPJwoZkWpryzWR7dsIKNiVgyH7QJWpyZsfXnnJ9ZbU2DqMXnvZsd/FD3ptXiVEZ8Sj2Z39nC9lQ==
X-Received: by 2002:a65:6899:: with SMTP id e25mr3467908pgt.387.1613142886891;
        Fri, 12 Feb 2021 07:14:46 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id o14sm6872845pgh.48.2021.02.12.07.14.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 07:14:46 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
Subject: [PATCH v2] psi: Use ONCPU state tracking machinery to detect reclaim
Date:   Fri, 12 Feb 2021 23:14:37 +0800
Message-Id: <20210212151437.69675-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the reclaim detection from the timer tick to the task state
tracking machinery using the recently added ONCPU state. And we
also add task psi_flags changes checking in the psi_task_switch()
optimization to update the parents properly.

In terms of performance and cost, this ONCPU task state tracking
is not cheaper than previous timer tick in aggregate. But the code is
simpler and shorter this way, so it's a maintainability win. And
Johannes did some testing with perf bench, the performace and cost
changes would be acceptable for real workloads.

Thanks to Johannes Weiner for pointing out the psi_task_switch()
optimization things and the clearer changelog.

Updates since v1:
- Fold changes from Johannes that compare task psi_flags instead of
  in_memstall in the psi_task_switch() optimization and move it out
  of the loop
- Include some comments about the performance and cost from Johannes
  too, and the detailed bench results can be seen from here:
  https://lore.kernel.org/patchwork/patch/1378653/#1577607

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/psi.h  |  1 -
 kernel/sched/core.c  |  1 -
 kernel/sched/psi.c   | 65 +++++++++++++++++++---------------------------------
 kernel/sched/stats.h |  9 --------
 4 files changed, 24 insertions(+), 52 deletions(-)

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
index 2293c45d289d..0fe6ff6a6a15 100644
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
@@ -823,17 +817,21 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	void *iter;
 
 	if (next->pid) {
+		bool identical_state;
+
 		psi_flags_change(next, 0, TSK_ONCPU);
 		/*
-		 * When moving state between tasks, the group that
-		 * contains them both does not change: we can stop
-		 * updating the tree once we reach the first common
-		 * ancestor. Iterate @next's ancestors until we
-		 * encounter @prev's state.
+		 * When switching between tasks that have an identical
+		 * runtime state, the cgroup that contains both tasks
+		 * runtime state, the cgroup that contains both tasks
+		 * we reach the first common ancestor. Iterate @next's
+		 * ancestors only until we encounter @prev's ONCPU.
 		 */
+		identical_state = prev->psi_flags == next->psi_flags;
 		iter = NULL;
 		while ((group = iterate_groups(next, &iter))) {
-			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
+			if (identical_state &&
+			    per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
 				common = group;
 				break;
 			}
@@ -859,21 +857,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
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

