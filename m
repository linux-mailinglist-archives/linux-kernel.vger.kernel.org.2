Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A5F3A9EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhFPP1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbhFPP1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:27:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C400C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:25:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d11so782821wrm.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OfWeLRN7aD+diTzZjnigJkvtjWcLavzHiDJB/2euGlY=;
        b=oHQxH+xBtpko5HraEOFf7/T5l9glLqJy6+t+iQqFulSpBZ/9dx1lPbFrl+GIgzpJxM
         +ErJ9m8gny4YZmIP2BY+eyVvqwI7lUyB2jIy7bdeahAkF0DQP8Fy3YxmTVnhmjJppPLG
         8P7F0uMvmN8tN9hEAi9ZR5L6XGKwBNcnFfZRJYs3aiJEAbDVdtJms+iaJVHn0zZKFVja
         J+GwSqP2HRBUHMGD/0Kpbh06V4fnukgiontoNN/LD2blh7K2SkevmX3DTc7rkXqneoOq
         90Po9Ceo2QB7gk7Q8/F5rluLaCNh6u6tnNT8A73zE/Tottjn3z2QA/xuLM6rhozU9s71
         ileg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OfWeLRN7aD+diTzZjnigJkvtjWcLavzHiDJB/2euGlY=;
        b=B5jKun2AVOQMkGe3An5WLcho8CbrHxyNN33qo8IcDmXDJRHYE2Y1iiszr5D4inqMMF
         wQsDdFNDgG4+GVJp9TZBFBd3wl/iN3qF+L6ptFMxqrEmE2izQed6kmoSR+B69E9mSGkF
         RDqcgBQFuVBVgm8F2KGKiDk/04v/+p4rt7qwvCpoZyjC/jJquRLHUaTeRYdGjYNlH3cF
         25O+YjP/YmuCFMjS1c6MH2pnWQZjAbMYOkydjK6WgYh9l9f3LpwbkUaDClY358A3lmPH
         5mvUi2eOEQ0lyI0A6MVkM+W2PTjCPmBlYvMFootxW8ZuCFhxWJhEbRqvxZig2ZZ9f0e/
         q1yw==
X-Gm-Message-State: AOAM530WuFfBGWwxm8jrhmBlqjxFiu4Iudq88jyaIlZ8NoQ6EJaZzNmz
        rcm/uY4nZuiH3g78TCad88Q2Ew==
X-Google-Smtp-Source: ABdhPJxPFcxE+Puc780v17x8JcMWL92WxNwhahUATzTvlaetaNfpVHIrLSnpiydzXAL/vpbteJX0DA==
X-Received: by 2002:adf:d1c9:: with SMTP id b9mr6154647wrd.101.1623857122469;
        Wed, 16 Jun 2021 08:25:22 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:60a0:f51c:af6:2dab? ([2a01:e34:ed2f:f020:60a0:f51c:af6:2dab])
        by smtp.googlemail.com with ESMTPSA id j18sm2498504wrw.30.2021.06.16.08.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 08:25:21 -0700 (PDT)
Subject: Re: [PATCH 1/2] clocksource/drivers/exynos_mct: Prioritise Arm arch
 timer on arm64
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210608154341.10794-1-will@kernel.org>
 <CGME20210608154400epcas1p1b22fd50629611a9475cb4d2b8dd9442d@epcas1p1.samsung.com>
 <20210608154341.10794-2-will@kernel.org>
 <466bfc19-2260-87c6-c458-b43cf23617e3@samsung.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2a0181ea-a26e-65e9-16f6-cc233b6b296f@linaro.org>
Date:   Wed, 16 Jun 2021 17:25:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <466bfc19-2260-87c6-c458-b43cf23617e3@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2021 03:03, Chanwoo Choi wrote:
> Hi,
> 
> On 6/9/21 12:43 AM, Will Deacon wrote:
>> All arm64 CPUs feature an architected timer, which offers a relatively
>> low-latency interface to a per-cpu clocksource and timer. For the most
>> part, using this interface is a no-brainer, with the exception of SoCs
>> where it cannot be used to wake up from deep idle state (i.e.
>> CLOCK_EVT_FEAT_C3STOP is set).
>>
>> On the contrary, the Exynos MCT is extremely slow to access yet can be
>> used as a wakeup source. In preparation for using the Exynos MCT as a
>> potential wakeup timer for the Arm architected timer, reduce its ratings
>> so that the architected timer is preferred.
>>
>> This effectively reverts the decision made in 6282edb72bed
>> ("clocksource/drivers/exynos_mct: Increase priority over ARM arch timer")
>> for arm64, as the reasoning for the original change was to work around
>> a 32-bit SoC design.
>>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Will Deacon <will@kernel.org>
>> ---
>>  drivers/clocksource/exynos_mct.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
>> index fabad79baafc..804d3e01c8f4 100644
>> --- a/drivers/clocksource/exynos_mct.c
>> +++ b/drivers/clocksource/exynos_mct.c
>> @@ -51,6 +51,15 @@
>>  
>>  #define TICK_BASE_CNT	1
>>  
>> +#ifdef CONFIG_ARM
>> +/* Use values higher than ARM arch timer. See 6282edb72bed. */
>> +#define MCT_CLKSOURCE_RATING		450
>> +#define MCT_CLKEVENTS_RATING		500
>> +#else
>> +#define MCT_CLKSOURCE_RATING		350
>> +#define MCT_CLKEVENTS_RATING		350
>> +#endif
>> +
>>  enum {
>>  	MCT_INT_SPI,
>>  	MCT_INT_PPI
>> @@ -206,7 +215,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
>>  
>>  static struct clocksource mct_frc = {
>>  	.name		= "mct-frc",
>> -	.rating		= 450,	/* use value higher than ARM arch timer */
>> +	.rating		= MCT_CLKSOURCE_RATING,
>>  	.read		= exynos4_frc_read,
>>  	.mask		= CLOCKSOURCE_MASK(32),
>>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>> @@ -457,7 +466,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>>  	evt->set_state_oneshot_stopped = set_state_shutdown;
>>  	evt->tick_resume = set_state_shutdown;
>>  	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
>> -	evt->rating = 500;	/* use value higher than ARM arch timer */
>> +	evt->rating = MCT_CLKEVENTS_RATING,
>>  
>>  	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
>>  
>>
> 
> I'm not sure that exynos mct is working without problem
> such as the case of 6282edb72bed.
> As described on On ,6282edb72bed the arch timer on exynos SoC
> depends on Exynos MCT device. the arch timer is not able to work
> without Exynos MCT because of using the common module.

Is it possible to change the DT to have a phandle to the exynos_mct, so
it will be probed before the arch_arm_timer ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
