Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FA644DC7C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 21:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhKKU3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 15:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhKKU3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 15:29:51 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F67C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 12:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=57M32KCr99mfqpQx+P/wOq1PJ9H4ReEA+yThcJaPntg=; b=UupfG5T+N5guGMgZjUvnSNv3Sr
        rGNYsXwDTD5kc156+qnZyp3KiJHCNU5YtS/AhUXT8QOgJ40yVkFlYB+/SZcl6z6ygdhr1bfxPMjK2
        1JPY5bzwRjsc+AZ3ha/u/o2oGZ+BN5fBj7eIxpZvnvruZHsioD+EaaumqRGepSCEbYkhrHoXbyLGd
        AhihOybcBRo+O7cmXUy2QpAMEGCsKerXCaxVkZuAGO7Qxe2cdlwBemPoscBEzQO3c1WXpjGJ+Ihc+
        o+ttk7Bk8X2dmZErnJoU1+RXMkkxVaC7ipnXKCo/k1XARZSiYlCRdIRjj+l9WWqgDteyHvdNwu+o9
        sGKDLPKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlGem-00FWPZ-K1; Thu, 11 Nov 2021 20:26:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC773986981; Thu, 11 Nov 2021 21:26:47 +0100 (CET)
Date:   Thu, 11 Nov 2021 21:26:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        =?utf-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Message-ID: <20211111202647.GH174703@worktop.programming.kicks-ass.net>
References: <4fafad133b074f279dbab1aa3642e23f@xiaomi.com>
 <20211107090131.1535-1-hdanton@sina.com>
 <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
 <02e118c0-2116-b806-2b48-b9c91dc847dd@redhat.com>
 <20211110213854.GE174703@worktop.programming.kicks-ass.net>
 <YY0x55wxO2v5HCOW@hirez.programming.kicks-ass.net>
 <61735528-141c-8d77-592d-b6b8fb75ebaa@redhat.com>
 <YY1s6v9b/tYtNnGv@hirez.programming.kicks-ass.net>
 <e16f9fc2-ce01-192b-065d-460c2ad9b317@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e16f9fc2-ce01-192b-065d-460c2ad9b317@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 02:36:52PM -0500, Waiman Long wrote:

> @@ -434,6 +430,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>  			if (!(oldcount & RWSEM_FLAG_HANDOFF) &&
>  			    time_after(jiffies, waiter->timeout)) {
>  				adjustment -= RWSEM_FLAG_HANDOFF;
> +				waiter->handoff_set = true;
>  				lockevent_inc(rwsem_rlock_handoff);
>  			}
>  

Do we really need this flag? Wouldn't it be the same as waiter-is-first
AND sem-has-handoff ?

>  static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
> +					struct rwsem_waiter *waiter)
>  {
>  	long count, new;
> +	bool first = rwsem_first_waiter(sem) == waiter;

flip those lines for reverse xmas please

>  
>  	lockdep_assert_held(&sem->wait_lock);
>  
> @@ -546,13 +541,14 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>  	do {
>  		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>  
> -		if (has_handoff && wstate == WRITER_NOT_FIRST)
> +		if (has_handoff && !first)
>  			return false;
>  
>  		new = count;
>  
>  		if (count & RWSEM_LOCK_MASK) {
> -			if (has_handoff || (wstate != WRITER_HANDOFF))
> +			if (has_handoff || (!waiter->rt_task &&
> +					    !time_after(jiffies, waiter->timeout)))


Does ->rt_task really help over rt_task(current) ? I suppose there's an
argument for locality, but that should be pretty much it, no?

>  				return false;
>  
>  			new |= RWSEM_FLAG_HANDOFF;
> @@ -889,6 +888,24 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
>  }
>  #endif
>  
> +/*
> + * Common code to handle rwsem flags in out_nolock path with wait_lock held.
> + */
> +static inline void rwsem_out_nolock_clear_flags(struct rw_semaphore *sem,
> +						struct rwsem_waiter *waiter)
> +{
> +	long flags = 0;
> +
> +	list_del(&waiter->list);
> +	if (list_empty(&sem->wait_list))
> +		flags = RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS;
> +	else if (waiter->handoff_set)
> +		flags = RWSEM_FLAG_HANDOFF;
> +
> +	if (flags)
> +		atomic_long_andnot(flags,  &sem->count);
> +}

Right, so I like sharing this between the two _slowpath functions, that
makes sense.

The difference between this and my approach is that I unconditionally
clear HANDOFF when @waiter was the first. Because if it was set, it
must've been ours, and if it wasn't set, clearing it doesn't really hurt
much. This is an unlikely path, I don't think the potentially extra
atomic is an issue here.

> +
>  /*
>   * Wait for the read lock to be granted
>   */
> @@ -936,6 +953,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>  	waiter.task = current;
>  	waiter.type = RWSEM_WAITING_FOR_READ;
>  	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
> +	waiter.handoff_set = false;

Forgot to set rt_task

>  
>  	raw_spin_lock_irq(&sem->wait_lock);
>  	if (list_empty(&sem->wait_list)) {

> @@ -1038,16 +1051,13 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  	waiter.task = current;
>  	waiter.type = RWSEM_WAITING_FOR_WRITE;
>  	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;

Forget to set handoff_set

> +	waiter.rt_task = rt_task(current);
>  
>  	raw_spin_lock_irq(&sem->wait_lock);

Again, I'm not convinced we need these variables.

> @@ -1083,13 +1093,16 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  	/* wait until we successfully acquire the lock */
>  	set_current_state(state);
>  	for (;;) {
> -		if (rwsem_try_write_lock(sem, wstate)) {
> +		if (rwsem_try_write_lock(sem, &waiter)) {
>  			/* rwsem_try_write_lock() implies ACQUIRE on success */
>  			break;
>  		}
>  
>  		raw_spin_unlock_irq(&sem->wait_lock);
>  
> +		if (signal_pending_state(state, current))
> +			goto out_nolock;
> +
>  		/*
>  		 * After setting the handoff bit and failing to acquire
>  		 * the lock, attempt to spin on owner to accelerate lock
> @@ -1098,7 +1111,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  		 * In this case, we attempt to acquire the lock again
>  		 * without sleeping.
>  		 */
> -		if (wstate == WRITER_HANDOFF) {
> +		if (waiter.handoff_set) {
>  			enum owner_state owner_state;
>  
>  			preempt_disable();

Does it matter much if we spin-wait for every first or only for handoff?

Either way around, I think spin-wait ought to terminate on sigpending
(same for mutex I suppose).

> @@ -1109,40 +1122,9 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  				goto trylock_again;
>  		}
>  
> -		/* Block until there are no active lockers. */
> -		for (;;) {
> -			if (signal_pending_state(state, current))
> -				goto out_nolock;
> -
> -			schedule();
> -			lockevent_inc(rwsem_sleep_writer);
> -			set_current_state(state);
> -			/*
> -			 * If HANDOFF bit is set, unconditionally do
> -			 * a trylock.
> -			 */
> -			if (wstate == WRITER_HANDOFF)
> -				break;
> -
> -			if ((wstate == WRITER_NOT_FIRST) &&
> -			    (rwsem_first_waiter(sem) == &waiter))
> -				wstate = WRITER_FIRST;
> -
> -			count = atomic_long_read(&sem->count);
> -			if (!(count & RWSEM_LOCK_MASK))
> -				break;
> -
> -			/*
> -			 * The setting of the handoff bit is deferred
> -			 * until rwsem_try_write_lock() is called.
> -			 */
> -			if ((wstate == WRITER_FIRST) && (rt_task(current) ||
> -			    time_after(jiffies, waiter.timeout))) {
> -				wstate = WRITER_HANDOFF;
> -				lockevent_inc(rwsem_wlock_handoff);
> -				break;
> -			}
> -		}
> +		schedule();
> +		lockevent_inc(rwsem_sleep_writer);
> +		set_current_state(state);
>  trylock_again:
>  		raw_spin_lock_irq(&sem->wait_lock);
>  	}

Nice.
