Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13DC40A880
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbhINHsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:48:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59940 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbhINHrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:47:42 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631605584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RODgxM1oU90CmdbKuTWL+EhjJcDY6wMezAJIZcOV/MQ=;
        b=geIynRIPqfJ784NBiO/mqojwo/HXdqLWTpqjZb674wmQeBGba78/vTwHzzSg2BNPXOoFm9
        oBpO+Az3oJXu36q4tvjzVoLKM9H2MOEVRsFviDUmD+cuFrXKxx7Tyu3ZyPAd3TW0Hi3sNo
        1g80k8zU7y8aURM2+3G3QYB3RYk42G9+wQ0EjHc0T3Z9Q+tPnkdEb27AAIgWBsbWVA5yW2
        upySnOnaYpdEvLIlzIMm0Cijm9uf995C/2X29pBJTjIRGzD+/63d8VOXUnffkTnwAO4H+S
        OxxAqmybCRiSZDeQ/qqmTNeu6z05TQoCPEGPwGBmPg9k38F2PedqRvV43ZZpNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631605584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RODgxM1oU90CmdbKuTWL+EhjJcDY6wMezAJIZcOV/MQ=;
        b=PDLoaFG4mFxi4pKyRkTVEmCkBzyv0zGChHDZ7jp8F6LeUyIidJ93CLeP+7d21jibNv1gZw
        qQy3ef0T/yvNnxBw==
To:     Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 4/4] locking/rwbase: Take care of ordering guarantee for
 fastpath reader
In-Reply-To: <20210909110203.953991276@infradead.org>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.953991276@infradead.org>
Date:   Tue, 14 Sep 2021 09:46:23 +0200
Message-ID: <87h7eneh0w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09 2021 at 12:59, Peter Zijlstra wrote:
> From: Boqun Feng <boqun.feng@gmail.com>
>
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
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/locking/rwbase_rt.c |   21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -41,6 +41,12 @@
>   * The risk of writer starvation is there, but the pathological use cases
>   * which trigger it are not necessarily the typical RT workloads.
>   *
> + * Fast-path orderings:
> + * The lock/unlock of readers can run in fast paths: lock and unlock are only
> + * atomic ops, and there is no inner lock to provide ACQUIRE and RELEASE
> + * semantics of rwbase_rt. Atomic ops should thus provide _acquire()
> + * and _release() (or stronger).
> + *
>   * Common code shared between RT rw_semaphore and rwlock
>   */
>  
> @@ -53,6 +59,7 @@ static __always_inline int rwbase_read_t
>  	 * set.
>  	 */
>  	for (r = atomic_read(&rwb->readers); r < 0;) {
> +		/* Fully-ordered if cmpxchg() succeeds, provides ACQUIRE */
>  		if (likely(atomic_try_cmpxchg(&rwb->readers, &r, r + 1)))
>  			return 1;
>  	}
> @@ -162,6 +169,8 @@ static __always_inline void rwbase_read_
>  	/*
>  	 * rwb->readers can only hit 0 when a writer is waiting for the
>  	 * active readers to leave the critical section.
> +	 *
> +	 * dec_and_test() is fully ordered, provides RELEASE.
>  	 */
>  	if (unlikely(atomic_dec_and_test(&rwb->readers)))
>  		__rwbase_read_unlock(rwb, state);
> @@ -172,7 +181,11 @@ static inline void __rwbase_write_unlock
>  {
>  	struct rt_mutex_base *rtm = &rwb->rtmutex;
>  
> -	atomic_add(READER_BIAS - bias, &rwb->readers);
> +	/*
> +	 * _release() is needed in case that reader is in fast path, pairing
> +	 * with atomic_try_cmpxchg() in rwbase_read_trylock(), provides RELEASE
> +	 */
> +	(void)atomic_add_return_release(READER_BIAS - bias, &rwb->readers);
>  	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
>  	rwbase_rtmutex_unlock(rtm);
>  }
> @@ -201,7 +214,11 @@ static inline bool __rwbase_write_tryloc
>  	/* Can do without CAS because we're serialized by wait_lock. */
>  	lockdep_assert_held(&rwb->rtmutex.wait_lock);
>  
> -	if (!atomic_read(&rwb->readers)) {
> + 	/*
> +	 * _acquire is needed in case the reader is in the fast path, pairing
> +	 * with rwbase_read_unlock(), provides ACQUIRE.
> +	 */
> +	if (!atomic_read_acquire(&rwb->readers)) {
>  		atomic_set(&rwb->readers, WRITER_BIAS);
>  		return 1;
>  	}

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
