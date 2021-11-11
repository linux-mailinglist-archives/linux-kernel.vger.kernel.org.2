Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A45044DDE9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 23:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbhKKWhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 17:37:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234085AbhKKWhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 17:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636670086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZVYOOOOTr+T00R5TDXmgBBHo1kRJTwHa9dn6o7KHwdw=;
        b=LfUN5IweKrQUQ7gnM4jKcekZIJVKWO9XkMM2MShmOeusrZiduzmHnA+hC4V5U1F0TcUSOV
        YSFhd5QDUOi2td0yjeLd297pc64/H5nfQBQAK+/fnKC/29iOOAQH4yU6IRF4MeEw37cqjR
        ffffDwTZn4xfMRQhSCN9aAY8nvCJMwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-K3XyyxsnNaGYHepi6FwgFg-1; Thu, 11 Nov 2021 17:34:43 -0500
X-MC-Unique: K3XyyxsnNaGYHepi6FwgFg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B12918414A0;
        Thu, 11 Nov 2021 22:34:41 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FF645C22B;
        Thu, 11 Nov 2021 22:34:33 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        mazhenhua <mazhenhua@xiaomi.com>,
        Hillf Danton <hdanton@sina.com>,
        Maria Yu <quic_aiquny@quicinc.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3] locking/rwsem: Make handoff bit handling more consistent
Date:   Thu, 11 Nov 2021 17:33:39 -0500
Message-Id: <20211111223339.362757-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some inconsistency in the way that the handoff bit is being
handled in readers and writers.

Firstly, when a queue head writer set the handoff bit, it will clear it
when the writer is being killed or interrupted on its way out without
acquiring the lock. That is not the case for a queue head reader. The
handoff bit will simply be inherited by the next waiter.

Secondly, in the out_nolock path of rwsem_down_read_slowpath(), both
the waiter and handoff bits are cleared if the wait queue becomes empty.
For rwsem_down_write_slowpath(), however, the handoff bit is not checked
and cleared if the wait queue is empty. This can potentially make the
handoff bit set with empty wait queue.

To make the handoff bit handling more consistent and robust,
extract out the rwsem flags handling code into a common
rwsem_out_nolock_clear_flags() function and call it from both the
reader and writer's out_nolock paths.  The common function will only
use atomic_long_andnot() to clear bits to avoid possible race condition.
It will also let the next waiter inherit the handoff bit if it had been
set.

This will elminate the handoff bit set with empty wait queue case as
well as the possible race condition that may screw up the count value.

While at it, simplify the trylock for loop in rwsem_down_write_slowpath()
to make it easier to read.

Fixes: 4f23dbc1e657 ("locking/rwsem: Implement lock handoff to prevent lock starvation")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 117 ++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 73 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c51387a43265..d587acd1142b 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -104,10 +104,11 @@
  * atomic_long_fetch_add() is used to obtain reader lock, whereas
  * atomic_long_cmpxchg() will be used to obtain writer lock.
  *
- * There are three places where the lock handoff bit may be set or cleared.
- * 1) rwsem_mark_wake() for readers.
- * 2) rwsem_try_write_lock() for writers.
- * 3) Error path of rwsem_down_write_slowpath().
+ * There are four places where the lock handoff bit may be set or cleared.
+ * 1) rwsem_mark_wake() for readers            -- set, clear
+ * 2) rwsem_try_write_lock() for writers       -- set, clear
+ * 3) Error path of rwsem_down_write_slowpath() -- clear
+ * 4) Error path of rwsem_down_read_slowpath()  -- clear
  *
  * For all the above cases, wait_lock will be held. A writer must also
  * be the first one in the wait_list to be eligible for setting the handoff
@@ -334,6 +335,9 @@ struct rwsem_waiter {
 	struct task_struct *task;
 	enum rwsem_waiter_type type;
 	unsigned long timeout;
+
+	/* Writer only, not initialized in reader */
+	bool handoff_set;
 };
 #define rwsem_first_waiter(sem) \
 	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
@@ -344,12 +348,6 @@ enum rwsem_wake_type {
 	RWSEM_WAKE_READ_OWNED	/* Waker thread holds the read lock */
 };
 
-enum writer_wait_state {
-	WRITER_NOT_FIRST,	/* Writer is not first in wait list */
-	WRITER_FIRST,		/* Writer is first in wait list     */
-	WRITER_HANDOFF		/* Writer is first & handoff needed */
-};
-
 /*
  * The typical HZ value is either 250 or 1000. So set the minimum waiting
  * time to at least 4ms or 1 jiffy (if it is higher than 4ms) in the wait
@@ -531,13 +529,11 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
  * This function must be called with the sem->wait_lock held to prevent
  * race conditions between checking the rwsem wait list and setting the
  * sem->count accordingly.
- *
- * If wstate is WRITER_HANDOFF, it will make sure that either the handoff
- * bit is set or the lock is acquired with handoff bit cleared.
  */
 static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
-					enum writer_wait_state wstate)
+					struct rwsem_waiter *waiter)
 {
+	bool first = rwsem_first_waiter(sem) == waiter;
 	long count, new;
 
 	lockdep_assert_held(&sem->wait_lock);
@@ -546,13 +542,15 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 	do {
 		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
 
-		if (has_handoff && wstate == WRITER_NOT_FIRST)
+		if (has_handoff && !first)
 			return false;
 
 		new = count;
 
 		if (count & RWSEM_LOCK_MASK) {
-			if (has_handoff || (wstate != WRITER_HANDOFF))
+			waiter->handoff_set = true;
+			if (has_handoff || (!rt_task(waiter->task) &&
+					    !time_after(jiffies, waiter->timeout)))
 				return false;
 
 			new |= RWSEM_FLAG_HANDOFF;
@@ -569,8 +567,10 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 	 * We have either acquired the lock with handoff bit cleared or
 	 * set the handoff bit.
 	 */
-	if (new & RWSEM_FLAG_HANDOFF)
+	if (new & RWSEM_FLAG_HANDOFF) {
+		lockevent_inc(rwsem_wlock_handoff);
 		return false;
+	}
 
 	rwsem_set_owner(sem);
 	return true;
@@ -889,6 +889,20 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 }
 #endif
 
+/*
+ * Common code to handle rwsem flags in out_nolock path with wait_lock held.
+ * If there is more than one waiter in the queue and the HANDOFF bit is set,
+ * the next waiter will inherit it if the first waiter is removed.
+ */
+static inline void rwsem_out_nolock_clear_flags(struct rw_semaphore *sem,
+						struct rwsem_waiter *waiter)
+{
+	list_del(&waiter->list);
+	if (list_empty(&sem->wait_list))
+		atomic_long_andnot(RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS,
+				   &sem->count);
+}
+
 /*
  * Wait for the read lock to be granted
  */
@@ -1002,11 +1016,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	return sem;
 
 out_nolock:
-	list_del(&waiter.list);
-	if (list_empty(&sem->wait_list)) {
-		atomic_long_andnot(RWSEM_FLAG_WAITERS|RWSEM_FLAG_HANDOFF,
-				   &sem->count);
-	}
+	rwsem_out_nolock_clear_flags(sem, &waiter);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock_fail);
@@ -1020,7 +1030,6 @@ static struct rw_semaphore *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count;
-	enum writer_wait_state wstate;
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
@@ -1038,16 +1047,13 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	waiter.task = current;
 	waiter.type = RWSEM_WAITING_FOR_WRITE;
 	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
+	waiter.handoff_set = false;
 
 	raw_spin_lock_irq(&sem->wait_lock);
-
-	/* account for this before adding a new element to the list */
-	wstate = list_empty(&sem->wait_list) ? WRITER_FIRST : WRITER_NOT_FIRST;
-
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we're now waiting on the lock */
-	if (wstate == WRITER_NOT_FIRST) {
+	if (rwsem_first_waiter(sem) != &waiter) {
 		count = atomic_long_read(&sem->count);
 
 		/*
@@ -1083,13 +1089,16 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
 	for (;;) {
-		if (rwsem_try_write_lock(sem, wstate)) {
+		if (rwsem_try_write_lock(sem, &waiter)) {
 			/* rwsem_try_write_lock() implies ACQUIRE on success */
 			break;
 		}
 
 		raw_spin_unlock_irq(&sem->wait_lock);
 
+		if (signal_pending_state(state, current))
+			goto out_nolock;
+
 		/*
 		 * After setting the handoff bit and failing to acquire
 		 * the lock, attempt to spin on owner to accelerate lock
@@ -1098,7 +1107,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		 * In this case, we attempt to acquire the lock again
 		 * without sleeping.
 		 */
-		if (wstate == WRITER_HANDOFF) {
+		if (waiter.handoff_set) {
 			enum owner_state owner_state;
 
 			preempt_disable();
@@ -1109,40 +1118,9 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 				goto trylock_again;
 		}
 
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
-			if (wstate == WRITER_HANDOFF)
-				break;
-
-			if ((wstate == WRITER_NOT_FIRST) &&
-			    (rwsem_first_waiter(sem) == &waiter))
-				wstate = WRITER_FIRST;
-
-			count = atomic_long_read(&sem->count);
-			if (!(count & RWSEM_LOCK_MASK))
-				break;
-
-			/*
-			 * The setting of the handoff bit is deferred
-			 * until rwsem_try_write_lock() is called.
-			 */
-			if ((wstate == WRITER_FIRST) && (rt_task(current) ||
-			    time_after(jiffies, waiter.timeout))) {
-				wstate = WRITER_HANDOFF;
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
@@ -1156,19 +1134,12 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 out_nolock:
 	__set_current_state(TASK_RUNNING);
 	raw_spin_lock_irq(&sem->wait_lock);
-	list_del(&waiter.list);
-
-	if (unlikely(wstate == WRITER_HANDOFF))
-		atomic_long_add(-RWSEM_FLAG_HANDOFF,  &sem->count);
-
-	if (list_empty(&sem->wait_list))
-		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
-	else
+	rwsem_out_nolock_clear_flags(sem, &waiter);
+	if (!list_empty(&sem->wait_list))
 		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
 	lockevent_inc(rwsem_wlock_fail);
-
 	return ERR_PTR(-EINTR);
 }
 
-- 
2.27.0

