Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDB23776D7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 15:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhEINzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 09:55:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59730 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhEINzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 09:55:38 -0400
Date:   Sun, 09 May 2021 13:54:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620568474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kw3QqMezHIoV1tcEyZRHQauf0e8EAkTFTOhXxNh2CCU=;
        b=3HERPfSHBsDFw0V8UaE74NRvXmzF//6viHOPb7Y4LbaLIakOUneo3yDfL9CbAAJd4Rxshb
        78Ak2DG8vxus0qOqqO/rbrJIsn1vR/RFAxwpWkAYME79kW8kl+jID+nlmJw3WeAcC6lB/v
        A/e9YQKVl+ujdV15nL34JPBiBfas3DtB1SDiocYVYtlBK4Ekfw8j3zu9xjpxnjsLLt5GYx
        Wl4xOCtLqm5MpVki1MdnquELKOnmJ+/iL4f7FCjyH8e+2bcdmMIqFdRH7nYz1570mOBdb7
        VeUDAu1ormJXbRN3qMlFGG9dApDKW8xKUXtT2MKSGs0QcGCd++GyAhCDAu8DLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620568474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kw3QqMezHIoV1tcEyZRHQauf0e8EAkTFTOhXxNh2CCU=;
        b=Vj9dAnUE1wX+UILC5XFwSXcCHXMCPLM58+bHcjF00kjXqvpa58aY+/7AH/yhdTBIcH42cp
        BLGU8GxprQ7GONDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for v5.13-rc1
Message-ID: <162056844193.15118.15395219660989373296.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-05-09

up to:  0258bdfaff5b: sched/fair: Fix unfairness caused by missing load decay


A set of scheduler updates:

 - Prevent PSI state corruption when schedule() races with cgroup move.  A
   recent commit combined two PSI callbacks to reduce the number of cgroup
   tree updates, but missed that schedule() can drop rq::lock for load
   balancing, which opens the race window for cgroup_move_task() which then
   observes half updated state. The fix is to solely use task::ps_flags
   instead of looking at the potentially mismatching scheduler state
   
 - Prevent an out-of-bounds access in uclamp caused bu a rounding division
   which can lead to an off-by-one error exceeding the buckets array size.

 - Prevent unfairness caused by missing load decay when a task is attached
   to a cfs runqueue. The old load of the task is attached to the runqueue
   and never removed. Fix it by enforcing the load update through the
   hierarchy for unthrottled run queue instances.

 - A documentation fix fot the 'sched_verbose' command line option

Thanks,

	tglx

------------------>
Barry Song (1):
      sched,doc: sched_debug_verbose cmdline should be sched_verbose

Johannes Weiner (1):
      psi: Fix psi state corruption when schedule() races with cgroup move

Odin Ugedal (1):
      sched/fair: Fix unfairness caused by missing load decay

Quentin Perret (1):
      sched: Fix out-of-bound access in uclamp


 Documentation/scheduler/sched-domains.rst |  2 +-
 kernel/sched/core.c                       |  2 +-
 kernel/sched/fair.c                       | 12 ++++++++---
 kernel/sched/psi.c                        | 36 ++++++++++++++++++++++---------
 4 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
index 14ea2f21d20e..84dcdcd2911c 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -74,7 +74,7 @@ for a given topology level by creating a sched_domain_topology_level array and
 calling set_sched_topology() with this array as the parameter.
 
 The sched-domains debugging infrastructure can be enabled by enabling
-CONFIG_SCHED_DEBUG and adding 'sched_debug_verbose' to your cmdline. If you
+CONFIG_SCHED_DEBUG and adding 'sched_verbose' to your cmdline. If you
 forgot to tweak your cmdline, you can also flip the
 /sys/kernel/debug/sched/verbose knob. This enables an error checking parse of
 the sched domains which should catch most possible errors (described above). It
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9143163fa678..5226cc26a095 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -938,7 +938,7 @@ DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
 
 static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
 {
-	return clamp_value / UCLAMP_BUCKET_DELTA;
+	return min_t(unsigned int, clamp_value / UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS - 1);
 }
 
 static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d75af1ecfb4..20aa234ffe04 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10878,16 +10878,22 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq;
 
+	list_add_leaf_cfs_rq(cfs_rq_of(se));
+
 	/* Start to propagate at parent */
 	se = se->parent;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 
-		if (cfs_rq_throttled(cfs_rq))
-			break;
+		if (!cfs_rq_throttled(cfs_rq)){
+			update_load_avg(cfs_rq, se, UPDATE_TG);
+			list_add_leaf_cfs_rq(cfs_rq);
+			continue;
+		}
 
-		update_load_avg(cfs_rq, se, UPDATE_TG);
+		if (list_add_leaf_cfs_rq(cfs_rq))
+			break;
 	}
 }
 #else
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index db27b69fa92a..cc25a3cff41f 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -972,7 +972,7 @@ void psi_cgroup_free(struct cgroup *cgroup)
  */
 void cgroup_move_task(struct task_struct *task, struct css_set *to)
 {
-	unsigned int task_flags = 0;
+	unsigned int task_flags;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -987,15 +987,31 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 
 	rq = task_rq_lock(task, &rf);
 
-	if (task_on_rq_queued(task)) {
-		task_flags = TSK_RUNNING;
-		if (task_current(rq, task))
-			task_flags |= TSK_ONCPU;
-	} else if (task->in_iowait)
-		task_flags = TSK_IOWAIT;
-
-	if (task->in_memstall)
-		task_flags |= TSK_MEMSTALL;
+	/*
+	 * We may race with schedule() dropping the rq lock between
+	 * deactivating prev and switching to next. Because the psi
+	 * updates from the deactivation are deferred to the switch
+	 * callback to save cgroup tree updates, the task's scheduling
+	 * state here is not coherent with its psi state:
+	 *
+	 * schedule()                   cgroup_move_task()
+	 *   rq_lock()
+	 *   deactivate_task()
+	 *     p->on_rq = 0
+	 *     psi_dequeue() // defers TSK_RUNNING & TSK_IOWAIT updates
+	 *   pick_next_task()
+	 *     rq_unlock()
+	 *                                rq_lock()
+	 *                                psi_task_change() // old cgroup
+	 *                                task->cgroups = to
+	 *                                psi_task_change() // new cgroup
+	 *                                rq_unlock()
+	 *     rq_lock()
+	 *   psi_sched_switch() // does deferred updates in new cgroup
+	 *
+	 * Don't rely on the scheduling state. Use psi_flags instead.
+	 */
+	task_flags = task->psi_flags;
 
 	if (task_flags)
 		psi_task_change(task, task_flags, 0);

