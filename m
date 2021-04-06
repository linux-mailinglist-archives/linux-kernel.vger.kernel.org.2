Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DFD3551FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhDFLYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhDFLYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:24:41 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A67C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 04:24:33 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso7124680wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 04:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y90qJiQJqj37slq7UDOicfYU3rLq+cqTTBwcfI0ELt8=;
        b=xVk3VZ+or4GiLIJqeHTK5qCXO7NcGvZFnZ+qikep6aLBm6rQKqQKHG0QXGMmaKI8Yf
         IahXP/BQH7EXeqSMxxXWhJptggzME7OTb9y+DEzZJPwANOHaAPQ7b/GFmW9gw8M+mzES
         uL19uCTbAmDpQ1+mPobjg/RCtKTf/KwspkgWAGiAsbfHFT2mgiIkgmkRSNBZ9EGjvBPf
         CuwAEk7nzx6q9ss9VoPU60tBNBWASkFp+AL1+3tgrkUdvJMueI8+TeOhiKPabpYGOPjR
         jaIeKqFfDq69ZBZJy95pVFpJWc24oyf01Gv801IMOIUUjgirxe/3x9YBe3D1XxtR2b8I
         ueFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y90qJiQJqj37slq7UDOicfYU3rLq+cqTTBwcfI0ELt8=;
        b=bLeBKud0XGF5lmYmpj0ZeJ6XmXszU2V+ww16f1RchSk6VSnZd5QRtkftO3TF+Z2tSB
         ryfGvINdWjN/Ciyz8DsrpQe4YzZViyyFNc0rjvfvr4abIY3Q2xhvAv4Z/WZKjWuwaGx7
         +4TjcLnZxxG83pZ8RV3oebnYnmKALpZQ4CHEwrzf2m6kF/6KMJ5mKqQRj1w1pYJ1VDVI
         BzHjxFdhp+4k+8K520hpX+7cwSRLtVp8zLvH7OioVMzOtU3XeKZHJrLQH0SuLl4UmeN3
         rykRb3CHjZPjDWhEIralvNWZc3JPHNbITigvhCGmBAIl2HajLTZZ8za6YXmZPmV32XFI
         SmGA==
X-Gm-Message-State: AOAM532f4+KoJipbjCgYe41UxL6nyQ8ocfUbZF2XWLhcjfW5q/abRhNI
        wTMylSMeSzFWs82WsUopVZzPT8gq/lCKzg==
X-Google-Smtp-Source: ABdhPJxY5q/XFvk9uCVb3DLlsLqRUZk2jLzDBdX+Qi4WvkX8bEl/int4cIstoggJNNbuoX8M6r0A7A==
X-Received: by 2002:a7b:cdef:: with SMTP id p15mr3745051wmj.0.1617708271814;
        Tue, 06 Apr 2021 04:24:31 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d506:6f5d:adb6:da14? ([2a01:e34:ed2f:f020:d506:6f5d:adb6:da14])
        by smtp.googlemail.com with ESMTPSA id c6sm31378321wri.32.2021.04.06.04.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 04:24:31 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: power_allocator: maintain the device
 statistics from going stale
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210331163352.32416-1-lukasz.luba@arm.com>
 <20210331163352.32416-2-lukasz.luba@arm.com>
 <b27e0c79-de27-f9b1-ad16-17825b302615@linaro.org>
 <1f0710d5-cd78-dfff-1ce2-bba5f6e469b7@arm.com>
 <1a0b6e4a-1717-91d6-a664-d50e6aa8a809@linaro.org>
 <d74b8e8e-64b0-d724-d572-f98eb597a60e@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cbc40019-8b2d-5d14-f0fd-b0018fb4a1f6@linaro.org>
Date:   Tue, 6 Apr 2021 13:24:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d74b8e8e-64b0-d724-d572-f98eb597a60e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2021 12:39, Lukasz Luba wrote:
> 
> 
> On 4/6/21 11:16 AM, Daniel Lezcano wrote:
>> On 06/04/2021 10:44, Lukasz Luba wrote:
>>>
>>>
>>> On 4/2/21 4:54 PM, Daniel Lezcano wrote:
>>>> On 31/03/2021 18:33, Lukasz Luba wrote:
>>>>> When the temperature is below the first activation trip point the
>>>>> cooling
>>>>> devices are not checked, so they cannot maintain fresh statistics. It
>>>>> leads into the situation, when temperature crosses first trip
>>>>> point, the
>>>>> statistics are stale and show state for very long period.
>>>>
>>>> Can you elaborate the statistics you are referring to ?
>>>>
>>>> I can understand the pid controller needs temperature but I don't
>>>> understand the statistics with the cooling device.
>>>>
>>>>
>>>
>>> The allocate_power() calls cooling_ops->get_requested_power(),
>>> which is for CPUs cpufreq_get_requested_power() function.
>>> In that cpufreq implementation for !SMP we still has the
>>> issue of stale statistics. Viresh, when he introduced the usage
>>> of sched_cpu_util(), he fixed that 'long non-meaningful period'
>>> of the broken statistics and it can be found since v5.12-rc1.
>>>
>>> The bug is still there for the !SMP. Look at the way how idle time
>>> is calculated in get_load() [1]. It relies on 'idle_time->timestamp'
>>> for calculating the period. But when this function is not called,
>>> the value can be very far away in time, e.g. a few seconds back,
>>> when the last allocate_power() was called.
>>>
>>> The bug is there for both SMP and !SMP [2] for older kernels, which can
>>> be used in Android or ChromeOS. I've been considering to put this simple
>>> IPA fix also to some other kernels, because Viresh's change is more
>>> a 'feature' and does not cover both platforms.
>>
>> Ok, so IIUC, the temperature is needed as well as the power to do the
>> connection for the pid loop (temp vs power).
>>
>> I'm trying to figure out how to delegate the mitigation switch on/off to
>> the core code instead of the governor (and kill tz->passive) but how
>> things are implemented for the IPA makes this very difficult.
>>
>> AFAICT, this fix is not correct.
>>
>> If the temperature is below the 'switch_on_temp' the passive is set to
>> zero and the throttle function is not called anymore (assuming it is
>> interrupt mode not polling mode), so the power number is not updated
>> also.
> 
> IPA doesn't work well in asynchronous mode, because it needs this fixed
> length for the period. I have been experimenting with tsens IRQs and
> also both fixed polling + sporadic asynchronous IRQs, trying to fix it
> and have 'predictable' IPA, but without a luck.
> IPA needs synchronous polling events like we have for high temp e.g.
> 100ms and low temp e.g. 1000ms. The asynchronous events are root of
> undesirable states (too low or to high) calculated and set for cooling
> devices. It's also harder to escape these states with asynchronous
> events. I don't recommend using IPA with asynchronous events from IRQs,
> for now. It might change in future, though.

I understand that but there is the 'switch_on_temp' trip point which is
supposed to begin to collect the power values ahead of the
'desired_temp' (aka mitigation trip point / sustainable power).


> The patch 2/2 should calm down the unnecessary updates/notifications so
> your request.
> The longer polling, which we have for temperature below 'switch_on_temp'
> (e.g. every 1sec) shouldn't harm the performance of the system, but
> definitely makes IPA more predictable and stable.

The change I proposed is correct then no ? The polling is still effective.

If the IPA needs a sampling, it may be more adequate to separate the
sampling from the polling. So the other governors won't be impacted by
the IPA specific setup, and we do not end up with polling/passive delays
tricks for a governor. The IPA would have its own self-encapsulated
sampling rate and the thermal zone setup won't depend on the governor.

What do you think ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
