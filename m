Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0CB44D8E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 16:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhKKPLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 10:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbhKKPLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:11:35 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58201C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 07:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VHvPPD99e05Cz4oZqQcXrWujlneCuJPSbXOxawlkkic=; b=m1ZO6bPMIRgjlPbCddU19oFL1M
        OkK+lsMtjTOCZp6h4We6y5fP0n4UFuX5xryh5a+ipGYFkIpGsK0nxk23MfG2KMTmmi2TZA6HtGz/y
        HN+OpKz0kxAVTbVJhtRyJs8W4PRcVvEkwoeSuLkSYJ4CFfx1FarvDUj96/6BmecDLcy4kl0k2WD7T
        oNI+SzCTjg2ukSkQQnXGQ+6UxhIocs0SXW41BaTkvygZaNmoWziRR+DR88fBXHEonOKNCW6PeqrGx
        qOMRA52OqQyx8KTxOVj0PyiqRgkYbdp2SFWcvGkTz0qqyEWqmPEbGNCLNr9BA9Oxou35rGmlC5sTh
        7kVJnolQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlBgg-00FTsU-RN; Thu, 11 Nov 2021 15:08:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D10530001B;
        Thu, 11 Nov 2021 16:08:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4434A212B0E8B; Thu, 11 Nov 2021 16:08:23 +0100 (CET)
Date:   Thu, 11 Nov 2021 16:08:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        =?utf-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Message-ID: <YY0x55wxO2v5HCOW@hirez.programming.kicks-ass.net>
References: <4fafad133b074f279dbab1aa3642e23f@xiaomi.com>
 <20211107090131.1535-1-hdanton@sina.com>
 <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
 <02e118c0-2116-b806-2b48-b9c91dc847dd@redhat.com>
 <20211110213854.GE174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110213854.GE174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 10:38:55PM +0100, Peter Zijlstra wrote:
> On Sun, Nov 07, 2021 at 02:52:36PM -0500, Waiman Long wrote:
> > > 
> > > I did have a tentative patch to address this issue which is somewhat
> > > similar to your approach. However, I would like to further investigate
> > > the exact mechanics of the race condition to make sure that I won't miss
> > > a latent bug somewhere else in the rwsem code.
> > 
> > I still couldn't figure how this race condition can happen. However, I do
> > discover that it is possible to leave rwsem with no waiter but handoff bit
> > set if we kill or interrupt all the waiters in the wait queue. I have just
> > sent out a patch to address that concern, but it should be able to handle
> > this race condition as well if it really happens.
> 
> The comment above RWSEM_WRITER_LOCKED seems wrong/out-dated in that
> there's a 4th place that modifies the HANDOFF bit namely
> rwsem_down_read_slowpath() in the out_nolock: case.
> 
> Now the thing I'm most worried about is that rwsem_down_write_slowpath()
> modifies the HANDOFF bit depending on wstate, and wstate itself it not
> determined under the same ->wait_lock section, so there could be a race
> there.
> 
> Another thing is that once wstate==HANDOFF, we rely on spin_on_owner()
> to return OWNER_NULL such that it goes to trylock_again, however if it
> returns anything else then we're at signal_pending_state() and the
> observed race can happen.
> 
> Now, spin_on_owner() *can* in fact return something else, consider
> need_resched() being set for instance.
> 
> Combined I think the observed race is valid.
> 
> Now before we go make things more complicated, I think we should see if
> we can make things simpler. Also I think perhaps the HANDOFF name here
> is a misnomer.
> 
> I agree that using _andnot() will fix this issue; I also agree with
> folding it with the existing _andnot() already there. But let me stare a
> little more at this code, something isn't making sense...

I think I want to see WRITER_HANDOFF go away. And preferably all of
wstate.

Something like the *completely* untested below, might set fire to your
pet, eat your granny, etc..

Also, perhaps s/HANDOFF/PHASE_CHANGE/ ?

Waiman, did I overlook something fundamental here?

---
 kernel/locking/rwsem.c | 85 +++++++++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 53 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c51387a43265..bc5da05346e2 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -104,14 +104,17 @@
  * atomic_long_fetch_add() is used to obtain reader lock, whereas
  * atomic_long_cmpxchg() will be used to obtain writer lock.
  *
- * There are three places where the lock handoff bit may be set or cleared.
- * 1) rwsem_mark_wake() for readers.
- * 2) rwsem_try_write_lock() for writers.
- * 3) Error path of rwsem_down_write_slowpath().
+ * There are four places where the lock handoff bit may be set or cleared.
+ * 1) rwsem_mark_wake() for readers		-- set, clear
+ * 2) rwsem_try_write_lock() for writers	-- set, clear
+ * 3) Error path of rwsem_down_write_slowpath() -- clear
+ * 4) Error path of rwsem_down_read_slowpath()  -- clear
  *
  * For all the above cases, wait_lock will be held. A writer must also
  * be the first one in the wait_list to be eligible for setting the handoff
  * bit. So concurrent setting/clearing of handoff bit is not possible.
+ *
+ * XXX handoff is a misnomer here, all it does it force a phase change
  */
 #define RWSEM_WRITER_LOCKED	(1UL << 0)
 #define RWSEM_FLAG_WAITERS	(1UL << 1)
@@ -344,12 +347,6 @@ enum rwsem_wake_type {
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
@@ -531,13 +528,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
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
+	bool timo = time_after(jiffies, waiter->timeout);
 	long count, new;
 
 	lockdep_assert_held(&sem->wait_lock);
@@ -546,13 +542,13 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 	do {
 		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
 
-		if (has_handoff && wstate == WRITER_NOT_FIRST)
+		if (has_handoff && !first)
 			return false;
 
 		new = count;
 
 		if (count & RWSEM_LOCK_MASK) {
-			if (has_handoff || (wstate != WRITER_HANDOFF))
+			if (has_handoff || !(first && timo))
 				return false;
 
 			new |= RWSEM_FLAG_HANDOFF;
@@ -707,6 +703,8 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 			break;
 		}
 
+		// XXX also terminate on signal_pending_state(current->__state, current) ?
+
 		cpu_relax();
 	}
 
@@ -1019,11 +1017,10 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 static struct rw_semaphore *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
-	long count;
-	enum writer_wait_state wstate;
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
+	long count, flags = 0;
 
 	/* do optimistic spinning and steal lock if possible */
 	if (rwsem_can_spin_on_owner(sem) && rwsem_optimistic_spin(sem)) {
@@ -1041,13 +1038,10 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 
 	raw_spin_lock_irq(&sem->wait_lock);
 
-	/* account for this before adding a new element to the list */
-	wstate = list_empty(&sem->wait_list) ? WRITER_FIRST : WRITER_NOT_FIRST;
-
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we're now waiting on the lock */
-	if (wstate == WRITER_NOT_FIRST) {
+	if (rwsem_first_waiter(sem) != &waiter) {
 		count = atomic_long_read(&sem->count);
 
 		/*
@@ -1083,22 +1077,14 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
 	for (;;) {
-		if (rwsem_try_write_lock(sem, wstate)) {
+		if (rwsem_try_write_lock(sem, &waiter)) {
 			/* rwsem_try_write_lock() implies ACQUIRE on success */
 			break;
 		}
 
 		raw_spin_unlock_irq(&sem->wait_lock);
 
-		/*
-		 * After setting the handoff bit and failing to acquire
-		 * the lock, attempt to spin on owner to accelerate lock
-		 * transfer. If the previous owner is a on-cpu writer and it
-		 * has just released the lock, OWNER_NULL will be returned.
-		 * In this case, we attempt to acquire the lock again
-		 * without sleeping.
-		 */
-		if (wstate == WRITER_HANDOFF) {
+		if (rwsem_first_waiter(sem) == &waiter) {
 			enum owner_state owner_state;
 
 			preempt_disable();
@@ -1117,28 +1103,15 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 			schedule();
 			lockevent_inc(rwsem_sleep_writer);
 			set_current_state(state);
-			/*
-			 * If HANDOFF bit is set, unconditionally do
-			 * a trylock.
-			 */
-			if (wstate == WRITER_HANDOFF)
-				break;
 
-			if ((wstate == WRITER_NOT_FIRST) &&
-			    (rwsem_first_waiter(sem) == &waiter))
-				wstate = WRITER_FIRST;
+			if (rwsem_first_waiter(sem) != &waiter)
+				continue;
 
 			count = atomic_long_read(&sem->count);
 			if (!(count & RWSEM_LOCK_MASK))
 				break;
 
-			/*
-			 * The setting of the handoff bit is deferred
-			 * until rwsem_try_write_lock() is called.
-			 */
-			if ((wstate == WRITER_FIRST) && (rt_task(current) ||
-			    time_after(jiffies, waiter.timeout))) {
-				wstate = WRITER_HANDOFF;
+			if (rt_task(current) || time_after(jiffies, waiter.timeout)) {
 				lockevent_inc(rwsem_wlock_handoff);
 				break;
 			}
@@ -1156,15 +1129,21 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 out_nolock:
 	__set_current_state(TASK_RUNNING);
 	raw_spin_lock_irq(&sem->wait_lock);
-	list_del(&waiter.list);
 
-	if (unlikely(wstate == WRITER_HANDOFF))
-		atomic_long_add(-RWSEM_FLAG_HANDOFF,  &sem->count);
+	if (rwsem_first_waiter(sem) == &waiter)
+		flags |= RWSEM_FLAG_HANDOFF;
+
+	list_del(&waiter.list);
 
 	if (list_empty(&sem->wait_list))
-		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
-	else
+		flags |= RWSEM_FLAG_WAITERS | RWSEM_FLAG_HANDOFF;
+
+	if (flags)
+		atomic_long_andnot(flags, &sem->count);
+
+	if (!list_empty(&sem->wait_list))
 		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
+
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
 	lockevent_inc(rwsem_wlock_fail);
