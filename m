Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6B53AE747
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFUKlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:41:32 -0400
Received: from foss.arm.com ([217.140.110.172]:60440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhFUKla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:41:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 566A9D6E;
        Mon, 21 Jun 2021 03:39:16 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1FF843F718;
        Mon, 21 Jun 2021 03:39:15 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2 1/2] sched/rt: Fix RT utilization tracking during policy change
Date:   Mon, 21 Jun 2021 11:37:51 +0100
Message-Id: <1624271872-211872-2-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624271872-211872-1-git-send-email-vincent.donnefort@arm.com>
References: <1624271872-211872-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RT keeps track of the utilization on a per-rq basis with the structure
avg_rt. This utilization is updated during task_tick_rt(),
put_prev_task_rt() and set_next_task_rt(). However, when the current
running task changes its policy, set_next_task_rt() which would usually
take care of updating the utilization when the rq starts running RT tasks,
will not see a such change, leaving the avg_rt structure outdated. When
that very same task will be dequeued later, put_prev_task_rt() will then
update the utilization, based on a wrong last_update_time, leading to a
huge spike in the RT utilization signal.

The signal would eventually recover from this issue after few ms. Even if
no RT tasks are run, avg_rt is also updated in __update_blocked_others().
But as the CPU capacity depends partly on the avg_rt, this issue has
nonetheless a significant impact on the scheduler.

Fix this issue by ensuring a load update when a running task changes
its policy to RT.

Fixes: 371bf427 ("sched/rt: Add rt_rq utilization tracking")
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a525447..3daf42a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2341,13 +2341,20 @@ void __init init_sched_rt_class(void)
 static void switched_to_rt(struct rq *rq, struct task_struct *p)
 {
 	/*
-	 * If we are already running, then there's nothing
-	 * that needs to be done. But if we are not running
-	 * we may need to preempt the current running task.
-	 * If that current running task is also an RT task
+	 * If we are running, update the avg_rt tracking, as the running time
+	 * will now on be accounted into the latter.
+	 */
+	if (task_current(rq, p)) {
+		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+		return;
+	}
+
+	/*
+	 * If we are not running we may need to preempt the current
+	 * running task. If that current running task is also an RT task
 	 * then see if we can move to another run queue.
 	 */
-	if (task_on_rq_queued(p) && rq->curr != p) {
+	if (task_on_rq_queued(p)) {
 #ifdef CONFIG_SMP
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
-- 
2.7.4

