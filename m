Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CF2431653
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhJRKoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhJRKn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:43:58 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2434DC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:41:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c29so14419603pfp.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=WbO711lZDlz/pOfI6lj/LIxiV3S8JdUOtW5IRCJxTWA=;
        b=FfIfoAubRRROU5D/gCrXhUONlV37jQSp6ioa4wYlZYDLcqkfxdtZccu7UECtuN0d8r
         IMZe1X1CwDrmCmKWkLccr6ZrG66gGW/91QaFrPv5SV51nLFiVM1BrQJHC0iopRjpc088
         3C1NxDG1+lC3Kmlpwrpl5RNsbKkHow9rSaX6wYGUxGW3sKSr6watQoQIrzwjduTN9LGK
         8cDN6F2q/EuLHerkXT47kbIFO4GHqZgfmxDhUk9mPmq9gCpBVvqLG8R1Ir1YfreCucr/
         D3Ojye+ae0c0YNbolFwuv8Xiskw2pUgeMZtROA46AdZ6e/RnO1f/LJ80hKtyxN2vrAXB
         IkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WbO711lZDlz/pOfI6lj/LIxiV3S8JdUOtW5IRCJxTWA=;
        b=i7vzXPCvIpsoDcJgXHwbS1XNU9TOeKQjR2oC1HP9y+dKaet650vdbBLZUtK4BEMvdT
         nyVM6kJDlkUTbiLN99AyktpnTsd9dCvOb3FtPVgzeqly3rJl6/KtdaBhdAF8KQjZZNMX
         Qosi79WPaG3OvA9LdQSor/3YELkGJxvjTmBmwTd+vxHxFsDPIq1Ymi9UT9CWdXqRPehS
         Zcni2RM4beycCwK12AqH5SaDGiPiOFF7ls8MBvXK649V5R0WRZp0EgSQCqPOI168u7WU
         9dSu8DF5jTqBX+QKpdK8KZQ+pWbTaWJnzuBxxfK7qAjhmqBZTXUv4kjNSxK5vMxGSeG6
         XE8g==
X-Gm-Message-State: AOAM5313J4E6OK7JTTss/AWAZHYpaC2pdVLsjkAKoALGwFF3Lo4cIQor
        KcZjF/2kdfoVkL88+IhhBHdZOA==
X-Google-Smtp-Source: ABdhPJzRL28jvo0X6pJhTmOH7G/xmhlU3qaUqk8F9V6qb4VGTDPjG8NkYvu7fRDz011tHVNOAM8TvA==
X-Received: by 2002:a63:4a18:: with SMTP id x24mr22758908pga.209.1634553707569;
        Mon, 18 Oct 2021 03:41:47 -0700 (PDT)
Received: from [10.76.34.190] ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id 17sm12948412pgr.10.2021.10.18.03.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 03:41:47 -0700 (PDT)
Message-ID: <d5ed22b4-cb3a-1c69-b173-90598c5b8204@bytedance.com>
Date:   Mon, 18 Oct 2021 18:41:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: [PATCH] Clocksource: Avoid misjudgment of clocksource
To:     John Stultz <john.stultz@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, shli@fb.com
References: <20211008080305.13401-1-yanghui.def@bytedance.com>
 <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
 <665f749e-b71e-a793-d759-87f7cf89677c@bytedance.com>
 <CALAqxLXWVpxTwEssBBUnS2ZYTpaCr3cue_dw5ZmEm5ZQ8Wf=wg@mail.gmail.com>
 <ad3d7e5d-cac1-5773-95f9-cc8f3cfd63a4@bytedance.com>
 <CALAqxLVn3U=Kj8BOcavQvF86ZZ2HgR_8iLb-zt4z_Fc=-=PSbQ@mail.gmail.com>
From:   yanghui <yanghui.def@bytedance.com>
In-Reply-To: <CALAqxLVn3U=Kj8BOcavQvF86ZZ2HgR_8iLb-zt4z_Fc=-=PSbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/10/12 下午1:02, John Stultz 写道:
> On Sat, Oct 9, 2021 at 2:02 AM yanghui <yanghui.def@bytedance.com> wrote:
>>
>>
>>
>> 在 2021/10/9 上午11:38, John Stultz 写道:
>>> On Fri, Oct 8, 2021 at 8:22 PM yanghui <yanghui.def@bytedance.com> wrote:
>>>> 在 2021/10/9 上午7:45, John Stultz 写道:
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
>>>>>>     kernel/time/clocksource.c | 6 +++++-
>>>>>>     1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>>>>>> index b8a14d2fb5ba..d535beadcbc8 100644
>>>>>> --- a/kernel/time/clocksource.c
>>>>>> +++ b/kernel/time/clocksource.c
>>>>>> @@ -136,8 +136,10 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
>>>>>>
>>>>>>     /*
>>>>>>      * Interval: 0.5sec.
>>>>>> + * MaxInterval: 1s.
>>>>>>      */
>>>>>>     #define WATCHDOG_INTERVAL (HZ >> 1)
>>>>>> +#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
>>>>>>
>>>>>>     static void clocksource_watchdog_work(struct work_struct *work)
>>>>>>     {
>>>>>> @@ -404,7 +406,9 @@ static void clocksource_watchdog(struct timer_list *unused)
>>>>>>
>>>>>>                    /* Check the deviation from the watchdog clocksource. */
>>>>>>                    md = cs->uncertainty_margin + watchdog->uncertainty_margin;
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
>>>>      Yes, only to check watchdog delta is more reasonable.
>>>>      I think Only have dmesg is not enough, because if tsc was be misjudged
>>>>      as unstable then switch to hpet. And hpet is very expensive for
>>>>      performance, so if we want to switch to tsc the only way is to reboot
>>>>      the server. We need to prevent the switching of the clock source in
>>>>      case of misjudgment.
>>>>      Circumstances of misjudgment:
>>>>      if clocksource_watchdog is executed after 10sec, the value of wd_delta
>>>>      and cs_delta also be about 10sec, also the value of (cs_nsec- wd_nsec)
>>>>      will be magnified 20 times(10sec/0.5sec).The delta value is magnified.
>>>
>>> Yea, it might be worth calculating an error rate instead of assuming
>>> the interval is fixed, but also just skipping the check may be
>>> reasonable assuming timers aren't constantly being delayed (and it's
>>> more of a transient state).
>>>
>>> At some point if the watchdog timer is delayed too much, the watchdog
>> I mean the execution cycle of this function(static void
>> clocksource_watchdog(struct timer_list *unused)) has been delayed.
>>
>>> hardware will fully wrap and one can no longer properly compare
>>> intervals. That's why the timer length is chosen as such, so having
>>> that timer delayed is really pushing the system into a potentially bad
>>> state where other subtle problems are likely to crop up.
>>>
>>> So I do worry these watchdog robustness fixes are papering over a
>>> problem, pushing expectations closer to the edge of how far the system
>>> should tolerate bad behavior. Because at some point we'll fall off. :)
>>
>> Sorry,I don't seem to understand what you mean. Should I send your Patch
>> v2 ?
> 
> Sending a v2 is usually a good step (persistence is key! :)
> 
> I'm sorry for being unclear in the above. I'm mostly just fretting
> that the watchdog logic has inherent assumptions that the timers won't
> be greatly delayed. Unfortunately the reality is that the timers may
> be delayed. So we can try to add some robustness (as your patch does),
> but at a certain point, the delays may exceed what the logic can
> tolerate and produce correct behavior. I worry that by pushing the
> robustness up to that limit, folks may not recognize the problematic
> behavior (greatly delayed timers - possibly caused by drivers
> disabling irqs for too long, or bad SMI logic, or long virtualization
> pauses), and think the system is still working as designed, even

I think we can increase the value of WATCHDOG_MAX_INTERVAL_NS up to
20sec(soft lockup time) or more longer. So we can filter those timer 
delays caused by non-softlockup as your said(drivers disabling irq, bad
SMI logic ...).
I think this method can solve the problem that the softlock is
too long and the clocksource is incorrectly switched, resulting
in performance degradation.
> though its regularly exceeding the bounds of the assumptions in the
> code. So without any feedback that something is wrong, those bounds
> will continue to be pushed until things really break in a way we
> cannot be robust about.
> 
> That's why I was suggesting adding some sort of printk warning when we
> do see a number of delayed timers so that folks have some signal that
> things are not as they are expected to be.
> 
> thanks
> -john
> 
