Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CAD344E73
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhCVSYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhCVSXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:23:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595A6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:23:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so11409697wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ySJvyA1Vk+WlWIAVpdaEw/cb8TtbtV3XIc6h1+nRJT4=;
        b=EYEwtse8Tfbhei4D4G24ggUMmPdbnWhNGAn/uaCsHWSGN1xHWkp8XNQsZBlU0rmqPP
         OF5bevWmwR8En6oyPXRetZsPWZS2pqtMWpVZU0rN7Z4CfBTvhLuQBoLRN1KI1SIfpNcu
         i79FSRJldWPSD8A5W8PK9kTpgwuvDKYmEb7SV8ptL+u2AXXZV4TkSCE04HukddGcgQNo
         kF0G3Pu5VkORcwFIlTNVoT9NDMmQp4iip/TgsIeMS8Xe8WXyC4IRrr6pLUTnNWkEBCum
         GZlsN8VzA/eTXih8JSucA3+ld59QNXphmZL2KPaPOwywrrBFjFlgAZYZIVd6KkfzpcNy
         04pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ySJvyA1Vk+WlWIAVpdaEw/cb8TtbtV3XIc6h1+nRJT4=;
        b=ZKKvWPU2ORjQrY8Ljnq1odMrIz6qFiZ+CT3Fpi26XfJWTDep3/cBI287lC6gL3bvqD
         HvaTLyzL+caTXaO9MUd3v+gZXoOu2M6xu2FBQUt8gFNp4evCJNvslM0CSSMZAKjvdd9r
         lEg6fxyuuMDcna70Q/KZ3fk2r6rleEpuMtBO5qXeCAi68QhTt/0YP6TWaSYI+bbVnJm3
         0ZaMJbBp7r1wdW3thuXMJpebmA6vazm4IVzMnO+bCvPqBhNPebzFNkztV/gfL7fB8MKu
         Pywaaz5UCrw94EMiLyeJJ2Lhg0xu0D3ARlqGVEUuGgdbGv4sAJJvbMdLpybScIjxJYbt
         S6Bg==
X-Gm-Message-State: AOAM533gueDER/2WPKon0+daUk2ndQYr8aZK8xOdSioK0VKj3Ew+ZGE/
        rWLDW0ucsrxe50xLGt332TheGQ==
X-Google-Smtp-Source: ABdhPJzb0KUsvmwF89Q6JC250XZHI3aXVw0gduj1cm4ArG5yoim7NODhbWWeHGHzQJUQSGKsRhJfBw==
X-Received: by 2002:a1c:771a:: with SMTP id t26mr317022wmi.60.1616437417956;
        Mon, 22 Mar 2021 11:23:37 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2091:71d6:3ab2:37f2? ([2a01:e34:ed2f:f020:2091:71d6:3ab2:37f2])
        by smtp.googlemail.com with ESMTPSA id v18sm21863898wrf.41.2021.03.22.11.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 11:23:37 -0700 (PDT)
Subject: Re: [PATCH 1/2] clocksource/drivers/timer-ti-dm: Prepare to handle
 dra7 timer wrap issue
To:     Tony Lindgren <tony@atomide.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Keerthy <j-keerthy@ti.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>
References: <20210304073737.15810-1-tony@atomide.com>
 <20210304073737.15810-2-tony@atomide.com>
 <556d55af-0b30-8751-6aef-2e1bb9db1a76@linaro.org>
 <YFjG5IsHExuaixN9@atomide.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5c3c2447-3f8c-160c-8761-e43c1b4ebbf9@linaro.org>
Date:   Mon, 22 Mar 2021 19:23:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFjG5IsHExuaixN9@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2021 17:33, Tony Lindgren wrote:
> Hi,
> 
> * Daniel Lezcano <daniel.lezcano@linaro.org> [210322 15:56]:
>> On 04/03/2021 08:37, Tony Lindgren wrote:
>>> There is a timer wrap issue on dra7 for the ARM architected timer.
>>> In a typical clock configuration the timer fails to wrap after 388 days.
>>>
>>> To work around the issue, we need to use timer-ti-dm timers instead.
>>>
>>> Let's prepare for adding support for percpu timers by adding a common
>>> dmtimer_clkevt_init_common() and call it from dmtimer_clockevent_init().
>>> This patch makes no intentional functional changes.
>>>
>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>> ---
>>
>> [ ... ]
>>
>>> @@ -575,33 +574,60 @@ static int __init dmtimer_clockevent_init(struct device_node *np)
>>>  	 */
>>>  	writel_relaxed(OMAP_TIMER_CTRL_POSTED, t->base + t->ifctrl);
>>>  
>>> +	if (dev->cpumask == cpu_possible_mask)
>>> +		irqflags = IRQF_TIMER;
>>> +	else
>>> +		irqflags = IRQF_TIMER | IRQF_NOBALANCING;
>>
>> Can you explain the reasoning behind the test above ?
> 
> In the per cpu case we assign one dmtimer per cpu, and we want the
> interrupt handling on the assigned CPU. In the per cpu case we have
> the cpu specified with dev->cpumask unlike for the normal clockevent
> case.
> 
> In the per cpu dmtimer case the interrupt line is not wired per cpu
> though, so I don't think we want to add IRQF_PERCPU here.

If it is per cpu, then the parameter will be cpumask_of(cpu). If there
is one cpu, no balancing can happen and then the IRQF_NOBALANCING is not
needed, neither this test and the irqflags, right?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
