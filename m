Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EFE3B750A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 17:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhF2PVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 11:21:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234627AbhF2PVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 11:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624979913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o30YUldJfd4ITIQHLeb0yQSPP0iIeIlTJu5av4dFewg=;
        b=Ln2F1WvtYb4nKTg5Ah9G9DIbStHgiyjwu+SFw3lM/D0c3Q8x6x09LJBYfsqT5KL4ARgMGO
        y6VgqGz/A4zcVURrtJhnJVsO5bLLqTghTTdAgR6CKJSOs7Sc/8b2oPfZFAJ8KinIq550IA
        Owm902uMiaZMZpI2B+ZGqL0j794WjZA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-ggbo3rsAOCyL8ZLQwRSNaw-1; Tue, 29 Jun 2021 11:18:31 -0400
X-MC-Unique: ggbo3rsAOCyL8ZLQwRSNaw-1
Received: by mail-qv1-f70.google.com with SMTP id z6-20020a0cfec60000b0290263740e5b2aso20770023qvs.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 08:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=o30YUldJfd4ITIQHLeb0yQSPP0iIeIlTJu5av4dFewg=;
        b=lFmoKLE59OeqLUyHVRtBBPKTH9HLUk0UJZ866k4+74vHTdCQ2qb/xL7VYP1NOJemrc
         XXlgNssvuu3ayBm5Y+SDTrJZVWUdIBp8gmYySE7VnRqwwDSuO4Di9NC2uwJFz1bPY6DN
         pRAvflqj9RFOmRL3HKQ2aMHUDuQHk1fRSMbKkR7CmpcFCb+F6EIDVVFPUP43LruLPsX5
         0+NGcRTvsjd0zqfZxI5+l6YOXMCL8ZSWCeQOjS7Ah7E/HX9j22wlLSMoVWv/OIJo8MJ2
         ghsTqwOw1aj/oxiyhPFdZtezFlZt5nRAAuk+4Wvsb0fR8WcE2yriOeMw/HEwsAEHT5yP
         L/UQ==
X-Gm-Message-State: AOAM532ZKKQwrGmHGvl759ClC3C/GiIJ4ofgpJb3Ct9IHlaO0xRrRNrn
        hnemT+Ge2IPD8W5aA56p40oYJpahqWcoXZthfsjTyJUz5Le/BA5sboL35Uik3ZAVqHtMzm5m5B3
        XidV5zVPPv0cOzgs0gb5P1Kn3IDFsW3d5FyO6oKnpkht3fhFX5ukPF4gbrSV2U4mfQFveuHXC
X-Received: by 2002:ac8:66d0:: with SMTP id m16mr12067340qtp.44.1624979911130;
        Tue, 29 Jun 2021 08:18:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/+WnYGIKqr+KKqDIyfR/GBRIVtHjdEhL76GVTfDjA3vUceyUqVgfIXvvQ48xOqFYOpbmfIQ==
X-Received: by 2002:ac8:66d0:: with SMTP id m16mr12067314qtp.44.1624979910840;
        Tue, 29 Jun 2021 08:18:30 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id d129sm12285467qkf.136.2021.06.29.08.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 08:18:30 -0700 (PDT)
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
 <78f45c3c-191b-bd14-3b38-522907d0e24f@redhat.com>
Message-ID: <d48fdbae-4b79-9039-4577-d3aaa18d543d@redhat.com>
Date:   Tue, 29 Jun 2021 11:18:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <78f45c3c-191b-bd14-3b38-522907d0e24f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/21 10:40 AM, Waiman Long wrote:
> On 6/29/21 5:52 AM, Xu, Yanfei wrote:
>>
>>
>> On 6/29/21 1:57 AM, Waiman Long wrote:
>>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>>
>>> On 6/28/21 11:51 AM, Yanfei Xu wrote:
>>>> When the mutex unlock path is excuted with WAITERS bit and without
>>>> HANDOFF bit set, it will wake up the first task in wait_list. If
>>>> there are some tasks not in wait_list are stealing lock, it is very
>>>> likely successfully due to the task field of lock is NULL and flags
>>>> field is non-NULL. Then the HANDOFF bit will be cleared. But if the
>>>> HANDOFF bit was just set by the waked task in wait_list, this clearing
>>>> is unexcepted.
>>>
>>> I think you mean "unexpected". Right? Anyway, all the setting and
>>
>> Right. It's my fault.
>>
>>> clearing of the HANDOFF bit are atomic. There shouldn't be any
>>> unexpected clearing.
>>>
>>>> __mutex_lock_common __mutex_lock_common
>>>>    __mutex_trylock schedule_preempt_disabled
>>>>      /*steal lock successfully*/ 
>>>> __mutex_set_flag(lock,MUTEX_FLAG_HANDOFF)
>>>>      __mutex_trylock_or_owner
>>>>        if (task==NULL)
>>>>        flags &= ~MUTEX_FLAG_HANDOFF
>>>>        atomic_long_cmpxchg_acquire
>>>>                                          __mutex_trylock //failed
>>>> mutex_optimistic_spin  //failed
>>>> schedule_preempt_disabled  //sleep without HANDOFF bit
>>>>
>>>> So the HANDOFF bit should be set as late as possible, here we defer
>>>> it util the task is going to be scheduled.
>>>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>>>> ---
>>>>
>>>> Hi maintainers,
>>>>
>>>> I am not very sure if I missed or misunderstanded something, please 
>>>> help
>>>> to review. Many thanks!
>>>>
>>>>   kernel/locking/mutex.c | 8 ++++----
>>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
>>>> index 013e1b08a1bf..e57d920e96bf 100644
>>>> --- a/kernel/locking/mutex.c
>>>> +++ b/kernel/locking/mutex.c
>>>> @@ -1033,17 +1033,17 @@ __mutex_lock_common(struct mutex *lock, 
>>>> long state, unsigned int subclass,
>>>>               }
>>>>
>>>>               spin_unlock(&lock->wait_lock);
>>>> +
>>>> +             if (first)
>>>> +                     __mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
>>>>               schedule_preempt_disabled();
>>>>
>>>>               /*
>>>>                * ww_mutex needs to always recheck its position 
>>>> since its waiter
>>>>                * list is not FIFO ordered.
>>>>                */
>>>> -             if (ww_ctx || !first) {
>>>> +             if (ww_ctx || !first)
>>>>                       first = __mutex_waiter_is_first(lock, &waiter);
>>>> -                     if (first)
>>>> -                             __mutex_set_flag(lock, 
>>>> MUTEX_FLAG_HANDOFF);
>>>> -             }
>>>>
>>>>               set_current_state(state);
>>>>               /*
>>>
>>> In general, I don't mind setting the HANDOFF bit later, but
>>> mutex_optimistic_spin() at the end of the loop should only be called
>>> after the HANDOFF bit is set. So the logic isn't quite right yet.
>>
>> Thanks for your reply.
>>
>> Why the mutex_optimistic_spin should be called after the HANDOFF bit is
>> set? I think the HANDOFF bit is only related to unlock path, and the
>> mutex_optimistic_spin and __mutex_trylock don't actually use it. （Or I
>> missed something? ）
>
> The purpose of doing spinning after the HANDOFF bit is set is to 
> eliminate the waiter wakeup latency, if possible. Before the HANDOFF 
> bit is set, the lock can be easily stolen and there is no point in 
> adding pressure to the lock cacheline.
>
>
>>
>> Maybe I described the issue not much clearly. Let me try again.
>>
>> The HANDOFF bit aims to avoid lock starvation. Lock starvation is
>> possible because mutex_lock（） allows lock stealing, where a runing( or
>> optimistic spinning) task beats the woken waiter to the acquire. So
>> maintainer add HANDOFF bit, once the stealing happened, the top-waiter
>> will must get the lock at the second wake up due to the HANDOFF bit.
>>
>> However, the fact is if the stealing happened, the HANDOFF will must be
>> clear by the thief task. Hence the top-waiter still might starve at the
>> second wake up.
>>
> I think you have some confusion here. If the HANDOFF bit is set before 
> the lock is stolen by an optimistic spinner, lock stealing can't 
> happen which is the point of having a HANDOFF bit. Also the clearing 
> of the HANDOFF bit isn't done by the task that steal the lock, it is 
> done by the current lock holder (i.e. the task that held the lock when 
> the HANDOFF bit was set) in the unlock path. It can be a lock stealer 
> that stole the lock before the HANDOFF bit is set. Of course, it will 
> be a bug if the current code doesn't actually do that. 

Oh, you are right. The current code doesn't actually prevent lock 
stealer from actually stealing the lock in the special case that the 
lock is in the unlock state when the HANDOFF bit is set. In this case, 
it is free for all and whoever gets the lock will also clear the the 
HANDOFF bit. The comment in __mutex_trylock_or_owner() about "We set the 
HANDOFF bit" isn't quite right.

One way to address this issue is to enforce the rule that non-first 
waiter can't steal the lock when the HANDOFF bit is set. That probably 
eliminates the need of a separate PICKUP bit.

Alternatively, we can let this state happens similar to what your patch 
proposes. However, we should clearly document in the code this special 
race condition.

Cheers,
Longman


