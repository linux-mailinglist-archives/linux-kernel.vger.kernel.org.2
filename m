Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601043B8472
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhF3N4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236407AbhF3Nwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625061015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X1s6ZGU7Ei2clicgZUd38j5YVof6F6vYQwTasSbc+gA=;
        b=WCGgAN3rV99jGeRW5XXxTsuZA+mk6VEBLWxQKZo5HyBYU6iNF2JspDcC/gcAk5CgziPzZ/
        WNWflpDaXcbs4OrU+6bzBgoWhhHPySpk9/4Z37p4QjQ69VtR+isOev9aKl0d4fcyJWFiLs
        0IaXZOCGi8WLt2CWflSbIZVMWJqWtsk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-0Lrz77syPoyaw-NxzA8oqg-1; Wed, 30 Jun 2021 09:50:14 -0400
X-MC-Unique: 0Lrz77syPoyaw-NxzA8oqg-1
Received: by mail-qt1-f198.google.com with SMTP id t21-20020a05622a01d5b0290251ab5e37d4so944109qtw.19
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 06:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X1s6ZGU7Ei2clicgZUd38j5YVof6F6vYQwTasSbc+gA=;
        b=uI3mebNro/Bn2zQOeUOU12a5M1eRsNT+NcSs5ULy+IC5Zyhkd/tw79rvyhXG1H9em5
         d9nqUqyA6vFozH+l5EXj5+qWAwuzgJR98Nu2GsDvRzSnO0rmYc0Ro1YVD9K3NLnni2nc
         TmI34hsmTftgq8J4aU/Cc7dwYdCnImD9xR6aKXbOsaDcLrVeBZ5sRr537kbgggw/6+0E
         otH56ZDuKvmZV6783oq7j1H9k/mVTrkH9E+EpGvCXHWmIq8yZLqLe4ICXpeDTp41YS8d
         EfJhn3ZBL+LWopBuJFt9TlJZGIidOkV9N28o5XMkR6uyN6lO6IkEj7PCC+pEolpOZjHP
         ZoHA==
X-Gm-Message-State: AOAM531BVgi6FtdtfAIW56azXzwkYNxhp/yxAFO9lAO6XwY/bRgwFaVl
        XOfzbz6vf/IcpUiMahgiP220spOwvbKjJJ7tSDRNNThn4qNrXxwUbG9OrlwEMIefNYftpFWXHRs
        fo9ur/PLUXpk8dyuCyW5tKves
X-Received: by 2002:ac8:5a81:: with SMTP id c1mr32706772qtc.194.1625061013897;
        Wed, 30 Jun 2021 06:50:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4ZgiB+tAt4p/NZ/eFDSBAFpTxOQVduMgfWMNorzI+jUArN7qo91dl4vyiir8cvFQ/IbYQLA==
X-Received: by 2002:ac8:5a81:: with SMTP id c1mr32706755qtc.194.1625061013664;
        Wed, 30 Jun 2021 06:50:13 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id l6sm13658962qkk.117.2021.06.30.06.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 06:50:12 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/mutex: Reduce chance of setting HANDOFF bit on
 unlocked mutex
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Xu, Yanfei" <yanfei.xu@windriver.com>
References: <20210629201138.31507-1-longman@redhat.com>
 <YNxFkD8qzex9MvQp@hirez.programming.kicks-ass.net>
Message-ID: <ecc0cc97-23ca-5de3-2a12-ed50aa12548c@redhat.com>
Date:   Wed, 30 Jun 2021 09:50:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YNxFkD8qzex9MvQp@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/21 6:21 AM, Peter Zijlstra wrote:
> On Tue, Jun 29, 2021 at 04:11:38PM -0400, Waiman Long wrote:
>
>> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
>> index d2df5e68b503..472ab21b5b8e 100644
>> --- a/kernel/locking/mutex.c
>> +++ b/kernel/locking/mutex.c
>> @@ -118,9 +118,9 @@ static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
>>   		}
>>   
>>   		/*
>> -		 * We set the HANDOFF bit, we must make sure it doesn't live
>> -		 * past the point where we acquire it. This would be possible
>> -		 * if we (accidentally) set the bit on an unlocked mutex.
>> +		 * Always clear the HANDOFF bit before acquiring the lock.
>> +		 * Note that if the bit is accidentally set on an unlocked
>> +		 * mutex, anyone can acquire it.
>>   		 */
>>   		flags &= ~MUTEX_FLAG_HANDOFF;
>>   
>> @@ -180,6 +180,11 @@ static inline void __mutex_set_flag(struct mutex *lock, unsigned long flag)
>>   	atomic_long_or(flag, &lock->owner);
>>   }
>>   
>> +static inline long __mutex_fetch_set_flag(struct mutex *lock, unsigned long flag)
>> +{
>> +	return atomic_long_fetch_or_relaxed(flag, &lock->owner);
>> +}
>> +
>>   static inline void __mutex_clear_flag(struct mutex *lock, unsigned long flag)
>>   {
> Hurmph, so we already have a cmpxchg loop in trylock, might as well make
> that do exactly what we want without holes on.
>
> How's something like the below? Boot tested, but please verify.
>
> ---
>   kernel/locking/mutex.c | 89 ++++++++++++++++++++++++++------------------------
>   1 file changed, 46 insertions(+), 43 deletions(-)

The code looks good to me. It is an even better approach to make sure 
that the HANDOFF will never be set on an unlocked mutex.

Reviewed-by: Waiman Long <longman@redhat.com>

