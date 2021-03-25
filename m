Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D887F349946
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhCYSOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhCYSNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:13:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD69C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=C8COEHm/b0TyzpvuWQoLqS5X7MSPymJX/PifR3/TxtU=; b=ENhXTZ+QLqdsA8QA+FvSB4D067
        gIjO6oAOpKLXZLDQnhkvqHoz8/SlPgOYM0xXmmEz1PWXaJ7Yz6t1e4m7anpKcDMsQ0DT0POBHgiZq
        jG5iN75+Zj75eVjpYdHClsCDQfwiJ2b09XoCZ3VfD38OS/hPbvD47RvpmQ55N9/g0Hmc2Tj5R6LR5
        ZkzTUUb7WeXHZKNBhuPi2459QXp1qIF/V0KqOBhZvbVYFkvgtBcBMfky+QRK7WQBDysUoj2s7vQ0r
        HweibzdfH4BLOJxVEsH0BlgURgAVtO6BmwSb4+D8P5h2ZEdnHVApZ06JOwxTIIrJpK/0XXQ7A4ayh
        275ZTP1A==;
Received: from [24.132.217.100] (helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPUSm-00DVHM-DV; Thu, 25 Mar 2021 18:12:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 853453003E1;
        Thu, 25 Mar 2021 19:11:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 715B420424916; Thu, 25 Mar 2021 19:11:37 +0100 (CET)
Date:   Thu, 25 Mar 2021 19:11:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH] task_struct::state frobbing
Message-ID: <YFzSWR6mAGitxMqA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hai,

First cut at changing task_struct::state to a 'sane' type.

It drops the volatile and reduces it to 'unsigned int'.

There's at least two issues vs PREEMPT (one in perf and one in KVM),
which I'll fix tomorrow, and there's a number of sites I left the
READ_ONCE() off, which I'll also audit again tomorrow.

builds x86_64-allmodconfig, but I'm sure the robots will find borkage in
other archs.

Also, be warned, there's some really 'magical' code out there.

---
 arch/x86/kernel/process.c               |  4 +-
 block/blk-mq.c                          |  6 +--
 drivers/md/dm.c                         |  6 +--
 drivers/net/ethernet/qualcomm/qca_spi.c |  6 +--
 drivers/usb/gadget/udc/max3420_udc.c    | 15 +++-----
 drivers/usb/host/max3421-hcd.c          |  3 +-
 fs/binfmt_elf.c                         |  8 ++--
 fs/io-wq.c                              | 11 +-----
 fs/userfaultfd.c                        |  4 +-
 include/linux/sched.h                   | 29 ++++++++-------
 include/linux/sched/debug.h             |  2 +-
 include/linux/sched/signal.h            |  2 +-
 init/init_task.c                        |  2 +-
 kernel/cgroup/cgroup-v1.c               |  2 +-
 kernel/debug/kdb/kdb_support.c          | 18 +++++----
 kernel/events/core.c                    |  4 +-
 kernel/fork.c                           |  4 +-
 kernel/freezer.c                        |  2 +-
 kernel/hung_task.c                      |  2 +-
 kernel/kthread.c                        |  4 +-
 kernel/locking/lockdep.c                |  2 +-
 kernel/locking/mutex.c                  |  6 +--
 kernel/locking/rtmutex.c                |  8 ++--
 kernel/locking/rwsem.c                  |  2 +-
 kernel/ptrace.c                         | 12 +++---
 kernel/rcu/rcutorture.c                 |  4 +-
 kernel/rcu/tree_plugin.h                |  2 +-
 kernel/rcu/tree_stall.h                 | 12 +++---
 kernel/sched/core.c                     | 65 +++++++++++++++++----------------
 kernel/sched/deadline.c                 | 10 ++---
 kernel/sched/fair.c                     | 11 ++++--
 kernel/sched/stats.h                    |  2 +-
 kernel/signal.c                         |  2 +-
 kernel/softirq.c                        |  5 +--
 kernel/time/timer.c                     |  2 +-
 lib/syscall.c                           |  4 +-
 mm/compaction.c                         |  2 +-
 virt/kvm/kvm_main.c                     |  3 +-
 38 files changed, 142 insertions(+), 146 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index cdfe5b4e99b3..32fc4437cf2c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -919,7 +919,7 @@ unsigned long get_wchan(struct task_struct *p)
 	unsigned long start, bottom, top, sp, fp, ip, ret = 0;
 	int count = 0;
 
-	if (p == current || p->state == TASK_RUNNING)
+	if (p == current || task_is_running(p))
 		return 0;
 
 	if (!try_get_task_stack(p))
@@ -963,7 +963,7 @@ unsigned long get_wchan(struct task_struct *p)
 			goto out;
 		}
 		fp = READ_ONCE_NOCHECK(*(unsigned long *)fp);
-	} while (count++ < 16 && p->state != TASK_RUNNING);
+	} while (count++ < 16 && !task_is_running(p));
 
 out:
 	put_task_stack(p);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4d7c1caa439..2e28e6d90ba0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3867,7 +3867,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
 	struct blk_mq_hw_ctx *hctx;
-	long state;
+	unsigned int state;
 
 	if (!blk_qc_t_valid(cookie) ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
@@ -3891,7 +3891,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 
 	hctx->poll_considered++;
 
-	state = current->state;
+	state = READ_ONCE(current->__state);
 	do {
 		int ret;
 
@@ -3907,7 +3907,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 		if (signal_pending_state(state, current))
 			__set_current_state(TASK_RUNNING);
 
-		if (current->state == TASK_RUNNING)
+		if (task_is_running(current))
 			return 1;
 		if (ret < 0 || !spin)
 			break;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 50b693d776d6..e425ef213405 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2330,7 +2330,7 @@ static bool md_in_flight_bios(struct mapped_device *md)
 	return sum != 0;
 }
 
-static int dm_wait_for_bios_completion(struct mapped_device *md, long task_state)
+static int dm_wait_for_bios_completion(struct mapped_device *md, unsigned int task_state)
 {
 	int r = 0;
 	DEFINE_WAIT(wait);
@@ -2353,7 +2353,7 @@ static int dm_wait_for_bios_completion(struct mapped_device *md, long task_state
 	return r;
 }
 
-static int dm_wait_for_completion(struct mapped_device *md, long task_state)
+static int dm_wait_for_completion(struct mapped_device *md, unsigned int task_state)
 {
 	int r = 0;
 
@@ -2480,7 +2480,7 @@ static void unlock_fs(struct mapped_device *md)
  * are being added to md->deferred list.
  */
 static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
-			unsigned suspend_flags, long task_state,
+			unsigned suspend_flags, unsigned int task_state,
 			int dmf_suspended_flag)
 {
 	bool do_lockfs = suspend_flags & DM_SUSPEND_LOCKFS_FLAG;
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 5a3b65a6eb4f..17ee771e0051 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -653,8 +653,7 @@ qcaspi_intr_handler(int irq, void *data)
 	struct qcaspi *qca = data;
 
 	qca->intr_req++;
-	if (qca->spi_thread &&
-	    qca->spi_thread->state != TASK_RUNNING)
+	if (qca->spi_thread)
 		wake_up_process(qca->spi_thread);
 
 	return IRQ_HANDLED;
@@ -777,8 +776,7 @@ qcaspi_netdev_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	netif_trans_update(dev);
 
-	if (qca->spi_thread &&
-	    qca->spi_thread->state != TASK_RUNNING)
+	if (qca->spi_thread)
 		wake_up_process(qca->spi_thread);
 
 	return NETDEV_TX_OK;
diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index 35179543c327..34f4db554977 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -509,8 +509,7 @@ static irqreturn_t max3420_vbus_handler(int irq, void *dev_id)
 			     ? USB_STATE_POWERED : USB_STATE_NOTATTACHED);
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	if (udc->thread_task &&
-	    udc->thread_task->state != TASK_RUNNING)
+	if (udc->thread_task)
 		wake_up_process(udc->thread_task);
 
 	return IRQ_HANDLED;
@@ -529,8 +528,7 @@ static irqreturn_t max3420_irq_handler(int irq, void *dev_id)
 	}
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	if (udc->thread_task &&
-	    udc->thread_task->state != TASK_RUNNING)
+	if (udc->thread_task)
 		wake_up_process(udc->thread_task);
 
 	return IRQ_HANDLED;
@@ -1093,8 +1091,7 @@ static int max3420_wakeup(struct usb_gadget *gadget)
 
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	if (udc->thread_task &&
-	    udc->thread_task->state != TASK_RUNNING)
+	if (udc->thread_task)
 		wake_up_process(udc->thread_task);
 	return ret;
 }
@@ -1117,8 +1114,7 @@ static int max3420_udc_start(struct usb_gadget *gadget,
 	udc->todo |= UDC_START;
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	if (udc->thread_task &&
-	    udc->thread_task->state != TASK_RUNNING)
+	if (udc->thread_task)
 		wake_up_process(udc->thread_task);
 
 	return 0;
@@ -1137,8 +1133,7 @@ static int max3420_udc_stop(struct usb_gadget *gadget)
 	udc->todo |= UDC_START;
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	if (udc->thread_task &&
-	    udc->thread_task->state != TASK_RUNNING)
+	if (udc->thread_task)
 		wake_up_process(udc->thread_task);
 
 	return 0;
diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index afd9174d83b1..e7a8e0609853 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1169,8 +1169,7 @@ max3421_irq_handler(int irq, void *dev_id)
 	struct spi_device *spi = to_spi_device(hcd->self.controller);
 	struct max3421_hcd *max3421_hcd = hcd_to_max3421(hcd);
 
-	if (max3421_hcd->spi_thread &&
-	    max3421_hcd->spi_thread->state != TASK_RUNNING)
+	if (max3421_hcd->spi_thread)
 		wake_up_process(max3421_hcd->spi_thread);
 	if (!test_and_set_bit(ENABLE_IRQ, &max3421_hcd->todo))
 		disable_irq_nosync(spi->irq);
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index b12ba98ae9f5..d1531afa555e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1537,7 +1537,8 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 {
 	const struct cred *cred;
 	unsigned int i, len;
-	
+	unsigned int state;
+
 	/* first copy the parameters from user space */
 	memset(psinfo, 0, sizeof(struct elf_prpsinfo));
 
@@ -1559,7 +1560,8 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 	psinfo->pr_pgrp = task_pgrp_vnr(p);
 	psinfo->pr_sid = task_session_vnr(p);
 
-	i = p->state ? ffz(~p->state) + 1 : 0;
+	state = READ_ONCE(p->__state);
+	i = state ? ffz(~state) + 1 : 0;
 	psinfo->pr_state = i;
 	psinfo->pr_sname = (i > 5) ? '.' : "RSDTZW"[i];
 	psinfo->pr_zomb = psinfo->pr_sname == 'Z';
@@ -1571,7 +1573,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 	SET_GID(psinfo->pr_gid, from_kgid_munged(cred->user_ns, cred->gid));
 	rcu_read_unlock();
 	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
-	
+
 	return 0;
 }
 
diff --git a/fs/io-wq.c b/fs/io-wq.c
index 3dc10bfd8c3b..4f98816be523 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -18,7 +18,6 @@
 #include <linux/tracehook.h>
 #include <linux/freezer.h>
 
-#include "../kernel/sched/sched.h"
 #include "io-wq.h"
 
 #define WORKER_IDLE_TIMEOUT	(5 * HZ)
@@ -1088,14 +1087,8 @@ void io_wq_put_and_exit(struct io_wq *wq)
 
 static bool io_wq_worker_affinity(struct io_worker *worker, void *data)
 {
-	struct task_struct *task = worker->task;
-	struct rq_flags rf;
-	struct rq *rq;
-
-	rq = task_rq_lock(task, &rf);
-	do_set_cpus_allowed(task, cpumask_of_node(worker->wqe->node));
-	task->flags |= PF_NO_SETAFFINITY;
-	task_rq_unlock(rq, task, &rf);
+	set_cpus_allowed_ptr(worker->task, cpumask_of_node(worker->wqe->node));
+
 	return false;
 }
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0be8cdd4425a..5f0643fc59f7 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -339,7 +339,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	return ret;
 }
 
-static inline long userfaultfd_get_blocking_state(unsigned int flags)
+static inline unsigned int userfaultfd_get_blocking_state(unsigned int flags)
 {
 	if (flags & FAULT_FLAG_INTERRUPTIBLE)
 		return TASK_INTERRUPTIBLE;
@@ -372,7 +372,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	struct userfaultfd_wait_queue uwq;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 	bool must_wait;
-	long blocking_state;
+	unsigned int blocking_state;
 
 	/*
 	 * We don't do userfault handling for the final child pid update.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0c56cc99e3da..225bb2008028 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -112,11 +112,13 @@ struct task_group;
 					 __TASK_TRACED | EXIT_DEAD | EXIT_ZOMBIE | \
 					 TASK_PARKED)
 
-#define task_is_traced(task)		((task->state & __TASK_TRACED) != 0)
+#define task_is_running(task)		(READ_ONCE((task)->__state) == TASK_RUNNING)
 
-#define task_is_stopped(task)		((task->state & __TASK_STOPPED) != 0)
+#define task_is_traced(task)		((task->__state & __TASK_TRACED) != 0)
 
-#define task_is_stopped_or_traced(task)	((task->state & (__TASK_STOPPED | __TASK_TRACED)) != 0)
+#define task_is_stopped(task)		((task->__state & __TASK_STOPPED) != 0)
+
+#define task_is_stopped_or_traced(task)	((task->__state & (__TASK_STOPPED | __TASK_TRACED)) != 0)
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 
@@ -131,14 +133,14 @@ struct task_group;
 	do {							\
 		WARN_ON_ONCE(is_special_task_state(state_value));\
 		current->task_state_change = _THIS_IP_;		\
-		current->state = (state_value);			\
+		WRITE_ONCE(current->__state, (state_value));	\
 	} while (0)
 
 #define set_current_state(state_value)				\
 	do {							\
 		WARN_ON_ONCE(is_special_task_state(state_value));\
 		current->task_state_change = _THIS_IP_;		\
-		smp_store_mb(current->state, (state_value));	\
+		smp_store_mb(current->__state, (state_value));	\
 	} while (0)
 
 #define set_special_state(state_value)					\
@@ -147,7 +149,7 @@ struct task_group;
 		WARN_ON_ONCE(!is_special_task_state(state_value));	\
 		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
 		current->task_state_change = _THIS_IP_;			\
-		current->state = (state_value);				\
+		WRITE_ONCE(current->__state, (state_value));		\
 		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0)
 #else
@@ -189,10 +191,10 @@ struct task_group;
  * Also see the comments of try_to_wake_up().
  */
 #define __set_current_state(state_value)				\
-	current->state = (state_value)
+	WRITE_ONCE(current->__state, (state_value))
 
 #define set_current_state(state_value)					\
-	smp_store_mb(current->state, (state_value))
+	smp_store_mb(current->__state, (state_value))
 
 /*
  * set_special_state() should be used for those states when the blocking task
@@ -204,7 +206,7 @@ struct task_group;
 	do {								\
 		unsigned long flags; /* may shadow */			\
 		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
-		current->state = (state_value);				\
+		WRITE_ONCE(current->__state, (state_value));		\
 		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0)
 
@@ -653,8 +655,7 @@ struct task_struct {
 	 */
 	struct thread_info		thread_info;
 #endif
-	/* -1 unrunnable, 0 runnable, >0 stopped: */
-	volatile long			state;
+	unsigned int			__state;
 
 	/*
 	 * This begins the randomizable portion of task_struct. Only
@@ -1503,7 +1504,7 @@ static inline pid_t task_pgrp_nr(struct task_struct *tsk)
 
 static inline unsigned int task_state_index(struct task_struct *tsk)
 {
-	unsigned int tsk_state = READ_ONCE(tsk->state);
+	unsigned int tsk_state = READ_ONCE(tsk->__state);
 	unsigned int state = (tsk_state | tsk->exit_state) & TASK_REPORT;
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(TASK_REPORT_MAX);
@@ -1811,10 +1812,10 @@ static __always_inline void scheduler_ipi(void)
 	 */
 	preempt_fold_need_resched();
 }
-extern unsigned long wait_task_inactive(struct task_struct *, long match_state);
+extern unsigned long wait_task_inactive(struct task_struct *, unsigned int match_state);
 #else
 static inline void scheduler_ipi(void) { }
-static inline unsigned long wait_task_inactive(struct task_struct *p, long match_state)
+static inline unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state)
 {
 	return 1;
 }
diff --git a/include/linux/sched/debug.h b/include/linux/sched/debug.h
index ae51f4529fc9..b5035afa2396 100644
--- a/include/linux/sched/debug.h
+++ b/include/linux/sched/debug.h
@@ -14,7 +14,7 @@ extern void dump_cpu_task(int cpu);
 /*
  * Only dump TASK_* tasks. (0 for all tasks)
  */
-extern void show_state_filter(unsigned long state_filter);
+extern void show_state_filter(unsigned int state_filter);
 
 static inline void show_state(void)
 {
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3f6a0fcaa10c..ea21a0e9cfcf 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -381,7 +381,7 @@ static inline int fatal_signal_pending(struct task_struct *p)
 	return task_sigpending(p) && __fatal_signal_pending(p);
 }
 
-static inline int signal_pending_state(long state, struct task_struct *p)
+static inline int signal_pending_state(unsigned int state, struct task_struct *p)
 {
 	if (!(state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)))
 		return 0;
diff --git a/init/init_task.c b/init/init_task.c
index 3711cdaafed2..c459857afe6b 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -71,7 +71,7 @@ struct task_struct init_task
 	.thread_info	= INIT_THREAD_INFO(init_task),
 	.stack_refcount	= REFCOUNT_INIT(1),
 #endif
-	.state		= 0,
+	.__state	= 0,
 	.stack		= init_stack,
 	.usage		= REFCOUNT_INIT(2),
 	.flags		= PF_KTHREAD,
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index a5751784ad74..dc9f41ac7d2e 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -713,7 +713,7 @@ int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry)
 
 	css_task_iter_start(&cgrp->self, 0, &it);
 	while ((tsk = css_task_iter_next(&it))) {
-		switch (tsk->state) {
+		switch (READ_ONCE(tsk->__state)) {
 		case TASK_RUNNING:
 			stats->nr_running++;
 			break;
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index f7c1885abeb6..f8eee874d95c 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -609,23 +609,25 @@ unsigned long kdb_task_state_string(const char *s)
  */
 char kdb_task_state_char (const struct task_struct *p)
 {
-	int cpu;
-	char state;
+	unsigned int p_state;
 	unsigned long tmp;
+	char state;
+	int cpu;
 
 	if (!p ||
 	    copy_from_kernel_nofault(&tmp, (char *)p, sizeof(unsigned long)))
 		return 'E';
 
 	cpu = kdb_process_cpu(p);
-	state = (p->state == 0) ? 'R' :
-		(p->state < 0) ? 'U' :
-		(p->state & TASK_UNINTERRUPTIBLE) ? 'D' :
-		(p->state & TASK_STOPPED) ? 'T' :
-		(p->state & TASK_TRACED) ? 'C' :
+	p_state = READ_ONCE(p->__state);
+	state = (p_state == 0) ? 'R' :
+		(p_state < 0) ? 'U' :
+		(p_state & TASK_UNINTERRUPTIBLE) ? 'D' :
+		(p_state & TASK_STOPPED) ? 'T' :
+		(p_state & TASK_TRACED) ? 'C' :
 		(p->exit_state & EXIT_ZOMBIE) ? 'Z' :
 		(p->exit_state & EXIT_DEAD) ? 'E' :
-		(p->state & TASK_INTERRUPTIBLE) ? 'S' : '?';
+		(p_state & TASK_INTERRUPTIBLE) ? 'S' : '?';
 	if (is_idle_task(p)) {
 		/* Idle task.  Is it really idle, apart from the kdb
 		 * interrupt? */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f07943183041..918fbe704852 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8568,9 +8568,11 @@ static void perf_event_switch(struct task_struct *task,
 		},
 	};
 
-	if (!sched_in && task->state == TASK_RUNNING)
+	/* XXX not actually correct vs preemption */
+	if (!sched_in && task_is_running(task)) {
 		switch_event.event_id.header.misc |=
 				PERF_RECORD_MISC_SWITCH_OUT_PREEMPT;
+	}
 
 	perf_iterate_sb(perf_event_switch_output,
 		       &switch_event,
diff --git a/kernel/fork.c b/kernel/fork.c
index 54cc905e5fe0..b27f7dc69263 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -421,7 +421,7 @@ static int memcg_charge_kernel_stack(struct task_struct *tsk)
 
 static void release_task_stack(struct task_struct *tsk)
 {
-	if (WARN_ON(tsk->state != TASK_DEAD))
+	if (WARN_ON(READ_ONCE(tsk->__state) != TASK_DEAD))
 		return;  /* Better to leak the stack than to free prematurely */
 
 	account_kernel_stack(tsk, -1);
@@ -2379,7 +2379,7 @@ static __latent_entropy struct task_struct *copy_process(
 	atomic_dec(&p->cred->user->processes);
 	exit_creds(p);
 bad_fork_free:
-	p->state = TASK_DEAD;
+	WRITE_ONCE(p->__state, TASK_DEAD);
 	put_task_stack(p);
 	delayed_free_task(p);
 fork_out:
diff --git a/kernel/freezer.c b/kernel/freezer.c
index 1a2d57d1327c..f62ce2f904d3 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -58,7 +58,7 @@ bool __refrigerator(bool check_kthr_stop)
 	/* Hmm, should we be allowed to suspend when there are realtime
 	   processes around? */
 	bool was_frozen = false;
-	long save = current->state;
+	unsigned int save = READ_ONCE(current->__state);
 
 	pr_debug("%s entered refrigerator\n", current->comm);
 
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 396ebaebea3f..b0ce8b3f3822 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -196,7 +196,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 			last_break = jiffies;
 		}
 		/* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
-		if (t->state == TASK_UNINTERRUPTIBLE)
+		if (READ_ONCE(t->__state) == TASK_UNINTERRUPTIBLE)
 			check_hung_task(t, timeout);
 	}
  unlock:
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1578973c5740..ece9a397fbdc 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -430,7 +430,7 @@ struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
 }
 EXPORT_SYMBOL(kthread_create_on_node);
 
-static void __kthread_bind_mask(struct task_struct *p, const struct cpumask *mask, long state)
+static void __kthread_bind_mask(struct task_struct *p, const struct cpumask *mask, unsigned int state)
 {
 	unsigned long flags;
 
@@ -446,7 +446,7 @@ static void __kthread_bind_mask(struct task_struct *p, const struct cpumask *mas
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 }
 
-static void __kthread_bind(struct task_struct *p, unsigned int cpu, long state)
+static void __kthread_bind(struct task_struct *p, unsigned int cpu, unsigned int state)
 {
 	__kthread_bind_mask(p, cpumask_of(cpu), state);
 }
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 99030e3e5563..7306539a5ad6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -760,7 +760,7 @@ static void lockdep_print_held_locks(struct task_struct *p)
 	 * It's not reliable to print a task's held locks if it's not sleeping
 	 * and it's not the current task.
 	 */
-	if (p->state == TASK_RUNNING && p != current)
+	if (p != current && task_is_running(p))
 		return;
 	for (i = 0; i < depth; i++) {
 		printk(" #%d: ", i);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cb6b112ce155..6f05b7652aa9 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -913,7 +913,7 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
  * Lock a mutex (possibly interruptible), slowpath:
  */
 static __always_inline int __sched
-__mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
+__mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclass,
 		    struct lockdep_map *nest_lock, unsigned long ip,
 		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
 {
@@ -1090,14 +1090,14 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 }
 
 static int __sched
-__mutex_lock(struct mutex *lock, long state, unsigned int subclass,
+__mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
 	     struct lockdep_map *nest_lock, unsigned long ip)
 {
 	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL, false);
 }
 
 static int __sched
-__ww_mutex_lock(struct mutex *lock, long state, unsigned int subclass,
+__ww_mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
 		struct lockdep_map *nest_lock, unsigned long ip,
 		struct ww_acquire_ctx *ww_ctx)
 {
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index db31bce114f8..28e64ec2afc1 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1144,7 +1144,7 @@ void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
  * Must be called with lock->wait_lock held and interrupts disabled
  */
 static int __sched
-__rt_mutex_slowlock(struct rt_mutex *lock, int state,
+__rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state,
 		    struct hrtimer_sleeper *timeout,
 		    struct rt_mutex_waiter *waiter)
 {
@@ -1207,7 +1207,7 @@ static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
  * Slow path lock function:
  */
 static int __sched
-rt_mutex_slowlock(struct rt_mutex *lock, int state,
+rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state,
 		  struct hrtimer_sleeper *timeout,
 		  enum rtmutex_chainwalk chwalk)
 {
@@ -1384,7 +1384,7 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
  */
 static inline int
 rt_mutex_fastlock(struct rt_mutex *lock, int state,
-		  int (*slowfn)(struct rt_mutex *lock, int state,
+		  int (*slowfn)(struct rt_mutex *lock, unsigned int state,
 				struct hrtimer_sleeper *timeout,
 				enum rtmutex_chainwalk chwalk))
 {
@@ -1398,7 +1398,7 @@ static inline int
 rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 			struct hrtimer_sleeper *timeout,
 			enum rtmutex_chainwalk chwalk,
-			int (*slowfn)(struct rt_mutex *lock, int state,
+			int (*slowfn)(struct rt_mutex *lock, unsigned int state,
 				      struct hrtimer_sleeper *timeout,
 				      enum rtmutex_chainwalk chwalk))
 {
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 809b0016d344..16bfbb10c74d 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -889,7 +889,7 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
  * Wait for the read lock to be granted
  */
 static struct rw_semaphore __sched *
-rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, int state)
+rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int state)
 {
 	long adjustment = -RWSEM_READER_BIAS;
 	long rcnt = (count >> RWSEM_READER_SHIFT);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index c71270a1677c..c532217ad0ba 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -181,7 +181,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !__fatal_signal_pending(task)) {
-		task->state = __TASK_TRACED;
+		WRITE_ONCE(task->__state, __TASK_TRACED);
 		ret = true;
 	}
 	spin_unlock_irq(&task->sighand->siglock);
@@ -191,7 +191,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (task->state != __TASK_TRACED)
+	if (READ_ONCE(task->__state) != __TASK_TRACED)
 		return;
 
 	WARN_ON(!task->ptrace || task->parent != current);
@@ -201,11 +201,11 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	 * Recheck state under the lock to close this race.
 	 */
 	spin_lock_irq(&task->sighand->siglock);
-	if (task->state == __TASK_TRACED) {
+	if (READ_ONCE(task->__state) == __TASK_TRACED) {
 		if (__fatal_signal_pending(task))
 			wake_up_state(task, __TASK_TRACED);
 		else
-			task->state = TASK_TRACED;
+			WRITE_ONCE(task->__state, TASK_TRACED);
 	}
 	spin_unlock_irq(&task->sighand->siglock);
 }
@@ -240,7 +240,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 	 */
 	read_lock(&tasklist_lock);
 	if (child->ptrace && child->parent == current) {
-		WARN_ON(child->state == __TASK_TRACED);
+		WARN_ON(task_is_traced(child));
 		/*
 		 * child->sighand can't be NULL, release_task()
 		 * does ptrace_unlink() before __exit_signal().
@@ -257,7 +257,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 			 * ptrace_stop() changes ->state back to TASK_RUNNING,
 			 * so we should not worry about leaking __TASK_TRACED.
 			 */
-			WARN_ON(child->state == __TASK_TRACED);
+			WARN_ON(task_is_traced(child));
 			ret = -ESRCH;
 		}
 	}
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 99657ffa6688..91217effff73 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1831,10 +1831,10 @@ rcu_torture_stats_print(void)
 		srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp,
 					&flags, &gp_seq);
 		wtp = READ_ONCE(writer_task);
-		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#lx cpu %d\n",
+		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
 			 rcu_torture_writer_state_getname(),
 			 rcu_torture_writer_state, gp_seq, flags,
-			 wtp == NULL ? ~0UL : wtp->state,
+			 wtp == NULL ? ~0U : wtp->__state,
 			 wtp == NULL ? -1 : (int)task_cpu(wtp));
 		if (!splatted && wtp) {
 			sched_show_task(wtp);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2d603771c7dc..99492425bd9e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2688,7 +2688,7 @@ EXPORT_SYMBOL_GPL(rcu_bind_current_to_nocb);
 #ifdef CONFIG_SMP
 static char *show_rcu_should_be_on_cpu(struct task_struct *tsp)
 {
-	return tsp && tsp->state == TASK_RUNNING && !tsp->on_cpu ? "!" : "";
+	return tsp && task_is_running(tsp) && !tsp->on_cpu ? "!" : "";
 }
 #else // #ifdef CONFIG_SMP
 static char *show_rcu_should_be_on_cpu(struct task_struct *tsp)
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 475b26171b20..5cf5252ef5e3 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -460,12 +460,12 @@ static void rcu_check_gp_kthread_starvation(void)
 
 	if (rcu_is_gp_kthread_starving(&j)) {
 		cpu = gpk ? task_cpu(gpk) : -1;
-		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
+		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#x ->cpu=%d\n",
 		       rcu_state.name, j,
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
 		       data_race(rcu_state.gp_flags),
 		       gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
-		       gpk ? gpk->state : ~0, cpu);
+		       gpk ? gpk->__state : ~0, cpu);
 		if (gpk) {
 			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
 			pr_err("RCU grace-period kthread stack dump:\n");
@@ -503,12 +503,12 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
 	    time_after(jiffies, jiffies_fqs + RCU_STALL_MIGHT_MIN) &&
 	    gpk && !READ_ONCE(gpk->on_rq)) {
 		cpu = task_cpu(gpk);
-		pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx\n",
+		pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%ld f%#x %s(%d) ->state=%#x\n",
 		       rcu_state.name, (jiffies - jiffies_fqs),
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
 		       data_race(rcu_state.gp_flags),
 		       gp_state_getname(RCU_GP_WAIT_FQS), RCU_GP_WAIT_FQS,
-		       gpk->state);
+		       gpk->__state);
 		pr_err("\tPossible timer handling issue on cpu=%d timer-softirq=%u\n",
 		       cpu, kstat_softirqs_cpu(TIMER_SOFTIRQ, cpu));
 	}
@@ -733,9 +733,9 @@ void show_rcu_gp_kthreads(void)
 	ja = j - data_race(rcu_state.gp_activity);
 	jr = j - data_race(rcu_state.gp_req_activity);
 	jw = j - data_race(rcu_state.gp_wake_time);
-	pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
+	pr_info("%s: wait state: %s(%d) ->state: %#x delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
-		rcu_state.gp_state, t ? t->state : 0x1ffffL,
+		rcu_state.gp_state, t ? t->__state : 0x1ffff,
 		ja, jr, jw, (long)data_race(rcu_state.gp_wake_seq),
 		(long)data_race(rcu_state.gp_seq),
 		(long)data_race(rcu_get_root()->gp_seq_needed),
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3384ea74cad4..fc395979191f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2267,7 +2267,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		return -EINVAL;
 	}
 
-	if (task_running(rq, p) || p->state == TASK_WAKING) {
+	if (task_running(rq, p) || READ_ONCE(p->__state) == TASK_WAKING) {
 		/*
 		 * MIGRATE_ENABLE gets here because 'p == current', but for
 		 * anything else we cannot do is_migration_disabled(), punt
@@ -2414,15 +2414,14 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	 * We should never call set_task_cpu() on a blocked task,
 	 * ttwu() will sort out the placement.
 	 */
-	WARN_ON_ONCE(p->state != TASK_RUNNING && p->state != TASK_WAKING &&
-			!p->on_rq);
+	WARN_ON_ONCE(p->__state != TASK_RUNNING && p->__state != TASK_WAKING && !p->on_rq);
 
 	/*
 	 * Migrating fair class task must have p->on_rq = TASK_ON_RQ_MIGRATING,
 	 * because schedstat_wait_{start,end} rebase migrating task's wait_start
 	 * time relying on p->on_rq.
 	 */
-	WARN_ON_ONCE(p->state == TASK_RUNNING &&
+	WARN_ON_ONCE(p->__state == TASK_RUNNING &&
 		     p->sched_class == &fair_sched_class &&
 		     (p->on_rq && !task_on_rq_migrating(p)));
 
@@ -2594,7 +2593,7 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p,
  * smp_call_function() if an IPI is sent by the same process we are
  * waiting to become inactive.
  */
-unsigned long wait_task_inactive(struct task_struct *p, long match_state)
+unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state)
 {
 	int running, queued;
 	struct rq_flags rf;
@@ -2622,7 +2621,7 @@ unsigned long wait_task_inactive(struct task_struct *p, long match_state)
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
-			if (match_state && unlikely(p->state != match_state))
+			if (match_state && unlikely(p->__state != match_state))
 				return 0;
 			cpu_relax();
 		}
@@ -2637,7 +2636,7 @@ unsigned long wait_task_inactive(struct task_struct *p, long match_state)
 		running = task_running(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if (!match_state || p->state == match_state)
+		if (!match_state || p->__state == match_state)
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &rf);
 
@@ -2946,7 +2945,7 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 			   struct rq_flags *rf)
 {
 	check_preempt_curr(rq, p, wake_flags);
-	p->state = TASK_RUNNING;
+	WRITE_ONCE(p->__state, TASK_RUNNING);
 	trace_sched_wakeup(p);
 
 #ifdef CONFIG_SMP
@@ -3335,12 +3334,12 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		 *  - we're serialized against set_special_state() by virtue of
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
-		if (!(p->state & state))
+		if (!(READ_ONCE(p->__state) & state))
 			goto out;
 
 		success = 1;
 		trace_sched_waking(p);
-		p->state = TASK_RUNNING;
+		WRITE_ONCE(p->__state, TASK_RUNNING);
 		trace_sched_wakeup(p);
 		goto out;
 	}
@@ -3353,7 +3352,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 */
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 	smp_mb__after_spinlock();
-	if (!(p->state & state))
+	if (!(p->__state & state))
 		goto unlock;
 
 	trace_sched_waking(p);
@@ -3419,7 +3418,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * TASK_WAKING such that we can unlock p->pi_lock before doing the
 	 * enqueue, such as ttwu_queue_wakelist().
 	 */
-	p->state = TASK_WAKING;
+	WRITE_ONCE(p->__state, TASK_WAKING);
 
 	/*
 	 * If the owning (remote) CPU is still in the middle of schedule() with
@@ -3512,7 +3511,7 @@ bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct t
 			ret = func(p, arg);
 		rq_unlock(rq, &rf);
 	} else {
-		switch (p->state) {
+		switch (p->__state) {
 		case TASK_RUNNING:
 		case TASK_WAKING:
 			break;
@@ -3725,7 +3724,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	 * nobody will actually run it, and a signal or other external
 	 * event cannot wake it up and insert it on the runqueue either.
 	 */
-	p->state = TASK_NEW;
+	p->__state = TASK_NEW;
 
 	/*
 	 * Make sure we do not leak PI boosting priority to the child.
@@ -3831,7 +3830,7 @@ void wake_up_new_task(struct task_struct *p)
 	struct rq *rq;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
-	p->state = TASK_RUNNING;
+	WRITE_ONCE(p->__state, TASK_RUNNING);
 #ifdef CONFIG_SMP
 	/*
 	 * Fork balancing, do it here and not earlier because:
@@ -4193,7 +4192,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 * running on another CPU and we could rave with its RUNNING -> DEAD
 	 * transition, resulting in a double drop.
 	 */
-	prev_state = prev->state;
+	prev_state = READ_ONCE(prev->__state);
 	vtime_task_switch(prev);
 	perf_event_task_sched_in(prev, current);
 	finish_task(prev);
@@ -4832,7 +4831,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 #endif
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-	if (!preempt && prev->state && prev->non_block_count) {
+	if (!preempt && prev->__state && prev->non_block_count) {
 		printk(KERN_ERR "BUG: scheduling in a non-blocking section: %s/%d/%i\n",
 			prev->comm, prev->pid, prev->non_block_count);
 		dump_stack();
@@ -5009,10 +5008,10 @@ static void __sched notrace __schedule(bool preempt)
 	 *  - we form a control dependency vs deactivate_task() below.
 	 *  - ptrace_{,un}freeze_traced() can change ->state underneath us.
 	 */
-	prev_state = prev->state;
+	prev_state = READ_ONCE(prev->__state);
 	if (!preempt && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
-			prev->state = TASK_RUNNING;
+			WRITE_ONCE(prev->__state, TASK_RUNNING);
 		} else {
 			prev->sched_contributes_to_load =
 				(prev_state & TASK_UNINTERRUPTIBLE) &&
@@ -5106,7 +5105,7 @@ static inline void sched_submit_work(struct task_struct *tsk)
 {
 	unsigned int task_flags;
 
-	if (!tsk->state)
+	if (!tsk->__state)
 		return;
 
 	task_flags = tsk->flags;
@@ -5181,7 +5180,7 @@ void __sched schedule_idle(void)
 	 * current task can be in any other state. Note, idle is always in the
 	 * TASK_RUNNING state.
 	 */
-	WARN_ON_ONCE(current->state);
+	WARN_ON_ONCE(current->__state);
 	do {
 		__schedule(false);
 	} while (need_resched());
@@ -7149,7 +7148,7 @@ int __sched yield_to(struct task_struct *p, bool preempt)
 	if (curr->sched_class != p->sched_class)
 		goto out_unlock;
 
-	if (task_running(p_rq, p) || p->state)
+	if (task_running(p_rq, p) || p->__state)
 		goto out_unlock;
 
 	yielded = curr->sched_class->yield_to_task(rq, p);
@@ -7352,7 +7351,7 @@ void sched_show_task(struct task_struct *p)
 
 	pr_info("task:%-15.15s state:%c", p->comm, task_state_to_char(p));
 
-	if (p->state == TASK_RUNNING)
+	if (READ_ONCE(p->__state) == TASK_RUNNING)
 		pr_cont("  running task    ");
 #ifdef CONFIG_DEBUG_STACK_USAGE
 	free = stack_not_used(p);
@@ -7374,28 +7373,30 @@ void sched_show_task(struct task_struct *p)
 EXPORT_SYMBOL_GPL(sched_show_task);
 
 static inline bool
-state_filter_match(unsigned long state_filter, struct task_struct *p)
+state_filter_match(unsigned int state_filter, struct task_struct *p)
 {
+	unsigned int state = READ_ONCE(p->__state);
+
 	/* no filter, everything matches */
 	if (!state_filter)
 		return true;
 
 	/* filter, but doesn't match */
-	if (!(p->state & state_filter))
+	if (!(state & state_filter))
 		return false;
 
 	/*
 	 * When looking for TASK_UNINTERRUPTIBLE skip TASK_IDLE (allows
 	 * TASK_KILLABLE).
 	 */
-	if (state_filter == TASK_UNINTERRUPTIBLE && p->state == TASK_IDLE)
+	if (state_filter == TASK_UNINTERRUPTIBLE && state == TASK_IDLE)
 		return false;
 
 	return true;
 }
 
 
-void show_state_filter(unsigned long state_filter)
+void show_state_filter(unsigned int state_filter)
 {
 	struct task_struct *g, *p;
 
@@ -7444,7 +7445,7 @@ void init_idle(struct task_struct *idle, int cpu)
 	raw_spin_lock_irqsave(&idle->pi_lock, flags);
 	raw_spin_lock(&rq->lock);
 
-	idle->state = TASK_RUNNING;
+	idle->__state = TASK_RUNNING;
 	idle->se.exec_start = sched_clock();
 	idle->flags |= PF_IDLE;
 
@@ -8273,15 +8274,15 @@ static inline int preempt_count_equals(int preempt_offset)
 
 void __might_sleep(const char *file, int line, int preempt_offset)
 {
+	unsigned int state = READ_ONCE(current->__state);
 	/*
 	 * Blocking primitives will set (and therefore destroy) current->state,
 	 * since we will exit with TASK_RUNNING make sure we enter with it,
 	 * otherwise we will destroy state.
 	 */
-	WARN_ONCE(current->state != TASK_RUNNING && current->task_state_change,
+	WARN_ONCE(state != TASK_RUNNING && current->task_state_change,
 			"do not call blocking ops when !TASK_RUNNING; "
-			"state=%lx set at [<%p>] %pS\n",
-			current->state,
+			"state=%x set at [<%p>] %pS\n", state,
 			(void *)current->task_state_change,
 			(void *)current->task_state_change);
 
@@ -8738,7 +8739,7 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 		 * has happened. This would lead to problems with PELT, due to
 		 * move wanting to detach+attach while we're not attached yet.
 		 */
-		if (task->state == TASK_NEW)
+		if (task->__state == TASK_NEW)
 			ret = -EINVAL;
 		raw_spin_unlock_irq(&task->pi_lock);
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9a2989749b8d..60cb1694838c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -348,10 +348,10 @@ static void task_non_contending(struct task_struct *p)
 	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
 		if (dl_task(p))
 			sub_running_bw(dl_se, dl_rq);
-		if (!dl_task(p) || p->state == TASK_DEAD) {
+		if (!dl_task(p) || p->__state == TASK_DEAD) {
 			struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
-			if (p->state == TASK_DEAD)
+			if (p->__state == TASK_DEAD)
 				sub_rq_bw(&p->dl, &rq->dl);
 			raw_spin_lock(&dl_b->lock);
 			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
@@ -1355,10 +1355,10 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	sched_clock_tick();
 	update_rq_clock(rq);
 
-	if (!dl_task(p) || p->state == TASK_DEAD) {
+	if (!dl_task(p) || p->__state == TASK_DEAD) {
 		struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
-		if (p->state == TASK_DEAD && dl_se->dl_non_contending) {
+		if (p->__state == TASK_DEAD && dl_se->dl_non_contending) {
 			sub_running_bw(&p->dl, dl_rq_of_se(&p->dl));
 			sub_rq_bw(&p->dl, dl_rq_of_se(&p->dl));
 			dl_se->dl_non_contending = 0;
@@ -1722,7 +1722,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 {
 	struct rq *rq;
 
-	if (p->state != TASK_WAKING)
+	if (p->__state != TASK_WAKING)
 		return;
 
 	rq = task_rq(p);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6aad02876346..09c12a93355e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1027,11 +1027,14 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	if ((flags & DEQUEUE_SLEEP) && entity_is_task(se)) {
 		struct task_struct *tsk = task_of(se);
+		unsigned int state;
 
-		if (tsk->state & TASK_INTERRUPTIBLE)
+		/* XXX racy against TTWU */
+		state = READ_ONCE(tsk->__state);
+		if (state & TASK_INTERRUPTIBLE)
 			__schedstat_set(se->statistics.sleep_start,
 				      rq_clock(rq_of(cfs_rq)));
-		if (tsk->state & TASK_UNINTERRUPTIBLE)
+		if (state & TASK_UNINTERRUPTIBLE)
 			__schedstat_set(se->statistics.block_start,
 				      rq_clock(rq_of(cfs_rq)));
 	}
@@ -6804,7 +6807,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	 * min_vruntime -- the latter is done by enqueue_entity() when placing
 	 * the task on the new runqueue.
 	 */
-	if (p->state == TASK_WAKING) {
+	if (p->__state == TASK_WAKING) {
 		struct sched_entity *se = &p->se;
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 		u64 min_vruntime;
@@ -10830,7 +10833,7 @@ static inline bool vruntime_normalized(struct task_struct *p)
 	 *   waiting for actually being woken up by sched_ttwu_pending().
 	 */
 	if (!se->sum_exec_runtime ||
-	    (p->state == TASK_WAKING && p->sched_remote_wakeup))
+	    (p->__state == TASK_WAKING && p->sched_remote_wakeup))
 		return true;
 
 	return false;
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index dc218e9f4558..08841369449e 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -221,7 +221,7 @@ static inline void sched_info_depart(struct rq *rq, struct task_struct *t)
 
 	rq_sched_info_depart(rq, delta);
 
-	if (t->state == TASK_RUNNING)
+	if (task_is_running(t))
 		sched_info_queued(rq, t);
 }
 
diff --git a/kernel/signal.c b/kernel/signal.c
index f2a1b898da29..b06694fae463 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4658,7 +4658,7 @@ void kdb_send_sig(struct task_struct *t, int sig)
 	}
 	new_t = kdb_prev_t != t;
 	kdb_prev_t = t;
-	if (t->state != TASK_RUNNING && new_t) {
+	if (!task_is_running(t) && new_t) {
 		spin_unlock(&t->sighand->siglock);
 		kdb_printf("Process is not RUNNING, sending a signal from "
 			   "kdb risks deadlock\n"
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 5a99696da86a..bff67d3897ea 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -76,7 +76,7 @@ static void wakeup_softirqd(void)
 	/* Interrupts are disabled: no need to stop preemption */
 	struct task_struct *tsk = __this_cpu_read(ksoftirqd);
 
-	if (tsk && tsk->state != TASK_RUNNING)
+	if (tsk)
 		wake_up_process(tsk);
 }
 
@@ -92,8 +92,7 @@ static bool ksoftirqd_running(unsigned long pending)
 
 	if (pending & SOFTIRQ_NOW_MASK)
 		return false;
-	return tsk && (tsk->state == TASK_RUNNING) &&
-		!__kthread_should_park(tsk);
+	return tsk && task_is_running(tsk) && !__kthread_should_park(tsk);
 }
 
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index f475f1a027c8..8fbe50d7b9fe 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1879,7 +1879,7 @@ signed long __sched schedule_timeout(signed long timeout)
 			printk(KERN_ERR "schedule_timeout: wrong timeout "
 				"value %lx\n", timeout);
 			dump_stack();
-			current->state = TASK_RUNNING;
+			__set_current_state(TASK_RUNNING);
 			goto out;
 		}
 	}
diff --git a/lib/syscall.c b/lib/syscall.c
index ba13e924c430..006e256d2264 100644
--- a/lib/syscall.c
+++ b/lib/syscall.c
@@ -68,13 +68,13 @@ static int collect_syscall(struct task_struct *target, struct syscall_info *info
  */
 int task_current_syscall(struct task_struct *target, struct syscall_info *info)
 {
-	long state;
 	unsigned long ncsw;
+	unsigned int state;
 
 	if (target == current)
 		return collect_syscall(target, info);
 
-	state = target->state;
+	state = READ_ONCE(target->__state);
 	if (unlikely(!state))
 		return -EAGAIN;
 
diff --git a/mm/compaction.c b/mm/compaction.c
index e04f4476e68e..5a6654334d9d 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1920,7 +1920,7 @@ static inline bool is_via_compact_memory(int order)
 
 static bool kswapd_is_running(pg_data_t *pgdat)
 {
-	return pgdat->kswapd && (pgdat->kswapd->state == TASK_RUNNING);
+	return pgdat->kswapd && task_is_running(pgdat->kswapd);
 }
 
 /*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 383df23514b9..3b8e68290e7a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4869,7 +4869,8 @@ static void kvm_sched_out(struct preempt_notifier *pn,
 {
 	struct kvm_vcpu *vcpu = preempt_notifier_to_vcpu(pn);
 
-	if (current->state == TASK_RUNNING) {
+	/* XXX also wrong */
+	if (current->__state == TASK_RUNNING) {
 		WRITE_ONCE(vcpu->preempted, true);
 		WRITE_ONCE(vcpu->ready, true);
 	}
