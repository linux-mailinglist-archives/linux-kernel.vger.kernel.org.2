Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A07429F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbhJLII7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbhJLIIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:08:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B20C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:06:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ls18so15101204pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cir0rNkMhBrCvZqc6YS64//eAxtQvaY9T10QcgTExTA=;
        b=UcBpiHosAoMMuSNxNbXVuat+Guqvjyv/o5VeyNEq6ME1KnrhvN5ZwgsojaSTz14DCu
         9N5ENIXLbn66cVSMf6+E5MFvZtPVelull78aQu5EEngH4NLLnneQ4bT8Lty5kEYb7FUK
         CguyiT+5Lkqotao4LE3wL/tPTbdPqk04xHdehongA/XPyzK89rRTk8Uvz0JJuUvJIF40
         m2QZQaluzJiO9L6ZnifRWZIDuZ8K03gYpNvXGSnWqqO26wBGeEHztsgzhfAQV0gRShX4
         L/JMxKngwHgB+k+oS+Tt56zpkB5Ln5AD/mZhcXk58eIvfI7nEiDeHdr2ZxKlZ2H1TsSk
         rodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cir0rNkMhBrCvZqc6YS64//eAxtQvaY9T10QcgTExTA=;
        b=quU6GLCC//RV0uxzZdMj87+GJc3VwO1iTeevQVEDAdIONUjO0BmkEXRTXW5PxKfi+e
         1LZrhkI8qNC9U7i7RPrcz8NHVEQ0yH4cP6obM1x/uoO8xzDqBMmbXddz0wjF9lmAvYjq
         W869bF7R0FA8Z/igP4qpcRauI7OO469qnDvONF9Y2XGvjHsLX7kWoy8hAFx+VvlOHqCe
         mCxiCuuh09o2YX9OHLixaM7kpr5godYLTAAx0cbtBL7LONgaWQEXS4lAy+1yIDJEk9Bi
         DoIBbJdBalmVwmrNAErXjyjItIelc/M+n8SHvrQJ5OFZ1zGxA6l+EaOsp4r/B/Od/ZG6
         y6tw==
X-Gm-Message-State: AOAM532sOMdJ1KCeYKqPNo7c6V7SHo3PtjwJRSFRoSllEshFzWOHSJ40
        djIVokmI9bjD1rwa230UvEUdYK/GvLz5wA==
X-Google-Smtp-Source: ABdhPJwyEHF+YqOFFfelwebP2Tm11qFO00Rgi7Gv/JT9RPNuEzSLDWgFK5xcnkdQHcUiWvkqkAWkAg==
X-Received: by 2002:a17:90b:3588:: with SMTP id mm8mr4356227pjb.238.1634026012656;
        Tue, 12 Oct 2021 01:06:52 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.111])
        by smtp.gmail.com with ESMTPSA id u4sm10388598pfh.147.2021.10.12.01.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 01:06:52 -0700 (PDT)
Subject: Re: [PATCH] Clocksource: Avoid misjudgment of clocksource
To:     John Stultz <john.stultz@linaro.org>
Cc:     yanghui <yanghui.def@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20211008080305.13401-1-yanghui.def@bytedance.com>
 <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
 <c70a418d-4748-6876-ac8a-c9d1b7e94e78@gmail.com>
 <CALAqxLVgQ6QEThWaN65nOW9F_XCh7885n9RigAQDU+OgDntS5g@mail.gmail.com>
 <6b715fb7-9850-04f3-4ab8-1a2a8a2cdfbf@gmail.com>
 <CALAqxLWgw8tA1Lrg27JUUFrGWCQqPQXmhjHyjsTRA5a4qingkg@mail.gmail.com>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <95c1a031-6751-f90f-d003-b74fbec0e9d8@gmail.com>
Date:   Tue, 12 Oct 2021 16:06:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLWgw8tA1Lrg27JUUFrGWCQqPQXmhjHyjsTRA5a4qingkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



John Stultz wrote on 2021/10/12 13:29:
> On Mon, Oct 11, 2021 at 10:23 PM brookxu <brookxu.cn@gmail.com> wrote:
>> John Stultz wrote on 2021/10/12 12:52 下午:
>>> On Sat, Oct 9, 2021 at 7:04 AM brookxu <brookxu.cn@gmail.com> wrote:
>>>>
>>>> hello
>>>>
>>>> John Stultz wrote on 2021/10/9 7:45:
>>>>> On Fri, Oct 8, 2021 at 1:03 AM yanghui <yanghui.def@bytedance.com> wrote:
>>>>>>
>>>>>> clocksource_watchdog is executed every WATCHDOG_INTERVAL(0.5s) by
>>>>>> Timer. But sometimes system is very busy and the Timer cannot be
>>>>>> executed in 0.5sec. For example,if clocksource_watchdog be executed
>>>>>> after 10sec, the calculated value of abs(cs_nsec - wd_nsec) will
>>>>>> be enlarged. Then the current clocksource will be misjudged as
>>>>>> unstable. So we add conditions to prevent the clocksource from
>>>>>> being misjudged.
>>>>>>
>>>>>> Signed-off-by: yanghui <yanghui.def@bytedance.com>
>>>>>> ---
>>>>>>  kernel/time/clocksource.c | 6 +++++-
>>>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>>>>>> index b8a14d2fb5ba..d535beadcbc8 100644
>>>>>> --- a/kernel/time/clocksource.c
>>>>>> +++ b/kernel/time/clocksource.c
>>>>>> @@ -136,8 +136,10 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
>>>>>>
>>>>>>  /*
>>>>>>   * Interval: 0.5sec.
>>>>>> + * MaxInterval: 1s.
>>>>>>   */
>>>>>>  #define WATCHDOG_INTERVAL (HZ >> 1)
>>>>>> +#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
>>>>>>
>>>>>>  static void clocksource_watchdog_work(struct work_struct *work)
>>>>>>  {
>>>>>> @@ -404,7 +406,9 @@ static void clocksource_watchdog(struct timer_list *unused)
>>>>>>
>>>>>>                 /* Check the deviation from the watchdog clocksource. */
>>>>>>                 md = cs->uncertainty_margin + watchdog->uncertainty_margin;
>>>>>> -               if (abs(cs_nsec - wd_nsec) > md) {
>>>>>> +               if ((abs(cs_nsec - wd_nsec) > md) &&
>>>>>> +                       cs_nsec < WATCHDOG_MAX_INTERVAL_NS &&
>>>>>
>>>>> Sorry, it's been awhile since I looked at this code, but why are you
>>>>> bounding the clocksource delta here?
>>>>> It seems like if the clocksource being watched was very wrong (with a
>>>>> delta larger than the MAX_INTERVAL_NS), we'd want to throw it out.
>>>>>
>>>>>> +                       wd_nsec < WATCHDOG_MAX_INTERVAL_NS) {
>>>>>
>>>>> Bounding the watchdog interval on the check does seem reasonable.
>>>>> Though one may want to keep track that if we are seeing too many of
>>>>> these delayed watchdog checks we provide some feedback via dmesg.
>>>>
>>>> For some fast timeout timers, such as acpi-timer, checking wd_nsec should not
>>>> make much sense, because when wacthdog is called, the timer may overflow many
>>>> times.
>>>
>>> Indeed. But in that case we can't tell which way is up. This is what I
>>> was fretting about when I said:
>>>> So I do worry these watchdog robustness fixes are papering over a
>>>> problem, pushing expectations closer to the edge of how far the system
>>>> should tolerate bad behavior. Because at some point we'll fall off. :)
>>>
>>> If the timer is delayed long enough for the watchdog to wrap, we're
>>> way out of tolerable behavior. There's not much we can do because we
>>> can't even tell what happened.
>>>
>>> But in the case where the watchdog has not wrapped, I don't see a
>>> major issue with trying to be a bit more robust in the face of just
>>> slightly delayed timers.
>>> (And yes, we can't really distinguish between slightly delayed and
>>> watchdog-wrap-interval + slight delay, but in either case we can
>>> probably skip disqualifying the clocksource as we know something seems
>>> off)
>>
>> If we record the watchdog's start_time in clocksource_start_watchdog(), and then
>> when we verify cycles in clocksource_watchdog(), check whether the clocksource
>> watchdog is blocked. Due to MSB verification, if the blocked time is greater than
>> half of the watchdog timer max_cycles, then we can safely ignore the current
>> verification? Do you think this idea is okay?
> 
> I can't say I totally understand the idea. Maybe could you clarify with a patch?
>

Sorry, it looks almost as follows:

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b8a14d2..87f3b67 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -119,6 +119,7 @@
 static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
 static DEFINE_SPINLOCK(watchdog_lock);
 static int watchdog_running;
+static unsigned long watchdog_start_time;
 static atomic_t watchdog_reset_pending;
 
 static inline void clocksource_watchdog_lock(unsigned long *flags)
@@ -356,6 +357,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	int next_cpu, reset_pending;
 	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
+	unsigned long max_jiffies;
 	u32 md;
 
 	spin_lock(&watchdog_lock);
@@ -402,6 +404,10 @@ static void clocksource_watchdog(struct timer_list *unused)
 		if (atomic_read(&watchdog_reset_pending))
 			continue;
 
+		max_jiffies = nsecs_to_jiffies(cs->max_idle_ns);
+		if (time_is_before_jiffies(watchdog_start_time + max_jiffies))
+			continue;
+
 		/* Check the deviation from the watchdog clocksource. */
 		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
 		if (abs(cs_nsec - wd_nsec) > md) {
@@ -474,6 +480,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	 * pair clocksource_stop_watchdog() clocksource_start_watchdog().
 	 */
 	if (!timer_pending(&watchdog_timer)) {
+		watchdog_start_time = jiffies;
 		watchdog_timer.expires += WATCHDOG_INTERVAL;
 		add_timer_on(&watchdog_timer, next_cpu);
 	}
@@ -488,6 +495,7 @@ static inline void clocksource_start_watchdog(void)
 	timer_setup(&watchdog_timer, clocksource_watchdog, 0);
 	watchdog_timer.expires = jiffies + WATCHDOG_INTERVAL;
 	add_timer_on(&watchdog_timer, cpumask_first(cpu_online_mask));
+	watchdog_start_time = jiffies;
 	watchdog_running = 1;
 }


> thanks
> -john
> 
