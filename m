Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3683FED45
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 13:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343985AbhIBL4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 07:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343940AbhIBL4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 07:56:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B271DC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 04:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3OEWNGsQK3O9uYcAmIpyIF+r20b4fZUMBAlU+pfNSuc=; b=A0LWcXorRin0EZpqAAItGK2jez
        RKDRX+4fQcyJT51pl7PGouIRBmsmkZ0E5xOOw91QTsDTPG2a2xzFRGpzxochZkUnVh0pgaVou4okA
        HFFtNtKQ2MW2F8/6phLHyhIA+5bEFz9DsrXH/nQ4/ckmcUfMPcS+jjHeWg4U5jm0i57TcrNq7vek5
        Pv5OiIs/+fr2sTXVOkXk0JiSswslRLBtWxukxQXwQg3fuzva8UWw4NOA4txjIJ5NqAuV4CjIK3Gwp
        e9jEuBhMIPYZgKFqlEjFIF3H6qHku9c872Erc3/gfvc/vZp3x8kN/Apq8oB8az8WjFeya6NMU5hey
        8KiZmomA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLlJZ-00077U-F2; Thu, 02 Sep 2021 11:55:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E5F2730029F;
        Thu,  2 Sep 2021 13:55:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDFCA2BC015B6; Thu,  2 Sep 2021 13:55:29 +0200 (CEST)
Date:   Thu, 2 Sep 2021 13:55:29 +0200
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
Message-ID: <YTC7sariSyBW48nh@hirez.programming.kicks-ass.net>
References: <20210901150627.620830-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901150627.620830-1-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 11:06:27PM +0800, Boqun Feng wrote:

> Sorry I'm late for the party of PREEMPT_RT lock review. Just want to
> point the problem with this patch. Not even compile test, but show the
> idea and check if I'm missing something subtle.

No worries, glad you could have a look. I think you're right and we
missed this.

> diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
> index 4ba15088e640..a1886fd8bde6 100644
> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -41,6 +41,12 @@
>   * The risk of writer starvation is there, but the pathological use cases
>   * which trigger it are not necessarily the typical RT workloads.
>   *
> + * Fast-path orderings:
> + * The lock/unlock of readers can run in fast paths: lock and unlock are only
> + * atomic ops, and there is no inner lock to provide ACQUIRE and RELEASE
> + * semantics of rwbase_rt. Atomic ops then should be stronger than _acquire()
> + * and _release() to provide necessary ordering guarantee.
> + *
>   * Common code shared between RT rw_semaphore and rwlock
>   */
>  
> @@ -53,6 +59,7 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
>  	 * set.
>  	 */
>  	for (r = atomic_read(&rwb->readers); r < 0;) {
> +		/* Fully-ordered if cmpxchg() succeeds, provides ACQUIRE */
>  		if (likely(atomic_try_cmpxchg(&rwb->readers, &r, r + 1)))
>  			return 1;
>  	}
> @@ -162,6 +169,8 @@ static __always_inline void rwbase_read_unlock(struct rwbase_rt *rwb,
>  	/*
>  	 * rwb->readers can only hit 0 when a writer is waiting for the
>  	 * active readers to leave the critical section.
> +	 *
> +	 * dec_and_test() is fully ordered, provides RELEASE.
>  	 */
>  	if (unlikely(atomic_dec_and_test(&rwb->readers)))
>  		__rwbase_read_unlock(rwb, state);
> @@ -172,7 +181,11 @@ static inline void __rwbase_write_unlock(struct rwbase_rt *rwb, int bias,
>  {
>  	struct rt_mutex_base *rtm = &rwb->rtmutex;
>  
> -	atomic_add(READER_BIAS - bias, &rwb->readers);
> +	/*
> +	 * _release() is needed in case that reader is in fast path, pairing
> +	 * with atomic_try_cmpxchg() in rwbase_read_trylock(), provides RELEASE
> +	 */
> +	(void)atomic_add_return_release(READER_BIAS - bias, &rwb->readers);

Very narrow race with the unlock below, but yes agreed.

>  	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
>  	rwbase_rtmutex_unlock(rtm);
>  }
> @@ -216,8 +229,14 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
>  	 */
>  	rwbase_set_and_save_current_state(state);
>  
> -	/* Block until all readers have left the critical section. */
> -	for (; atomic_read(&rwb->readers);) {
> +	/*
> +	 * Block until all readers have left the critical section.
> +	 *
> +	 * _acqurie() is needed in case that the reader side runs in the fast
> +	 * path, pairing with the atomic_dec_and_test() in rwbase_read_unlock(),
> +	 * provides ACQUIRE.
> +	 */
> +	for (; atomic_read_acquire(&rwb->readers);) {
>  		/* Optimized out for rwlocks */
>  		if (rwbase_signal_pending_state(state, current)) {
>  			__set_current_state(TASK_RUNNING);

I think we can restructure things to avoid this one, but yes. Suppose we
do:

	readers = atomic_sub_return_relaxed(READER_BIAS, &rwb->readers);

	/*
	 * These two provide either an smp_mb() or an UNLOCK+LOCK
	 * ordering, either is strong enough to provide ACQUIRE order
	 * for the above load of @readers.
	 */
	rwbase_set_and_save_current_state(state);
	raw_spin_lock_irqsave(&rtm->wait_lock, flags);

	while (readers) {
		...
		readers = atomic_read(&rwb->readers);
		if (readers)
			rwbase_schedule();
		...
	}


> @@ -229,6 +248,9 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
>  		/*
>  		 * Schedule and wait for the readers to leave the critical
>  		 * section. The last reader leaving it wakes the waiter.
> +		 *
> +		 * _acquire() is not needed, because we can rely on the smp_mb()
> +		 * in set_current_state() to provide ACQUIRE.
>  		 */
>  		if (atomic_read(&rwb->readers) != 0)
>  			rwbase_schedule();
> @@ -253,7 +275,11 @@ static inline int rwbase_write_trylock(struct rwbase_rt *rwb)
>  	atomic_sub(READER_BIAS, &rwb->readers);
>  
>  	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> -	if (!atomic_read(&rwb->readers)) {
> +	/*
> +	 * _acquire() is needed in case reader is in the fast path, pairing with
> +	 * rwbase_read_unlock(), provides ACQUIRE.
> +	 */
> +	if (!atomic_read_acquire(&rwb->readers)) {

Moo; the alternative is using dec_and_lock instead of dec_and_test, but
that's not going to be worth it.

>  		atomic_set(&rwb->readers, WRITER_BIAS);
>  		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
>  		return 1;
> -- 
> 2.32.0
> 
