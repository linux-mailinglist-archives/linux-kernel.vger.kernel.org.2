Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94D83AE5FD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhFUJ2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFUJ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:28:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44595C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:25:52 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n35-20020a05600c3ba3b02901cdecb6bda8so13316851wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=khjWeiSnkM2JJW86gTrKIOVSLeTv7Yb6KaH/heggdtk=;
        b=D7+xRf++un3IqmYn8bmv7KAGa9NMjyPIbi8yoy4Ti9SUXDRJjRaloHfCpxV/03Arf7
         CoERUSxWGR0XDUWdMf/1y7IHE6wK6tX5nqjAOvuhocuiKx22ltR0guuxKZePTG1Fgl9k
         NA3WegyOWA5PBhjYeeddblQoSNJ5dcaLnGxqKOn9yIK97LKfgo7SEzfR6PGsn3vvw2B7
         A7SG9sOSiEH/snvvetYA4vFouncOe8XSKa4X3stERRW8kdZzIy3Gak8fRXXGb15X7iGt
         AxQpL3GA0gWVhio0AHuwSHamj0wj8pYNhx1ttV3fUV2+mkZvOPS0jHoNaXjh0nKxEqV/
         /QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=khjWeiSnkM2JJW86gTrKIOVSLeTv7Yb6KaH/heggdtk=;
        b=WRFbfYXjHgKoecAOUF007hhCYMARKAsoeqEXAqnT8FvpOXzHyUPJFSkGOjqAHOpIbp
         cnw47ypi4k4AX31QJWN1pe5yv/lxNw5abwBRkHYslBGbPfvx5J8uN4jb+35HNz3rB+I7
         X5+1fH+7OtVq+4WPKbxjPthKv6KBEqS32sigZdySF2JaxFWx+pvWTQrKc06ZI5ypkIqz
         atBREYoURwQOHBetnGYRMNJ3Nee9/XA85oQ5uOnx43iqlsj4YHxSfEON5bYHCzpZlTJI
         fw1ah+r0YcNeLo6fLqCFwLoX2ufskrocuhrJeGX2I5gJsaD7Lv1wyHYlkPaqRg/tqU71
         wpGA==
X-Gm-Message-State: AOAM53311A5CITRIOtsAMV8p0klweUoCfHEc+YsYLxg2PseDujDteg/j
        7VV7TkhxOFnvJnX1+pKik5yEcA==
X-Google-Smtp-Source: ABdhPJyU+t2q4RnAwWxnByMGNzM0KKcktgIONYVsvt+ZubU3WPqQEmpfq8xdZyXbgeekVOfLseJSTQ==
X-Received: by 2002:a7b:c1d3:: with SMTP id a19mr12109104wmj.181.1624267549391;
        Mon, 21 Jun 2021 02:25:49 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211? ([2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211])
        by smtp.googlemail.com with ESMTPSA id 24sm4377077wmi.35.2021.06.21.02.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 02:25:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] clocksource/drivers/exynos_mct: Prioritise Arm arch
 timer on arm64
To:     Will Deacon <will@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210608154341.10794-1-will@kernel.org>
 <CGME20210608154400epcas1p1b22fd50629611a9475cb4d2b8dd9442d@epcas1p1.samsung.com>
 <20210608154341.10794-2-will@kernel.org>
 <466bfc19-2260-87c6-c458-b43cf23617e3@samsung.com>
 <2a0181ea-a26e-65e9-16f6-cc233b6b296f@linaro.org>
 <fbcd234d-3ea0-d609-1f1d-b557ea329c37@samsung.com>
 <20210617214748.GC25403@willie-the-truck>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d79ebd58-1c4e-834c-fc06-482f25f6f3de@linaro.org>
Date:   Mon, 21 Jun 2021 11:25:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210617214748.GC25403@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2021 23:47, Will Deacon wrote:
> On Thu, Jun 17, 2021 at 09:58:35AM +0900, Chanwoo Choi wrote:
>> On 6/17/21 12:25 AM, Daniel Lezcano wrote:
>>> On 10/06/2021 03:03, Chanwoo Choi wrote:
>>>> On 6/9/21 12:43 AM, Will Deacon wrote:
>>>>> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
>>>>> index fabad79baafc..804d3e01c8f4 100644
>>>>> --- a/drivers/clocksource/exynos_mct.c
>>>>> +++ b/drivers/clocksource/exynos_mct.c
>>>>> @@ -51,6 +51,15 @@
>>>>>  
>>>>>  #define TICK_BASE_CNT	1
>>>>>  
>>>>> +#ifdef CONFIG_ARM
>>>>> +/* Use values higher than ARM arch timer. See 6282edb72bed. */
>>>>> +#define MCT_CLKSOURCE_RATING		450
>>>>> +#define MCT_CLKEVENTS_RATING		500
>>>>> +#else
>>>>> +#define MCT_CLKSOURCE_RATING		350
>>>>> +#define MCT_CLKEVENTS_RATING		350
>>>>> +#endif
>>>>> +
>>>>>  enum {
>>>>>  	MCT_INT_SPI,
>>>>>  	MCT_INT_PPI
>>>>> @@ -206,7 +215,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
>>>>>  
>>>>>  static struct clocksource mct_frc = {
>>>>>  	.name		= "mct-frc",
>>>>> -	.rating		= 450,	/* use value higher than ARM arch timer */
>>>>> +	.rating		= MCT_CLKSOURCE_RATING,
>>>>>  	.read		= exynos4_frc_read,
>>>>>  	.mask		= CLOCKSOURCE_MASK(32),
>>>>>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>>>>> @@ -457,7 +466,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>>>>>  	evt->set_state_oneshot_stopped = set_state_shutdown;
>>>>>  	evt->tick_resume = set_state_shutdown;
>>>>>  	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
>>>>> -	evt->rating = 500;	/* use value higher than ARM arch timer */
>>>>> +	evt->rating = MCT_CLKEVENTS_RATING,
>>>>>  
>>>>>  	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
>>>>>  
>>>>>
>>>>
>>>> I'm not sure that exynos mct is working without problem
>>>> such as the case of 6282edb72bed.
>>>> As described on On ,6282edb72bed the arch timer on exynos SoC
>>>> depends on Exynos MCT device. the arch timer is not able to work
>>>> without Exynos MCT because of using the common module.
>>>
>>> Is it possible to change the DT to have a phandle to the exynos_mct, so
>>> it will be probed before the arch_arm_timer ?
>>
>> I think that DT changes is not proper way to keep the order between
>> exynos_mct and arch timer.
> 
> exynos4_mct_frc_start() is called unconditionally from probe via
> exynos4_clocksource_init() so as long as the mct probes first, then the
> arch timer should work, no? The rating shouldn't affect that.

How do you ensure the exynos mct is probed before the arch timer ?

The Makefile provides the right order, but the dependency is implicit.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
