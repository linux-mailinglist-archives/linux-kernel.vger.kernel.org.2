Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643C64276E6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 05:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244198AbhJIDYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 23:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhJIDYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 23:24:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE192C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 20:22:53 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so10643534pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 20:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=VeTmaxVF4TBZ5ceO194kE6I8QDY5rOGwcUY1j5F3fgI=;
        b=TtHis15HBeBcisgBdbT3fUnYFmHfRS5+npg5e4AcfQZutDg3LzZedaLkFU+4+9Ko5A
         OJTmmo67wjZYYMxCNaTi1l1WdeCIio4EACeQfRNIM+VpX5vUz3lPeevZdAguFm9pKMv2
         FOVREsObMXcK1+2r21Wa1qaSwMnRcrGZYfFoEHE/spx3t2OEOBb5J0FwMk75n2ty04jr
         WiOCtR8U4gEb6JilaK5LFHN8qkBp6e7pX4DhyQZ/7cdF6mnSU5cPLRLIKe3H7+/EARF3
         BGlVSoK+fYehGXxESV/Ld1bj/ZANgE2a1WMiyn30YsQYAQ1rVPGa1vGcjoL7cJTnnVqJ
         /tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VeTmaxVF4TBZ5ceO194kE6I8QDY5rOGwcUY1j5F3fgI=;
        b=HcxvkyuMmfINMFj7rW/ZcLU4UfAJAZ5a5qyo9gCBI7fl6S8WUzqOGQMCUJW9djEmnT
         GBmS0LW3v1CIotEh40wG56pDDtGvljx7sZl5HesVjLsX3Um2YBUJQyUuVLf0AqjW08HY
         aXcMmQXl94O9jshKs34tIdAvFvCRovxYXd7WYBtYyTAz7sDaP90v/cWaUDrheMXAeCGJ
         cXqZCgCIDspzZhZpAdN12YciSPIyvHYUYuNtsjwdo5iYUuuQ6vcqaNkSbOhRB/xm3AQP
         zlY97+vHknmQb8hNonMLjYEdHjH9jBDYG1+gGv35BMz8l8i6tNmdYgdr2vQ5rcqQlcK/
         xMcg==
X-Gm-Message-State: AOAM531Iz+SYBIrHlYW93R9vgC9+I2i8HKjUamJNEoT7Agxk/H1LapLM
        M+eJPYS2ZLGouSXh4CQDlY0hiw==
X-Google-Smtp-Source: ABdhPJyPsAyAViABIjAYXWkalJZSS7rmSNY8EN0XsPd3q53sT5KyY19DWLmuReNAz0qn45VrTyidSg==
X-Received: by 2002:a17:90a:ab15:: with SMTP id m21mr16363445pjq.166.1633749773233;
        Fri, 08 Oct 2021 20:22:53 -0700 (PDT)
Received: from [10.76.34.190] ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id w185sm607171pfd.113.2021.10.08.20.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 20:22:52 -0700 (PDT)
Message-ID: <665f749e-b71e-a793-d759-87f7cf89677c@bytedance.com>
Date:   Sat, 9 Oct 2021 11:22:48 +0800
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
From:   yanghui <yanghui.def@bytedance.com>
In-Reply-To: <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/10/9 上午7:45, John Stultz 写道:
> On Fri, Oct 8, 2021 at 1:03 AM yanghui <yanghui.def@bytedance.com> wrote:
>>
>> clocksource_watchdog is executed every WATCHDOG_INTERVAL(0.5s) by
>> Timer. But sometimes system is very busy and the Timer cannot be
>> executed in 0.5sec. For example,if clocksource_watchdog be executed
>> after 10sec, the calculated value of abs(cs_nsec - wd_nsec) will
>> be enlarged. Then the current clocksource will be misjudged as
>> unstable. So we add conditions to prevent the clocksource from
>> being misjudged.
>>
>> Signed-off-by: yanghui <yanghui.def@bytedance.com>
>> ---
>>   kernel/time/clocksource.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>> index b8a14d2fb5ba..d535beadcbc8 100644
>> --- a/kernel/time/clocksource.c
>> +++ b/kernel/time/clocksource.c
>> @@ -136,8 +136,10 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
>>
>>   /*
>>    * Interval: 0.5sec.
>> + * MaxInterval: 1s.
>>    */
>>   #define WATCHDOG_INTERVAL (HZ >> 1)
>> +#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
>>
>>   static void clocksource_watchdog_work(struct work_struct *work)
>>   {
>> @@ -404,7 +406,9 @@ static void clocksource_watchdog(struct timer_list *unused)
>>
>>                  /* Check the deviation from the watchdog clocksource. */
>>                  md = cs->uncertainty_margin + watchdog->uncertainty_margin;
>> -               if (abs(cs_nsec - wd_nsec) > md) {
>> +               if ((abs(cs_nsec - wd_nsec) > md) &&
>> +                       cs_nsec < WATCHDOG_MAX_INTERVAL_NS &&
> 
> Sorry, it's been awhile since I looked at this code, but why are you
> bounding the clocksource delta here?
> It seems like if the clocksource being watched was very wrong (with a
> delta larger than the MAX_INTERVAL_NS), we'd want to throw it out.
> 
>> +                       wd_nsec < WATCHDOG_MAX_INTERVAL_NS) {
> 
> Bounding the watchdog interval on the check does seem reasonable.
> Though one may want to keep track that if we are seeing too many of
> these delayed watchdog checks we provide some feedback via dmesg.

   Yes, only to check watchdog delta is more reasonable.
   I think Only have dmesg is not enough, because if tsc was be misjudged
   as unstable then switch to hpet. And hpet is very expensive for
   performance, so if we want to switch to tsc the only way is to reboot
   the server. We need to prevent the switching of the clock source in
   case of misjudgment.
   Circumstances of misjudgment:
   if clocksource_watchdog is executed after 10sec, the value of wd_delta
   and cs_delta also be about 10sec, also the value of (cs_nsec- wd_nsec)
   will be magnified 20 times(10sec/0.5sec).The delta value is magnified.
   But now clocksource is accurate, the Timer is inaccurate. So we 
misjudged the clocksource. We need avoid this from happening.

thanks
-Hui
> 
> thanks
> -john
> 
