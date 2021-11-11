Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6923C44DCD7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 22:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhKKVEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:04:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhKKVEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636664480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWTCUVr1/MCDyV25kMMe4vJKzeu3lMrSgCcy+MwjbvU=;
        b=hayOhaHI78dkDHzGT/gSAOdR+uyjv0nPtJ5FJnXzcjQR6DnAPwsT6XjsalZIjITqj5/I4k
        FMiknHqF+u+tjkWijb+qphtGsdcwUa0KW64vzdxQb5IdScVRpChV5E9mgPxeoLamL5PLVR
        4MCtHZobAUzX9mbD8esNi4SqGwSmWhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-zMbQWJ_1NoCTwMpoaO3Z8w-1; Thu, 11 Nov 2021 16:01:19 -0500
X-MC-Unique: zMbQWJ_1NoCTwMpoaO3Z8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4192010144E0;
        Thu, 11 Nov 2021 21:01:18 +0000 (UTC)
Received: from [10.22.8.202] (unknown [10.22.8.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C97901002D71;
        Thu, 11 Nov 2021 21:01:16 +0000 (UTC)
Message-ID: <be3dc705-494a-913e-230f-9533c7404ac2@redhat.com>
Date:   Thu, 11 Nov 2021 16:01:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        =?UTF-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4fafad133b074f279dbab1aa3642e23f@xiaomi.com>
 <20211107090131.1535-1-hdanton@sina.com>
 <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
 <02e118c0-2116-b806-2b48-b9c91dc847dd@redhat.com>
 <20211110213854.GE174703@worktop.programming.kicks-ass.net>
 <YY0x55wxO2v5HCOW@hirez.programming.kicks-ass.net>
 <61735528-141c-8d77-592d-b6b8fb75ebaa@redhat.com>
 <YY1s6v9b/tYtNnGv@hirez.programming.kicks-ass.net>
 <e16f9fc2-ce01-192b-065d-460c2ad9b317@redhat.com>
 <20211111202647.GH174703@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211111202647.GH174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/11/21 15:26, Peter Zijlstra wrote:
> On Thu, Nov 11, 2021 at 02:36:52PM -0500, Waiman Long wrote:
>
>> @@ -434,6 +430,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>>   			if (!(oldcount & RWSEM_FLAG_HANDOFF) &&
>>   			    time_after(jiffies, waiter->timeout)) {
>>   				adjustment -= RWSEM_FLAG_HANDOFF;
>> +				waiter->handoff_set = true;
>>   				lockevent_inc(rwsem_rlock_handoff);
>>   			}
>>   
> Do we really need this flag? Wouldn't it be the same as waiter-is-first
> AND sem-has-handoff ?
That is true. The only downside is that we have to read the count first 
in rwsem_out_nolock_clear_flags(). Since this is not a fast path, it 
should be OK to do that.
>>   static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>> +					struct rwsem_waiter *waiter)
>>   {
>>   	long count, new;
>> +	bool first = rwsem_first_waiter(sem) == waiter;
> flip those lines for reverse xmas please
Sure, will do.
>
>>   
>>   	lockdep_assert_held(&sem->wait_lock);
>>   
>> @@ -546,13 +541,14 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>>   	do {
>>   		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>>   
>> -		if (has_handoff && wstate == WRITER_NOT_FIRST)
>> +		if (has_handoff && !first)
>>   			return false;
>>   
>>   		new = count;
>>   
>>   		if (count & RWSEM_LOCK_MASK) {
>> -			if (has_handoff || (wstate != WRITER_HANDOFF))
>> +			if (has_handoff || (!waiter->rt_task &&
>> +					    !time_after(jiffies, waiter->timeout)))
>
> Does ->rt_task really help over rt_task(current) ? I suppose there's an
> argument for locality, but that should be pretty much it, no?
Waiting for the timeout may introduce too much latency for RT task. That 
is the only reason I am doing it. I can take it out if you think it is 
not necessary.
>
>>   				return false;
>>   
>>   			new |= RWSEM_FLAG_HANDOFF;
>> @@ -889,6 +888,24 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
>>   }
>>   #endif
>>   
>> +/*
>> + * Common code to handle rwsem flags in out_nolock path with wait_lock held.
>> + */
>> +static inline void rwsem_out_nolock_clear_flags(struct rw_semaphore *sem,
>> +						struct rwsem_waiter *waiter)
>> +{
>> +	long flags = 0;
>> +
>> +	list_del(&waiter->list);
>> +	if (list_empty(&sem->wait_list))
>> +		flags = RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS;
>> +	else if (waiter->handoff_set)
>> +		flags = RWSEM_FLAG_HANDOFF;
>> +
>> +	if (flags)
>> +		atomic_long_andnot(flags,  &sem->count);
>> +}
> Right, so I like sharing this between the two _slowpath functions, that
> makes sense.
>
> The difference between this and my approach is that I unconditionally
> clear HANDOFF when @waiter was the first. Because if it was set, it
> must've been ours, and if it wasn't set, clearing it doesn't really hurt
> much. This is an unlikely path, I don't think the potentially extra
> atomic is an issue here.
That is true, we shouldn't worry too much about performance for this 
unlikely path. Will make the change.
>
>> +
>>   /*
>>    * Wait for the read lock to be granted
>>    */
>> @@ -936,6 +953,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>>   	waiter.task = current;
>>   	waiter.type = RWSEM_WAITING_FOR_READ;
>>   	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
>> +	waiter.handoff_set = false;
> Forgot to set rt_task

We don't use rt_task for reader. It is writer only. I will document that.

>
>>   
>>   	raw_spin_lock_irq(&sem->wait_lock);
>>   	if (list_empty(&sem->wait_list)) {
>> @@ -1038,16 +1051,13 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>>   	waiter.task = current;
>>   	waiter.type = RWSEM_WAITING_FOR_WRITE;
>>   	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
> Forget to set handoff_set
Yes, I was aware of that.
>
>> +	waiter.rt_task = rt_task(current);
>>   
>>   	raw_spin_lock_irq(&sem->wait_lock);
> Again, I'm not convinced we need these variables.
I will take out handoff_set as suggested. I can can also take out 
rt_task if you don't think we need to test it.
>
>> @@ -1083,13 +1093,16 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>>   	/* wait until we successfully acquire the lock */
>>   	set_current_state(state);
>>   	for (;;) {
>> -		if (rwsem_try_write_lock(sem, wstate)) {
>> +		if (rwsem_try_write_lock(sem, &waiter)) {
>>   			/* rwsem_try_write_lock() implies ACQUIRE on success */
>>   			break;
>>   		}
>>   
>>   		raw_spin_unlock_irq(&sem->wait_lock);
>>   
>> +		if (signal_pending_state(state, current))
>> +			goto out_nolock;
>> +
>>   		/*
>>   		 * After setting the handoff bit and failing to acquire
>>   		 * the lock, attempt to spin on owner to accelerate lock
>> @@ -1098,7 +1111,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>>   		 * In this case, we attempt to acquire the lock again
>>   		 * without sleeping.
>>   		 */
>> -		if (wstate == WRITER_HANDOFF) {
>> +		if (waiter.handoff_set) {
>>   			enum owner_state owner_state;
>>   
>>   			preempt_disable();
> Does it matter much if we spin-wait for every first or only for handoff?
Only for handoff as no other task will be spinning for the lock.
>
> Either way around, I think spin-wait ought to terminate on sigpending
> (same for mutex I suppose).

I am thinking about that too. Time for another followup patch, I think.

Cheers,
Longman

