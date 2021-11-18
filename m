Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD2045620B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 19:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhKRSPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 13:15:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234346AbhKRSPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637259135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxg/TVHdwtBQVY5nxbtP/+vp+jJ++dcyFK+gQZlfSsk=;
        b=LWGgRMl4HltfVzBtK7tSkXuZ/1bONbTMeF/lWWv1iRPecWQY8Q+s/qjTNA30/LfKqJFxx0
        BHprslz+XzV4IROrRiUESNmiSQI8LuN8vxu+WYFQVJfhIVE6fEHh15UUyMqHvBShMJoB3a
        uiHovaLn1p0Aac9zIMfrdZck8D2d1nM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-8vrf8jOpPaerSCYES0oCrQ-1; Thu, 18 Nov 2021 13:12:14 -0500
X-MC-Unique: 8vrf8jOpPaerSCYES0oCrQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F504DF8A4;
        Thu, 18 Nov 2021 18:12:13 +0000 (UTC)
Received: from [10.22.16.126] (unknown [10.22.16.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 405FD104A9EE;
        Thu, 18 Nov 2021 18:12:04 +0000 (UTC)
Message-ID: <54f5bdcf-8b6e-0e53-8f28-5d5c3eb5f7ad@redhat.com>
Date:   Thu, 18 Nov 2021 13:12:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] locking/rwsem: Optimize down_read_trylock() under highly
 contended case
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        zhengqi.arch@bytedance.com
References: <20211118094455.9068-1-songmuchun@bytedance.com>
 <YZZNv3JflBYwRjdd@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YZZNv3JflBYwRjdd@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/21 07:57, Peter Zijlstra wrote:
> On Thu, Nov 18, 2021 at 05:44:55PM +0800, Muchun Song wrote:
>
>> By using the above benchmark, the real executing time on a x86-64 system
>> before and after the patch were:
> What kind of x86_64 ?
>
>>                    Before Patch  After Patch
>>     # of Threads      real          real     reduced by
>>     ------------     ------        ------    ----------
>>           1          65,373        65,206       ~0.0%
>>           4          15,467        15,378       ~0.5%
>>          40           6,214         5,528      ~11.0%
>>
>> For the uncontended case, the new down_read_trylock() is the same as
>> before. For the contended cases, the new down_read_trylock() is faster
>> than before. The more contended, the more fast.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>   kernel/locking/rwsem.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index c51387a43265..ef2b2a3f508c 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -1249,17 +1249,14 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
>>   
>>   	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
>>   
>> -	/*
>> -	 * Optimize for the case when the rwsem is not locked at all.
>> -	 */
>> -	tmp = RWSEM_UNLOCKED_VALUE;
>> -	do {
>> +	tmp = atomic_long_read(&sem->count);
>> +	while (!(tmp & RWSEM_READ_FAILED_MASK)) {
>>   		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
>> -					tmp + RWSEM_READER_BIAS)) {
>> +						    tmp + RWSEM_READER_BIAS)) {
>>   			rwsem_set_reader_owned(sem);
>>   			return 1;
>>   		}
>> -	} while (!(tmp & RWSEM_READ_FAILED_MASK));
>> +	}
>>   	return 0;
>>   }
> This is weird... so the only difference is that leading load, but given
> contention you'd expect that load to stall, also, given it's a
> non-exclusive load, to get stolen by a competing CPU. Whereas the old
> code would start with a cmpxchg, which obviously will also stall, but
> does an exclusive load.
>
> And the thinking is that the exclusive load and the presence of the
> cmpxchg loop would keep the line on that CPU for a little while and
> progress is made.
>
> Clearly this isn't working as expected. Also I suppose it would need
> wider testing...

For a contended case, doing a shared read first doing an exclusive 
cmpxchg can certainly help to reduce cacheline trashing. I have no 
objection to making this change.

I believe most of the other trylock functions do a read first before 
doing an atomic operation. In essence, we assume the use of trylock 
means the callers are expecting an contended lock whereas callers of 
regular *lock() function are expecting an uncontended lock.

Acked-by: Waiman Long <longman@redhat.com>

-Longman

