Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCB0403BC5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349458AbhIHOvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 10:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349385AbhIHOvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:51:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F27C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LgpvfypdVLL0GX2yopkhXW9gmCnuLEbTmbgtObGA9kc=; b=Kvs5HNufdENmKCbLdgl5s7A+Cd
        HkLG1057zQIzo6Un5fazd7uwT2eCMPKOCANzyN1TZ6zrpMBB3E6LrBpm+Lr5PXBd1DCkF/NVvAoxr
        NDS+EglGdsT1XKFLAaT+rLIAtbI5hpdlmJGp2/5pcFWS5vHAFQzEnanBJa2Nuwl14vbsxZcqnvgu2
        +H7uV4bH36PqpzqONERz6T4pEdXGSeVtNfgJGmhjueNguMMmu2gnjrRTt0JZXEGVtkzD6dopfiKol
        WuGM/+DmGo6l3ODqvnj/0uwxK+UzgwUA24Mi9K76Gkc1UqUink3V+ViKaRxf1wGoHpxL9JrVPotBs
        x/UuzzVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNyt8-008tlK-10; Wed, 08 Sep 2021 14:49:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 153EB300314;
        Wed,  8 Sep 2021 16:49:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF6DC201736BC; Wed,  8 Sep 2021 16:49:20 +0200 (CEST)
Date:   Wed, 8 Sep 2021 16:49:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] locking: rwbase: Take care of ordering guarantee for
 fastpath reader
Message-ID: <YTjNcD7nyLiChTIJ@hirez.programming.kicks-ass.net>
References: <20210901150627.620830-1-boqun.feng@gmail.com>
 <YTijvI3BpBxkWcTd@hirez.programming.kicks-ass.net>
 <YTi15PNcExiJRZoa@boqun-archlinux>
 <YTjLhnvDxwkE9Kky@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTjLhnvDxwkE9Kky@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 04:41:10PM +0200, Peter Zijlstra wrote:

> Subject: sched/wakeup: Strengthen current_save_and_set_rtlock_wait_state()
> 
> While looking at current_save_and_set_rtlock_wait_state() I'm thinking
> it really ought to use smp_store_mb(), because something like:
> 
> 	current_save_and_set_rtlock_wait_state();
> 	for (;;) {
> 		if (try_lock())
> 			break;
> 		raw_spin_unlock_irq(&lock->wait_lock);
> 		if (!cond)
> 			schedule();
> 		raw_spin_lock_irq(&lock->wait_lock);
> 		set_current_state(TASK_RTLOCK_WAIT);
> 	}
> 	current_restore_rtlock_saved_state();
> 
> which is very close to the advertised usage in the comment, is actually
> broken I think:
> 
>  - try_lock() doesn't need to provide any ordering on failure;
>  - raw_spin_unlock() only needs to provide RELEASE ordering;
> 
> which gives that the above turns into something like:
> 
> 	WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);
> 	raw_spin_unlock(&current->pi_lock);
> 	raw_spin_unlock(&lock->wait_lock);
> 	if (!cond)
> 
> and the load of @cond is then allowed to speculate right before the
> __state store, and we've got a missed wakeup -> BAD(tm).
> 
> Fixes: 5f220be21418 ("sched/wakeup: Prepare for RT sleeping spin/rwlocks")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

On top of which we can do your patch like.

---
Subject: lockin/rwbase: Take care of ordering guarantee for fastpath reader
From: Boqun Feng <boqun.feng@gmail.com>
Date: Wed, 1 Sep 2021 23:06:27 +0800

From: Boqun Feng <boqun.feng@gmail.com>

Readers of rwbase can lock and unlock without taking any inner lock, if
that happens, we need the ordering provided by atomic operations to
satisfy the ordering semantics of lock/unlock. Without that, considering
the follow case:

	{ X = 0 initially }

	CPU 0			CPU 1
	=====			=====
				rt_write_lock();
				X = 1
				rt_write_unlock():
				  atomic_add(READER_BIAS - WRITER_BIAS, ->readers);
				  // ->readers is READER_BIAS.
	rt_read_lock():
	  if ((r = atomic_read(->readers)) < 0) // True
	    atomic_try_cmpxchg(->readers, r, r + 1); // succeed.
	  <acquire the read lock via fast path>

	r1 = X;	// r1 may be 0, because nothing prevent the reordering
	        // of "X=1" and atomic_add() on CPU 1.

Therefore audit every usage of atomic operations that may happen in a
fast path, and add necessary barriers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210901150627.620830-1-boqun.feng@gmail.com
---
 kernel/locking/rwbase_rt.c |   41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -41,6 +41,12 @@
  * The risk of writer starvation is there, but the pathological use cases
  * which trigger it are not necessarily the typical RT workloads.
  *
+ * Fast-path orderings:
+ * The lock/unlock of readers can run in fast paths: lock and unlock are only
+ * atomic ops, and there is no inner lock to provide ACQUIRE and RELEASE
+ * semantics of rwbase_rt. Atomic ops then should be stronger than _acquire()
+ * and _release() to provide necessary ordering guarantee.
+ *
  * Common code shared between RT rw_semaphore and rwlock
  */
 
@@ -53,6 +59,7 @@ static __always_inline int rwbase_read_t
 	 * set.
 	 */
 	for (r = atomic_read(&rwb->readers); r < 0;) {
+		/* Fully-ordered if cmpxchg() succeeds, provides ACQUIRE */
 		if (likely(atomic_try_cmpxchg(&rwb->readers, &r, r + 1)))
 			return 1;
 	}
@@ -162,6 +169,8 @@ static __always_inline void rwbase_read_
 	/*
 	 * rwb->readers can only hit 0 when a writer is waiting for the
 	 * active readers to leave the critical section.
+	 *
+	 * dec_and_test() is fully ordered, provides RELEASE.
 	 */
 	if (unlikely(atomic_dec_and_test(&rwb->readers)))
 		__rwbase_read_unlock(rwb, state);
@@ -172,7 +181,11 @@ static inline void __rwbase_write_unlock
 {
 	struct rt_mutex_base *rtm = &rwb->rtmutex;
 
-	atomic_add(READER_BIAS - bias, &rwb->readers);
+	/*
+	 * _release() is needed in case that reader is in fast path, pairing
+	 * with atomic_try_cmpxchg() in rwbase_read_trylock(), provides RELEASE
+	 */
+	(void)atomic_add_return_release(READER_BIAS - bias, &rwb->readers);
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 	rwbase_rtmutex_unlock(rtm);
 }
@@ -201,6 +214,7 @@ static int __sched rwbase_write_lock(str
 {
 	struct rt_mutex_base *rtm = &rwb->rtmutex;
 	unsigned long flags;
+	int readers;
 
 	/* Take the rtmutex as a first step */
 	if (rwbase_rtmutex_lock_state(rtm, state))
@@ -210,14 +224,23 @@ static int __sched rwbase_write_lock(str
 	atomic_sub(READER_BIAS, &rwb->readers);
 
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+
+	/* The below set_*_state() thingy implies smp_mb() to provide ACQUIRE */
+	readers = atomic_read(&rwb->readers);
 	/*
 	 * set_current_state() for rw_semaphore
 	 * current_save_and_set_rtlock_wait_state() for rwlock
 	 */
 	rwbase_set_and_save_current_state(state);
 
-	/* Block until all readers have left the critical section. */
-	for (; atomic_read(&rwb->readers);) {
+	/*
+	 * Block until all readers have left the critical section.
+	 *
+	 * _acqurie() is needed in case that the reader side runs in the fast
+	 * path, pairing with the atomic_dec_and_test() in rwbase_read_unlock(),
+	 * provides ACQUIRE.
+	 */
+	while (readers) {
 		/* Optimized out for rwlocks */
 		if (rwbase_signal_pending_state(state, current)) {
 			__set_current_state(TASK_RUNNING);
@@ -229,8 +252,12 @@ static int __sched rwbase_write_lock(str
 		/*
 		 * Schedule and wait for the readers to leave the critical
 		 * section. The last reader leaving it wakes the waiter.
+		 *
+		 * _acquire() is not needed, because we can rely on the smp_mb()
+		 * in set_current_state() to provide ACQUIRE.
 		 */
-		if (atomic_read(&rwb->readers) != 0)
+		readers = atomic_read(&rwb->readers);
+		if (readers)
 			rwbase_schedule();
 		set_current_state(state);
 		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
@@ -253,7 +280,11 @@ static inline int rwbase_write_trylock(s
 	atomic_sub(READER_BIAS, &rwb->readers);
 
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
-	if (!atomic_read(&rwb->readers)) {
+	/*
+	 * _acquire() is needed in case reader is in the fast path, pairing with
+	 * rwbase_read_unlock(), provides ACQUIRE.
+	 */
+	if (!atomic_read_acquire(&rwb->readers)) {
 		atomic_set(&rwb->readers, WRITER_BIAS);
 		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 		return 1;
