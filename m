Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22CE40392A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 13:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349314AbhIHLxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 07:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344680AbhIHLxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 07:53:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EB1C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 04:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wCq9JxIXk+f8Mj7BfQwV6pw8scS9BkoUzeH1Gy11Vmo=; b=Yb1kdeMsdvUH6RZMXhzDHO4MTm
        eyib46lPHa1b0dvK0PaioURQ8AYbGAKBgYLcfn5t9JfJb++YNyZk47/eTKJRjEd9PxUGgtKRNq0D4
        GyoDR8lQkcn9Ez7zJpHK7GkyffHvvQzmVvZz+VF6SgMmE6xmgSvLLynj3AT9wF7Q1hkty6njvy26+
        DmH8FoUyB4n1SRub4dhO6hf7wX/uzA9zC1KgLSeE0f29joau3DrS5+ivUHJ02/C8bBsKYGgOmOsMs
        gypwmf4X/TRljtd/lBx58tg4auiXaNjMALM9d6Y748Di3qPL/pefLgOHuNAGELZF5mCvEtg9dAiSy
        5uhlSguw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNw6w-008mMc-KL; Wed, 08 Sep 2021 11:51:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 06F2F300454;
        Wed,  8 Sep 2021 13:51:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E46FE2080015E; Wed,  8 Sep 2021 13:51:24 +0200 (CEST)
Date:   Wed, 8 Sep 2021 13:51:24 +0200
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
Message-ID: <YTijvI3BpBxkWcTd@hirez.programming.kicks-ass.net>
References: <20210901150627.620830-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901150627.620830-1-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 11:06:27PM +0800, Boqun Feng wrote:
> Readers of rwbase can lock and unlock without taking any inner lock, if
> that happens, we need the ordering provided by atomic operations to
> satisfy the ordering semantics of lock/unlock. Without that, considering
> the follow case:
> 
> 	{ X = 0 initially }
> 
> 	CPU 0			CPU 1
> 	=====			=====
> 				rt_write_lock();
> 				X = 1
> 				rt_write_unlock():
> 				  atomic_add(READER_BIAS - WRITER_BIAS, ->readers);
> 				  // ->readers is READER_BIAS.
> 	rt_read_lock():
> 	  if ((r = atomic_read(->readers)) < 0) // True
> 	    atomic_try_cmpxchg(->readers, r, r + 1); // succeed.
> 	  <acquire the read lock via fast path>
> 
> 	r1 = X;	// r1 may be 0, because nothing prevent the reordering
> 	        // of "X=1" and atomic_add() on CPU 1.
> 
> Therefore audit every usage of atomic operations that may happen in a
> fast path, and add necessary barriers.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---

Does this work for you?

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 4ba15088e640..4685d3780683 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -53,6 +53,7 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
 	 * set.
 	 */
 	for (r = atomic_read(&rwb->readers); r < 0;) {
+		/* Fully ordered on success, provides ACQUIRE */
 		if (likely(atomic_try_cmpxchg(&rwb->readers, &r, r + 1)))
 			return 1;
 	}
@@ -162,6 +163,8 @@ static __always_inline void rwbase_read_unlock(struct rwbase_rt *rwb,
 	/*
 	 * rwb->readers can only hit 0 when a writer is waiting for the
 	 * active readers to leave the critical section.
+	 *
+	 * Fully ordered, provides RELEASE.
 	 */
 	if (unlikely(atomic_dec_and_test(&rwb->readers)))
 		__rwbase_read_unlock(rwb, state);
@@ -172,7 +175,10 @@ static inline void __rwbase_write_unlock(struct rwbase_rt *rwb, int bias,
 {
 	struct rt_mutex_base *rtm = &rwb->rtmutex;
 
-	atomic_add(READER_BIAS - bias, &rwb->readers);
+	/*
+	 * Needs to provide RELEASE vs rwbase_read_trylock().
+	 */
+	(void)atomic_fetch_add_release(READER_BIAS - bias, &rwb->readers);
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 	rwbase_rtmutex_unlock(rtm);
 }
@@ -201,23 +207,30 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 {
 	struct rt_mutex_base *rtm = &rwb->rtmutex;
 	unsigned long flags;
+	int readers;
 
 	/* Take the rtmutex as a first step */
 	if (rwbase_rtmutex_lock_state(rtm, state))
 		return -EINTR;
 
 	/* Force readers into slow path */
-	atomic_sub(READER_BIAS, &rwb->readers);
+	readers = atomic_sub_return_relaxed(READER_BIAS, &rwb->readers);
 
-	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
 	/*
 	 * set_current_state() for rw_semaphore
 	 * current_save_and_set_rtlock_wait_state() for rwlock
 	 */
 	rwbase_set_and_save_current_state(state);
+	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
 
-	/* Block until all readers have left the critical section. */
-	for (; atomic_read(&rwb->readers);) {
+	/*
+	 * Block until all readers have left the critical section.
+	 *
+	 * In the case of !readers, the above implies TSO ordering
+	 * at the very least and hence provides ACQUIRE vs the earlier
+	 * atomic_sub_return_relaxed().
+	 */
+	while (readers) {
 		/* Optimized out for rwlocks */
 		if (rwbase_signal_pending_state(state, current)) {
 			__set_current_state(TASK_RUNNING);
@@ -230,8 +243,12 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 		 * Schedule and wait for the readers to leave the critical
 		 * section. The last reader leaving it wakes the waiter.
 		 */
-		if (atomic_read(&rwb->readers) != 0)
+		readers = atomic_read(&rwb->readers);
+		if (readers != 0)
 			rwbase_schedule();
+		/*
+		 * Implies smp_mb() and provides ACQUIRE for the !readers case.
+		 */
 		set_current_state(state);
 		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
 	}
@@ -253,7 +270,10 @@ static inline int rwbase_write_trylock(struct rwbase_rt *rwb)
 	atomic_sub(READER_BIAS, &rwb->readers);
 
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
-	if (!atomic_read(&rwb->readers)) {
+	/*
+	 * Needs ACQUIRE vs rwbase_read_unlock();
+	 */
+	if (!atomic_read_acquire(&rwb->readers)) {
 		atomic_set(&rwb->readers, WRITER_BIAS);
 		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 		return 1;
