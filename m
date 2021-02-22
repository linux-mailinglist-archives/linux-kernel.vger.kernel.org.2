Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606F932121A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 09:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhBVIhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 03:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhBVIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 03:37:12 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ECFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 00:36:32 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i9so2732481wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 00:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rAg4EewEnjk4UCCsJmjOHgsR6AXU7AP1VYxhJm9JOaA=;
        b=K1YLIMKUT5eMSX/KUsvUwe93zB+imNjT0mvOX73CTZojhOIkM/Ok4exabM4OyuzGBn
         7CR18ENETheo4Jm+AdRcUePdoY3V9kAa6tkGRa7899fSsqoFOt5Hs4bL6bO5fp9y8sjt
         gqYd6TSuEK/aJTb3kGlUQ+9QMd4kTxDwKtvN+07TJeoh1BZdRh67uHiBRqo1vzTajRBy
         hwiwySkIOd27+Ck6ya//7Lb+6jv+wTOmgR42JniGaCiTyvRBC5HtclS8I6EQ/cRyqYkk
         qFNEI9LgEHqXM0Bb+mjcG+22NNq3LZwKe2mUUge30+SWwun5tvgSJBKIMKpgssJJwmZz
         cqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rAg4EewEnjk4UCCsJmjOHgsR6AXU7AP1VYxhJm9JOaA=;
        b=JTiPiNTa8mYjFLNcPRL2IhZ+ZYeTxWanpRR1TqZ2p8be6yB/UCJdkKxuqdGGw4jS8B
         5M8+4/RVmjLMmJ+XHcnQudq8rhYNioRoTtaTbbJi2a+Y092FPm43YZy2xMPuQNBZjlZw
         bnOWdurenGWhGPsfCVP2gfk4NlR0toLfjE+t1X8b+tM0PetfITEDB7VEmvLjuf6Lpyy0
         1dX3Fc5F3uzwUCp0b1ROQtDZcQuoH9kbM3BiOBEdljXZYPSeJ7T72dKc/OHNEIFemyeo
         Df94KDLAUsFEu49ENiBgsfS4EXGTqYYBV/hPu0TGbCHKylqgPIk4RLSsI3LyWiU6c8YH
         iUpw==
X-Gm-Message-State: AOAM531IpcFUYBqqvQYTHq41u8u/c4VbNgA6TC9KhFZ9RS92V9hpKi0G
        56JN4RRcpIlNB4W+E9rdwNlOng==
X-Google-Smtp-Source: ABdhPJzuHkitC0FD+nkw4S9XNfdKaS8c0gg5a/JWcKcaDWTTAMwsf4y0SyltfXsX21uMmhQEL20ImA==
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr19258294wmy.120.1613982990655;
        Mon, 22 Feb 2021 00:36:30 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8d19:48da:83de:346d? ([2a01:e34:ed2f:f020:8d19:48da:83de:346d])
        by smtp.googlemail.com with ESMTPSA id m9sm68278833wml.3.2021.02.22.00.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 00:36:30 -0800 (PST)
Subject: Re: [GIT PULL] timer drivers fixes for v5.11-rc5
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd.bergmann@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, trix@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
References: <ae3bcda6-5180-639d-6246-d2dfd271c3e7@linaro.org>
 <7a90ec96-d8e5-e505-bd5a-38cc00892021@linaro.org>
Message-ID: <db09cb3f-5074-a5e6-ea88-c4f304194c9d@linaro.org>
Date:   Mon, 22 Feb 2021 09:36:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7a90ec96-d8e5-e505-bd5a-38cc00892021@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

those fixes were not picked up

  -- Daniel


On 27/01/2021 09:47, Daniel Lezcano wrote:
> 
> Hi Thomas,
> 
> just a gentle ping
> 
> On 20/01/2021 09:31, Daniel Lezcano wrote:
>>
>> Hi Thomas,
>>
>> please consider the following three fixes for the timer drivers.
>>
>> Thanks
>>
>>   -- Daniel
>>
>> The following changes since commit e3fab2f3de081e98c50b7b4ace1b040161d95310:
>>
>>   ntp: Fix RTC synchronization on 32-bit platforms (2021-01-12 21:13:01
>> +0100)
>>
>> are available in the Git repository at:
>>
>>   https://git.linaro.org/people/daniel.lezcano/linux.git
>> tags/timers-v5.11-rc5
>>
>> for you to fetch changes up to 7da390694afbaed8e0f05717a541dfaf1077ba51:
>>
>>   clocksource/drivers/mxs_timer: Add missing semicolon when DEBUG is
>> defined (2021-01-18 22:28:59 +0100)
>>
>> ----------------------------------------------------------------
>> - Fix harmless warning with the ixp4xx when the TIMER_OF option is not
>> selected (Arnd Bergmann)
>>
>> - Make sure channel clock supply is enabled on sh_cmt (Geert Uytterhoeven)
>>
>> - Fix compilation error when DEBUG is defined with the mxs_timer (Tom Rix)
>>
>> ----------------------------------------------------------------
>> Arnd Bergmann (1):
>>       clocksource/drivers/ixp4xx: Select TIMER_OF when needed
>>
>> Geert Uytterhoeven (1):
>>       clocksource/drivers/sh_cmt: Make sure channel clock supply is enabled
>>
>> Tom Rix (1):
>>       clocksource/drivers/mxs_timer: Add missing semicolon when DEBUG is
>> defined
>>
>>  arch/arm/mach-ixp4xx/Kconfig    |  1 -
>>  drivers/clocksource/Kconfig     |  1 +
>>  drivers/clocksource/mxs_timer.c |  5 +----
>>  drivers/clocksource/sh_cmt.c    | 16 +++++++++++++---
>>  4 files changed, 15 insertions(+), 8 deletions(-)
>>
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
