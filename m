Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF793FF805
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 01:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243560AbhIBXrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 19:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbhIBXrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 19:47:18 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE04C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 16:46:19 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r26so4788034oij.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 16:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yhrB4jkxB0rkK0lg6jYD3fQ3rzrSWHvKOoCuFGJll6Q=;
        b=M0ZDgSx78+u74cPiguYj9VDuBfs8UziN2C5/eWoPlyh5KVHtTGoBdkAoiBqbrOVlST
         L6K9Ui5cmzdPYrmE3MofgLVbsCJWrzMyt+GHKRppfDrUxsSDezEvygQ5Fu81yqG0ReYq
         mXbBAh3endhbsFFjbo8w6mny6rV1nKrsDiyVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yhrB4jkxB0rkK0lg6jYD3fQ3rzrSWHvKOoCuFGJll6Q=;
        b=thgLCGB+FSNLWMDIgu7xFtft5KxgK68+2/LKko01nO0tDcQOD9tc7Jadp6DUKW6WIE
         X0ztpFHcKCjw7qbXD9dDFzh70cw4NxBa3l6ARA9hLMXZfNcNQ+Lx1OGSKJzMeNBmMU45
         Pwtoc+4dzN/oTYwwB1uFbOD8GeESt316+eQNmIfTfZrJZYqYRhkC4n6K2eEmanYysRb4
         hBtquqDvZM8/kcsnG1hOAvEWywHUQmQX5g9VlcaykVUdGOcKFRvBlFvH9S20JEZN359t
         XOz0kZ2VWNXHya6sMnavbH03cXz72Ix4VTyNcDRQOQAD0uynkA2LlfwJ/LkzjruM+cB1
         y+Qg==
X-Gm-Message-State: AOAM5307W1pvCc6Lsv3gTEdx2aIAsnNxbMg+xI9QceIIgWv/W0VJMaqt
        K5M9ISiDHvuv8ikvx4PWLX3sdw==
X-Google-Smtp-Source: ABdhPJyZk3uni82kYrWf4YjV/QZfCD6qRORXh3zcoWWBWQ2lym3s0vrsnCoNVieoe2RD5ARAbpn9eQ==
X-Received: by 2002:aca:1e11:: with SMTP id m17mr4102489oic.104.1630626378568;
        Thu, 02 Sep 2021 16:46:18 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k8sm676820oom.20.2021.09.02.16.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 16:46:18 -0700 (PDT)
Subject: Re: [PATCH v2] workqueue: Don't record workqueue stack holding
 raw_spin_lock
To:     Marco Elver <elver@google.com>
Cc:     tj@kernel.org, jiangshanlai@gmail.com, akpm@linux-foundation.org,
        andreyknvl@gmail.com, dvyukov@google.com,
        walter-zh.wu@mediatek.com, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210902200134.25603-1-skhan@linuxfoundation.org>
 <CANpmjNPWyp67SSfRiXVYTiqRaMre9XVQzNVM-73PQ6TTjQW3Gw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2bd3759d-cd13-24f5-2cbd-00505d98e0c9@linuxfoundation.org>
Date:   Thu, 2 Sep 2021 17:46:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CANpmjNPWyp67SSfRiXVYTiqRaMre9XVQzNVM-73PQ6TTjQW3Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/21 3:58 PM, Marco Elver wrote:
> On Thu, 2 Sept 2021 at 22:01, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> When CONFIG_PROVE_RAW_LOCK_NESTING=y and CONFIG_KASAN are enabled,
>> kasan_record_aux_stack() runs into "BUG: Invalid wait context" when
>> it tries to allocate memory attempting to acquire spinlock in page
>> allocation code while holding workqueue pool raw_spinlock.
>>

[snip]

>> Fix it by calling kasan_record_aux_stack() conditionally only when
>> CONFIG_PROVE_RAW_LOCK_NESTING is not enabled. After exploring other
>> options such as calling kasan_record_aux_stack() after releasing the
>> pool lock, opting for a least disruptive path of stubbing this record
>> function to avoid nesting raw spinlock and spinlock.
>>

[snip]

>>
>> Fixes: e89a85d63fb2 ("workqueue: kasan: record workqueue stack")
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>> Changes since v1:
>> -- Instead of changing when record happens, disable record
>>     when CONFIG_PROVE_RAW_LOCK_NESTING=y
>>
>>   kernel/workqueue.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index f148eacda55a..435970ef81ae 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -1328,8 +1328,16 @@ static void insert_work(struct pool_workqueue *pwq, struct work_struct *work,
>>   {
>>          struct worker_pool *pool = pwq->pool;
>>
>> -       /* record the work call stack in order to print it in KASAN reports */
>> +       /*
>> +        * record the work call stack in order to print it in KASAN reports
>> +        * Doing this when CONFIG_PROVE_RAW_LOCK_NESTING is enabled results
>> +        * in nesting raw spinlock with page allocation spinlock.
>> +        *
>> +        * Avoid recording when CONFIG_PROVE_RAW_LOCK_NESTING is enabled.
>> +        */
>> +#if !defined(CONFIG_PROVE_RAW_LOCK_NESTING)
> 
> Just "if (!IS_ENABLED(CONFIG_PROVE_RAW_LOCK_NESTING))" should work
> here, however...
> 

Yes. That would work.

> ... PROVE_RAW_LOCK_NESTING exists for PREEMPT_RT's benefit. I don't
> think silencing the debugging tool is the solution, because the bug
> still exists in a PREEMPT_RT kernel.
> 

This silencing is limited in scope to just the insert_work() and when
PROVE_RAW_LOCK_NESTING is enabled. Please see below under your proposed
option 2

> +Cc Sebastian for advice. I may have missed something obvious. :-)
> 

Thanks for adding Sebastian

> I have a suspicion that kasan_record_aux_stack() (via
> stack_depot_save()) is generally unsound on PREEMPT_RT kernels,
> because allocating memory cannot be done within raw-locked critical
> sections because memory allocation is preemptible on RT. Even using
> GWP_NOWAIT/ATOMIC doesn't help (which kasan_record_aux_stack() uses).
> 
> It follows that if we do not know what type of locks may be held when
> calling kasan_record_aux_stack() we have a bug in RT.
> 
> I see 3 options:
> 
> 1. Try to move kasan_record_aux_stack() where no raw lock is held.
> (Seems complicated per v1 attempt?)
> 

Yes. kasan_record_aux_stack() is better called from insert_work()
prior to insertion. This makes it difficult to do - we don't want
to release the pool lock.

> But ideally we make kasan_record_aux_stack() more robust on RT:
> 
> 2. Make kasan_record_aux_stack() a no-op on RT (and if
> PROVE_RAW_LOCK_NESTING). Perhaps overkill?
> 

I considered it and didn't go down that route because it is a big
hammer. I choose to just disable the debug code in insert_work()
path instead. Not ideal, but limits the disable to a narrower
scope. Limiting the scope in kasan_record_aux_stack() extends to
all other paths where kasan_record_aux_stack() is used.

> 3. Try to not allocate memory in stackdepot. Not sure this is feasible
> without telling stackdepot to preallocate the max slabs on boot if RT.
> 

We could. I have to ask though how much of the real world cases do we
need to impact for the debug code to work?

> Anything else? Because I don't think any of the options are satisfying.
> 

One option to consider is checking dry-run invalid nesting check and
bail out if it is true in kasan_record_aux_stack()

thanks,
-- Shuah
