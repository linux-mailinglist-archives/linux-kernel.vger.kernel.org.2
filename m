Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE80F429D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 07:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhJLFZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 01:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhJLFZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 01:25:13 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39770C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 22:23:12 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x130so7660017pfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 22:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=COcvRsCsEe6tJq554tZFYlkfAaR6wJVU63fFR7L7ghg=;
        b=qm1nyhlLhyEkEk2l3Z3heSzErciPgzFirWYzV9CvMFO164MkCnFfjgOsXcP/psLT8a
         Wb0BxK2/3pJapWjng2fw8rEWJJbD8C/+BvBCceaaRPssisMJubJvHw3v4ixmdRbc33a5
         Ps7T5xsXDwYBsGbzd4ZVgZPGGp9rMFy0e5uegFbi8Bcz7jG9tiNeNel/A7c1L0ZQFz9I
         H3yS/otQqs7AucPOVXUSYSwQp+fbRG5tardFO2K1g+NEobMOOOL96KXCj9fJH/U59dKn
         Gh14Kmd7poj7iRevlnxlhvS9+MLZphgVw7bYo1drnwwFzuxtWJkf6XOT86ko3+DQrPs8
         auaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=COcvRsCsEe6tJq554tZFYlkfAaR6wJVU63fFR7L7ghg=;
        b=7xuAPWHXYxayy79sVUwoExjsSakG9zM3+FbVWoix8CIw+2VAXC/6nW4c5IyOZlpyE0
         dUZ2x0+9mcnj7y2NEIRgMvEyWBXKbdV6TTe+opz2EiKL9P0nOEl5b8Do92eoneOHpNfT
         Dc81VrswckJ1bbMMnu1EUCnbBcv2z4xPx+rtJVT6frZL8gNjTH+2YbZ7tY9qJzYJ2zIq
         e6UK8vkkbovi2eZQlVJQS4aZJ7MITZEriKHpt/zqAxrNQjd617bdVGTWd+/JfDuUaF3u
         To/Np4ltvN9dOL65LgFMLMt75r4hXNau2U6WDLYPEbkR7ExrE7eRiFMD/r/tzMP3s0l6
         gTMQ==
X-Gm-Message-State: AOAM531BRCnjS5pMw46Ldz40WinV8R12xM7lBTVhMg7IG1A3/BYnt7/9
        0LnAxBh4hwJDnzRMqRBJ/bZQnIdL2G2bhEcN
X-Google-Smtp-Source: ABdhPJz63qgnIpHTe9vzEkqxcUAFExbN1KwBAgpODg+SoDCTZ83Js/hGdNONrm61lyoTaLodfCUC2g==
X-Received: by 2002:a62:64c9:0:b0:44d:27ba:9a8e with SMTP id y192-20020a6264c9000000b0044d27ba9a8emr6421116pfb.2.1634016191461;
        Mon, 11 Oct 2021 22:23:11 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.114])
        by smtp.gmail.com with ESMTPSA id v21sm2092513pgo.35.2021.10.11.22.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 22:23:11 -0700 (PDT)
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
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <6b715fb7-9850-04f3-4ab8-1a2a8a2cdfbf@gmail.com>
Date:   Tue, 12 Oct 2021 13:21:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLVgQ6QEThWaN65nOW9F_XCh7885n9RigAQDU+OgDntS5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



John Stultz wrote on 2021/10/12 12:52 下午:
> On Sat, Oct 9, 2021 at 7:04 AM brookxu <brookxu.cn@gmail.com> wrote:
>>
>> hello
>>
>> John Stultz wrote on 2021/10/9 7:45:
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
>>>>  kernel/time/clocksource.c | 6 +++++-
>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>>>> index b8a14d2fb5ba..d535beadcbc8 100644
>>>> --- a/kernel/time/clocksource.c
>>>> +++ b/kernel/time/clocksource.c
>>>> @@ -136,8 +136,10 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
>>>>
>>>>  /*
>>>>   * Interval: 0.5sec.
>>>> + * MaxInterval: 1s.
>>>>   */
>>>>  #define WATCHDOG_INTERVAL (HZ >> 1)
>>>> +#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
>>>>
>>>>  static void clocksource_watchdog_work(struct work_struct *work)
>>>>  {
>>>> @@ -404,7 +406,9 @@ static void clocksource_watchdog(struct timer_list *unused)
>>>>
>>>>                 /* Check the deviation from the watchdog clocksource. */
>>>>                 md = cs->uncertainty_margin + watchdog->uncertainty_margin;
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
>> For some fast timeout timers, such as acpi-timer, checking wd_nsec should not
>> make much sense, because when wacthdog is called, the timer may overflow many
>> times.
> 
> Indeed. But in that case we can't tell which way is up. This is what I
> was fretting about when I said:
>> So I do worry these watchdog robustness fixes are papering over a
>> problem, pushing expectations closer to the edge of how far the system
>> should tolerate bad behavior. Because at some point we'll fall off. :)
> 
> If the timer is delayed long enough for the watchdog to wrap, we're
> way out of tolerable behavior. There's not much we can do because we
> can't even tell what happened.
> 
> But in the case where the watchdog has not wrapped, I don't see a
> major issue with trying to be a bit more robust in the face of just
> slightly delayed timers.
> (And yes, we can't really distinguish between slightly delayed and
> watchdog-wrap-interval + slight delay, but in either case we can
> probably skip disqualifying the clocksource as we know something seems
> off)

If we record the watchdog's start_time in clocksource_start_watchdog(), and then
when we verify cycles in clocksource_watchdog(), check whether the clocksource
watchdog is blocked. Due to MSB verification, if the blocked time is greater than
half of the watchdog timer max_cycles, then we can safely ignore the current
verification? Do you think this idea is okay?

> thanks
> -john
> 
