Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35967432C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 06:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhJSEQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 00:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSEQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 00:16:25 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A693C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 21:14:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q10-20020a17090a1b0a00b001a076a59640so1191534pjq.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 21:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=vf+m4S1uFzOF7CKEj0X8xjItryGCSD/MeU2OELsr6oY=;
        b=PWkLVtzpNxzhoiJKl4JUiilphlybq7ov9GivL55AzxPJ+3K+IqDhllcdawjkSsgeUb
         1jvh15xGpSn6/eKOh23QbOuTgNUbOnHRid2nEcFtHMnvUnYnb+qPIF+vQE/BHPCCyX1/
         bUkvINSdDEK/rSKvcDFPNu3XEg0L/WnL/jQ25DwxKlOpoVC4fD9yk5LtsOfTYPC97QkB
         HWqTXniVQsm5EYH9+W/iKTS2HqmT2C6AEzqyuR+4BbijD6BITnBqjZwk8DarW2D4ig1f
         NiPF6UerV89c4oYSzbqxiCDy/IxmyFxh9uWMVPwZOchLfECCpDeZTf5JOCpox0nIbvJb
         2m+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vf+m4S1uFzOF7CKEj0X8xjItryGCSD/MeU2OELsr6oY=;
        b=sTNjzgjEkNyBBuaDeizYi8na7PE17m2ALC7lKRr7ospAIqH0ERv7xq4leHz1vuXYWY
         C11BvDELRQPIm6H2L7i+MuvOZ9uIvVxaS6IppadEya5pxawYEhxiAkYivAXGMJoYPdRU
         2cm3Ifit/DLMldvSZ3Aowd/76Jz5ex+1re0gRoMUV+GDBZiLeA/EAqV4nUTtqc9PlTh3
         IIJjWkW3Fv4DXtDrTPEdtNcJfqpYkNXwGbYkHojhO519mwVelQfyl2/LkgYIpmDLB/EJ
         Ca4B2xKAOSgih6hMxpjB56wOjjaFAQTHRrxN0TfLYbpIBhjIaZeg9Rtxv5BlPh9joSrw
         ElJA==
X-Gm-Message-State: AOAM533ykl1wWa6ftv7MTTFl8SNzxYa97SdAXsWqwgnpA6O428InAYd6
        OyTFhD/SqU5FgCqBZF97+8aR0g==
X-Google-Smtp-Source: ABdhPJwsIo+xM66EdB/BKBstzFUrLT7MCh4W62alZpTypIP2aL2kWP+YicMcL5NJoQr162VpZmLPvA==
X-Received: by 2002:a17:90a:6a8f:: with SMTP id u15mr3600595pjj.212.1634616853092;
        Mon, 18 Oct 2021 21:14:13 -0700 (PDT)
Received: from [10.76.34.190] ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id q13sm15313987pfj.26.2021.10.18.21.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 21:14:12 -0700 (PDT)
Message-ID: <61381153-634e-489b-848f-7077ce46049a@bytedance.com>
Date:   Tue, 19 Oct 2021 12:14:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: [PATCH] Clocksource: Avoid misjudgment of clocksource
To:     John Stultz <john.stultz@linaro.org>,
        brookxu <brookxu.cn@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, shli@fb.com
References: <20211008080305.13401-1-yanghui.def@bytedance.com>
 <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
 <c70a418d-4748-6876-ac8a-c9d1b7e94e78@gmail.com>
 <CALAqxLVgQ6QEThWaN65nOW9F_XCh7885n9RigAQDU+OgDntS5g@mail.gmail.com>
 <6b715fb7-9850-04f3-4ab8-1a2a8a2cdfbf@gmail.com>
 <CALAqxLWgw8tA1Lrg27JUUFrGWCQqPQXmhjHyjsTRA5a4qingkg@mail.gmail.com>
 <95c1a031-6751-f90f-d003-b74fbec0e9d8@gmail.com>
 <CALAqxLVcc9nscuWT-qFH=JbatVL0c5AxH5B9y3qE1ekG=BZ0aA@mail.gmail.com>
From:   yanghui <yanghui.def@bytedance.com>
In-Reply-To: <CALAqxLVcc9nscuWT-qFH=JbatVL0c5AxH5B9y3qE1ekG=BZ0aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/10/19 上午12:14, John Stultz 写道:
> On Tue, Oct 12, 2021 at 1:06 AM brookxu <brookxu.cn@gmail.com> wrote:
>> John Stultz wrote on 2021/10/12 13:29:
>>> On Mon, Oct 11, 2021 at 10:23 PM brookxu <brookxu.cn@gmail.com> wrote:
>>>> John Stultz wrote on 2021/10/12 12:52 下午:
>>>>> On Sat, Oct 9, 2021 at 7:04 AM brookxu <brookxu.cn@gmail.com> wrote:
>>>> If we record the watchdog's start_time in clocksource_start_watchdog(), and then
>>>> when we verify cycles in clocksource_watchdog(), check whether the clocksource
>>>> watchdog is blocked. Due to MSB verification, if the blocked time is greater than
>>>> half of the watchdog timer max_cycles, then we can safely ignore the current
>>>> verification? Do you think this idea is okay?
>>>
>>> I can't say I totally understand the idea. Maybe could you clarify with a patch?
>>>
>>
>> Sorry, it looks almost as follows:
>>
>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>> index b8a14d2..87f3b67 100644
>> --- a/kernel/time/clocksource.c
>> +++ b/kernel/time/clocksource.c
>> @@ -119,6 +119,7 @@
>>   static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
>>   static DEFINE_SPINLOCK(watchdog_lock);
>>   static int watchdog_running;
>> +static unsigned long watchdog_start_time;
>>   static atomic_t watchdog_reset_pending;
>>
>>   static inline void clocksource_watchdog_lock(unsigned long *flags)
>> @@ -356,6 +357,7 @@ static void clocksource_watchdog(struct timer_list *unused)
>>          int next_cpu, reset_pending;
>>          int64_t wd_nsec, cs_nsec;
>>          struct clocksource *cs;
>> +       unsigned long max_jiffies;
>>          u32 md;
>>
>>          spin_lock(&watchdog_lock);
>> @@ -402,6 +404,10 @@ static void clocksource_watchdog(struct timer_list *unused)
>>                  if (atomic_read(&watchdog_reset_pending))
>>                          continue;
>>
>> +               max_jiffies = nsecs_to_jiffies(cs->max_idle_ns);
>> +               if (time_is_before_jiffies(watchdog_start_time + max_jiffies))
>> +                       continue;
>> +
> 
> Sorry, what is the benefit of using jiffies here?   Jiffies are
> updated by counting the number of tick intervals on the current
> clocksource.
> 
> This seems like circular logic, where we're trying to judge the
> current clocksource by using something we derived from the current
> clocksource.
> That's why the watchdog clocksource is important, as it's supposed to
> be a separate counter that is more reliable (but likely slower) then
> the preferred clocksource.
> 
> So I'm not really sure how this helps.
> 
> The earlier patch by yanghui at least used the watchdog interval to
> decide if the watchdog timer had expired late. Which seemed
> reasonable, but I thought it might be helpful to add some sort of a
> counter so if the case is happening repeatedly (timers constantly
> being delayed) we have a better signal that the watchdog and current
> clocksource are out of sync.  Because again, timers are fired based on

I think only have a signal ls not enough. we need to prevent
clocksource from being incorrectly switched.

The Timer callback function clocksource_watchdog() is executed in the
context of softirq(run_timer_softirq()). So if softirq is disabled for
long time(One situation is long time softlockup), clocksource_watchdog()
will be delay executed.
> the current clocksource. So constant delays likely mean things are
> wrong.
> > thanks
> -john
> 
> thanks
> -john
> 
I think it will be better to add this to my patch:
  /*
   * Interval: 0.5sec.
- * MaxInterval: 1s.
+ * MaxInterval: 20s.
   */
  #define WATCHDOG_INTERVAL (HZ >> 1)
-#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
+#define WATCHDOG_MAX_INTERVAL_NS (20 * NSEC_PER_SEC)

thanks


