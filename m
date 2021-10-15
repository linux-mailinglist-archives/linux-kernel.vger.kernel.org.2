Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C5B42E9FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhJOH0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbhJOH0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:26:22 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3170C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:24:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so6639577pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1cq04QVODDYvQigVED+4WJakpryrkwsEBQDStfZC3II=;
        b=SvGxmUt5gDMdvHfTFkrH8bYpaaWtvtYXveYAJbDmeeAivuoA1gPdAJTN1XeM/Zl/+e
         94UX5na7k/KFOhRxSPSXGDjypI3ZFWRaPaIO3EqTouANr/CAsxMP6pvY+1Bp+nPuhOYv
         HpIJmfVzpWrlhEysPFiuFrzFOJikpzV/sFtHVvLVF73Sv9K7PbNHCwMWLuJ9dL/igQkm
         G3p0VY0qYQ0crn2Z2StHsPnN9op2OYAVLrRr2sxmQIS0jcQVZqsF7ibu/xM/qDV31One
         K/TA2BXzHMtEZZh4VkyDB5sFz+x7JeSXQJkEVjFbUWsIrmigFIwuYlyrCBobtT1Xzx/y
         l1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1cq04QVODDYvQigVED+4WJakpryrkwsEBQDStfZC3II=;
        b=Aaojl2oiJ0be+93kF7hDoA5QY3DCREnrna3xgowtxDwwh+4la9qxOKxzvpsQ7gGQD8
         8tQakNfas8oqd5lfkdwmPwBz6w0oL1+cu6xTzwff84kUysdfWiulNb46EmDnsVqoO8kw
         dRu1LQ0O3FfY9zKbBcXKgUbjOU28INHtb5E8/p9nt9n35C22pFGuaDMiVcoqRiFBWEli
         /U4pmXd+BMUsh3/PbYE90Amo8iSn7ea4vgD69fL2r13P7//GqhgSkh8SZXDb2swkOJTJ
         EAeGhFRQntRE1lNbdQSMkjEKc4/tiniT9q/rs0QCedEnLV4r3wZ7zsNqMgyJSU//BJy/
         CVcg==
X-Gm-Message-State: AOAM531951iPV27YS3y3BrPI3RX0077wY2bTP4NWrmRg6wEaA+WdKOpg
        gLZhvYIs6gFBFCY9JlKGL7cKu2Y5/qU=
X-Google-Smtp-Source: ABdhPJz9INn+hMXAkarZl8uOhafqlxGmFLBhPPsUhUkvV9FsX6TGvA+CdLW/MqbQCC3Te5jHq+DHuw==
X-Received: by 2002:a17:90b:3b44:: with SMTP id ot4mr11999532pjb.73.1634282655170;
        Fri, 15 Oct 2021 00:24:15 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.114])
        by smtp.gmail.com with ESMTPSA id e6sm4240665pfm.212.2021.10.15.00.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 00:24:14 -0700 (PDT)
Subject: Re: [PATCH] Clocksource: Avoid misjudgment of clocksource
To:     yanghui <yanghui.def@bytedance.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20211008080305.13401-1-yanghui.def@bytedance.com>
 <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
 <c70a418d-4748-6876-ac8a-c9d1b7e94e78@gmail.com>
 <CALAqxLVgQ6QEThWaN65nOW9F_XCh7885n9RigAQDU+OgDntS5g@mail.gmail.com>
 <6b715fb7-9850-04f3-4ab8-1a2a8a2cdfbf@gmail.com>
 <CALAqxLWgw8tA1Lrg27JUUFrGWCQqPQXmhjHyjsTRA5a4qingkg@mail.gmail.com>
 <95c1a031-6751-f90f-d003-b74fbec0e9d8@gmail.com>
 <d528515c-4c74-a948-1db5-cba77d692ef3@bytedance.com>
 <6cf3b695-0f62-a67a-513d-4911be0f6a57@bytedance.com>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <1282d837-eee1-856f-d102-85b0c70739ad@gmail.com>
Date:   Fri, 15 Oct 2021 15:24:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6cf3b695-0f62-a67a-513d-4911be0f6a57@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

>>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>>> index b8a14d2..87f3b67 100644
>>> --- a/kernel/time/clocksource.c
>>> +++ b/kernel/time/clocksource.c
>>> @@ -119,6 +119,7 @@
>>>   static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
>>>   static DEFINE_SPINLOCK(watchdog_lock);
>>>   static int watchdog_running;
>>> +static unsigned long watchdog_start_time;
>>>   static atomic_t watchdog_reset_pending;
>>>   static inline void clocksource_watchdog_lock(unsigned long *flags)
>>> @@ -356,6 +357,7 @@ static void clocksource_watchdog(struct timer_list *unused)
>>>       int next_cpu, reset_pending;
>>>       int64_t wd_nsec, cs_nsec;
>>>       struct clocksource *cs;
>>> +    unsigned long max_jiffies;
>>>       u32 md;
>>>       spin_lock(&watchdog_lock);
>>> @@ -402,6 +404,10 @@ static void clocksource_watchdog(struct timer_list *unused)
>>>           if (atomic_read(&watchdog_reset_pending))
>>>               continue;
>>> +        max_jiffies = nsecs_to_jiffies(cs->max_idle_ns);
>>> +        if (time_is_before_jiffies(watchdog_start_time + max_jiffies))
>>> +            continue;
>>> +
> 
> Hi John:
> What do you think of this suggest？If the interval between two executions of the function clocksource_watchdog() exceeds max_idle_ns. We think the current judement is unreasonable,so we skip this judgment.

I feel that there are still some things that need to be discussed. This
solution may still fail in some scenarios. Assume that tick_do_timer_cpu
is CPU1 and clocksource watchdog is CPU2. At a certain point in time, CPU1
updates jiffies, and then the interrupt is closed for some reason, then
jiffies will not be updated. At the same time, the clocksource watchdog of
CPU2 is activated, and still delayed for a period of time due to high load.
Since the jiffies is not updated, this judgment should fail at this time. 
But I think it might be necessary to troubleshoot other problems, because
the interrupt should not closed for a long time. How do you think about
this scene.

Thanks.
>>>           /* Check the deviation from the watchdog clocksource. */
>>>           md = cs->uncertainty_margin + watchdog->uncertainty_margin;
>>>           if (abs(cs_nsec - wd_nsec) > md) {
>>> @@ -474,6 +480,7 @@ static void clocksource_watchdog(struct timer_list *unused)
>>>        * pair clocksource_stop_watchdog() clocksource_start_watchdog().
>>>        */
>>>       if (!timer_pending(&watchdog_timer)) {
>>> +        watchdog_start_time = jiffies;
>>>           watchdog_timer.expires += WATCHDOG_INTERVAL;
>>>           add_timer_on(&watchdog_timer, next_cpu);
>>>       }
>>> @@ -488,6 +495,7 @@ static inline void clocksource_start_watchdog(void)
>>>       timer_setup(&watchdog_timer, clocksource_watchdog, 0);
>>>       watchdog_timer.expires = jiffies + WATCHDOG_INTERVAL;
>>>       add_timer_on(&watchdog_timer, cpumask_first(cpu_online_mask));
>>> +    watchdog_start_time = jiffies;
>>>       watchdog_running = 1;
>>>   }
>>>
>>>
>>>> thanks
>>>> -john
>>>>
>>
>> It looks good to me.
>> thanks.
> 
