Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EC244DCE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 22:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhKKVMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:12:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhKKVMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636664980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Id9L/FfXmLGKzMeYtqJwSgUZoNij+BebFeyYZxdPNYg=;
        b=bUOeqqGPpDsopMIO5UHGnJoJHy0da5S/fCw+WlbFOFlm3derE8sD3h6b2HwMKJh3w7RQxe
        87hAfUEmCHJMGvaBFE+kOEIXP1pc3axR0TNKgpLLDJYHgx+WqbPxlPkW7sNhSPkoaDv3zQ
        p76XtjPXY3Tq+QlKDzGubpSJiMOvO6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-_vL5ZOU6OdKSYkc1pNmgiw-1; Thu, 11 Nov 2021 16:09:39 -0500
X-MC-Unique: _vL5ZOU6OdKSYkc1pNmgiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FD2E1006AA0;
        Thu, 11 Nov 2021 21:09:38 +0000 (UTC)
Received: from [10.22.8.202] (unknown [10.22.8.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3274D60C05;
        Thu, 11 Nov 2021 21:09:36 +0000 (UTC)
Message-ID: <d7d15ac8-5f23-383b-1fba-ca541747dd77@redhat.com>
Date:   Thu, 11 Nov 2021 16:09:35 -0500
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
 <20211111205008.GJ174703@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211111205008.GJ174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/21 15:50, Peter Zijlstra wrote:
> So I suspect that if..
>
> On Thu, Nov 11, 2021 at 02:36:52PM -0500, Waiman Long wrote:
>>   static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>> -					enum writer_wait_state wstate)
>> +					struct rwsem_waiter *waiter)
>>   {
>>   	long count, new;
>> +	bool first = rwsem_first_waiter(sem) == waiter;
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
>>   				return false;
> we delete this whole condition, and..
I don't think we can take out this if test.
>
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
> take out this else,
>
>> +
>> +	if (flags)
>> +		atomic_long_andnot(flags,  &sem->count);
>> +}
> We get the inherit thing for free, no?
>
> Once HANDOFF is set, new readers are blocked. And then allow any first
> waiter to acquire the lock, who cares if it was the one responsible for
> having set the HANDOFF bit.

Yes, we can have the policy of inheriting the HANDOFF bit as long as it 
is consistent which will be the case here with a common out_nolock 
function. I can go with that. I just have to document this fact in the 
comment.

Cheers,
Longman

