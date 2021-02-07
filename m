Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA89131242C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 12:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhBGL5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 06:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhBGL5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 06:57:31 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545A0C061756
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 03:56:51 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id j11so6332435plt.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 03:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4mQI/KS4Z5TsmVlCwBI8zop+g8lTETXf2wTTdJoLpIY=;
        b=kdWF1Wccvss4OT10SrvQ+qgNvH9Np0hfpBq9fvK0e5LW9fumOHZOCaIVPvWIm5xcUQ
         Vo6GJmZE8K8kSRo3O3oTSTkIejL6N0dIRLwVSjQu7MxLBNai8XNtfNlL/7O467dUTjw9
         l8vqENVnepLqm7RDiXIuyzJA0Qaykd/l3POIDbGVFv73L1JudhBG04FXwPGcs0n2D6vT
         wtExRfqPgyOeHSaZgZmeQuGgEC/LiFgiRLeXoI9+mRCFGdowaTaqy0xgICAl/MTBNd57
         +42fBlfpbv2sw3oqaqLOL5FjVCF2/TP5kpKEK6OfmmOpClMu7hLSZEAKUjew83c+PRoC
         XORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4mQI/KS4Z5TsmVlCwBI8zop+g8lTETXf2wTTdJoLpIY=;
        b=DZeMiC8bzZVwPmWA32dItJNrrPSR54iTe5yfzD0ywAuMmjWYjem04VZm1CGjGc+njj
         44iP+vy9EF9x0qh0qqH7BSXLOzOhkOmOsszzY0Vglu9IleFS7qdL+ZzzRsKHO2LfrgFA
         YAtBiPaJmEujuW3CX/NsdMOEY9P+MKaywYIgc1XZdrpJBGs2Joj7eFreWm5JFFvt9AWo
         rGy43j6hAuhtzITe5o0jYsKypROKu7nXHEZ1fHXgNPZGfvqP+F2VBR3nLmOYm6QmeeWl
         B25tpGkRWF9EobCJ7ECcsh6Ec8PaJmvlHgqmNgKr9fCmCXXN9SmjV9y3xCaGzK/PtFdX
         hZtA==
X-Gm-Message-State: AOAM533nRU0hhtojbyfWxA9ZpGkoBe4bXH17cew1ZQ9GUMhHHmpdMkjT
        zc03vLbYcF44Ba62poRQ/Uo/sQ==
X-Google-Smtp-Source: ABdhPJyLNVTzLBjSMSMv5ABOFnBTwEvO6zNjKTymv3cGc25lTYEyLDeRWXgmxuUeMS9IohQdKsntMA==
X-Received: by 2002:a17:902:b485:b029:e1:916c:a4d6 with SMTP id y5-20020a170902b485b02900e1916ca4d6mr11856049plr.57.1612699010851;
        Sun, 07 Feb 2021 03:56:50 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id e23sm1465715pfd.145.2021.02.07.03.56.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Feb 2021 03:56:50 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: [PATCH] psi: Remove the redundant psi_task_tick
Date:   Sun,  7 Feb 2021 19:56:42 +0800
Message-Id: <20210207115642.75620-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhouchengming <zhouchengming@bytedance.com>

When the current task in a cgroup is in_memstall, the corresponding psi_group
is in PSI_MEM_FULL state, so we can remove the redundant psi_task_tick
from scheduler_tick to save this periodic cost.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/psi.h  |  1 -
 kernel/sched/core.c  |  1 -
 kernel/sched/psi.c   | 40 ++++------------------------------------
 kernel/sched/stats.h |  9 ---------
 4 files changed, 4 insertions(+), 47 deletions(-)

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
index 8f90be7b10d4..1fdd6f73c62b 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -225,7 +225,8 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 	case PSI_MEM_SOME:
 		return tasks[NR_MEMSTALL];
 	case PSI_MEM_FULL:
-		return tasks[NR_MEMSTALL] && !tasks[NR_RUNNING];
+		return (tasks[NR_MEMSTALL] && !tasks[NR_RUNNING]) ||
+		       (tasks[NR_ONCPU] && current->in_memstall);
 	case PSI_CPU_SOME:
 		return tasks[NR_RUNNING] > tasks[NR_ONCPU];
 	case PSI_CPU_FULL:
@@ -644,8 +645,7 @@ static void poll_timer_fn(struct timer_list *t)
 	wake_up_interruptible(&group->poll_wait);
 }
 
-static void record_times(struct psi_group_cpu *groupc, int cpu,
-			 bool memstall_tick)
+static void record_times(struct psi_group_cpu *groupc, int cpu)
 {
 	u32 delta;
 	u64 now;
@@ -664,23 +664,6 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
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
@@ -714,7 +697,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	 */
 	write_seqcount_begin(&groupc->seq);
 
-	record_times(groupc, cpu, false);
+	record_times(groupc, cpu);
 
 	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
 		if (!(m & (1 << t)))
@@ -859,21 +842,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
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

