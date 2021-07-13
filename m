Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E2C3C73F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhGMQQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54156 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhGMQQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:03 -0400
Message-Id: <20210713160746.207208684@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GockKDMz9G4HLPwwVwAdy+5VB3Lao0s5VB16bfb9DMk=;
        b=qwZ9+1xL/Pg907+Far+IYVpd+UPmEeR9pWv8vNzUiHPYDjdPpST+RbAsEX7B/sTDavcy06
        yT4vEHMcOHGrUJyxA5DVtyfX+iltwXV1D+XqUCQ6aXNudqJwpS//GzOhyRCJ/N/ynPqgWF
        ZBnNlYaL8HHwjIuvKN90GWrwiAQZDDeFyy0b9WucdNCn1uX2VJemZzRIB7YTJjqU2VC5A4
        A1iHHKamHuwGq7T8oZRuGnra89Jv56JaXideg0AT3WDvfPTY1G24FnfqxkRZLvx2Xs4G0y
        J20jb4exwB/dgL/284WBRr9CEb/dFHqjm3PNicCA1aNE82CiFBZFucIoH7ZxGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GockKDMz9G4HLPwwVwAdy+5VB3Lao0s5VB16bfb9DMk=;
        b=p35SNfYHhHIsuWFuI7z0f9VSt2O0AqaEhE7cDqCw26GNaunnJsFu9TGh6a7V+JNYC6yj1j
        vBqcp2mgx1WYT8DA==
Date:   Tue, 13 Jul 2021 17:10:57 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [patch 03/50] sched: Prepare for RT sleeping spin/rwlocks
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Waiting for spinlocks and rwlocks on non RT enabled kernels is task::state
preserving. Any wakeup which matches the state is valid.

RT enabled kernels substitutes them with 'sleeping' spinlocks. This creates
an issue vs. task::state.

In order to block on the lock the task has to overwrite task::state and a
consecutive wakeup issued by the unlocker sets the state back to
TASK_RUNNING. As a consequence the task loses the state which was set
before the lock acquire and also any regular wakeup targeted at the task
while it is blocked on the lock.

To handle this gracefully add a 'saved_state' member to task_struct which
is used in the following way:

 1) When a task blocks on a 'sleeping' spinlock, the current state is saved
    in task::saved_state before it is set to TASK_RTLOCK_WAIT.

 2) When the task unblocks and after acquiring the lock, it restores the saved
    state.

 3) When a regular wakeup happens for a task while it is blocked then the
    state change of that wakeup is redirected to operate on task::saved_state.

    This is also required when the task state is running because the task
    might have been woken up from the lock wait and has not yet restored
    the saved state.

To make it complete provide the necessary helpers to save and restore the
saved state along with the necessary documentation how the RT lock blocking
is supposed to work.

For non-RT kernels there is no functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched.h |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c   |   33 +++++++++++++++++++++++
 2 files changed, 103 insertions(+)
---
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -155,6 +155,27 @@ struct task_group;
 		WRITE_ONCE(current->__state, (state_value));		\
 		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0)
+
+
+#define current_save_and_set_rtlock_wait_state()			\
+	do {								\
+		raw_spin_lock(&current->pi_lock);			\
+		current->saved_state = current->__state;		\
+		current->saved_state_change = current->task_state_change;\
+		current->task_state_change = _THIS_IP_;			\
+		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
+		raw_spin_unlock(&current->pi_lock);			\
+	} while (0);
+
+#define current_restore_rtlock_saved_state()				\
+	do {								\
+		raw_spin_lock(&current->pi_lock);			\
+		current->task_state_change = current->saved_state_change;\
+		WRITE_ONCE(current->__state, current->saved_state);	\
+		current->saved_state = TASK_RUNNING;			\
+		raw_spin_unlock(&current->pi_lock);			\
+	} while (0);
+
 #else
 /*
  * set_current_state() includes a barrier so that the write of current->state
@@ -213,6 +234,47 @@ struct task_group;
 		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0)
 
+/*
+ * PREEMPT_RT specific variants for "sleeping" spin/rwlocks
+ *
+ * RT's spin/rwlock substitutions are state preserving. The state of the
+ * task when blocking on the lock is saved in task_struct::saved_state and
+ * restored after the lock has been acquired.  These operations are
+ * serialized by task_struct::pi_lock against try_to_wake_up(). Any non RT
+ * lock related wakeups while the task is blocked on the lock are
+ * redirected to operate on task_struct::saved_state to ensure that these
+ * are not dropped. On restore task_struct::saved_state is set to
+ * TASK_RUNNING so any wakeup attempt redirected to saved_state will fail.
+ *
+ * The lock operation looks like this:
+ *
+ *	current_save_and_set_rtlock_wait_state();
+ *	for (;;) {
+ *		if (try_lock())
+ *			break;
+ *		raw_spin_unlock_irq(&lock->wait_lock);
+ *		schedule_rtlock();
+ *		raw_spin_lock_irq(&lock->wait_lock);
+ *		set_current_state(TASK_RTLOCK_WAIT);
+ *	}
+ *	current_restore_rtlock_saved_state();
+ */
+#define current_save_and_set_rtlock_wait_state()			\
+	do {								\
+		raw_spin_lock(&current->pi_lock);			\
+		current->saved_state = current->state;			\
+		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
+		raw_spin_unlock(&current->pi_lock);			\
+	} while (0);
+
+#define current_restore_rtlock_saved_state()				\
+	do {								\
+		raw_spin_lock(&current->pi_lock);			\
+		WRITE_ONCE(current->__state, current->saved_state);	\
+		current->saved_state = TASK_RUNNING;			\
+		raw_spin_unlock(&current->pi_lock);			\
+	} while (0);
+
 #endif
 
 #define get_current_state()	READ_ONCE(current->__state)
@@ -670,6 +732,11 @@ struct task_struct {
 #endif
 	unsigned int			__state;
 
+#ifdef CONFIG_PREEMPT_RT
+	/* saved state for "spinlock sleepers" */
+	unsigned int			saved_state;
+#endif
+
 	/*
 	 * This begins the randomizable portion of task_struct. Only
 	 * scheduling-critical items should be added above here.
@@ -1359,6 +1426,9 @@ struct task_struct {
 	struct kmap_ctrl		kmap_ctrl;
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	unsigned long			task_state_change;
+# ifdef CONFIG_PREEMPT_RT
+	unsigned long			saved_state_change;
+# endif
 #endif
 	int				pagefault_disabled;
 #ifdef CONFIG_MMU
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3568,14 +3568,47 @@ static void ttwu_queue(struct task_struc
  *
  * The caller holds p::pi_lock if p != current or has preemption
  * disabled when p == current.
+ *
+ * The rules of PREEMPT_RT saved_state:
+ *
+ *   The related locking code always holds p::pi_lock when updating
+ *   p::saved_state, which means the code is fully serialized in both cases.
+ *
+ *   The lock wait and lock wakeups happen via TASK_RTLOCK_WAIT. No other
+ *   bits set. This allows to distinguish all wakeup scenarios.
  */
 static __always_inline
 bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 {
+	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)) {
+		WARN_ON_ONCE((state & TASK_RTLOCK_WAIT) &&
+			     state != TASK_RTLOCK_WAIT);
+	}
+
 	if (READ_ONCE(p->__state) & state) {
 		*success = 1;
 		return true;
 	}
+
+#ifdef CONFIG_PREEMPT_RT
+	/*
+	 * Saved state preserves the task state accross blocking on
+	 * a RT lock.  If the state matches, set p::saved_state to
+	 * TASK_RUNNING, but do not wake the task because it waits
+	 * for a lock wakeup. Also indicate success because from
+	 * the regular waker's point of view this has succeeded.
+	 *
+	 * After acquiring the lock the task will restore p::state
+	 * from p::saved_state which ensures that the regular
+	 * wakeup is not lost. The restore will also set
+	 * p::saved_state to TASK_RUNNING so any further tests will
+	 * not result in false positives vs. @success
+	 */
+	if (p->saved_state & state) {
+		p->saved_state = TASK_RUNNING;
+		*success = 1;
+	}
+#endif
 	return false;
 }
 

