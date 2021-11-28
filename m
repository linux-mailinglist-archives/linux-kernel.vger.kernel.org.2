Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB1C4607A2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 17:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358555AbhK1QlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 11:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353452AbhK1QjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 11:39:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8D9C0613F8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 08:35:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638117317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pJNNajwrSTWBdBAx7ALhXVK2aTLri1RS2FCX8Ox5vgI=;
        b=MtXv0mT6UDUQzqNxmsu6ZytVEH7zook1EDmLkXwz7OpSgtmZXYMC4JLFPrLhoQ5/0DcN+X
        PfAkXAC+hpQe+TMmKwAn+cMickh21/giGHLu5hqrnyewEURemPyoDCixzgZnNSzqR0PLC2
        4KWA7cnL34zYpxd96USsEeedg+UppbGek9tdNNJxgxOj/K0/xl7Dh9ziXCvSa43KhrFk4x
        qJ+kuC2c4GV3vRlreqWhhIFwH/xCu0EoOV4gokeB6etyvLUsdMSjy0H9bJDy9ulDNexWa+
        9NxCzGpRAyvBxHklkb2Sz1EtlTYUAR2zvBS4yBvavVZlBJngrax7mTiZ/9xP3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638117317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pJNNajwrSTWBdBAx7ALhXVK2aTLri1RS2FCX8Ox5vgI=;
        b=TEp3uj6W6oByme7mIHSNmLAQ1ot+LjontObILubWCpgdD0uEEVoSEVqXhK9tia5P1v0R4Z
        MnytblYmUhE+r9Dw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for v5.16-rc3
Message-ID: <163811728418.767205.14544746031342483043.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 28 Nov 2021 17:35:16 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2=
021-11-28

up to:  14c240488411: locking/rwsem: Optimize down_read_trylock() under highl=
y contended case


Two regression fixes for reader writer semaphores:

 - Plug a race in the lock handoff which is caused by inconsistency of the
   reader and writer path and can lead to corruption of the underlying
   counter.

 - down_read_trylock() is suboptimal when the lock is contended and
   multiple readers trylock concurrently. That's due to the initial value
   being read non-atomically which results in at least two compare exchange
   loops. Making the initial readout atomic reduces this significantly.
   Whith 40 readers by 11% in a benchmark which enforces contention on
   mmap_sem.


Thanks,

	tglx

------------------>
Muchun Song (1):
      locking/rwsem: Optimize down_read_trylock() under highly contended case

Waiman Long (1):
      locking/rwsem: Make handoff bit handling more consistent


 kernel/locking/rwsem.c | 182 ++++++++++++++++++++++++-----------------------=
--
 1 file changed, 89 insertions(+), 93 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c51387a43265..04a74d040a6d 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -105,9 +105,9 @@
  * atomic_long_cmpxchg() will be used to obtain writer lock.
  *
  * There are three places where the lock handoff bit may be set or cleared.
- * 1) rwsem_mark_wake() for readers.
- * 2) rwsem_try_write_lock() for writers.
- * 3) Error path of rwsem_down_write_slowpath().
+ * 1) rwsem_mark_wake() for readers		-- set, clear
+ * 2) rwsem_try_write_lock() for writers	-- set, clear
+ * 3) rwsem_del_waiter()			-- clear
  *
  * For all the above cases, wait_lock will be held. A writer must also
  * be the first one in the wait_list to be eligible for setting the handoff
@@ -334,6 +334,9 @@ struct rwsem_waiter {
 	struct task_struct *task;
 	enum rwsem_waiter_type type;
 	unsigned long timeout;
+
+	/* Writer only, not initialized in reader */
+	bool handoff_set;
 };
 #define rwsem_first_waiter(sem) \
 	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
@@ -344,12 +347,6 @@ enum rwsem_wake_type {
 	RWSEM_WAKE_READ_OWNED	/* Waker thread holds the read lock */
 };
=20
-enum writer_wait_state {
-	WRITER_NOT_FIRST,	/* Writer is not first in wait list */
-	WRITER_FIRST,		/* Writer is first in wait list     */
-	WRITER_HANDOFF		/* Writer is first & handoff needed */
-};
-
 /*
  * The typical HZ value is either 250 or 1000. So set the minimum waiting
  * time to at least 4ms or 1 jiffy (if it is higher than 4ms) in the wait
@@ -365,6 +362,31 @@ enum writer_wait_state {
  */
 #define MAX_READERS_WAKEUP	0x100
=20
+static inline void
+rwsem_add_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
+{
+	lockdep_assert_held(&sem->wait_lock);
+	list_add_tail(&waiter->list, &sem->wait_list);
+	/* caller will set RWSEM_FLAG_WAITERS */
+}
+
+/*
+ * Remove a waiter from the wait_list and clear flags.
+ *
+ * Both rwsem_mark_wake() and rwsem_try_write_lock() contain a full 'copy' of
+ * this function. Modify with care.
+ */
+static inline void
+rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
+{
+	lockdep_assert_held(&sem->wait_lock);
+	list_del(&waiter->list);
+	if (likely(!list_empty(&sem->wait_list)))
+		return;
+
+	atomic_long_andnot(RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS, &sem->count);
+}
+
 /*
  * handle the lock release when processes blocked on it that can now run
  * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
@@ -376,6 +398,8 @@ enum writer_wait_state {
  *   preferably when the wait_lock is released
  * - woken process blocks are discarded from the list after having task zero=
ed
  * - writers are only marked woken if downgrading is false
+ *
+ * Implies rwsem_del_waiter() for all woken readers.
  */
 static void rwsem_mark_wake(struct rw_semaphore *sem,
 			    enum rwsem_wake_type wake_type,
@@ -490,18 +514,25 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
=20
 	adjustment =3D woken * RWSEM_READER_BIAS - adjustment;
 	lockevent_cond_inc(rwsem_wake_reader, woken);
+
+	oldcount =3D atomic_long_read(&sem->count);
 	if (list_empty(&sem->wait_list)) {
-		/* hit end of list above */
+		/*
+		 * Combined with list_move_tail() above, this implies
+		 * rwsem_del_waiter().
+		 */
 		adjustment -=3D RWSEM_FLAG_WAITERS;
+		if (oldcount & RWSEM_FLAG_HANDOFF)
+			adjustment -=3D RWSEM_FLAG_HANDOFF;
+	} else if (woken) {
+		/*
+		 * When we've woken a reader, we no longer need to force
+		 * writers to give up the lock and we can clear HANDOFF.
+		 */
+		if (oldcount & RWSEM_FLAG_HANDOFF)
+			adjustment -=3D RWSEM_FLAG_HANDOFF;
 	}
=20
-	/*
-	 * When we've woken a reader, we no longer need to force writers
-	 * to give up the lock and we can clear HANDOFF.
-	 */
-	if (woken && (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF))
-		adjustment -=3D RWSEM_FLAG_HANDOFF;
-
 	if (adjustment)
 		atomic_long_add(adjustment, &sem->count);
=20
@@ -532,12 +563,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
  * race conditions between checking the rwsem wait list and setting the
  * sem->count accordingly.
  *
- * If wstate is WRITER_HANDOFF, it will make sure that either the handoff
- * bit is set or the lock is acquired with handoff bit cleared.
+ * Implies rwsem_del_waiter() on success.
  */
 static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
-					enum writer_wait_state wstate)
+					struct rwsem_waiter *waiter)
 {
+	bool first =3D rwsem_first_waiter(sem) =3D=3D waiter;
 	long count, new;
=20
 	lockdep_assert_held(&sem->wait_lock);
@@ -546,13 +577,19 @@ static inline bool rwsem_try_write_lock(struct rw_semap=
hore *sem,
 	do {
 		bool has_handoff =3D !!(count & RWSEM_FLAG_HANDOFF);
=20
-		if (has_handoff && wstate =3D=3D WRITER_NOT_FIRST)
-			return false;
+		if (has_handoff) {
+			if (!first)
+				return false;
+
+			/* First waiter inherits a previously set handoff bit */
+			waiter->handoff_set =3D true;
+		}
=20
 		new =3D count;
=20
 		if (count & RWSEM_LOCK_MASK) {
-			if (has_handoff || (wstate !=3D WRITER_HANDOFF))
+			if (has_handoff || (!rt_task(waiter->task) &&
+					    !time_after(jiffies, waiter->timeout)))
 				return false;
=20
 			new |=3D RWSEM_FLAG_HANDOFF;
@@ -569,9 +606,17 @@ static inline bool rwsem_try_write_lock(struct rw_semaph=
ore *sem,
 	 * We have either acquired the lock with handoff bit cleared or
 	 * set the handoff bit.
 	 */
-	if (new & RWSEM_FLAG_HANDOFF)
+	if (new & RWSEM_FLAG_HANDOFF) {
+		waiter->handoff_set =3D true;
+		lockevent_inc(rwsem_wlock_handoff);
 		return false;
+	}
=20
+	/*
+	 * Have rwsem_try_write_lock() fully imply rwsem_del_waiter() on
+	 * success.
+	 */
+	list_del(&waiter->list);
 	rwsem_set_owner(sem);
 	return true;
 }
@@ -956,7 +1001,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long =
count, unsigned int stat
 		}
 		adjustment +=3D RWSEM_FLAG_WAITERS;
 	}
-	list_add_tail(&waiter.list, &sem->wait_list);
+	rwsem_add_waiter(sem, &waiter);
=20
 	/* we're now waiting on the lock, but no longer actively locking */
 	count =3D atomic_long_add_return(adjustment, &sem->count);
@@ -1002,11 +1047,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, lon=
g count, unsigned int stat
 	return sem;
=20
 out_nolock:
-	list_del(&waiter.list);
-	if (list_empty(&sem->wait_list)) {
-		atomic_long_andnot(RWSEM_FLAG_WAITERS|RWSEM_FLAG_HANDOFF,
-				   &sem->count);
-	}
+	rwsem_del_waiter(sem, &waiter);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock_fail);
@@ -1020,9 +1061,7 @@ static struct rw_semaphore *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count;
-	enum writer_wait_state wstate;
 	struct rwsem_waiter waiter;
-	struct rw_semaphore *ret =3D sem;
 	DEFINE_WAKE_Q(wake_q);
=20
 	/* do optimistic spinning and steal lock if possible */
@@ -1038,16 +1077,13 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, i=
nt state)
 	waiter.task =3D current;
 	waiter.type =3D RWSEM_WAITING_FOR_WRITE;
 	waiter.timeout =3D jiffies + RWSEM_WAIT_TIMEOUT;
+	waiter.handoff_set =3D false;
=20
 	raw_spin_lock_irq(&sem->wait_lock);
-
-	/* account for this before adding a new element to the list */
-	wstate =3D list_empty(&sem->wait_list) ? WRITER_FIRST : WRITER_NOT_FIRST;
-
-	list_add_tail(&waiter.list, &sem->wait_list);
+	rwsem_add_waiter(sem, &waiter);
=20
 	/* we're now waiting on the lock */
-	if (wstate =3D=3D WRITER_NOT_FIRST) {
+	if (rwsem_first_waiter(sem) !=3D &waiter) {
 		count =3D atomic_long_read(&sem->count);
=20
 		/*
@@ -1083,13 +1119,16 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, i=
nt state)
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
 	for (;;) {
-		if (rwsem_try_write_lock(sem, wstate)) {
+		if (rwsem_try_write_lock(sem, &waiter)) {
 			/* rwsem_try_write_lock() implies ACQUIRE on success */
 			break;
 		}
=20
 		raw_spin_unlock_irq(&sem->wait_lock);
=20
+		if (signal_pending_state(state, current))
+			goto out_nolock;
+
 		/*
 		 * After setting the handoff bit and failing to acquire
 		 * the lock, attempt to spin on owner to accelerate lock
@@ -1098,7 +1137,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int=
 state)
 		 * In this case, we attempt to acquire the lock again
 		 * without sleeping.
 		 */
-		if (wstate =3D=3D WRITER_HANDOFF) {
+		if (waiter.handoff_set) {
 			enum owner_state owner_state;
=20
 			preempt_disable();
@@ -1109,66 +1148,26 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, i=
nt state)
 				goto trylock_again;
 		}
=20
-		/* Block until there are no active lockers. */
-		for (;;) {
-			if (signal_pending_state(state, current))
-				goto out_nolock;
-
-			schedule();
-			lockevent_inc(rwsem_sleep_writer);
-			set_current_state(state);
-			/*
-			 * If HANDOFF bit is set, unconditionally do
-			 * a trylock.
-			 */
-			if (wstate =3D=3D WRITER_HANDOFF)
-				break;
-
-			if ((wstate =3D=3D WRITER_NOT_FIRST) &&
-			    (rwsem_first_waiter(sem) =3D=3D &waiter))
-				wstate =3D WRITER_FIRST;
-
-			count =3D atomic_long_read(&sem->count);
-			if (!(count & RWSEM_LOCK_MASK))
-				break;
-
-			/*
-			 * The setting of the handoff bit is deferred
-			 * until rwsem_try_write_lock() is called.
-			 */
-			if ((wstate =3D=3D WRITER_FIRST) && (rt_task(current) ||
-			    time_after(jiffies, waiter.timeout))) {
-				wstate =3D WRITER_HANDOFF;
-				lockevent_inc(rwsem_wlock_handoff);
-				break;
-			}
-		}
+		schedule();
+		lockevent_inc(rwsem_sleep_writer);
+		set_current_state(state);
 trylock_again:
 		raw_spin_lock_irq(&sem->wait_lock);
 	}
 	__set_current_state(TASK_RUNNING);
-	list_del(&waiter.list);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	lockevent_inc(rwsem_wlock);
-
-	return ret;
+	return sem;
=20
 out_nolock:
 	__set_current_state(TASK_RUNNING);
 	raw_spin_lock_irq(&sem->wait_lock);
-	list_del(&waiter.list);
-
-	if (unlikely(wstate =3D=3D WRITER_HANDOFF))
-		atomic_long_add(-RWSEM_FLAG_HANDOFF,  &sem->count);
-
-	if (list_empty(&sem->wait_list))
-		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
-	else
+	rwsem_del_waiter(sem, &waiter);
+	if (!list_empty(&sem->wait_list))
 		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
 	lockevent_inc(rwsem_wlock_fail);
-
 	return ERR_PTR(-EINTR);
 }
=20
@@ -1249,17 +1248,14 @@ static inline int __down_read_trylock(struct rw_semap=
hore *sem)
=20
 	DEBUG_RWSEMS_WARN_ON(sem->magic !=3D sem, sem);
=20
-	/*
-	 * Optimize for the case when the rwsem is not locked at all.
-	 */
-	tmp =3D RWSEM_UNLOCKED_VALUE;
-	do {
+	tmp =3D atomic_long_read(&sem->count);
+	while (!(tmp & RWSEM_READ_FAILED_MASK)) {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
-					tmp + RWSEM_READER_BIAS)) {
+						    tmp + RWSEM_READER_BIAS)) {
 			rwsem_set_reader_owned(sem);
 			return 1;
 		}
-	} while (!(tmp & RWSEM_READ_FAILED_MASK));
+	}
 	return 0;
 }
=20

