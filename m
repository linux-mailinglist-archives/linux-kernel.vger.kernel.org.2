Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89FB305067
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbhA0EG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhA0DEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:04:22 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35B6C061353
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 18:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=fgdumxwAnCVF5cAIS0s3q9j4VaU1jzEi6kSNzEIX6Bc=; b=BDJIZIF985E18xtpmRHRzCp8nB
        JD1WN0pZJQRkNzUOLgRwOyVErGu3+aWaz03uHEHhsns35/zhk47cAWM4CsVtdxYmCZDzkTVOyMRn4
        +XnusSsWVX8TWrnzGt5W6QxBwvHcRj6XAQPGSzmEhtyEM27BFuNHBceZGSOl4Qxw5/YWk11s9kOya
        N1L+bP0FtFokpD0579Jjjq+zvmgfBtk8wT+fTCpYO2lDVs1ZE7687lUQtj910udSBxfBLPnUjgPz1
        P9btDjzSHp6C7QNmq+a7NT7+wCx3CtMDtRUeU9n8H8LcQ8XfCOY8vCaDgrE9vTPVhsG6pBVhowAzk
        ujurFB/Q==;
Received: from [2601:1c0:6280:3f0::7650] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4aey-00038Z-A7; Wed, 27 Jan 2021 02:34:21 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 RESEND] kernel: delete repeated words in comments
Date:   Tue, 26 Jan 2021 18:34:12 -0800
Message-Id: <20210127023412.26292-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop repeated words in kernel/events/.
{if, the, that, with, time}

Drop repeated words in kernel/locking/.
{it, no, the}

Drop repeated words in kernel/sched/.
{in, not}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org> # for kernel/locking/
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
v3: combine 3 small patches into one patch; rebase & resend to Andrew

 kernel/events/core.c       |    8 ++++----
 kernel/events/uprobes.c    |    2 +-
 kernel/locking/rtmutex.c   |    4 ++--
 kernel/locking/rwsem.c     |    2 +-
 kernel/locking/semaphore.c |    2 +-
 kernel/sched/fair.c        |    2 +-
 kernel/sched/membarrier.c  |    2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

--- linux-next-20210125.orig/kernel/events/core.c
+++ linux-next-20210125/kernel/events/core.c
@@ -269,7 +269,7 @@ static void event_function_call(struct p
 	if (!event->parent) {
 		/*
 		 * If this is a !child event, we must hold ctx::mutex to
-		 * stabilize the the event->ctx relation. See
+		 * stabilize the event->ctx relation. See
 		 * perf_event_ctx_lock().
 		 */
 		lockdep_assert_held(&ctx->mutex);
@@ -1303,7 +1303,7 @@ static void put_ctx(struct perf_event_co
  * life-time rules separate them. That is an exiting task cannot fork, and a
  * spawning task cannot (yet) exit.
  *
- * But remember that that these are parent<->child context relations, and
+ * But remember that these are parent<->child context relations, and
  * migration does not affect children, therefore these two orderings should not
  * interact.
  *
@@ -1442,7 +1442,7 @@ static u64 primary_event_id(struct perf_
 /*
  * Get the perf_event_context for a task and lock it.
  *
- * This has to cope with with the fact that until it is locked,
+ * This has to cope with the fact that until it is locked,
  * the context could get moved to another task.
  */
 static struct perf_event_context *
@@ -2501,7 +2501,7 @@ static void perf_set_shadow_time(struct
 	 * But this is a bit hairy.
 	 *
 	 * So instead, we have an explicit cgroup call to remain
-	 * within the time time source all along. We believe it
+	 * within the time source all along. We believe it
 	 * is cleaner and simpler to understand.
 	 */
 	if (is_cgroup_event(event))
--- linux-next-20210125.orig/kernel/events/uprobes.c
+++ linux-next-20210125/kernel/events/uprobes.c
@@ -1735,7 +1735,7 @@ void uprobe_free_utask(struct task_struc
 }
 
 /*
- * Allocate a uprobe_task object for the task if if necessary.
+ * Allocate a uprobe_task object for the task if necessary.
  * Called when the thread hits a breakpoint.
  *
  * Returns:
--- linux-next-20210125.orig/kernel/locking/rtmutex.c
+++ linux-next-20210125/kernel/locking/rtmutex.c
@@ -1438,7 +1438,7 @@ rt_mutex_fasttrylock(struct rt_mutex *lo
 }
 
 /*
- * Performs the wakeup of the the top-waiter and re-enables preemption.
+ * Performs the wakeup of the top-waiter and re-enables preemption.
  */
 void rt_mutex_postunlock(struct wake_q_head *wake_q)
 {
@@ -1833,7 +1833,7 @@ struct task_struct *rt_mutex_next_owner(
  *			been started.
  * @waiter:		the pre-initialized rt_mutex_waiter
  *
- * Wait for the the lock acquisition started on our behalf by
+ * Wait for the lock acquisition started on our behalf by
  * rt_mutex_start_proxy_lock(). Upon failure, the caller must call
  * rt_mutex_cleanup_proxy_lock().
  *
--- linux-next-20210125.orig/kernel/locking/rwsem.c
+++ linux-next-20210125/kernel/locking/rwsem.c
@@ -1048,7 +1048,7 @@ rwsem_down_write_slowpath(struct rw_sema
 
 		/*
 		 * If there were already threads queued before us and:
-		 *  1) there are no no active locks, wake the front
+		 *  1) there are no active locks, wake the front
 		 *     queued process(es) as the handoff bit might be set.
 		 *  2) there are no active writers and some readers, the lock
 		 *     must be read owned; so we try to wake any read lock
--- linux-next-20210125.orig/kernel/locking/semaphore.c
+++ linux-next-20210125/kernel/locking/semaphore.c
@@ -119,7 +119,7 @@ EXPORT_SYMBOL(down_killable);
  * @sem: the semaphore to be acquired
  *
  * Try to acquire the semaphore atomically.  Returns 0 if the semaphore has
- * been acquired successfully or 1 if it it cannot be acquired.
+ * been acquired successfully or 1 if it cannot be acquired.
  *
  * NOTE: This return value is inverted from both spin_trylock and
  * mutex_trylock!  Be careful about this when converting code.
--- linux-next-20210125.orig/kernel/sched/fair.c
+++ linux-next-20210125/kernel/sched/fair.c
@@ -5144,7 +5144,7 @@ static void do_sched_cfs_slack_timer(str
 /*
  * When a group wakes up we want to make sure that its quota is not already
  * expired/exceeded, otherwise it may be allowed to steal additional ticks of
- * runtime as update_curr() throttling can not not trigger until it's on-rq.
+ * runtime as update_curr() throttling can not trigger until it's on-rq.
  */
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
 {
--- linux-next-20210125.orig/kernel/sched/membarrier.c
+++ linux-next-20210125/kernel/sched/membarrier.c
@@ -454,7 +454,7 @@ static int sync_runqueues_membarrier_sta
 
 	/*
 	 * For each cpu runqueue, if the task's mm match @mm, ensure that all
-	 * @mm's membarrier state set bits are also set in in the runqueue's
+	 * @mm's membarrier state set bits are also set in the runqueue's
 	 * membarrier state. This ensures that a runqueue scheduling
 	 * between threads which are users of @mm has its membarrier state
 	 * updated.
