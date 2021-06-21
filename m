Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199C83AE6DE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFUKT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:19:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36505 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUKT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:19:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210621101743euoutp0116c6d754a7f09e202b3945ecd93e7c23~KkZAWu81L0836508365euoutp01Q
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:17:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210621101743euoutp0116c6d754a7f09e202b3945ecd93e7c23~KkZAWu81L0836508365euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624270663;
        bh=WSO4e5lafNSepdrpflxgvnQdSn9FT06t0wJAz/tEsMM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dXGgFRpfYYgCBOQ6GyFtwES80wWSb0S5RqDjYy7MbolW4qeLB8ib8HR8UdZeH4gm8
         tOwMq5y4ajao35F8SAKeLXrvpE8767L52ZcOgVmbXsmapzRNH5+VkwhcMKmrDbUkqQ
         OQLtCaqHhkpQVK50ttskrVtiyxH4sg30YyLnVA1U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210621101743eucas1p1b7d27303cb30ef7bd8a1e721b01eddc8~KkZADaYrm1817518175eucas1p15;
        Mon, 21 Jun 2021 10:17:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1F.D9.42068.74760D06; Mon, 21
        Jun 2021 11:17:43 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210621101742eucas1p13deeb4c2d37622f46c78efa459dacd41~KkY-cmTOU2649626496eucas1p1X;
        Mon, 21 Jun 2021 10:17:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210621101742eusmtrp2df67a60edd4b61b213cf38914e4cdeb6~KkY-b2ifF0037200372eusmtrp2a;
        Mon, 21 Jun 2021 10:17:42 +0000 (GMT)
X-AuditID: cbfec7f4-c71ff7000002a454-e4-60d067476978
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BC.1C.20981.64760D06; Mon, 21
        Jun 2021 11:17:42 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210621101742eusmtip183fc43d230629d14287870adeffc4deb~KkY_4BId12107121071eusmtip1Q;
        Mon, 21 Jun 2021 10:17:42 +0000 (GMT)
Subject: Re: [PATCH 1/2] clocksource/drivers/exynos_mct: Prioritise Arm arch
 timer on arm64
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <95fb8ea3-f409-55ee-6b5c-f19858dd0fab@samsung.com>
Date:   Mon, 21 Jun 2021 12:17:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d79ebd58-1c4e-834c-fc06-482f25f6f3de@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djP87ru6RcSDDob+Syuf3nOajHvs6zF
        +fMb2C02vv3BZLHp8TVWi8u75rBZbN40ldmi5Y6pA4fHrIZeNo9NqzrZPO5c28Pm8e7cOXaP
        zUvqPfq2rGL0+LxJLoA9issmJTUnsyy1SN8ugSvj2OznrAWvJCouv5jB1sA4V6SLkZNDQsBE
        YuOm/cxdjFwcQgIrGCU23mlmgnC+MEq8u7GQEcL5zCix5OZiJpiWyfceQrUsZ5T4tK+JBcL5
        yCjRfXg/excjB4ewQKzE9aXKIA0iAqUSu3Y8ZwOxmQUuMEr8PxYHYrMJGEp0ve0Ci/MK2Em0
        zp3ODGKzCKhKfFz6H2yZqECyxPt5M1ghagQlTs58wgJicwLVP2rZygIxU15i+9s5zBC2uMSt
        J/PBXpAQ+MIh0fx1OTPE1S4SXQ3HWSFsYYlXx7ewQ9gyEv93wjQ0M0o8PLeWHcLpYZS43DSD
        EaLKWuLOuV9sIJ8xC2hKrN+lDxF2lDixfhEzSFhCgE/ixltBiCP4JCZtmw4V5pXoaBOCqFaT
        mHV8HdzagxcuMU9gVJqF5LVZSN6ZheSdWQh7FzCyrGIUTy0tzk1PLTbKSy3XK07MLS7NS9dL
        zs/dxAhMTqf/Hf+yg3H5q496hxiZOBgPMUpwMCuJ8N5MuZAgxJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnDdpy5p4IYH0xJLU7NTUgtQimCwTB6dUAxOz9okbbqUO5jMmh7XYnylUWbBKT2uXZUe+
        bD3Hvq+Truokvwo7eP71pQrTW7wBUfUfDVQEvz0y0E0zM0z8z14vZ7Sgx/FCTunx2pInZzMP
        Mf5viMs0Xpf9TaV4T88G2XCvH6ll9rFt5ysy338N6+wSl6xYmSLaP+3oa4HzDLt6lVhcTp1Y
        4rVRhfm6yR5lnjmvjn5b3ZPNGGyU9SGO18OWdUPGurs/whKS4mTa1GJ4DqronPp68dmDaRX5
        y/58Pup3OURVOKtt6YYsodQ3LpPtsqZoLY1/uSx6719lLod1sj+S1W9qlltl+k/nCrd9fKel
        6ljErIo/73JsL+W2HNCeffNn/PQ9BmsSdL7FKbEUZyQaajEXFScCACig6yy9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7pu6RcSDM61Kllc//Kc1WLeZ1mL
        8+c3sFtsfPuDyWLT42usFpd3zWGz2LxpKrNFyx1TBw6PWQ29bB6bVnWyedy5tofN4925c+we
        m5fUe/RtWcXo8XmTXAB7lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1N
        SmpOZllqkb5dgl7GsdnPWQteSVRcfjGDrYFxrkgXIyeHhICJxOR7D5m7GLk4hASWMkrceHSL
        ESIhI3FyWgMrhC0s8edaFxtE0XtGiWv/1rF3MXJwCAvESlxfqgxSIyJQKtH/ay0jSA2zwCVG
        iR3bb7CBJIQENjJLfJlTDmKzCRhKdL3tAovzCthJtM6dzgxiswioSnxc+p8JxBYVSJb4ub4d
        qkZQ4uTMJywgNidQ/aOWrWA2s4CZxLzND5khbHmJ7W/nQNniEreezGeawCg0C0n7LCQts5C0
        zELSsoCRZRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgNG479nPLDsaVrz7qHWJk4mA8xCjB
        wawkwnsz5UKCEG9KYmVValF+fFFpTmrxIUZToH8mMkuJJucD00FeSbyhmYGpoYmZpYGppZmx
        kjivyZE18UIC6YklqdmpqQWpRTB9TBycUg1Mq+XYeLbJWjzceD7gOaOOnbnbpKOLL22+u/7I
        br/IO1lT1n35uLSu8tyRxV9fnpmcfTrynYzXgRdPt811k3+cy8xV/jQ3juuWq/XsKosSDdVF
        ScdtTmuovhM77bH3pLH2bD9PrjtPvA3m1Czon5U3TUtj5QmRfyuZOosdfU6/eNpv93Gdx66S
        lTcvLUk80PlptdMe841z+JL2iu89V3NcOfv2TsHzwgsK7u043/P/cujzfXeDX7Mc94raqmTG
        wc0j7dWV/2uvmvwbpl6RfbOTbWu1nv95F++oPTkuPvjPinUv933Y/MKKTe6fqoZTvO3ldTqP
        dppZZQncir9+499qT5fffiV8Cz9rv3PcrFHoeEOJpTgj0VCLuag4EQAsSadQTwMAAA==
X-CMS-MailID: 20210621101742eucas1p13deeb4c2d37622f46c78efa459dacd41
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210608154400epcas1p1b22fd50629611a9475cb4d2b8dd9442d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210608154400epcas1p1b22fd50629611a9475cb4d2b8dd9442d
References: <20210608154341.10794-1-will@kernel.org>
        <CGME20210608154400epcas1p1b22fd50629611a9475cb4d2b8dd9442d@epcas1p1.samsung.com>
        <20210608154341.10794-2-will@kernel.org>
        <466bfc19-2260-87c6-c458-b43cf23617e3@samsung.com>
        <2a0181ea-a26e-65e9-16f6-cc233b6b296f@linaro.org>
        <fbcd234d-3ea0-d609-1f1d-b557ea329c37@samsung.com>
        <20210617214748.GC25403@willie-the-truck>
        <d79ebd58-1c4e-834c-fc06-482f25f6f3de@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 21.06.2021 11:25, Daniel Lezcano wrote:
> On 17/06/2021 23:47, Will Deacon wrote:
>> On Thu, Jun 17, 2021 at 09:58:35AM +0900, Chanwoo Choi wrote:
>>> On 6/17/21 12:25 AM, Daniel Lezcano wrote:
>>>> On 10/06/2021 03:03, Chanwoo Choi wrote:
>>>>> On 6/9/21 12:43 AM, Will Deacon wrote:
>>>>>> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
>>>>>> index fabad79baafc..804d3e01c8f4 100644
>>>>>> --- a/drivers/clocksource/exynos_mct.c
>>>>>> +++ b/drivers/clocksource/exynos_mct.c
>>>>>> @@ -51,6 +51,15 @@
>>>>>>   
>>>>>>   #define TICK_BASE_CNT	1
>>>>>>   
>>>>>> +#ifdef CONFIG_ARM
>>>>>> +/* Use values higher than ARM arch timer. See 6282edb72bed. */
>>>>>> +#define MCT_CLKSOURCE_RATING		450
>>>>>> +#define MCT_CLKEVENTS_RATING		500
>>>>>> +#else
>>>>>> +#define MCT_CLKSOURCE_RATING		350
>>>>>> +#define MCT_CLKEVENTS_RATING		350
>>>>>> +#endif
>>>>>> +
>>>>>>   enum {
>>>>>>   	MCT_INT_SPI,
>>>>>>   	MCT_INT_PPI
>>>>>> @@ -206,7 +215,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
>>>>>>   
>>>>>>   static struct clocksource mct_frc = {
>>>>>>   	.name		= "mct-frc",
>>>>>> -	.rating		= 450,	/* use value higher than ARM arch timer */
>>>>>> +	.rating		= MCT_CLKSOURCE_RATING,
>>>>>>   	.read		= exynos4_frc_read,
>>>>>>   	.mask		= CLOCKSOURCE_MASK(32),
>>>>>>   	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>>>>>> @@ -457,7 +466,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>>>>>>   	evt->set_state_oneshot_stopped = set_state_shutdown;
>>>>>>   	evt->tick_resume = set_state_shutdown;
>>>>>>   	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
>>>>>> -	evt->rating = 500;	/* use value higher than ARM arch timer */
>>>>>> +	evt->rating = MCT_CLKEVENTS_RATING,
>>>>>>   
>>>>>>   	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
>>>>>>   
>>>>>>
>>>>> I'm not sure that exynos mct is working without problem
>>>>> such as the case of 6282edb72bed.
>>>>> As described on On ,6282edb72bed the arch timer on exynos SoC
>>>>> depends on Exynos MCT device. the arch timer is not able to work
>>>>> without Exynos MCT because of using the common module.
>>>> Is it possible to change the DT to have a phandle to the exynos_mct, so
>>>> it will be probed before the arch_arm_timer ?
>>> I think that DT changes is not proper way to keep the order between
>>> exynos_mct and arch timer.
>> exynos4_mct_frc_start() is called unconditionally from probe via
>> exynos4_clocksource_init() so as long as the mct probes first, then the
>> arch timer should work, no? The rating shouldn't affect that.
> How do you ensure the exynos mct is probed before the arch timer ?
>
> The Makefile provides the right order, but the dependency is implicit.

In my test systems based on Exynos5433, the bootloader enabled MCT, so 
kernel can also start with arch_timer then switch to MCT. The probe 
order also depend on the order of DT nodes, so with the current dts MCT 
is probed first. This is not the best approach, but so far it works.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

