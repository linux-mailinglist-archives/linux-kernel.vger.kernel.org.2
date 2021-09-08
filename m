Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B52D403BB2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351943AbhIHOnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 10:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351932AbhIHOno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:43:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600E3C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=umPny3Ok0/zsN6Nvy2jYnqoJuWfVc2FWJg6UAYNRrPo=; b=g9hpn+iFXn8HwbSWpCypvYf4wO
        1OHpv4WsFFJrsS1z1BZt93Qbhu7Y46ZHNVfA57Qecf/dV7wT+gvVdoIIUbudm5pjs/J7xNik9h3KI
        kC3iwxIxC5UaiPy4yqbWXtfb/eMZ25YuNcPAISo/S5VvHw/iZIO5zf4N23ddON+uo1+RQ/t4t6vDH
        Hw0YOuyH48E0d6SVhi/JrP2ZYt6UgaDoqNMhmoDzqMUJaJhAJOMvlnm2PXpxaVg4AHg+34rx5M7jo
        sP7K+2hb2bOLDMb8J24soE8jCev6aWo3J0JBddyqmm15vV7bqOl6Wy/klEp62OGL2VgO1nspqGYK2
        39yMtz0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNylD-008tSZ-Bf; Wed, 08 Sep 2021 14:41:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5BA43300454;
        Wed,  8 Sep 2021 16:41:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36FD3201736A5; Wed,  8 Sep 2021 16:41:10 +0200 (CEST)
Date:   Wed, 8 Sep 2021 16:41:10 +0200
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
Message-ID: <YTjLhnvDxwkE9Kky@hirez.programming.kicks-ass.net>
References: <20210901150627.620830-1-boqun.feng@gmail.com>
 <YTijvI3BpBxkWcTd@hirez.programming.kicks-ass.net>
 <YTi15PNcExiJRZoa@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTi15PNcExiJRZoa@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 09:08:52PM +0800, Boqun Feng wrote:
> On Wed, Sep 08, 2021 at 01:51:24PM +0200, Peter Zijlstra wrote:
> [...]
> > @@ -201,23 +207,30 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
> >  {
> >  	struct rt_mutex_base *rtm = &rwb->rtmutex;
> >  	unsigned long flags;
> > +	int readers;
> >  
> >  	/* Take the rtmutex as a first step */
> >  	if (rwbase_rtmutex_lock_state(rtm, state))
> >  		return -EINTR;
> >  
> >  	/* Force readers into slow path */
> > -	atomic_sub(READER_BIAS, &rwb->readers);
> > +	readers = atomic_sub_return_relaxed(READER_BIAS, &rwb->readers);
> >  
> > -	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> >  	/*
> >  	 * set_current_state() for rw_semaphore
> >  	 * current_save_and_set_rtlock_wait_state() for rwlock
> >  	 */
> >  	rwbase_set_and_save_current_state(state);
> 
> rwbase_set_and_save_current_state() may eventually call
> current_save_and_set_rtlock_wait_state(), which requires being called
> with irq-off, while rwbase_write_lock() may be called with irq-on. I
> guess we can change the raw_spin_lock() to raw_spin_lock_irqsave() in
> current_save_and_set_rtlock_wait_state() to solve this.

Oh right... that's actually something I pointed out to Thomas during
review, and I suppose we both forgot about it, or figured it didn't
matter enough.

Oooh, Thomas added that lockdep_assert.. still lemme change that to
match set_special_state().

Also,...

---
Subject: sched/wakeup: Strengthen current_save_and_set_rtlock_wait_state()

While looking at current_save_and_set_rtlock_wait_state() I'm thinking
it really ought to use smp_store_mb(), because something like:

	current_save_and_set_rtlock_wait_state();
	for (;;) {
		if (try_lock())
			break;
		raw_spin_unlock_irq(&lock->wait_lock);
		if (!cond)
			schedule();
		raw_spin_lock_irq(&lock->wait_lock);
		set_current_state(TASK_RTLOCK_WAIT);
	}
	current_restore_rtlock_saved_state();

which is very close to the advertised usage in the comment, is actually
broken I think:

 - try_lock() doesn't need to provide any ordering on failure;
 - raw_spin_unlock() only needs to provide RELEASE ordering;

which gives that the above turns into something like:

	WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);
	raw_spin_unlock(&current->pi_lock);
	raw_spin_unlock(&lock->wait_lock);
	if (!cond)

and the load of @cond is then allowed to speculate right before the
__state store, and we've got a missed wakeup -> BAD(tm).

Fixes: 5f220be21418 ("sched/wakeup: Prepare for RT sleeping spin/rwlocks")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1780260f237b..3d3246d7e87d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -245,7 +245,8 @@ struct task_group;
  *		if (try_lock())
  *			break;
  *		raw_spin_unlock_irq(&lock->wait_lock);
- *		schedule_rtlock();
+ *		if (!cond)
+ *			schedule_rtlock();
  *		raw_spin_lock_irq(&lock->wait_lock);
  *		set_current_state(TASK_RTLOCK_WAIT);
  *	}
@@ -253,22 +254,24 @@ struct task_group;
  */
 #define current_save_and_set_rtlock_wait_state()			\
 	do {								\
-		lockdep_assert_irqs_disabled();				\
-		raw_spin_lock(&current->pi_lock);			\
+		unsigned long flags; /* may shadow */			\
+									\
+		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
 		current->saved_state = current->__state;		\
 		debug_rtlock_wait_set_state();				\
-		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
-		raw_spin_unlock(&current->pi_lock);			\
+		smp_store_mb(current->__state, TASK_RTLOCK_WAIT);	\
+		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0);
 
 #define current_restore_rtlock_saved_state()				\
 	do {								\
-		lockdep_assert_irqs_disabled();				\
-		raw_spin_lock(&current->pi_lock);			\
+		unsigned long flags; /* may shadow */			\
+									\
+		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
 		debug_rtlock_wait_restore_state();			\
 		WRITE_ONCE(current->__state, current->saved_state);	\
 		current->saved_state = TASK_RUNNING;			\
-		raw_spin_unlock(&current->pi_lock);			\
+		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0);
 
 #define get_current_state()	READ_ONCE(current->__state)
