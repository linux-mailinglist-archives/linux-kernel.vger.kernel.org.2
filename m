Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61107403BAC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349309AbhIHOl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 10:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231164AbhIHOl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631112017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F0mS/4vH+akbhx3KmKiVesBsbwWaeG1PhCRwFwsmwm4=;
        b=XhJNvncY/kFTOOvP/oc6U+NuHKobjBRhetort0Q+mJSDosGIaKl+RxkDH87kR+o1fYdlLw
        m9LRkzOzOA89C+2l9nd5weHfs3F6HqvGtAm+ilZjOi7tJRlvYez84Jd1lNCOuX1C2+daZd
        UL0+g4+bRi6jVw4lCwHBXt5LQYdY0wc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-8aXf3lXuMAmVuIIEd5ErFQ-1; Wed, 08 Sep 2021 10:40:16 -0400
X-MC-Unique: 8aXf3lXuMAmVuIIEd5ErFQ-1
Received: by mail-qt1-f197.google.com with SMTP id o7-20020a05622a138700b002a0e807258bso2452694qtk.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 07:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=F0mS/4vH+akbhx3KmKiVesBsbwWaeG1PhCRwFwsmwm4=;
        b=fClKXg0mEtLww3DMEolOEWlri4RPH+xUEsBfgIbarU3m2uF/kPt1ZYZ/8W0iW8g96i
         rl6JuVZv6ivZEmER3kOLu7P1k2/1+bsUlF/qFWgse55ov66XgCnZKTa2l2EvA46M6W+H
         5lyQn44VNbjUJODYTYUA9GLHHRccb+PLK0w8khxfiaCY1wJZ9YIh5wLM4pVH8xMnV0Pq
         pbxhM8+TxiABGo3favNmLztNOHeN2JEWCFx0hw5H1/zg5Eprcc3r3EHbHcSZhcVcRauv
         Iv8/WyANf2wAYSd5Q3Axda9362ZYzMw2hvuqSPvY5klsvp6Mosw8QJl4Gqx8dtwOMoeN
         AZyA==
X-Gm-Message-State: AOAM531ngU6z+cJgypoitAJrSOeo3fmMliirDbv6wyh5GPnc5wRjG9ty
        YYDkausehOo6YCL7dr7A4p0ptFs2i6pRGZq2w/zdX8Vi1LonGz73O8B3xsr0aOOoYjDLCp2UY8B
        8McLNl/mVK7GF7CXnniRJcKxW
X-Received: by 2002:ad4:5f06:: with SMTP id fo6mr4293723qvb.32.1631112016420;
        Wed, 08 Sep 2021 07:40:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/QsCtIYTif18mNNXhu/aYeBjgKlf815YDrQE6oMXEjqwGIZImLb3bnFRl+eOk1YZkdCP9HA==
X-Received: by 2002:ad4:5f06:: with SMTP id fo6mr4293695qvb.32.1631112016200;
        Wed, 08 Sep 2021 07:40:16 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id d68sm1882756qke.19.2021.09.08.07.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 07:40:15 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] lockdep: Let lock_is_held_type() detect recursive read
 as read
To:     Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210901162255.u2vhecaxgjsjfdtc@linutronix.de>
 <9af2b074-9fcf-5aea-f37d-9b2482146489@redhat.com>
 <20210903084001.lblecrvz4esl4mrr@linutronix.de>
 <YTgc8xXuVlpOhoUT@boqun-archlinux>
Message-ID: <959eddbd-799b-3b10-0f30-0209f883d5ed@redhat.com>
Date:   Wed, 8 Sep 2021 10:40:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YTgc8xXuVlpOhoUT@boqun-archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 10:16 PM, Boqun Feng wrote:
> On Fri, Sep 03, 2021 at 10:40:01AM +0200, Sebastian Andrzej Siewior wrote:
>> lock_is_held_type(, 1) detects acquired read locks. It only recognized
>> locks acquired with lock_acquire_shared(). Read locks acquired with
>> lock_acquire_shared_recursive() are not recognized because a `2' is
>> stored as the read value.
>>
>> Rework the check to additionally recognise lock's read value one and two
>> as a read held lock.
>>
>> Fixes: e918188611f07 ("locking: More accurate annotations for read_lock()")
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>> v1…v2:
>>    - simplify the read check to !!read as suggested by Waiman Long.
>>
>>   kernel/locking/lockdep.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- a/kernel/locking/lockdep.c
>> +++ b/kernel/locking/lockdep.c
>> @@ -5366,7 +5366,7 @@ int __lock_is_held(const struct lockdep_
>>   		struct held_lock *hlock = curr->held_locks + i;
>>   
>>   		if (match_held_lock(hlock, lock)) {
>> -			if (read == -1 || hlock->read == read)
>> +			if (read == -1 || hlock->read == !!read)
> I think this should be:
>
> 	!!hlock->read == read
>
> With that,
>
> Acked-by: Boqun Feng <boqun.feng@gmail.com>
>
You are right. It should be the other way around. read can only be -1, 
0, 1 while hlock->read can be 0, 1, 2.

Cheers,
Longman

