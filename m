Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7160F311E63
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 16:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBFPTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 10:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhBFPTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 10:19:15 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA13C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 07:18:36 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id w2so17640442ejk.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 07:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ItQHd2GrzRPCmgBgYX8DawsOHK6+fo9VfSyqkSGNNzM=;
        b=MHLehyIxXs8eGsrNM1e0DdkeHPqN/a0mz2IEjhV2OAMg6IYMndscg8mFjvdPsR9+oX
         QrYMtvSak7uGCMSiALF7qf10cGHu0cJ+2Yzuo2bBOT6g5zHPq1p4IQcOOAaLY3XXTI9e
         PBvVfR5OCSvdzzdF5jc4gMZ+wbO/3xtZ/XFD8XGtu/WPleBaHdcb8kQUC/JoFWOnyauE
         PXurlxPo7LrGlAQBQvI8EQhF7tiJvQlFFjaSHlSirWrPqzOlVYuK+pKEiU2+J2YFGqWx
         k6cSASTE8Rf8CGzQj2BUHsvywFMGa4W7zZ5Nz+xjBTVJumIyWwWo9n+oiWcaFW7tWswl
         Cd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ItQHd2GrzRPCmgBgYX8DawsOHK6+fo9VfSyqkSGNNzM=;
        b=Q+8o5NsD5SH9S5rMCx2qejeoGO0tejYPeA9uIYqqzYSXAu7k7FBWITQOa+nuxHjndP
         q3nDKRsYW/I+zr3SRwhiGlfQ89nDA3xakldR0uSD4GteyXaDre7TThMJdYIZ5GN9e1Ao
         ciox4jI1Go8dCLL8Pvo7MTNSMT+99mSCQ91yMLMtlh6gahOWjntJZZMVw/5UjcrYWCLv
         1Idqz2XZfFY5vwwKTSIXgfLsOLcAxh730D1lD62ZVx4Ro15ID+o7bTrSS2+Xyl4I+JKk
         rMN1JLcxb7r+BnBabMlP+rx8FsR/1Fea94cs0/V9GQ/Iz8NhGE/V5M/JZldSPjvHp4f8
         Pybg==
X-Gm-Message-State: AOAM533+E+E2aNWf5dTRzBYW58ah2TOChi0/xCzBtpVSoPvPKu0+O6us
        osvvZtV0Bg4JqVCcWEdvxA==
X-Google-Smtp-Source: ABdhPJz/MJdIGugdR3UCS9MUgH2Fn1UdP4DuuprSuAqhmomfIVYcK4p/Vpi3QS6+WnZk43fCq00WtQ==
X-Received: by 2002:a17:906:fc5:: with SMTP id c5mr8942271ejk.538.1612624714953;
        Sat, 06 Feb 2021 07:18:34 -0800 (PST)
Received: from localhost.localdomain ([46.53.252.141])
        by smtp.gmail.com with ESMTPSA id gz14sm5368391ejc.105.2021.02.06.07.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 07:18:34 -0800 (PST)
Date:   Sat, 6 Feb 2021 18:18:32 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] sched: make struct task_struct::state 32-bit
Message-ID: <20210206151832.GA487103@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32-bit accesses are shorter than 64-bit accesses on x86_64.
Nothing uses 64-bitness of struct task_struct::state.

Propagate 32-bitness to other variables and functions.

Silently delete "extern" from prototypes.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 block/blk-mq.c               |    2 +-
 drivers/md/dm.c              |    6 +++---
 fs/userfaultfd.c             |    4 ++--
 include/linux/sched.h        |    6 +++---
 include/linux/sched/debug.h  |    2 +-
 include/linux/sched/signal.h |    2 +-
 kernel/freezer.c             |    2 +-
 kernel/kthread.c             |    4 ++--
 kernel/locking/mutex.c       |    6 +++---
 kernel/locking/semaphore.c   |    2 +-
 kernel/rcu/rcutorture.c      |    4 ++--
 kernel/rcu/tree_stall.h      |    6 +++---
 kernel/sched/core.c          |   10 +++++-----
 lib/syscall.c                |    2 +-
 14 files changed, 29 insertions(+), 29 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3841,7 +3841,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
 	struct blk_mq_hw_ctx *hctx;
-	long state;
+	int state;
 
 	if (!blk_qc_t_valid(cookie) ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2253,7 +2253,7 @@ static bool md_in_flight_bios(struct mapped_device *md)
 	return sum != 0;
 }
 
-static int dm_wait_for_bios_completion(struct mapped_device *md, long task_state)
+static int dm_wait_for_bios_completion(struct mapped_device *md, int task_state)
 {
 	int r = 0;
 	DEFINE_WAIT(wait);
@@ -2276,7 +2276,7 @@ static int dm_wait_for_bios_completion(struct mapped_device *md, long task_state
 	return r;
 }
 
-static int dm_wait_for_completion(struct mapped_device *md, long task_state)
+static int dm_wait_for_completion(struct mapped_device *md, int task_state)
 {
 	int r = 0;
 
@@ -2403,7 +2403,7 @@ static void unlock_fs(struct mapped_device *md)
  * are being added to md->deferred list.
  */
 static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
-			unsigned suspend_flags, long task_state,
+			unsigned suspend_flags, int task_state,
 			int dmf_suspended_flag)
 {
 	bool do_lockfs = suspend_flags & DM_SUSPEND_LOCKFS_FLAG;
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -339,7 +339,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	return ret;
 }
 
-static inline long userfaultfd_get_blocking_state(unsigned int flags)
+static inline int userfaultfd_get_blocking_state(unsigned int flags)
 {
 	if (flags & FAULT_FLAG_INTERRUPTIBLE)
 		return TASK_INTERRUPTIBLE;
@@ -372,7 +372,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	struct userfaultfd_wait_queue uwq;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 	bool must_wait;
-	long blocking_state;
+	int blocking_state;
 
 	/*
 	 * We don't do userfault handling for the final child pid update.
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -655,7 +655,7 @@ struct task_struct {
 	struct thread_info		thread_info;
 #endif
 	/* -1 unrunnable, 0 runnable, >0 stopped: */
-	volatile long			state;
+	volatile int			state;
 
 	/*
 	 * This begins the randomizable portion of task_struct. Only
@@ -1806,10 +1806,10 @@ static __always_inline void scheduler_ipi(void)
 	 */
 	preempt_fold_need_resched();
 }
-extern unsigned long wait_task_inactive(struct task_struct *, long match_state);
+unsigned long wait_task_inactive(struct task_struct *, int match_state);
 #else
 static inline void scheduler_ipi(void) { }
-static inline unsigned long wait_task_inactive(struct task_struct *p, long match_state)
+static inline unsigned long wait_task_inactive(struct task_struct *p, int match_state)
 {
 	return 1;
 }
--- a/include/linux/sched/debug.h
+++ b/include/linux/sched/debug.h
@@ -14,7 +14,7 @@ extern void dump_cpu_task(int cpu);
 /*
  * Only dump TASK_* tasks. (0 for all tasks)
  */
-extern void show_state_filter(unsigned long state_filter);
+void show_state_filter(unsigned int state_filter);
 
 static inline void show_state(void)
 {
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -381,7 +381,7 @@ static inline int fatal_signal_pending(struct task_struct *p)
 	return task_sigpending(p) && __fatal_signal_pending(p);
 }
 
-static inline int signal_pending_state(long state, struct task_struct *p)
+static inline int signal_pending_state(int state, struct task_struct *p)
 {
 	if (!(state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)))
 		return 0;
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -58,7 +58,7 @@ bool __refrigerator(bool check_kthr_stop)
 	/* Hmm, should we be allowed to suspend when there are realtime
 	   processes around? */
 	bool was_frozen = false;
-	long save = current->state;
+	int save = current->state;
 
 	pr_debug("%s entered refrigerator\n", current->comm);
 
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -430,7 +430,7 @@ struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
 }
 EXPORT_SYMBOL(kthread_create_on_node);
 
-static void __kthread_bind_mask(struct task_struct *p, const struct cpumask *mask, long state)
+static void __kthread_bind_mask(struct task_struct *p, const struct cpumask *mask, int state)
 {
 	unsigned long flags;
 
@@ -446,7 +446,7 @@ static void __kthread_bind_mask(struct task_struct *p, const struct cpumask *mas
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 }
 
-static void __kthread_bind(struct task_struct *p, unsigned int cpu, long state)
+static void __kthread_bind(struct task_struct *p, unsigned int cpu, int state)
 {
 	__kthread_bind_mask(p, cpumask_of(cpu), state);
 }
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -923,7 +923,7 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
  * Lock a mutex (possibly interruptible), slowpath:
  */
 static __always_inline int __sched
-__mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
+__mutex_lock_common(struct mutex *lock, int state, unsigned int subclass,
 		    struct lockdep_map *nest_lock, unsigned long ip,
 		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
 {
@@ -1097,14 +1097,14 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 }
 
 static int __sched
-__mutex_lock(struct mutex *lock, long state, unsigned int subclass,
+__mutex_lock(struct mutex *lock, int state, unsigned int subclass,
 	     struct lockdep_map *nest_lock, unsigned long ip)
 {
 	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL, false);
 }
 
 static int __sched
-__ww_mutex_lock(struct mutex *lock, long state, unsigned int subclass,
+__ww_mutex_lock(struct mutex *lock, int state, unsigned int subclass,
 		struct lockdep_map *nest_lock, unsigned long ip,
 		struct ww_acquire_ctx *ww_ctx)
 {
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -201,7 +201,7 @@ struct semaphore_waiter {
  * constant, and thus optimised away by the compiler.  Likewise the
  * 'timeout' parameter for the cases without timeouts.
  */
-static inline int __sched __down_common(struct semaphore *sem, long state,
+static inline int __sched __down_common(struct semaphore *sem, int state,
 								long timeout)
 {
 	struct semaphore_waiter waiter;
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1600,10 +1600,10 @@ rcu_torture_stats_print(void)
 		srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp,
 					&flags, &gp_seq);
 		wtp = READ_ONCE(writer_task);
-		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#lx cpu %d\n",
+		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
 			 rcu_torture_writer_state_getname(),
 			 rcu_torture_writer_state, gp_seq, flags,
-			 wtp == NULL ? ~0UL : wtp->state,
+			 wtp == NULL ? ~0U : wtp->state,
 			 wtp == NULL ? -1 : (int)task_cpu(wtp));
 		if (!splatted && wtp) {
 			sched_show_task(wtp);
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -453,7 +453,7 @@ static void rcu_check_gp_kthread_starvation(void)
 	unsigned long j;
 
 	if (rcu_is_gp_kthread_starving(&j)) {
-		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
+		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#x ->cpu=%d\n",
 		       rcu_state.name, j,
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
 		       data_race(rcu_state.gp_flags),
@@ -679,9 +679,9 @@ void show_rcu_gp_kthreads(void)
 	ja = j - data_race(rcu_state.gp_activity);
 	jr = j - data_race(rcu_state.gp_req_activity);
 	jw = j - data_race(rcu_state.gp_wake_time);
-	pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
+	pr_info("%s: wait state: %s(%d) ->state: %#x delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
-		rcu_state.gp_state, t ? t->state : 0x1ffffL,
+		rcu_state.gp_state, t ? t->state : 0x1ffff,
 		ja, jr, jw, (long)data_race(rcu_state.gp_wake_seq),
 		(long)data_race(rcu_state.gp_seq),
 		(long)data_race(rcu_get_root()->gp_seq_needed),
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2589,7 +2589,7 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p,
  * smp_call_function() if an IPI is sent by the same process we are
  * waiting to become inactive.
  */
-unsigned long wait_task_inactive(struct task_struct *p, long match_state)
+unsigned long wait_task_inactive(struct task_struct *p, int match_state)
 {
 	int running, queued;
 	struct rq_flags rf;
@@ -4960,7 +4960,7 @@ static void __sched notrace __schedule(bool preempt)
 {
 	struct task_struct *prev, *next;
 	unsigned long *switch_count;
-	unsigned long prev_state;
+	int prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
 	int cpu;
@@ -7011,7 +7011,7 @@ void sched_show_task(struct task_struct *p)
 EXPORT_SYMBOL_GPL(sched_show_task);
 
 static inline bool
-state_filter_match(unsigned long state_filter, struct task_struct *p)
+state_filter_match(unsigned int state_filter, struct task_struct *p)
 {
 	/* no filter, everything matches */
 	if (!state_filter)
@@ -7032,7 +7032,7 @@ state_filter_match(unsigned long state_filter, struct task_struct *p)
 }
 
 
-void show_state_filter(unsigned long state_filter)
+void show_state_filter(unsigned int state_filter)
 {
 	struct task_struct *g, *p;
 
@@ -7912,7 +7912,7 @@ void __might_sleep(const char *file, int line, int preempt_offset)
 	 */
 	WARN_ONCE(current->state != TASK_RUNNING && current->task_state_change,
 			"do not call blocking ops when !TASK_RUNNING; "
-			"state=%lx set at [<%p>] %pS\n",
+			"state=%x set at [<%p>] %pS\n",
 			current->state,
 			(void *)current->task_state_change,
 			(void *)current->task_state_change);
--- a/lib/syscall.c
+++ b/lib/syscall.c
@@ -68,7 +68,7 @@ static int collect_syscall(struct task_struct *target, struct syscall_info *info
  */
 int task_current_syscall(struct task_struct *target, struct syscall_info *info)
 {
-	long state;
+	int state;
 	unsigned long ncsw;
 
 	if (target == current)
