Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC60A394C65
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 16:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhE2OGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 10:06:21 -0400
Received: from m12-13.163.com ([220.181.12.13]:45784 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhE2OGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 10:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=lWDYOx5Ftn9wVNj+/U
        P4mRyPc2wO7EcA83OdtRxnNNw=; b=AHuVrdeiljr/KJ6X3TLazS+DvN5vYA+cQV
        JRganYiK0AAHPVbtRs9w6W6E09JS0AW19rUY0fHpRLX70QSTvmqubi37EyiiWLfc
        euStpjjmGO7lgahdku6xQA3oTfz3h4lfXH8VlGNLl5VUEIfSdZf6mLHTr/b/mdm3
        b3mr1JM6w=
Received: from localhost.localdomain (unknown [36.170.33.212])
        by smtp9 (Coremail) with SMTP id DcCowAA3DeqsRbJgsfZmDQ--.47516S2;
        Sat, 29 May 2021 21:46:21 +0800 (CST)
From:   Hailong Liu <liuhailongg6@163.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH v2 RESEND] sched/rt:fix the missing of rt_rq runtime check in rt-period timer
Date:   Sat, 29 May 2021 21:45:39 +0800
Message-Id: <20210529134539.9672-1-liuhailongg6@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DcCowAA3DeqsRbJgsfZmDQ--.47516S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFW5urW8AryfXry8uFWUXFb_yoW5AF1Upa
        sxJ347Ka1vya48Kay8A3s7WryF9393try3Xa4DK3yxJ3W5Cr1UXry5tr1IqFySgr93CF17
        Aw4Dt3yfWF4UtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jHVbkUUUUU=
X-Originating-IP: [36.170.33.212]
X-CM-SenderInfo: xolxxtxlor0wjjw6il2tof0z/1tbiyA2hYFp7CdQ0-wAAsz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hailong Liu <liu.hailong6@zte.com.cn>

The rq->rd->span of isolcpus may not be serviced by the timer, which leaves
these CPUs indefinitely throttled.

Steps to reproduce on my on my 8-CPUs machine:
1 enable  CONFIG_RT_GROUP_SCHED=y, and boot kernel with command-line
  "isolcpus=4-7"

2 create a child group and init it:
  mount -t cgroup -o cpu cpu /sys/fs/cgroup
  mkdir /sys/fs/cgroup/child0
  echo 950000 > /sys/fs/cgroup/child0/cpu.rt_runtime_us
3 run two rt-loop tasks, assume their pids are $pid1 and $pid2
4 affinity a rt task to the isolated cpu-sets
  taskset -p 0xf0 $pid2
5 add tasks created above into child cpu-group
  echo $pid1 > /sys/fs/cgroup/child0/tasks
  echo $pid2 > /sys/fs/cgroup/child0/tasks
6 check wat happened:
  "top": one of the task will fail to has cpu usage, but its stat is "R"
  "kill": the task on the problem rt_rq can't be killed

Fix it by checking all online CPUs in do_sched_rt_period_timer.

Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
---
 kernel/sched/rt.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index c286e5ba3c94..0bda43e756d7 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -579,18 +579,6 @@ static int rt_se_boosted(struct sched_rt_entity *rt_se)
 	return p->prio != p->normal_prio;
 }
 
-#ifdef CONFIG_SMP
-static inline const struct cpumask *sched_rt_period_mask(void)
-{
-	return this_rq()->rd->span;
-}
-#else
-static inline const struct cpumask *sched_rt_period_mask(void)
-{
-	return cpu_online_mask;
-}
-#endif
-
 static inline
 struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu)
 {
@@ -648,11 +636,6 @@ static inline int rt_rq_throttled(struct rt_rq *rt_rq)
 	return rt_rq->rt_throttled;
 }
 
-static inline const struct cpumask *sched_rt_period_mask(void)
-{
-	return cpu_online_mask;
-}
-
 static inline
 struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu)
 {
@@ -856,20 +839,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 	int i, idle = 1, throttled = 0;
 	const struct cpumask *span;
 
-	span = sched_rt_period_mask();
-#ifdef CONFIG_RT_GROUP_SCHED
-	/*
-	 * FIXME: isolated CPUs should really leave the root task group,
-	 * whether they are isolcpus or were isolated via cpusets, lest
-	 * the timer run on a CPU which does not service all runqueues,
-	 * potentially leaving other CPUs indefinitely throttled.  If
-	 * isolation is really required, the user will turn the throttle
-	 * off to kill the perturbations it causes anyway.  Meanwhile,
-	 * this maintains functionality for boot and/or troubleshooting.
-	 */
-	if (rt_b == &root_task_group.rt_bandwidth)
-		span = cpu_online_mask;
-#endif
+	span = cpu_online_mask;
 	for_each_cpu(i, span) {
 		int enqueue = 0;
 		struct rt_rq *rt_rq = sched_rt_period_rt_rq(rt_b, i);
-- 
2.17.1


