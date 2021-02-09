Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9874B31494F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 08:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBIHL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 02:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhBIHLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:11:25 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42E3C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 23:10:45 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b8so9212125plh.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 23:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xa/F5J2XbvqQXc13QF9QNc4BHiOeHqqEiOQQrM3Oap4=;
        b=xbVMRaQXjRSRMUTu3lL5rlitOuFh/G7nMkOMp0+dwYWAqsh/wQXhQlO0uEAnksmYrP
         w1rikYGAcZtLa9oHAM2V3xbZk0yuDgt7mgvXsCZOzo0B+XuUlPViAmHLj1WsK4CPYp7D
         urIf2NZTlOPCmRkSTy+O+10tVU2/wDbo9cRB67qWwXzSFHF3ZMOdm1JGxdjxYDiKEYAE
         35B5QQrVkGL173iGGgQStvrpDbX+gM+OioMzxZuFeXo1e754SNUiWzTRdjv7+wkHeACS
         zAbtcF5f8SRVV4xnQNp7gCebO9VAl5j4002uDLQrfFODmsXuMdqFzV3dzCe2F0zWS3Ml
         VrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xa/F5J2XbvqQXc13QF9QNc4BHiOeHqqEiOQQrM3Oap4=;
        b=CPgjK4yDMz/QZMjJhbmcJracQ8DvzSVDGBXaM33XgDJLzsuDb/qXz5LOdWBh57LBEU
         78Ge8ifeUHsLo11l1XVGI8m9rBq3d63/QWswKKunULtshawxcPooV/vUK8KEJdTN1b2k
         BHHkyfnOd756yN3wmmy7TByy4OUv+ywDEUuQ0QRd/ZJuKTQK+Ix/gWYLbzCBpeObw+N1
         yVApQ8y0rBOgcWVkMIokLxtkncTjFbZwALeTFxMsn6qGMDQTSceTHjigC6HyYc+aTcjz
         8ZKqpdVyQnKuuoEFfErztfUMXu3JlApRYOkB+1mRYCI2z1xI2BWlcAXubH/DLQiBKD1A
         80uw==
X-Gm-Message-State: AOAM533wuxPvFFdHERPvTz4sjpp4zqVYb5X1INj6fbuopDctOIk+/Fyr
        dNXY5RsryQN3CYmI9BUWRzw0bw==
X-Google-Smtp-Source: ABdhPJx8NsLbzwjd5jnGYZ7IkUymTX4eMAGR1bOaW8zoFyhdd02KMcCgeCoCF7mZiQRELYZVAxD9/g==
X-Received: by 2002:a17:902:26a:b029:e2:f436:15d8 with SMTP id 97-20020a170902026ab02900e2f43615d8mr1839481plc.31.1612854645252;
        Mon, 08 Feb 2021 23:10:45 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id a5sm6503633pgh.15.2021.02.08.23.10.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 23:10:44 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
Subject: [PATCH v2] psi: Remove the redundant psi_task_tick
Date:   Tue,  9 Feb 2021 15:10:33 +0800
Message-Id: <20210209071033.16989-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the current task in a cgroup is in_memstall, the corresponding groupc
on that cpu is in PSI_MEM_FULL state, so we can exploit that to remove the
redundant psi_task_tick from scheduler_tick to save this periodic cost.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/psi.h  |  1 -
 kernel/sched/core.c  |  1 -
 kernel/sched/psi.c   | 49 ++++++++++++++-----------------------------------
 kernel/sched/stats.h |  9 ---------
 4 files changed, 14 insertions(+), 46 deletions(-)

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
index 2293c45d289d..6e46d9eb279b 100644
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
@@ -859,21 +853,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
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

