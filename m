Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8FA44FD86
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 04:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbhKODmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 22:42:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28908 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236885AbhKODmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 22:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636947546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GqfnG3kzB7LuV3kVCOkyfsdOLqvjHJ5wK0ZM6eC+Uok=;
        b=XSKbmqNygjqDIglrVoJVYamY7s3CTLnwxohz483H3As1HsegDiCSrr7DMF4t+4aj8ds88x
        148fHht14NCtSFKEutRHsNkhSx/2UQ7zFtz/EFYveaxUyTrlvVQ9OA5gyj475sue4Rn2c6
        NGjllsIz8xWRH6FUX/wgqK5x+4l6c90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-voGasRj6MQ21ACM0E0wB6A-1; Sun, 14 Nov 2021 22:39:01 -0500
X-MC-Unique: voGasRj6MQ21ACM0E0wB6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E55D871817;
        Mon, 15 Nov 2021 03:38:59 +0000 (UTC)
Received: from [10.22.16.82] (unknown [10.22.16.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C19A560BE5;
        Mon, 15 Nov 2021 03:38:57 +0000 (UTC)
Message-ID: <a141b93d-1945-a44d-467f-54b648cbf4d0@redhat.com>
Date:   Sun, 14 Nov 2021 22:38:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] locking/rwsem: Make handoff bit handling more
 consistent
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        mazhenhua <mazhenhua@xiaomi.com>,
        Hillf Danton <hdanton@sina.com>,
        Maria Yu <quic_aiquny@quicinc.com>
References: <20211112040753.389380-1-longman@redhat.com>
 <YY5Z009P2jJ4X484@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YY5Z009P2jJ4X484@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/21 07:10, Peter Zijlstra wrote:
> On Thu, Nov 11, 2021 at 11:07:53PM -0500, Waiman Long wrote:
>> @@ -889,6 +892,20 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
>>   }
>>   #endif
>>   
>> +/*
>> + * Common code to handle rwsem flags in out_nolock path with wait_lock held.
>> + * If there is more than one waiter in the queue and the HANDOFF bit is set,
>> + * the next waiter will inherit it if the first waiter is removed.
>> + */
>> +static inline void rwsem_out_nolock_clear_flags(struct rw_semaphore *sem,
>> +						struct rwsem_waiter *waiter)
> I'm going to rename that, it doesn't just clear flags, it dequeues the
> waiter.
>
> Argh, rwsem_mark_wake() doesn't clear HANDOFF when list_empty(), and
> write_slowpath() is *far* too clever about all of this.
rwsem_mark_wake() does clear the HANDOFF flag if it was set.
>
>
>> +{
>> +	list_del(&waiter->list);
> 	if (list_empty(&sem->wait_list)) {
>> +		atomic_long_andnot(RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS,
>> +				   &sem->count);
> 	}
>> +}
>
>
>> @@ -1098,7 +1110,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>>   		 * In this case, we attempt to acquire the lock again
>>   		 * without sleeping.
>>   		 */
>> -		if (wstate == WRITER_HANDOFF) {
>> +		if (waiter.handoff_set) {
> I'm thinking this wants to be something like:
>
> 		if (rwsem_first_waiter(sem) == &waiter && waiter.handoff_set) {
handoff_set flag is only set when the waiter becomes the first.
>
>>   			enum owner_state owner_state;
>>   
>>   			preempt_disable();
> How's this (on top) then?
>
> ---
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -104,11 +104,10 @@
>    * atomic_long_fetch_add() is used to obtain reader lock, whereas
>    * atomic_long_cmpxchg() will be used to obtain writer lock.
>    *
> - * There are four places where the lock handoff bit may be set or cleared.
> - * 1) rwsem_mark_wake() for readers            -- set, clear
> - * 2) rwsem_try_write_lock() for writers       -- set, clear
> - * 3) Error path of rwsem_down_write_slowpath() -- clear
> - * 4) Error path of rwsem_down_read_slowpath()  -- clear
> + * There are three places where the lock handoff bit may be set or cleared.
> + * 1) rwsem_mark_wake() for readers		-- set, clear
> + * 2) rwsem_try_write_lock() for writers	-- set, clear
> + * 3) rwsem_del_waiter()			-- clear
>    *
>    * For all the above cases, wait_lock will be held. A writer must also
>    * be the first one in the wait_list to be eligible for setting the handoff
> @@ -363,6 +362,31 @@ enum rwsem_wake_type {
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
> @@ -374,6 +398,8 @@ enum rwsem_wake_type {
>    *   preferably when the wait_lock is released
>    * - woken process blocks are discarded from the list after having task zeroed
>    * - writers are only marked woken if downgrading is false
> + *
> + * Implies rwsem_del_waiter() for all woken readers.
>    */
>   static void rwsem_mark_wake(struct rw_semaphore *sem,
>   			    enum rwsem_wake_type wake_type,
> @@ -488,18 +514,25 @@ static void rwsem_mark_wake(struct rw_se
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
> @@ -529,6 +562,8 @@ static void rwsem_mark_wake(struct rw_se
>    * This function must be called with the sem->wait_lock held to prevent
>    * race conditions between checking the rwsem wait list and setting the
>    * sem->count accordingly.
> + *
> + * Implies rwsem_del_waiter() on success.
>    */
>   static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   					struct rwsem_waiter *waiter)
> @@ -575,6 +610,11 @@ static inline bool rwsem_try_write_lock(
>   		return false;
>   	}
>   
> +	/*
> +	 * Have rwsem_try_write_lock() fully imply rwsem_del_waiter() on
> +	 * success.
> +	 */
> +	list_del(&waiter->list);
>   	rwsem_set_owner(sem);
>   	return true;
>   }
> @@ -893,20 +933,6 @@ rwsem_spin_on_owner(struct rw_semaphore
>   #endif
>   
>   /*
> - * Common code to handle rwsem flags in out_nolock path with wait_lock held.
> - * If there is more than one waiter in the queue and the HANDOFF bit is set,
> - * the next waiter will inherit it if the first waiter is removed.
> - */
> -static inline void rwsem_out_nolock_clear_flags(struct rw_semaphore *sem,
> -						struct rwsem_waiter *waiter)
> -{
> -	list_del(&waiter->list);
> -	if (list_empty(&sem->wait_list))
> -		atomic_long_andnot(RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS,
> -				   &sem->count);
> -}
> -
> -/*
>    * Wait for the read lock to be granted
>    */
>   static struct rw_semaphore __sched *
> @@ -973,7 +999,7 @@ rwsem_down_read_slowpath(struct rw_semap
>   		}
>   		adjustment += RWSEM_FLAG_WAITERS;
>   	}
> -	list_add_tail(&waiter.list, &sem->wait_list);
> +	rwsem_add_waiter(sem, &waiter);
>   
>   	/* we're now waiting on the lock, but no longer actively locking */
>   	count = atomic_long_add_return(adjustment, &sem->count);
> @@ -1019,7 +1045,7 @@ rwsem_down_read_slowpath(struct rw_semap
>   	return sem;
>   
>   out_nolock:
> -	rwsem_out_nolock_clear_flags(sem, &waiter);
> +	rwsem_del_waiter(sem, &waiter);
>   	raw_spin_unlock_irq(&sem->wait_lock);
>   	__set_current_state(TASK_RUNNING);
>   	lockevent_inc(rwsem_rlock_fail);
> @@ -1034,7 +1060,6 @@ rwsem_down_write_slowpath(struct rw_sema
>   {
>   	long count;
>   	struct rwsem_waiter waiter;
> -	struct rw_semaphore *ret = sem;
>   	DEFINE_WAKE_Q(wake_q);
>   
>   	/* do optimistic spinning and steal lock if possible */
> @@ -1053,7 +1078,7 @@ rwsem_down_write_slowpath(struct rw_sema
>   	waiter.handoff_set = false;
>   
>   	raw_spin_lock_irq(&sem->wait_lock);
> -	list_add_tail(&waiter.list, &sem->wait_list);
> +	rwsem_add_waiter(sem, &waiter);
>   
>   	/* we're now waiting on the lock */
>   	if (rwsem_first_waiter(sem) != &waiter) {
> @@ -1110,7 +1135,7 @@ rwsem_down_write_slowpath(struct rw_sema
>   		 * In this case, we attempt to acquire the lock again
>   		 * without sleeping.
>   		 */
> -		if (waiter.handoff_set) {
> +		if (rwsem_first_waiter(sem) == &waiter && waiter.handoff_set) {
>   			enum owner_state owner_state;
>   
>   			preempt_disable();
> @@ -1128,16 +1153,14 @@ rwsem_down_write_slowpath(struct rw_sema
>   		raw_spin_lock_irq(&sem->wait_lock);
>   	}
>   	__set_current_state(TASK_RUNNING);
> -	list_del(&waiter.list);
+    rwsem_del_waiter(sem, &waiters); ?
>   	raw_spin_unlock_irq(&sem->wait_lock);
>   	lockevent_inc(rwsem_wlock);
> -
> -	return ret;
> +	return sem;
>   
>   out_nolock:
>   	__set_current_state(TASK_RUNNING);
>   	raw_spin_lock_irq(&sem->wait_lock);
> -	rwsem_out_nolock_clear_flags(sem, &waiter);
> +	rwsem_del_waiter(sem, &waiter);
>   	if (!list_empty(&sem->wait_list))
>   		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
>   	raw_spin_unlock_irq(&sem->wait_lock);
>
Sorry for the late reply as I was busy on other works.

I like the idea. I will incorporate in a new patch tomorrow.

Cheers,
Longman

