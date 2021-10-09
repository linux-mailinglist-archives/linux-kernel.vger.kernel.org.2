Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC81442783C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 11:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244276AbhJIJEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 05:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhJIJEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 05:04:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93D6C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 02:02:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so11039168pjw.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 02:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=ytt3WCg91eCNZjpSJuDFk04EFIJndQ+IVu53Sddgxts=;
        b=BMJh9CoYoLSK483lqgaxKiqc1i4rbMsi7dHs4LIDn7EW60lJZh+8V1ICNXdNviuM31
         +0GVpIl4OSMMFdRDBZeKk/+cWq52ZwwUF2uNjPXeHWVmDULLMjbjVVJ6fvn7PVNuSLe0
         XiRlfST0zdMNMEaKZVEWKVmCOYB8Q28yNMYnmPRypAZ3/W7PrrzV+P5SevGdxulr+KZl
         I94quIADKEL/NfbpBHH5Tj+Rnl79RZQbr+6DrFuOnZo7w5wuuFoYcsVTACj79vqJWHdq
         pWibraS6oDxGdCQhvtVeChQXBmuS5wml9bdWJ5/HFwMD0XtuszPXsInOVQjUXigEFpZR
         fksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ytt3WCg91eCNZjpSJuDFk04EFIJndQ+IVu53Sddgxts=;
        b=03EEbKSOjsObVUMxSsKdeu2OZ5ut/s1E7LgtFHyR9nrvJqNzWsscIVwz2w4H9A9G16
         6su3Zvt5N+/IlcXmkAKpF0VqP0H+WBattAS5Hong28Y6ageDyyy0IbQLq6h4cyIlKznf
         av0T97J1vR0QhQc/x4I3ILsSDxgGZi2CnAkx10CQW9QGKmdwL9mbmSZwhC8wUkjoKyTQ
         EB3sXp/C94y/U4FVAwwO/enPJh7kVjfzMOlxWUbTxbjt/wIkViGd8Y0kWzIYfWAJHOcG
         1nmtipiHo2yH1JLBF2N0ihPOe7Jf/fznPD4JgzHcrfgALYkVZJ/HRxxApO4wAgrLzp+b
         4NzA==
X-Gm-Message-State: AOAM5333gKh30LlU5tKf0z716QK6sWzqeJZJrBnXOmKPiY4r6pKEBkP6
        w9NzUeeiiR+u2HBU1AAcx+JBzw==
X-Google-Smtp-Source: ABdhPJzzGNAEiznsVxQdTECGGLVnK/AfgBo9InHms4uyKkf2mCgrrHBQ3EOjFYdahdz347Qfq7PMZA==
X-Received: by 2002:a17:90b:4c0f:: with SMTP id na15mr17070904pjb.200.1633770127224;
        Sat, 09 Oct 2021 02:02:07 -0700 (PDT)
Received: from [10.254.129.32] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id p189sm1588836pfp.167.2021.10.09.02.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 02:02:06 -0700 (PDT)
Message-ID: <ad3d7e5d-cac1-5773-95f9-cc8f3cfd63a4@bytedance.com>
Date:   Sat, 9 Oct 2021 17:02:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [External] Re: [PATCH] Clocksource: Avoid misjudgment of
 clocksource
To:     John Stultz <john.stultz@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20211008080305.13401-1-yanghui.def@bytedance.com>
 <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
 <665f749e-b71e-a793-d759-87f7cf89677c@bytedance.com>
 <CALAqxLXWVpxTwEssBBUnS2ZYTpaCr3cue_dw5ZmEm5ZQ8Wf=wg@mail.gmail.com>
From:   yanghui <yanghui.def@bytedance.com>
In-Reply-To: <CALAqxLXWVpxTwEssBBUnS2ZYTpaCr3cue_dw5ZmEm5ZQ8Wf=wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/10/9 上午11:38, John Stultz 写道:
> On Fri, Oct 8, 2021 at 8:22 PM yanghui <yanghui.def@bytedance.com> wrote:
>> 在 2021/10/9 上午7:45, John Stultz 写道:
>>> On Fri, Oct 8, 2021 at 1:03 AM yanghui <yanghui.def@bytedance.com> wrote:
>>>>
>>>> clocksource_watchdog is executed every WATCHDOG_INTERVAL(0.5s) by
>>>> Timer. But sometimes system is very busy and the Timer cannot be
>>>> executed in 0.5sec. For example,if clocksource_watchdog be executed
>>>> after 10sec, the calculated value of abs(cs_nsec - wd_nsec) will
>>>> be enlarged. Then the current clocksource will be misjudged as
>>>> unstable. So we add conditions to prevent the clocksource from
>>>> being misjudged.
>>>>
>>>> Signed-off-by: yanghui <yanghui.def@bytedance.com>
>>>> ---
>>>>    kernel/time/clocksource.c | 6 +++++-
>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>>>> index b8a14d2fb5ba..d535beadcbc8 100644
>>>> --- a/kernel/time/clocksource.c
>>>> +++ b/kernel/time/clocksource.c
>>>> @@ -136,8 +136,10 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
>>>>
>>>>    /*
>>>>     * Interval: 0.5sec.
>>>> + * MaxInterval: 1s.
>>>>     */
>>>>    #define WATCHDOG_INTERVAL (HZ >> 1)
>>>> +#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
>>>>
>>>>    static void clocksource_watchdog_work(struct work_struct *work)
>>>>    {
>>>> @@ -404,7 +406,9 @@ static void clocksource_watchdog(struct timer_list *unused)
>>>>
>>>>                   /* Check the deviation from the watchdog clocksource. */
>>>>                   md = cs->uncertainty_margin + watchdog->uncertainty_margin;
>>>> -               if (abs(cs_nsec - wd_nsec) > md) {
>>>> +               if ((abs(cs_nsec - wd_nsec) > md) &&
>>>> +                       cs_nsec < WATCHDOG_MAX_INTERVAL_NS &&
>>>
>>> Sorry, it's been awhile since I looked at this code, but why are you
>>> bounding the clocksource delta here?
>>> It seems like if the clocksource being watched was very wrong (with a
>>> delta larger than the MAX_INTERVAL_NS), we'd want to throw it out.
>>>
>>>> +                       wd_nsec < WATCHDOG_MAX_INTERVAL_NS) {
>>>
>>> Bounding the watchdog interval on the check does seem reasonable.
>>> Though one may want to keep track that if we are seeing too many of
>>> these delayed watchdog checks we provide some feedback via dmesg.
>>
>>     Yes, only to check watchdog delta is more reasonable.
>>     I think Only have dmesg is not enough, because if tsc was be misjudged
>>     as unstable then switch to hpet. And hpet is very expensive for
>>     performance, so if we want to switch to tsc the only way is to reboot
>>     the server. We need to prevent the switching of the clock source in
>>     case of misjudgment.
>>     Circumstances of misjudgment:
>>     if clocksource_watchdog is executed after 10sec, the value of wd_delta
>>     and cs_delta also be about 10sec, also the value of (cs_nsec- wd_nsec)
>>     will be magnified 20 times(10sec/0.5sec).The delta value is magnified.
> 
> Yea, it might be worth calculating an error rate instead of assuming
> the interval is fixed, but also just skipping the check may be
> reasonable assuming timers aren't constantly being delayed (and it's
> more of a transient state).
> 
> At some point if the watchdog timer is delayed too much, the watchdog
I mean the execution cycle of this function(static void 
clocksource_watchdog(struct timer_list *unused)) has been delayed.

> hardware will fully wrap and one can no longer properly compare
> intervals. That's why the timer length is chosen as such, so having
> that timer delayed is really pushing the system into a potentially bad
> state where other subtle problems are likely to crop up.
> 
> So I do worry these watchdog robustness fixes are papering over a
> problem, pushing expectations closer to the edge of how far the system
> should tolerate bad behavior. Because at some point we'll fall off. :)

Sorry,I don't seem to understand what you mean. Should I send your Patch 
v2 ?

thanks
-hui
> 
> thanks
> -john
> 
