Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8873DBA6C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbhG3OWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:22:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56148 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhG3OST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:18:19 -0400
Message-ID: <20210730135208.418508738@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=buj/OW1ieu3Doe+LABCGRoieN/bpNcsjaa3txJrK/pA=;
        b=irhlXQ+JqrBSyLa3fz4M0T+P8p58JzfCcQmCmekFLYkHupiGiKxpXNBj1ZGyXaiMzeC4M6
        86cz1ap827eQi0ug8m3s9Fx93gJwdu4tFAAoaMB7Gq1p1iuUKlj2BHmkYk326KyX9JUZSt
        zRCeHDnN/S3E5kedjgx5Z1pEfeTLpSMoVsry2vsIDTM1Z5WYzi/tXSpKsoI0wx4vFvXAmI
        DkPsMdjZt4sv5iuniX3t+dlo7ORP39EFfqmWB7JnsMjMCwXv5SrDa5/z0bI5YBo8lFbCBE
        Yf+xDtOUKRUasSBrz1ywOF606zkt11wDd6K2GHFsw7z1OdX0hjrtgGLgLGrUAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=buj/OW1ieu3Doe+LABCGRoieN/bpNcsjaa3txJrK/pA=;
        b=bNRRpaxxhYd41wQeAVFg0u73qAUgvJ6pVrJtelfq90Pybgddgx6GdG4IQWIW9GtP4OFh5R
        roM7uP7zk7qNmJCA==
Date:   Fri, 30 Jul 2021 15:51:05 +0200
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
Subject: [patch 58/63] futex: Prevent requeue_pi() lock nesting issue on RT
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The requeue_pi() operation on RT kernels creates a problem versus the
task::pi_blocked_on state when a waiter is woken early (signal, timeout)
and that early wake up interleaves with the requeue_pi() operation.

When the requeue manages to block the waiter on the rtmutex which is
associated to the second futex, then a concurrent early wakeup of that
waiter faces the problem that it has to acquire the hash bucket spinlock,
which is not an issue on non-RT kernels, but on RT kernels spinlocks are
substituted by 'sleeping' spinlocks based on rtmutex. If the hash bucket
lock is contended then blocking on that spinlock would result in a
impossible situation: blocking on two locks at the same time (the hash
bucket lock and the rtmutex representing the PI futex).

It was considered to make the hash bucket locks raw_spinlocks, but
especially requeue operations with a large amount of waiters can introduce
significant latencies, so that's not an option for RT.

The RT tree carried a solution which (ab)used task::pi_blocked_on to store
the information about an ongoing requeue and an early wakeup which worked,
but required to add checks for these special states all over the place.

The distangling of an early wakeup of a waiter for a requeue_pi() operation
is already looking at quite some different states and the task::pi_blocked_on
magic just expanded that to a hard to understand 'state machine'.

This can be avoided by keeping track of the waiter/requeue state in the
futex_q object itself.

Add a requeue_state field to struct futex_q with the following possible
states:

	Q_REQUEUE_PI_NONE
	Q_REQUEUE_PI_IGNORE
	Q_REQUEUE_PI_IN_PROGRESS
	Q_REQUEUE_PI_WAIT
	Q_REQUEUE_PI_DONE
	Q_REQUEUE_PI_LOCKED

The waiter starts with state = NONE and the following state transitions are
valid:

On the waiter side:
  Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_IGNORE
  Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_WAIT

On the requeue side:
  Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_INPROGRESS
  Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_DONE/LOCKED
  Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_NONE (requeue failed)
  Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_DONE/LOCKED
  Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_IGNORE (requeue failed)

The requeue side ignores a waiter with state Q_REQUEUE_PI_IGNORE as this
signals that the waiter is already on the way out. It also means that
the waiter is still on the 'wait' futex, i.e. uaddr1.

The waiter side signals early wakeup to the requeue side either through
setting state to Q_REQUEUE_PI_IGNORE or to Q_REQUEUE_PI_WAIT depending
on the current state. In case of Q_REQUEUE_PI_IGNORE it can immediately
proceed to take the hash bucket lock of uaddr1. If it set state to WAIT,
which means the wakeup is interleaving with a requeue in progress it has
to wait for the requeue side to change the state. Either to DONE/LOCKED
or to IGNORE. DONE/LOCKED means the waiter q is now on the uaddr2 futex
and either blocked (DONE) or has acquired it (LOCKED). IGNORE is set by
the requeue side when the requeue attempt failed via deadlock detection
and therefore the waiter's futex_q is still on the uaddr1 futex.

While this is not strictly required on !RT making this unconditional has
the benefit of common code and it also allows the waiter to avoid taking
the hash bucket lock on the way out in certain cases, which reduces
contention.

Add the required helpers required for the state transitions, invoke them at
the right places and restructure the futex_wait_requeue_pi() code to handle
the return from wait (early or not) based on the state machine values.

On !RT enabled kernels the waiter spin waits for the state going from
Q_REQUEUE_PI_WAIT to some other state, on RT enabled kernels this is
handled by rcuwait_wait_event() and the corresponding wake up on the
requeue side.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c |  349 +++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 278 insertions(+), 71 deletions(-)
---
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -197,6 +197,8 @@ struct futex_pi_state {
  * @rt_waiter:		rt_waiter storage for use with requeue_pi
  * @requeue_pi_key:	the requeue_pi target futex key
  * @bitset:		bitset for the optional bitmasked wakeup
+ * @requeue_state:	State field for futex_requeue_pi()
+ * @requeue_wait:	RCU wait for futex_requeue_pi() (RT only)
  *
  * We use this hashed waitqueue, instead of a normal wait_queue_entry_t, so
  * we can wake only the relevant ones (hashed queues may be shared).
@@ -219,6 +221,10 @@ struct futex_q {
 	struct rt_mutex_waiter *rt_waiter;
 	union futex_key *requeue_pi_key;
 	u32 bitset;
+	atomic_t requeue_state;
+#ifdef CONFIG_PREEMPT_RT
+	struct rcuwait requeue_wait;
+#endif
 } __randomize_layout;
 
 static const struct futex_q futex_q_init = {
@@ -1793,6 +1799,158 @@ void requeue_futex(struct futex_q *q, st
 	q->key = *key2;
 }
 
+/*
+ * On PREEMPT_RT, the hash bucket lock is a 'sleeping' spinlock with an
+ * underlying rtmutex. The task which is about to be requeued could have
+ * just woken up (timeout, signal). After the wake up the task has to
+ * acquire hash bucket lock, which is held by the requeue code.  As a task
+ * can only be blocked on _ONE_ rtmutex at a time, the proxy lock blocking
+ * and the hash bucket lock blocking would collide and corrupt state.
+ *
+ * On !PREEMPT_RT this is not a problem and everything could be serialized
+ * on hash bucket lock, but aside of having the benefit of common code,
+ * this allows to avoid doing the requeue when the task is already on the
+ * way out and taking the hash bucket lock of the original uaddr1 when the
+ * requeue has been completed.
+ *
+ * The following state transitions are valid:
+ *
+ * On the waiter side:
+ *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_IGNORE
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_WAIT
+ *
+ * On the requeue side:
+ *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_INPROGRESS
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_DONE/LOCKED
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_NONE (requeue failed)
+ *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_DONE/LOCKED
+ *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_IGNORE (requeue failed)
+ *
+ * The requeue side ignores a waiter with state Q_REQUEUE_PI_IGNORE as this
+ * signals that the waiter is already on the way out. It also means that
+ * the waiter is still on the 'wait' futex, i.e. uaddr1.
+ *
+ * The waiter side signals early wakeup to the requeue side either through
+ * setting state to Q_REQUEUE_PI_IGNORE or to Q_REQUEUE_PI_WAIT depending
+ * on the current state. In case of Q_REQUEUE_PI_IGNORE it can immediately
+ * proceed to take the hash bucket lock of uaddr1. If it set state to WAIT,
+ * which means the wakeup is interleaving with a requeue in progress it has
+ * to wait for the requeue side to change the state. Either to DONE/LOCKED
+ * or to IGNORE. DONE/LOCKED means the waiter q is now on the uaddr2 futex
+ * and either blocked (DONE) or has acquired it (LOCKED). IGNORE is set by
+ * the requeue side when the requeue attempt failed via deadlock detection
+ * and therefore the waiter q is still on the uaddr1 futex.
+ */
+enum {
+	Q_REQUEUE_PI_NONE		=  0,
+	Q_REQUEUE_PI_IGNORE,
+	Q_REQUEUE_PI_IN_PROGRESS,
+	Q_REQUEUE_PI_WAIT,
+	Q_REQUEUE_PI_DONE,
+	Q_REQUEUE_PI_LOCKED,
+};
+
+static inline bool futex_requeue_pi_prepare(struct futex_q *q,
+					    struct futex_pi_state *pi_state)
+{
+	int cur, res, new;
+
+	/*
+	 * Set state to Q_REQUEUE_PI_IN_PROGRESS unless an early wakeup has
+	 * already set Q_REQUEUE_PI_IGNORE to signal that requeue should
+	 * ignore the waiter.
+	 */
+	for (cur = atomic_read(&q->requeue_state);; cur = res) {
+		if (cur == Q_REQUEUE_PI_IGNORE)
+			return false;
+
+		/*
+		 * futex_proxy_trylock_atomic() might have set it to
+		 * IN_PROGRESS and a interleaved early wake to WAIT.
+		 *
+		 * It was considered to have an extra state for that
+		 * trylock, but that would just add more conditionals
+		 * all over the place for a dubious value.
+		 */
+		if (cur != Q_REQUEUE_PI_NONE)
+			break;
+
+		new = Q_REQUEUE_PI_IN_PROGRESS;
+		res = atomic_cmpxchg(&q->requeue_state, cur, new);
+		if (likely(cur == res))
+			break;
+	}
+	q->pi_state = pi_state;
+	return true;
+}
+
+static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
+{
+	int cur, res, new;
+
+	for (cur = atomic_read(&q->requeue_state);; cur = res) {
+		if (locked >= 0) {
+			/* Requeue succeeded. Set DONE or LOCKED */
+			new = Q_REQUEUE_PI_DONE + locked;
+		} else if (cur == Q_REQUEUE_PI_IN_PROGRESS) {
+			/* Deadlock, no early wakeup interleave */
+			new = Q_REQUEUE_PI_NONE;
+		} else {
+			/* Deadlock, early wakeup interleave. */
+			new = Q_REQUEUE_PI_IGNORE;
+		}
+
+		res = atomic_cmpxchg(&q->requeue_state, cur, new);
+		if (likely(cur == res))
+			break;
+	}
+
+#ifdef CONFIG_PREEMPT_RT
+	/* If the waiter interleaved with the requeue let it know */
+	if (unlikely(cur == Q_REQUEUE_PI_WAIT))
+		rcuwait_wake_up(&q->requeue_wait);
+#endif
+}
+
+static inline int futex_requeue_pi_wakeup_sync(struct futex_q *q)
+{
+	int cur, new, res;
+
+	for (cur = atomic_read(&q->requeue_state);; cur = res) {
+		/* Is requeue done already? */
+		if (cur >= Q_REQUEUE_PI_DONE)
+			break;
+
+		/*
+		 * If not done, then tell the requeue code to either ignore
+		 * the waiter or to wake it up once the requeue is done.
+		 */
+		new = !cur ? Q_REQUEUE_PI_IGNORE : Q_REQUEUE_PI_WAIT;
+		res = atomic_cmpxchg(&q->requeue_state, cur, new);
+		if (likely(cur == res))
+			break;
+	}
+
+	/* If the requeue was in progress, wait for it to complete */
+	if (cur == Q_REQUEUE_PI_IN_PROGRESS) {
+#ifdef CONFIG_PREEMPT_RT
+		rcuwait_wait_event(&q->requeue_wait,
+				   atomic_read(&q->requeue_state) != Q_REQUEUE_PI_WAIT,
+				   TASK_UNINTERRUPTIBLE);
+#else
+		while (atomic_read(&q->requeue_state) == Q_REQUEUE_PI_WAIT)
+			cpu_relax();
+#endif
+	}
+
+	/*
+	 * Requeue is now either prohibited or complete. Reread state
+	 * because during the wait above it might have changed. Nothing
+	 * will modify q->requeue_state after this point.
+	 */
+	return atomic_read(&q->requeue_state);
+}
+
 /**
  * requeue_pi_wake_futex() - Wake a task that acquired the lock during requeue
  * @q:		the futex_q
@@ -1820,6 +1978,8 @@ void requeue_pi_wake_futex(struct futex_
 
 	q->lock_ptr = &hb->lock;
 
+	/* Signal locked state to the waiter */
+	futex_requeue_pi_complete(q, 1);
 	wake_up_state(q->task, TASK_NORMAL);
 }
 
@@ -1887,6 +2047,10 @@ futex_proxy_trylock_atomic(u32 __user *p
 	if (!match_futex(top_waiter->requeue_pi_key, key2))
 		return -EINVAL;
 
+	/* Ensure that this does not race against an early wakeup */
+	if (!futex_requeue_pi_prepare(top_waiter, NULL))
+		return -EAGAIN;
+
 	/*
 	 * Try to take the lock for top_waiter.  Set the FUTEX_WAITERS bit in
 	 * the contended case or if set_waiters is 1.  The pi_state is returned
@@ -1896,8 +2060,22 @@ futex_proxy_trylock_atomic(u32 __user *p
 	ret = futex_lock_pi_atomic(pifutex, hb2, key2, ps, top_waiter->task,
 				   exiting, set_waiters);
 	if (ret == 1) {
+		/* Dequeue, wake up and update top_waiter::requeue_state */
 		requeue_pi_wake_futex(top_waiter, key2, hb2);
 		return vpid;
+	} else if (ret < 0) {
+		/* Rewind top_waiter::requeue_state */
+		futex_requeue_pi_complete(top_waiter, ret);
+	} else {
+		/*
+		 * futex_lock_pi_atomic() did not acquire the user space
+		 * futex, but managed to establish the proxy lock and pi
+		 * state. top_waiter::requeue_state cannot be fixed up here
+		 * because the waiter is not enqueued on the rtmutex
+		 * yet. This is handled at the callsite depending on the
+		 * result of rt_mutex_start_proxy_lock() which is
+		 * guaranteed to be reached with this function returning 0.
+		 */
 	}
 	return ret;
 }
@@ -2038,6 +2216,8 @@ static int futex_requeue(u32 __user *uad
 		 * intend to requeue waiters, force setting the FUTEX_WAITERS
 		 * bit.  We force this here where we are able to easily handle
 		 * faults rather in the requeue loop below.
+		 *
+		 * Updates topwaiter::requeue_state if a top waiter exists.
 		 */
 		ret = futex_proxy_trylock_atomic(uaddr2, hb1, hb2, &key1,
 						 &key2, &pi_state,
@@ -2051,6 +2231,27 @@ static int futex_requeue(u32 __user *uad
 		 * vpid of the top waiter task.
 		 * If the lock was not taken, we have pi_state and an initial
 		 * refcount on it. In case of an error we have nothing.
+		 *
+		 * The top waiter's requeue_state is up to date:
+		 *
+		 *  - If the lock was acquired atomically (ret > 0), then
+		 *    the state is Q_REQUEUE_PI_LOCKED. No matter whether
+		 *    the below lookup_pi_state() fails or not requeue_state
+		 *    is correct because that waiter is dequeued and woken
+		 *    up and nothing can hold it up.
+		 *
+		 *  - If the trylock failed with an error (ret < 0) then
+		 *    the state is either Q_REQUEUE_PI_NONE, i.e. "nothing
+		 *    happened", or Q_REQUEUE_PI_IGNORE when there was an
+		 *    interleaved early wakeup.
+		 *
+		 *  - If the trylock did not succeed (ret == 0) then the
+		 *    state is either Q_REQUEUE_PI_IN_PROGRESS or
+		 *    Q_REQUEUE_PI_WAIT if an early wakeup interleaved.
+		 *    This will be cleaned up in the loop below, which
+		 *    cannot fail because futex_proxy_trylock_atomic() did
+		 *    the same sanity checks for requeue_pi as the loop
+		 *    below does.
 		 */
 		if (ret > 0) {
 			WARN_ON(pi_state);
@@ -2076,7 +2277,10 @@ static int futex_requeue(u32 __user *uad
 			/* We hold a reference on the pi state. */
 			break;
 
-			/* If the above failed, then pi_state is NULL */
+		/*
+		 * If the above failed, then pi_state is NULL and
+		 * waiter::requeue_state is correct.
+		 */
 		case -EFAULT:
 			double_unlock_hb(hb1, hb2);
 			hb_waiters_dec(hb2);
@@ -2152,21 +2356,39 @@ static int futex_requeue(u32 __user *uad
 		 * object of the waiter.
 		 */
 		get_pi_state(pi_state);
-		this->pi_state = pi_state;
+
+		/* Don't requeue when the waiter is already on the way out. */
+		if (!futex_requeue_pi_prepare(this, pi_state)) {
+			/*
+			 * Early woken waiter signaled that it is on the
+			 * way out. Drop the pi_state reference and try the
+			 * next waiter. @this->pi_state is still NULL.
+			 */
+			put_pi_state(pi_state);
+			continue;
+		}
+
 		ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
-						this->rt_waiter, this->task);
+						this->rt_waiter,
+						this->task);
+
 		if (ret == 1) {
 			/*
 			 * We got the lock. We do neither drop the refcount
 			 * on pi_state nor clear this->pi_state because the
 			 * waiter needs the pi_state for cleaning up the
 			 * user space value. It will drop the refcount
-			 * after doing so.
+			 * after doing so. this::requeue_state is updated
+			 * in the wakeup as well.
 			 */
 			requeue_pi_wake_futex(this, &key2, hb2);
 			task_count++;
-			continue;
-		} else if (ret) {
+		} else if (!ret) {
+			/* Waiter is queued, move it to hb2 */
+			requeue_futex(this, hb1, hb2, &key2);
+			futex_requeue_pi_complete(this, 0);
+			task_count++;
+		} else {
 			/*
 			 * rt_mutex_start_proxy_lock() detected a potential
 			 * deadlock when we tried to queue that waiter.
@@ -2176,15 +2398,13 @@ static int futex_requeue(u32 __user *uad
 			 */
 			this->pi_state = NULL;
 			put_pi_state(pi_state);
+			futex_requeue_pi_complete(this, ret);
 			/*
 			 * We stop queueing more waiters and let user space
 			 * deal with the mess.
 			 */
 			break;
 		}
-		/* Waiter is queued, move it to hb2 */
-		requeue_futex(this, hb1, hb2, &key2);
-		task_count++;
 	}
 
 	/*
@@ -3082,27 +3302,22 @@ static int futex_unlock_pi(u32 __user *u
 }
 
 /**
- * handle_early_requeue_pi_wakeup() - Detect early wakeup on the initial futex
+ * handle_early_requeue_pi_wakeup() - Handle early wakeup on the initial futex
  * @hb:		the hash_bucket futex_q was original enqueued on
  * @q:		the futex_q woken while waiting to be requeued
- * @key2:	the futex_key of the requeue target futex
  * @timeout:	the timeout associated with the wait (NULL if none)
  *
- * Detect if the task was woken on the initial futex as opposed to the requeue
- * target futex.  If so, determine if it was a timeout or a signal that caused
- * the wakeup and return the appropriate error code to the caller.  Must be
- * called with the hb lock held.
+ * Determine the cause for the early wakeup.
  *
  * Return:
- *  -  0 = no early wakeup detected;
- *  - <0 = -ETIMEDOUT or -ERESTARTNOINTR
+ *  -EWOULDBLOCK or -ETIMEDOUT or -ERESTARTNOINTR
  */
 static inline
 int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
-				   struct futex_q *q, union futex_key *key2,
+				   struct futex_q *q,
 				   struct hrtimer_sleeper *timeout)
 {
-	int ret = 0;
+	int ret;
 
 	/*
 	 * With the hb lock held, we avoid races while we process the wakeup.
@@ -3111,22 +3326,21 @@ int handle_early_requeue_pi_wakeup(struc
 	 * It can't be requeued from uaddr2 to something else since we don't
 	 * support a PI aware source futex for requeue.
 	 */
-	if (!match_futex(&q->key, key2)) {
-		WARN_ON(q->lock_ptr && (&hb->lock != q->lock_ptr));
-		/*
-		 * We were woken prior to requeue by a timeout or a signal.
-		 * Unqueue the futex_q and determine which it was.
-		 */
-		plist_del(&q->list, &hb->chain);
-		hb_waiters_dec(hb);
+	WARN_ON_ONCE(&hb->lock != q->lock_ptr);
 
-		/* Handle spurious wakeups gracefully */
-		ret = -EWOULDBLOCK;
-		if (timeout && !timeout->task)
-			ret = -ETIMEDOUT;
-		else if (signal_pending(current))
-			ret = -ERESTARTNOINTR;
-	}
+	/*
+	 * We were woken prior to requeue by a timeout or a signal.
+	 * Unqueue the futex_q and determine which it was.
+	 */
+	plist_del(&q->list, &hb->chain);
+	hb_waiters_dec(hb);
+
+	/* Handle spurious wakeups gracefully */
+	ret = -EWOULDBLOCK;
+	if (timeout && !timeout->task)
+		ret = -ETIMEDOUT;
+	else if (signal_pending(current))
+		ret = -ERESTARTNOINTR;
 	return ret;
 }
 
@@ -3179,6 +3393,7 @@ static int futex_wait_requeue_pi(u32 __u
 	struct futex_hash_bucket *hb;
 	union futex_key key2 = FUTEX_KEY_INIT;
 	struct futex_q q = futex_q_init;
+	struct rt_mutex_base *pi_mutex;
 	int res, ret;
 
 	if (!IS_ENABLED(CONFIG_FUTEX_PI))
@@ -3228,30 +3443,22 @@ static int futex_wait_requeue_pi(u32 __u
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
 	futex_wait_queue_me(hb, &q, to);
 
-	spin_lock(&hb->lock);
-	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
-	spin_unlock(&hb->lock);
-	if (ret)
-		goto out;
-
-	/*
-	 * In order for us to be here, we know our q.key == key2, and since
-	 * we took the hb->lock above, we also know that futex_requeue() has
-	 * completed and we no longer have to concern ourselves with a wakeup
-	 * race with the atomic proxy lock acquisition by the requeue code.
-	 */
+	switch (futex_requeue_pi_wakeup_sync(&q)) {
+	case Q_REQUEUE_PI_IGNORE:
+		/* The waiter is still on uaddr1 */
+		spin_lock(&hb->lock);
+		ret = handle_early_requeue_pi_wakeup(hb, &q, to);
+		spin_unlock(&hb->lock);
+		break;
 
-	/*
-	 * Check if the requeue code acquired the second futex for us and do
-	 * any pertinent fixup.
-	 */
-	if (!q.rt_waiter) {
+	case Q_REQUEUE_PI_LOCKED:
+		/* The requeue acquired the lock */
 		if (q.pi_state && (q.pi_state->owner != current)) {
 			spin_lock(q.lock_ptr);
 			ret = fixup_owner(uaddr2, &q, true);
 			/*
-			 * Drop the reference to the pi state which
-			 * the requeue_pi() code acquired for us.
+			 * Drop the reference to the pi state which the
+			 * requeue_pi() code acquired for us.
 			 */
 			put_pi_state(q.pi_state);
 			spin_unlock(q.lock_ptr);
@@ -3261,18 +3468,14 @@ static int futex_wait_requeue_pi(u32 __u
 			 */
 			ret = ret < 0 ? ret : 0;
 		}
-	} else {
-		struct rt_mutex_base *pi_mutex;
+		break;
 
-		/*
-		 * We have been woken up by futex_unlock_pi(), a timeout, or a
-		 * signal.  futex_unlock_pi() will not destroy the lock_ptr nor
-		 * the pi_state.
-		 */
-		WARN_ON(!q.pi_state);
+	case Q_REQUEUE_PI_DONE:
+		/* Requeue completed. Current is 'pi_blocked_on' the rtmutex */
 		pi_mutex = &q.pi_state->pi_mutex;
 		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
 
+		/* Current is not longer pi_blocked_on */
 		spin_lock(q.lock_ptr);
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret = 0;
@@ -3292,17 +3495,21 @@ static int futex_wait_requeue_pi(u32 __u
 
 		unqueue_me_pi(&q);
 		spin_unlock(q.lock_ptr);
-	}
 
-	if (ret == -EINTR) {
-		/*
-		 * We've already been requeued, but cannot restart by calling
-		 * futex_lock_pi() directly. We could restart this syscall, but
-		 * it would detect that the user space "val" changed and return
-		 * -EWOULDBLOCK.  Save the overhead of the restart and return
-		 * -EWOULDBLOCK directly.
-		 */
-		ret = -EWOULDBLOCK;
+		if (ret == -EINTR) {
+			/*
+			 * We've already been requeued, but cannot restart
+			 * by calling futex_lock_pi() directly. We could
+			 * restart this syscall, but it would detect that
+			 * the user space "val" changed and return
+			 * -EWOULDBLOCK.  Save the overhead of the restart
+			 * and return -EWOULDBLOCK directly.
+			 */
+			ret = -EWOULDBLOCK;
+		}
+		break;
+	default:
+		BUG();
 	}
 
 out:

