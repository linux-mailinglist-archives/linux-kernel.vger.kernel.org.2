Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA04E452824
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 03:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbhKPC5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 21:57:41 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:4699 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhKPCzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 21:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637031170; x=1668567170;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CB8ERLokzWgcQ25ClSltrZAEv9+3Fm1ZTXOeytEpwIE=;
  b=fcdV86Y8MLC7X4R18Z1hAn1nZLntoNJ3KbTvgUV6Y/D9R6/ZfL7dGUg2
   +n2U5kN/N7OecEJUmdXk8NbY1HpYsD5CKGNEBkUXkVLiS28kHQ56ym0QD
   JbJjD84s45myDesnebQvlGhmKdVtxiiXELVfkoAx/5F2wewLVF8YdSw40
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 15 Nov 2021 18:52:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 18:52:47 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 15 Nov 2021 18:52:47 -0800
Received: from [10.239.96.187] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 15 Nov
 2021 18:52:45 -0800
Message-ID: <32b433a1-31f9-14ba-e8f6-87b69c2c4ac9@quicinc.com>
Date:   Tue, 16 Nov 2021 10:52:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        mazhenhua <mazhenhua@xiaomi.com>, Hillf Danton <hdanton@sina.com>
References: <20211116012912.723980-1-longman@redhat.com>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <20211116012912.723980-1-longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/2021 9:29 AM, Waiman Long wrote:
> There are some inconsistency in the way that the handoff bit is being
> handled in readers and writers.
> 
> Firstly, when a queue head writer set the handoff bit, it will clear it
> when the writer is being killed or interrupted on its way out without
> acquiring the lock. That is not the case for a queue head reader. The
> handoff bit will simply be inherited by the next waiter.
> 
> Secondly, in the out_nolock path of rwsem_down_read_slowpath(), both
> the waiter and handoff bits are cleared if the wait queue becomes empty.
> For rwsem_down_write_slowpath(), however, the handoff bit is not checked
> and cleared if the wait queue is empty. This can potentially make the
> handoff bit set with empty wait queue.
> 
> To make the handoff bit handling more consistent and robust, extract
> out handoff bit clearing code into the new rwsem_del_waiter() helper
> function.  The common function will only use atomic_long_andnot() to
> clear bits when the wait queue is empty to avoid possible race condition.
we do have race condition needed to be fixed with this change.
> If the first waiter with handoff bit set is killed or interrupted to
> exit the slowpath without acquiring the lock, the next waiter will
> inherit the handoff bit.
> 
> While at it, simplify the trylock for loop in rwsem_down_write_slowpath()
> to make it easier to read.
> 
> Fixes: 4f23dbc1e657 ("locking/rwsem: Implement lock handoff to prevent lock starvation")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/locking/rwsem.c | 171 ++++++++++++++++++++---------------------
>   1 file changed, 85 insertions(+), 86 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index c51387a43265..e039cf1605af 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -105,9 +105,9 @@
>    * atomic_long_cmpxchg() will be used to obtain writer lock.
>    *
>    * There are three places where the lock handoff bit may be set or cleared.
> - * 1) rwsem_mark_wake() for readers.
> - * 2) rwsem_try_write_lock() for writers.
> - * 3) Error path of rwsem_down_write_slowpath().
> + * 1) rwsem_mark_wake() for readers		-- set, clear
> + * 2) rwsem_try_write_lock() for writers	-- set, clear
> + * 3) rwsem_del_waiter()			-- clear
>    *
>    * For all the above cases, wait_lock will be held. A writer must also
>    * be the first one in the wait_list to be eligible for setting the handoff
> @@ -334,6 +334,9 @@ struct rwsem_waiter {
>   	struct task_struct *task;
>   	enum rwsem_waiter_type type;
>   	unsigned long timeout;
> +
> +	/* Writer only, not initialized in reader */
> +	bool handoff_set;
>   };
>   #define rwsem_first_waiter(sem) \
>   	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
> @@ -344,12 +347,6 @@ enum rwsem_wake_type {
>   	RWSEM_WAKE_READ_OWNED	/* Waker thread holds the read lock */
>   };
>   
> -enum writer_wait_state {
> -	WRITER_NOT_FIRST,	/* Writer is not first in wait list */
> -	WRITER_FIRST,		/* Writer is first in wait list     */
> -	WRITER_HANDOFF		/* Writer is first & handoff needed */
> -};
> -
>   /*
>    * The typical HZ value is either 250 or 1000. So set the minimum waiting
>    * time to at least 4ms or 1 jiffy (if it is higher than 4ms) in the wait
> @@ -365,6 +362,31 @@ enum writer_wait_state {
>    */
>   #define MAX_READERS_WAKEUP	0x100
>   
> +static inline void
> +rwsem_add_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
> +{
> +	lockdep_assert_held(&sem->wait_lock);
> +	list_add_tail(&waiter->list, &sem->wait_list);
> +	/* caller will set RWSEM_FLAG_WAITERS */
> +}
> +
> +/*
> + * Remove a waiter from the wait_list and clear flags.
> + *
> + * Both rwsem_mark_wake() and rwsem_try_write_lock() contain a full 'copy' of
> + * this function. Modify with care.
> + */
> +static inline void
> +rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
> +{
> +	lockdep_assert_held(&sem->wait_lock);
> +	list_del(&waiter->list);
> +	if (likely(!list_empty(&sem->wait_list)))
> +		return;
> +
> +	atomic_long_andnot(RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS, &sem->count);
> +}
> +
>   /*
>    * handle the lock release when processes blocked on it that can now run
>    * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
> @@ -376,6 +398,8 @@ enum writer_wait_state {
>    *   preferably when the wait_lock is released
>    * - woken process blocks are discarded from the list after having task zeroed
>    * - writers are only marked woken if downgrading is false
> + *
> + * Implies rwsem_del_waiter() for all woken readers.
>    */
>   static void rwsem_mark_wake(struct rw_semaphore *sem,
>   			    enum rwsem_wake_type wake_type,
> @@ -490,18 +514,25 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>   
>   	adjustment = woken * RWSEM_READER_BIAS - adjustment;
>   	lockevent_cond_inc(rwsem_wake_reader, woken);
> +
> +	oldcount = atomic_long_read(&sem->count);
>   	if (list_empty(&sem->wait_list)) {
> -		/* hit end of list above */
> +		/*
> +		 * Combined with list_move_tail() above, this implies
> +		 * rwsem_del_waiter().
> +		 */
>   		adjustment -= RWSEM_FLAG_WAITERS;
> +		if (oldcount & RWSEM_FLAG_HANDOFF)
> +			adjustment -= RWSEM_FLAG_HANDOFF;
> +	} else if (woken) {
> +		/*
> +		 * When we've woken a reader, we no longer need to force
> +		 * writers to give up the lock and we can clear HANDOFF.
> +		 */
> +		if (oldcount & RWSEM_FLAG_HANDOFF)
> +			adjustment -= RWSEM_FLAG_HANDOFF;
>   	}
>   
> -	/*
> -	 * When we've woken a reader, we no longer need to force writers
> -	 * to give up the lock and we can clear HANDOFF.
> -	 */
> -	if (woken && (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF))
> -		adjustment -= RWSEM_FLAG_HANDOFF;
> -
>   	if (adjustment)
>   		atomic_long_add(adjustment, &sem->count);
>   
> @@ -532,12 +563,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>    * race conditions between checking the rwsem wait list and setting the
>    * sem->count accordingly.
>    *
> - * If wstate is WRITER_HANDOFF, it will make sure that either the handoff
> - * bit is set or the lock is acquired with handoff bit cleared.
> + * Implies rwsem_del_waiter() on success.
>    */
>   static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
> -					enum writer_wait_state wstate)
> +					struct rwsem_waiter *waiter)
>   {
> +	bool first = rwsem_first_waiter(sem) == waiter;
>   	long count, new;
>   
>   	lockdep_assert_held(&sem->wait_lock);
> @@ -546,13 +577,19 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   	do {
>   		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>   
> -		if (has_handoff && wstate == WRITER_NOT_FIRST)
> -			return false;
> +		if (has_handoff) {
> +			if (!first)
> +				return false;
> +
> +			/* First waiter inherits a previously set handoff bit */
> +			waiter->handoff_set = true;
> +		}
>   
>   		new = count;
>   
>   		if (count & RWSEM_LOCK_MASK) {
> -			if (has_handoff || (wstate != WRITER_HANDOFF))
> +			if (has_handoff || (!rt_task(waiter->task) &&
> +					    !time_after(jiffies, waiter->timeout)))
>   				return false;
>   
>   			new |= RWSEM_FLAG_HANDOFF;
> @@ -569,9 +606,17 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   	 * We have either acquired the lock with handoff bit cleared or
>   	 * set the handoff bit.
>   	 */
> -	if (new & RWSEM_FLAG_HANDOFF)
> +	if (new & RWSEM_FLAG_HANDOFF) {
> +		waiter->handoff_set = true;
> +		lockevent_inc(rwsem_wlock_handoff);
>   		return false;
> +	}
>   
> +	/*
> +	 * Have rwsem_try_write_lock() fully imply rwsem_del_waiter() on
> +	 * success.
> +	 */
> +	list_del(&waiter->list);
>   	rwsem_set_owner(sem);
>   	return true;
>   }
> @@ -956,7 +1001,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>   		}
>   		adjustment += RWSEM_FLAG_WAITERS;
>   	}
> -	list_add_tail(&waiter.list, &sem->wait_list);
> +	rwsem_add_waiter(sem, &waiter);
>   
>   	/* we're now waiting on the lock, but no longer actively locking */
>   	count = atomic_long_add_return(adjustment, &sem->count);
> @@ -1002,11 +1047,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>   	return sem;
>   
>   out_nolock:
> -	list_del(&waiter.list);
> -	if (list_empty(&sem->wait_list)) {
> -		atomic_long_andnot(RWSEM_FLAG_WAITERS|RWSEM_FLAG_HANDOFF,
> -				   &sem->count);
> -	}
> +	rwsem_del_waiter(sem, &waiter);
>   	raw_spin_unlock_irq(&sem->wait_lock);
>   	__set_current_state(TASK_RUNNING);
>   	lockevent_inc(rwsem_rlock_fail);
> @@ -1020,9 +1061,7 @@ static struct rw_semaphore *
>   rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>   {
>   	long count;
> -	enum writer_wait_state wstate;
>   	struct rwsem_waiter waiter;
> -	struct rw_semaphore *ret = sem;
>   	DEFINE_WAKE_Q(wake_q);
>   
>   	/* do optimistic spinning and steal lock if possible */
> @@ -1038,16 +1077,13 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>   	waiter.task = current;
>   	waiter.type = RWSEM_WAITING_FOR_WRITE;
>   	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
> +	waiter.handoff_set = false;
>   
>   	raw_spin_lock_irq(&sem->wait_lock);
> -
> -	/* account for this before adding a new element to the list */
> -	wstate = list_empty(&sem->wait_list) ? WRITER_FIRST : WRITER_NOT_FIRST;
> -
> -	list_add_tail(&waiter.list, &sem->wait_list);
> +	rwsem_add_waiter(sem, &waiter);
>   
>   	/* we're now waiting on the lock */
> -	if (wstate == WRITER_NOT_FIRST) {
> +	if (rwsem_first_waiter(sem) != &waiter) {
>   		count = atomic_long_read(&sem->count);
>   
>   		/*
> @@ -1083,13 +1119,16 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>   	/* wait until we successfully acquire the lock */
>   	set_current_state(state);
>   	for (;;) {
> -		if (rwsem_try_write_lock(sem, wstate)) {
> +		if (rwsem_try_write_lock(sem, &waiter)) {
>   			/* rwsem_try_write_lock() implies ACQUIRE on success */
>   			break;
>   		}
>   
>   		raw_spin_unlock_irq(&sem->wait_lock);
>   
> +		if (signal_pending_state(state, current))
> +			goto out_nolock;
> +
>   		/*
>   		 * After setting the handoff bit and failing to acquire
>   		 * the lock, attempt to spin on owner to accelerate lock
> @@ -1098,7 +1137,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>   		 * In this case, we attempt to acquire the lock again
>   		 * without sleeping.
>   		 */
> -		if (wstate == WRITER_HANDOFF) {
> +		if (waiter.handoff_set) {
>   			enum owner_state owner_state;
>   
>   			preempt_disable();
> @@ -1109,66 +1148,26 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>   				goto trylock_again;
>   		}
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
>   trylock_again:
>   		raw_spin_lock_irq(&sem->wait_lock);
>   	}
>   	__set_current_state(TASK_RUNNING);
> -	list_del(&waiter.list);
>   	raw_spin_unlock_irq(&sem->wait_lock);
>   	lockevent_inc(rwsem_wlock);
> -
> -	return ret;
> +	return sem;
>   
>   out_nolock:
>   	__set_current_state(TASK_RUNNING);
>   	raw_spin_lock_irq(&sem->wait_lock);
> -	list_del(&waiter.list);
> -
> -	if (unlikely(wstate == WRITER_HANDOFF))
> -		atomic_long_add(-RWSEM_FLAG_HANDOFF,  &sem->count);
> -
> -	if (list_empty(&sem->wait_list))
> -		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
> -	else
> +	rwsem_del_waiter(sem, &waiter);
> +	if (!list_empty(&sem->wait_list))
>   		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
>   	raw_spin_unlock_irq(&sem->wait_lock);
>   	wake_up_q(&wake_q);
>   	lockevent_inc(rwsem_wlock_fail);
> -
>   	return ERR_PTR(-EINTR);
>   }
>   
> 


-- 
Thx and BRs,
Aiqun(Maria) Yu
