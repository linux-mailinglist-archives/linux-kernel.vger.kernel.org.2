Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7860E443E46
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhKCIUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:20:49 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:43396
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231259AbhKCIUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:20:49 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 921293F1AE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 08:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635927489;
        bh=cwNxbrI9kV2XnLI3KJvle55OQFc9F7LvaCdlR7m/it0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=BRzYUv3e9zBbjErVOhlDYZpqShXRDH0Z6AZ+yftoaMnWKJo9nxBZ+fyNa2RX4nGZF
         4tki33VlH+ypnpgyMneoSd37Piq8bPYpSSnw4yanYcL6cWRdK5fTKy8wO0TkfV3rmc
         Zp7U0zu2RKabXVKMOvjuhdmSe9n0qvFkUXbLQSt49Fx5ip0V2indYOWhMrJ8y6cTQ4
         UjG4BDRGzqq67xCJ4Hg2SUVI7JSRPqYHM3l+lijfoNavwno5VhYWEcUlvM4a7HySjn
         chXvTyuGsfVNojCml7qDl7xwnIRMhKpMzc6aaDPgSwqP/cTu94xkiKS62sUvjQanWq
         mRgPpVAUAtXRQ==
Received: by mail-lj1-f198.google.com with SMTP id e13-20020a2e9e0d000000b00216ace8e8e5so774820ljk.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 01:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cwNxbrI9kV2XnLI3KJvle55OQFc9F7LvaCdlR7m/it0=;
        b=Zh38aFZZfFdf8kdbRwVgpSciSR0TB4D4Ez9puettxk+I8mhf7vq9WqvrJTlpKDeDmJ
         Shz/DAp1T2/692P1lMQz2ENJDMEEex4RZ0nZiNxbOXgjcwdi8t4B1GrM6DyHZooJ9deD
         kdX0dkYWAlaCgMMirur1onveesLkaiNt2joOl8NxeY97AVyle5icdugFVA1P3M5+uVGK
         saWIpDZjA9BnCSESFGFPrzUAnRExfqDYykoFFKFpYDTSUjHaNMeCDDIyO/MnjCWjfBWn
         LJy7mEUu66qBha2TegalIcGEW1d4Vqm/H1AGPUClMoHWFsouV2j30L7FoLkAKKsPudYm
         Qz3Q==
X-Gm-Message-State: AOAM53138huVjz40PEoe8Ga6BwSGoVmgQI61fHbaVnu2QYej+b00uWo6
        WbLmF4W3amScIGZaIH8wMjcPFKCVYh40pBcyPPiaVz6i5+eZOnCJtZZ+bW7NWTJ4CPW3iGt16ux
        232/cleXjcPPxEK2Cp7BcXbwqHvKrzZuHMcYY3/GWOQ==
X-Received: by 2002:a2e:a543:: with SMTP id e3mr22940374ljn.319.1635927489000;
        Wed, 03 Nov 2021 01:18:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHxvd6LVc2WkgfdVN2SSB7y2Go8fRYN0n19U86pvtQcrEjINW8va8TKsm3vxchOnnwRK624Q==
X-Received: by 2002:a2e:a543:: with SMTP id e3mr22940353ljn.319.1635927488810;
        Wed, 03 Nov 2021 01:18:08 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o2sm116255lfq.41.2021.11.03.01.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 01:18:08 -0700 (PDT)
Message-ID: <83f6574b-bbab-f0c3-7198-f773c3dcfc63@canonical.com>
Date:   Wed, 3 Nov 2021 09:18:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2 1/2] clocksource/drivers/exynos_mct_v2: introduce
 Exynos MCT version 2 driver for next Exynos SoC
Content-Language: en-US
To:     Youngmin Nam <youngmin.nam@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     will@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, pullip.cho@samsung.com,
        hoony.yu@samsung.com, hajun.sung@samsung.com,
        myung-su.cha@samsung.com, kgene@kernel.org
References: <20211102001122.27516-1-youngmin.nam@samsung.com>
 <CGME20211101234500epcas2p2d0e5bc54615b635f6694bc1be4c89fb5@epcas2p2.samsung.com>
 <20211102001122.27516-2-youngmin.nam@samsung.com>
 <20211102102802.GA16545@C02TD0UTHF1T.local> <20211103000945.GA48132@perf>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211103000945.GA48132@perf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2021 01:09, Youngmin Nam wrote:
> On Tue, Nov 02, 2021 at 10:28:10AM +0000, Mark Rutland wrote:
>> On Tue, Nov 02, 2021 at 09:11:21AM +0900, Youngmin Nam wrote:
>>> Exynos MCT version 2 is composed of 1 FRC and 12 comparators.
>>> There are no global timer and local timer anymore.
>>> The 1 of 64bit FRC serves as "up-counter"(not "comparators").
>>> The 12 comaprators(not "counter") can be used as per-cpu event timer
>>> so that it can support upto 12 cores.
>>> And a RTC source can be used as backup clock source.
>>
>> [...]
>>
>>> +static int exynos_mct_starting_cpu(unsigned int cpu)
>>> +{
>>> +	struct mct_clock_event_device *mevt = per_cpu_ptr(&percpu_mct_tick, cpu);
>>> +	struct clock_event_device *evt = &mevt->evt;
>>> +
>>> +	snprintf(mevt->name, sizeof(mevt->name), "mct_comp%d", cpu);
>>> +
>>> +	evt->name = mevt->name;
>>> +	evt->cpumask = cpumask_of(cpu);
>>> +	evt->set_next_event = exynos_comp_set_next_event;
>>> +	evt->set_state_periodic = mct_set_state_periodic;
>>> +	evt->set_state_shutdown = mct_set_state_shutdown;
>>> +	evt->set_state_oneshot = mct_set_state_shutdown;
>>> +	evt->set_state_oneshot_stopped = mct_set_state_shutdown;
>>> +	evt->tick_resume = mct_set_state_shutdown;
>>> +	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
>>> +	evt->rating = 500;	/* use value higher than ARM arch timer */
>>
>> Previously Will asked you to try CLOCK_EVT_FEAT_PERCPU here, and to set
>> the C3STOP flag on the arch timer via the DT when necessary, rather than
>> trying to override the arch timer like this:
>>
>>   https://protect2.fireeye.com/v1/url?k=72526080-2dc9598b-7253ebcf-002590f5b904-ca603717c6462908&q=1&e=be56aa83-dbac-4639-913d-d388620fe3fc&u=https%3A%2F%2Flore.kernel.org%2Fr%2F20211027073458.GA22231%40willie-the-truck
>>
>> There are a bunch of things that depend on the architected timer working
>> as a clocksource (e.g. vdso, kvm), and it *should* work as a lock
>> clockevent_device if configured correctly, and it's much more consistent
>> with *everyone else* to use the arhcitected timer by default.
>>
>> Please try as Will suggested above, so that this works from day one.
>>
>> Thanks,
>> Mark.
>>
> 
> Hi Mark.
> It looks like you missed my previous mail.
> https://lore.kernel.org/all/20211029035422.GA30523@perf/#t
> 
> Yes, I believe Will's suggestion definitely will work.
> But that is for performance not functionality.
> As a driver for new H/W IP I would like to confirm functionality first.
> 
> We need more time to test this feature with our exynos core power down feature.
> And we need to do a various regression test whether there is another corner case or not.
> So, how about we apply Will's suggetion later after the current patchset is merged first?
> After doing our regression test with our exynos core power down feature, we can confirm this.
> 

Not really, because once it is merged there is no incentive to fix it or
simply changing it can be forgotten. Also similarly to commit
6282edb72bed ("clocksource/drivers/exynos_mct: Increase priority over
ARM arch timer"), there should be a valid and serious reason to
prioritize Exynos MCT.


Best regards,
Krzysztof
