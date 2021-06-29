Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25603B7483
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbhF2Omo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234450AbhF2Omn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624977616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YtmFbZOSHZ9C1V0yE8gtAFy62LH0n7QU6fuet14tIjU=;
        b=Z9MaiUeRKPb+kMniCV2uKuhlWdKfCy+M/MFdG98EoWBJo40bBz/9vW0DqLGgsZZkTmWuIM
        MQzwRniCo/0TUaCErnhsAPSNikrC1JEFB1Cfg2bRWYA8Pyj/GIW21KKGvjuD7tWCh5kWWd
        GBTTU+5LtBASOOM+I/0O5DqKNwaCwPQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-84uBZVfyMRm5-fl6mpxhXg-1; Tue, 29 Jun 2021 10:40:14 -0400
X-MC-Unique: 84uBZVfyMRm5-fl6mpxhXg-1
Received: by mail-qv1-f71.google.com with SMTP id f11-20020a056214164bb029026bc7adaae8so20691412qvw.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YtmFbZOSHZ9C1V0yE8gtAFy62LH0n7QU6fuet14tIjU=;
        b=fLc3KnBpjRpHBggOy7bnrRTnwyhyV01eWcTfDY06OBJAdOW3L4FhbZJxoTEnCkuzr7
         L+YfU50+nDZN+0zlDzcQNeseTal02iSn00kYNw00d0vrlocOQdCPAxHsKMkjLRSnSNMM
         72PDAABg5amQ2Xh2gYILJKqvTk99u7B5lX9Jo8QkGgYA4BvKvzu05RWCdLz4micJ+I4y
         Jp+rgDZ7LZ0fr0tewbCNI6JXtmbAbxAHUhQWEmn+qKorGprqBBScwPIjOd5xRWQ0Onh2
         raleRPtGaoYdBb1zqMEgjRNMGYX4Y0tVAJteFe4rvCBCJWdNJGnLWK5NxiMcoQ0WBzGg
         hHdA==
X-Gm-Message-State: AOAM530cpk2Vxev4+KLtA3kQBIIIjsGxFI7SUBVP73n7QEmM+uJOfHHY
        ZpVio0uA9SgUT7M0+ahVa3u1HbCv/h3LRrsHwkIVAH/tLx/fVc7V8805WaK0r8X96L6NMvbfV8D
        buHFR2a/QilUY3+JVN9arcBuhBVGSLzqC+9GwWBo0iS0bLv91K5+L71jjmOFqKw7pvuDr3bAT
X-Received: by 2002:ac8:7f87:: with SMTP id z7mr299567qtj.238.1624977614000;
        Tue, 29 Jun 2021 07:40:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMcGlHa8KMSVF8vb6YvECQhqrhDxq7DCLxr5BUsvHZvkoI6KklF8gio72jYt4kNyS+YaDy0A==
X-Received: by 2002:ac8:7f87:: with SMTP id z7mr299534qtj.238.1624977613745;
        Tue, 29 Jun 2021 07:40:13 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id w15sm5717790qkj.7.2021.06.29.07.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 07:40:13 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/mutex: fix the MUTEX_FLAG_HANDOFF bit is cleared
 unexpected
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>,
        Waiman Long <llong@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20210628155155.11623-1-yanfei.xu@windriver.com>
 <e914d4fd-5afc-35f9-c068-7044ceda53dd@redhat.com>
 <02691c73-6ba8-241c-6ec8-486d9d549c23@windriver.com>
Message-ID: <78f45c3c-191b-bd14-3b38-522907d0e24f@redhat.com>
Date:   Tue, 29 Jun 2021 10:40:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <02691c73-6ba8-241c-6ec8-486d9d549c23@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/21 5:52 AM, Xu, Yanfei wrote:
>
>
> On 6/29/21 1:57 AM, Waiman Long wrote:
>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>
>> On 6/28/21 11:51 AM, Yanfei Xu wrote:
>>> When the mutex unlock path is excuted with WAITERS bit and without
>>> HANDOFF bit set, it will wake up the first task in wait_list. If
>>> there are some tasks not in wait_list are stealing lock, it is very
>>> likely successfully due to the task field of lock is NULL and flags
>>> field is non-NULL. Then the HANDOFF bit will be cleared. But if the
>>> HANDOFF bit was just set by the waked task in wait_list, this clearing
>>> is unexcepted.
>>
>> I think you mean "unexpected". Right? Anyway, all the setting and
>
> Right. It's my fault.
>
>> clearing of the HANDOFF bit are atomic. There shouldn't be any
>> unexpected clearing.
>>
>>> __mutex_lock_common __mutex_lock_common
>>>    __mutex_trylock schedule_preempt_disabled
>>>      /*steal lock successfully*/ 
>>> __mutex_set_flag(lock,MUTEX_FLAG_HANDOFF)
>>>      __mutex_trylock_or_owner
>>>        if (task==NULL)
>>>        flags &= ~MUTEX_FLAG_HANDOFF
>>>        atomic_long_cmpxchg_acquire
>>>                                          __mutex_trylock //failed
>>> mutex_optimistic_spin  //failed
>>> schedule_preempt_disabled  //sleep without HANDOFF bit
>>>
>>> So the HANDOFF bit should be set as late as possible, here we defer
>>> it util the task is going to be scheduled.
>>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>>> ---
>>>
>>> Hi maintainers,
>>>
>>> I am not very sure if I missed or misunderstanded something, please 
>>> help
>>> to review. Many thanks!
>>>
>>>   kernel/locking/mutex.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
>>> index 013e1b08a1bf..e57d920e96bf 100644
>>> --- a/kernel/locking/mutex.c
>>> +++ b/kernel/locking/mutex.c
>>> @@ -1033,17 +1033,17 @@ __mutex_lock_common(struct mutex *lock, long 
>>> state, unsigned int subclass,
>>>               }
>>>
>>>               spin_unlock(&lock->wait_lock);
>>> +
>>> +             if (first)
>>> +                     __mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
>>>               schedule_preempt_disabled();
>>>
>>>               /*
>>>                * ww_mutex needs to always recheck its position since 
>>> its waiter
>>>                * list is not FIFO ordered.
>>>                */
>>> -             if (ww_ctx || !first) {
>>> +             if (ww_ctx || !first)
>>>                       first = __mutex_waiter_is_first(lock, &waiter);
>>> -                     if (first)
>>> -                             __mutex_set_flag(lock, 
>>> MUTEX_FLAG_HANDOFF);
>>> -             }
>>>
>>>               set_current_state(state);
>>>               /*
>>
>> In general, I don't mind setting the HANDOFF bit later, but
>> mutex_optimistic_spin() at the end of the loop should only be called
>> after the HANDOFF bit is set. So the logic isn't quite right yet.
>
> Thanks for your reply.
>
> Why the mutex_optimistic_spin should be called after the HANDOFF bit is
> set? I think the HANDOFF bit is only related to unlock path, and the
> mutex_optimistic_spin and __mutex_trylock don't actually use it. （Or I
> missed something? ）

The purpose of doing spinning after the HANDOFF bit is set is to 
eliminate the waiter wakeup latency, if possible. Before the HANDOFF bit 
is set, the lock can be easily stolen and there is no point in adding 
pressure to the lock cacheline.


>
> Maybe I described the issue not much clearly. Let me try again.
>
> The HANDOFF bit aims to avoid lock starvation. Lock starvation is
> possible because mutex_lock（） allows lock stealing, where a runing( or
> optimistic spinning) task beats the woken waiter to the acquire. So
> maintainer add HANDOFF bit, once the stealing happened, the top-waiter
> will must get the lock at the second wake up due to the HANDOFF bit.
>
> However, the fact is if the stealing happened, the HANDOFF will must be
> clear by the thief task. Hence the top-waiter still might starve at the
> second wake up.
>
I think you have some confusion here. If the HANDOFF bit is set before 
the lock is stolen by an optimistic spinner, lock stealing can't happen 
which is the point of having a HANDOFF bit. Also the clearing of the 
HANDOFF bit isn't done by the task that steal the lock, it is done by 
the current lock holder (i.e. the task that held the lock when the 
HANDOFF bit was set) in the unlock path. It can be a lock stealer that 
stole the lock before the HANDOFF bit is set. Of course, it will be a 
bug if the current code doesn't actually do that.

Cheers,
Longman

