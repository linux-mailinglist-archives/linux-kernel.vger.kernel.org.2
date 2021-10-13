Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C8342BB33
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbhJMJNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:13:38 -0400
Received: from out10.migadu.com ([46.105.121.227]:53927 "EHLO out10.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239032AbhJMJNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:13:36 -0400
Date:   Wed, 13 Oct 2021 17:12:13 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634116290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=12xyU9ESjgQ8P6VbonR/ccrgpFuMm7MqQbLXKtwlUv8=;
        b=qtZDvMMVLn/s3/TcefFjbnlmHdYUMrAZrW0gxki7PPP9sMFD7dSCrEJew2EhgenKpewq6c
        +jpFa+dqOwPvG85ffQEY5Ph4z552KEpq8mLB9qKw8CTRbJAbmwWNTK+93LyQT0fPeRcbQW
        CtnF9QOs3hJmcm+1EKqw1J7hD8XnDck=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tao Zhou <tao.zhou@linux.dev>
Subject: [PATCH] sched/fair: Minor comments modifications
Message-ID: <YWai7ejNSTo8PETc@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some minor comments modifications not completely.

Signed-off-by: Tao Zhou <tao.zhou@linux.dev>
---
 kernel/sched/fair.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f6a05d9b5443..3845263d4e17 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3355,7 +3355,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
  * differential update where we store the last value we propagated. This in
  * turn allows skipping updates if the differential is 'small'.
  *
- * Updating tg's load_avg is necessary before update_cfs_share().
+ * Updating tg's load_avg is necessary before update_cfs_group().
  */
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
@@ -3691,7 +3691,7 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
  * avg. The immediate corollary is that all (fair) tasks must be attached, see
  * post_init_entity_util_avg().
  *
- * cfs_rq->avg is used for task_h_load() and update_cfs_share() for example.
+ * cfs_rq->avg is used for task_h_load() and update_cfs_group() for example.
  *
  * Returns true if the load decayed or we removed load.
  *
@@ -4844,7 +4844,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		 * entire period. We additionally needed to make sure that any
 		 * subsequent check_cfs_rq_runtime calls agree not to throttle
 		 * us, as we may commit to do cfs put_prev+pick_next, so we ask
-		 * for 1ns of runtime rather than just check cfs_b.
+		 * for 1ms of runtime rather than just check cfs_b.
 		 */
 		dequeue = 0;
 	} else {
@@ -5267,7 +5267,10 @@ static void sync_throttle(struct task_group *tg, int cpu)
 	cfs_rq->throttled_clock_task = rq_clock_task(cpu_rq(cpu));
 }
 
-/* conditionally throttle active cfs_rq's from put_prev_entity() */
+/*
+ * conditionally throttle active cfs_rq's from put_prev_entity()
+ * and pick_task_fair()
+ */
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 {
 	if (!cfs_bandwidth_used())
@@ -5878,11 +5881,11 @@ static void record_wakee(struct task_struct *p)
  * Detect M:N waker/wakee relationships via a switching-frequency heuristic.
  *
  * A waker of many should wake a different task than the one last awakened
- * at a frequency roughly N times higher than one of its wakees.
+ * at a frequency roughly N/M times higher than one of its wakees.
  *
  * In order to determine whether we should let the load spread vs consolidating
  * to shared cache, we look for a minimum 'flip' frequency of llc_size in one
- * partner, and a factor of lls_size higher frequency in the other.
+ * partner, and a factor of llc_size higher frequency in the other.
  *
  * With both conditions met, we can be relatively sure that the relationship is
  * non-monogamous, with partner count exceeding socket size.
@@ -7160,7 +7163,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	 *
 	 * Note: this also catches the edge-case of curr being in a throttled
 	 * group (e.g. via set_curr_task), since update_curr() (in the
-	 * enqueue of curr) will have resulted in resched being set.  This
+	 * enqueue of se) will have resulted in resched being set.  This
 	 * prevents us from potentially nominating it as a false LAST_BUDDY
 	 * below.
 	 */
@@ -7212,8 +7215,8 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	/*
 	 * Only set the backward buddy when the current task is still
 	 * on the rq. This can happen when a wakeup gets interleaved
-	 * with schedule on the ->pre_schedule() or idle_balance()
-	 * point, either of which can * drop the rq lock.
+	 * with schedule on the -> put_prev_task_balance() point, which
+	 * can drop the rq lock.
 	 *
 	 * Also, during early boot the idle thread is in the fair class,
 	 * for obvious reasons its a bad idea to schedule back to it.
@@ -7483,7 +7486,7 @@ static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
  * per-CPU scheduler provides, namely provide a proportional amount of compute
  * time to each task. This is expressed in the following equation:
  *
- *   W_i,n/P_i == W_j,n/P_j for all i,j                               (1)
+ *   W_i,n/C_i == W_j,n/C_j for all i,j                               (1)
  *
  * Where W_i,n is the n-th weight average for CPU i. The instantaneous weight
  * W_i,0 is defined as:
@@ -7617,7 +7620,7 @@ enum group_type {
 	 */
 	group_misfit_task,
 	/*
-	 * SD_ASYM_PACKING only: One local CPU with higher capacity is available,
+	 * SD_ASYM_PACKING only: One local CPU with higher priority is available,
 	 * and the task should be migrated to it instead of running on the
 	 * current CPU.
 	 */
@@ -8532,7 +8535,7 @@ static inline int sg_imbalanced(struct sched_group *group)
  * available capacity for CFS tasks.
  * For the latter, we use a threshold to stabilize the state, to take into
  * account the variance of the tasks' load and to return true if the available
- * capacity in meaningful for the load balancer.
+ * capacity is meaningful for the load balancer.
  * As an example, an available capacity of 1% can appear but it doesn't make
  * any benefit for the load balance.
  */
-- 
2.32.0
