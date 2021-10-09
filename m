Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12565427ABB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 16:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhJIOGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 10:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbhJIOGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 10:06:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14196C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 07:04:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so9973546pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 07:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jr6NELFTJSILYLfmz25jHNXv/Ijq+7slmsiNmx6mB/o=;
        b=bP/f+RdZIBWQqjUy1P5tdIejEDYDo6EqoAnnpIc25e2bsZ5f25QWxX0PvGdAgA9CSQ
         x3MMY6r4zU/t2P6Efeu8biuk+Ka0S+fHeNW4qNiKoC6iZ72s/tjhs2kwK0kO77NyFJWy
         l5CfLYQcPCqMOkAyqg0nDxlvZTbW4f9mkeeF2ikuFrzGAnuKqJcYvuCTJEGue530px4q
         Zt2yIKMHUxwg7YP8DZT4Qj2/RzzreidqN3zWYTyaVM00RolPaEJLxoOHbbvmuQEfjdr+
         J1qRhp6SfXHSWqwojHiNFDd7ehGenD7YVOwNrr/BehILpu7TMf8aF7aWJPC0dvxe4Hbu
         vL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jr6NELFTJSILYLfmz25jHNXv/Ijq+7slmsiNmx6mB/o=;
        b=eJVZ2l3mLPJp6VKpi2Fg++HycCXchb1/f0P/eUwE49ioqumo1kldIBM4xFRyRPmqc1
         FJ2OCrklQ6JSYsnyi7/zzsgBeZWN6LvsH5P/Y11NazUFGdZ1rJTMOtR0fIxF9c+USMwR
         LWwU1SveBP4r7cDk8bDovkAIDeqEzl8jBcuQEijT9klk99VCfs3O8GzjM7s5E13cDDkF
         GXTiU47B139/xuI9dwZA7ERD/wSIhZQLM8d/1kXhYJNzgj7m268XSRnE9VBg0vV/yk3t
         nTl1YNzXOSbqixRJv0rF3OnvyYpAy0vo/b9JfGe0RiHZyp4jHLi8MlIo5OKIRRTdUYnY
         og1g==
X-Gm-Message-State: AOAM532DXi9IUf5SAh3GBu1AIbUd5S0zWbDFBGZ1KMbvdPiZPva2m8rG
        ZFTH48i4/KOUNG7kqAUBY/FnUfZvoRO3Ng==
X-Google-Smtp-Source: ABdhPJyhh2TUX8OURWKMchmffRhfwaLQMbMa3ofiD3ZluWEMJ/tIa+cDnfX576MvHZMYJm9TdAytJg==
X-Received: by 2002:a17:90a:6583:: with SMTP id k3mr18915882pjj.147.1633788266350;
        Sat, 09 Oct 2021 07:04:26 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.112])
        by smtp.gmail.com with ESMTPSA id d137sm2480755pfd.72.2021.10.09.07.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 07:04:26 -0700 (PDT)
Subject: Re: [PATCH] Clocksource: Avoid misjudgment of clocksource
To:     John Stultz <john.stultz@linaro.org>,
        yanghui <yanghui.def@bytedance.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20211008080305.13401-1-yanghui.def@bytedance.com>
 <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <c70a418d-4748-6876-ac8a-c9d1b7e94e78@gmail.com>
Date:   Sat, 9 Oct 2021 22:04:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello

John Stultz wrote on 2021/10/9 7:45:
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
>>  kernel/time/clocksource.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>> index b8a14d2fb5ba..d535beadcbc8 100644
>> --- a/kernel/time/clocksource.c
>> +++ b/kernel/time/clocksource.c
>> @@ -136,8 +136,10 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
>>
>>  /*
>>   * Interval: 0.5sec.
>> + * MaxInterval: 1s.
>>   */
>>  #define WATCHDOG_INTERVAL (HZ >> 1)
>> +#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
>>
>>  static void clocksource_watchdog_work(struct work_struct *work)
>>  {
>> @@ -404,7 +406,9 @@ static void clocksource_watchdog(struct timer_list *unused)
>>
>>                 /* Check the deviation from the watchdog clocksource. */
>>                 md = cs->uncertainty_margin + watchdog->uncertainty_margin;
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

For some fast timeout timers, such as acpi-timer, checking wd_nsec should not
make much sense, because when wacthdog is called, the timer may overflow many
times.

> thanks
> -john
> 
