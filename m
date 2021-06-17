Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3FC3AA838
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 02:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbhFQAmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 20:42:38 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:41843 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhFQAmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 20:42:31 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210617004022epoutp0455c34c96cf0fe9f1d1ea81eb24882cd8~JN7xiEb9V0795607956epoutp04V
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:40:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210617004022epoutp0455c34c96cf0fe9f1d1ea81eb24882cd8~JN7xiEb9V0795607956epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623890422;
        bh=ztHsB24trgV+hpc4lN7exTQ5OEFZrVEMZIGj5xyUugE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=esi+CExcFSBv84AiZ+fQDNFS7zTWtJ4FYRpTSq5gXHT1RjtVzSdnSR1kgj8c0X1kQ
         qEqNcDUH0GbnwCMoxaVG7wz9c399XyGao6O0SAau/q06C4mtHmdFUn7s8RXz8GRwie
         2dWXZPsCrrBQxdWw6KEbJLUYkvODtoaH9q3xZ5TA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210617004022epcas1p4fe44a33441c99a79c5260d88229287ba~JN7xIi66G3107931079epcas1p4Q;
        Thu, 17 Jun 2021 00:40:22 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4G539t6fQnz4x9Px; Thu, 17 Jun
        2021 00:40:18 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.D0.09701.FE99AC06; Thu, 17 Jun 2021 09:40:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210617004013epcas1p184c165a548af19bfcccdaae9c8d03b3d~JN7oylLHB2390723907epcas1p1m;
        Thu, 17 Jun 2021 00:40:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210617004013epsmtrp2713fea3f7d31380feca9b4460913ba6c~JN7oxlhd21111911119epsmtrp21;
        Thu, 17 Jun 2021 00:40:13 +0000 (GMT)
X-AuditID: b6c32a36-647ff700000025e5-58-60ca99ef3945
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.6A.08637.DE99AC06; Thu, 17 Jun 2021 09:40:13 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210617004013epsmtip1c28a0800d678df7ab390d7004c5d1b8b~JN7ohjTsO2519725197epsmtip1c;
        Thu, 17 Jun 2021 00:40:13 +0000 (GMT)
Subject: Re: [PATCH 2/2] clocksource/drivers/exynos_mct: Mark MCT device as
 CLOCK_EVT_FEAT_PERCPU
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2556dd26-c072-5bbc-18fc-9fdec46b0657@samsung.com>
Date:   Thu, 17 Jun 2021 09:59:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210608154341.10794-3-will@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmge77macSDH7/F7KY91nW4vz5DewW
        G9/+YLLY9Pgaq8XlXXPYLNYeuctusXnTVGaLljumDhwesxp62Tw2repk87hzbQ+bx7tz59g9
        Ni+p9+jbsorR4/MmuQD2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTc
        VFslF58AXbfMHKCTlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFlgV6xYm5xaV5
        6XrJ+blWhgYGRqZAhQnZGa1HHrEXzOWuOHrlDlMD41HOLkZODgkBE4lDL1pZuhi5OIQEdjBK
        LHu5jQnC+cQo0ffgL1TmG6PEzS23mWBaZpxqYoNI7GWUaF5yjBXCec8o8f91D1AVB4ewQLLE
        mqYQkAYRAXuJ2xMfg01iFuhlkli0opkdJMEmoCWx/8UNNhCbX0BR4uqPx4wgNq+AncSnVWvB
        algEVCUuzn7LAmKLCoRJnNzWAlUjKHFy5hOwOKeAqcSFXbOZQWxmAXGJW0/mM0HY8hLb385h
        BlksIbCFQ+LclTfsIMdJCLhItL3TgPhGWOLV8S3sELaUxOd3e9kg7GqJlSePsEH0djBKbNl/
        gRUiYSyxf+lksCeZBTQl1u/ShwgrSuz8PZcRYi+fxLuvPawQq3glOtqEIEqUJS4/uAsNREmJ
        xe2dbBMYlWYh+WYWkg9mIflgFsKyBYwsqxjFUguKc9NTiw0LjJBjexMjOLlqme1gnPT2g94h
        RiYOxkOMEhzMSiK8usUnEoR4UxIrq1KL8uOLSnNSiw8xmgLDdyKzlGhyPjC955XEG5oaGRsb
        W5gYmpkaGiqJ8+5kO5QgJJCeWJKanZpakFoE08fEwSnVwBRf3cEfP/9t9M+0NbHzwj6t3P9b
        7nbEs5IQ1YofptJFfDK9BwVvu1eqmpveV+hdouohlMzr82r/wSDja+avZX2erXiaNG9u3JTU
        +Wl2f3x6Kzcr+ewKr+5h9ryafrOVW6TjAG/j+kmqr6/yh9/gYZ6+3OHag5VNc3XPBd6I3LA5
        d+GV9zXBZbG8Ar1VX6LZZULvF6TUX/y3Z/3shp3cvHfb8sKM3xo9yn+9htH8WVmSeZvWj3aj
        1mczZJer+VXz+i9ovvJ+mc9v2+q6ibIzNz1d5j+1fk1MZhjfh9ijc1ebq2dkbRLbpR1lcpWr
        YcORc8sWvQpccn6yldrShgf/N9u1TNs6+diV7+92rYx9NU+JpTgj0VCLuag4EQCCjiG+NwQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTvftzFMJBntaRSzmfZa1OH9+A7vF
        xrc/mCw2Pb7GanF51xw2i7VH7rJbbN40ldmi5Y6pA4fHrIZeNo9NqzrZPO5c28Pm8e7cOXaP
        zUvqPfq2rGL0+LxJLoA9issmJTUnsyy1SN8ugSuj9cgj9oK53BVHr9xhamA8ytnFyMkhIWAi
        MeNUE1sXIxeHkMBuRok3P8+wQCQkJaZdPMrcxcgBZAtLHD5cDFHzllFizsS1TCBxYYFkiTVN
        ISDlIgL2ErcnPmYBqWEWmMgkseDWQlaQhJDAZkaJle3CIDabgJbE/hc32EBsfgFFias/HjOC
        2LwCdhKfVq1lB7FZBFQlLs5+C3aDqECYxM4lj5kgagQlTs58AhbnFDCVuLBrNjOIzSygLvFn
        3iUoW1zi1pP5TBC2vMT2t3OYJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCYl1qu
        V5yYW1yal66XnJ+7iREcZVqaOxi3r/qgd4iRiYPxEKMEB7OSCK9u8YkEId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpgOPG/ZdIDthnNlBlfLh+XerbdZ
        VRmCNRRX/lnudLj2XvGn6zyLeC891yy85KKtuTp0++sYryyNw9Y9oVPVezLmxJvfX1W4wzCZ
        i++Prftyi322nAHztKdo1ytVyohV8K++eGpdcK6FdMrpY72adsu+TZTTft398Hxy92oF2xOp
        eXvuutqZCkjvq1AO2R7/aIfl1sw/Wv1yxXbP1Ran3w0TtJm04FJQ2pPTC664bV0l2vTWUSVQ
        7cQJoXqZ/6+d6zkE7mV+KPMJyr+2IWVr7MOcGY+Lq/Oc9iybkyFwYdnurkteSlsPBkR0MPy8
        45Vuvz7tIOf3ZYHV5z6uWbX4yPSnJatkVDjeGdfvnFVkGa7EUpyRaKjFXFScCABEUcz9IQMA
        AA==
X-CMS-MailID: 20210617004013epcas1p184c165a548af19bfcccdaae9c8d03b3d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210608154402epcas1p401cdd1cd14425e2f542a344a0ebcc97e
References: <20210608154341.10794-1-will@kernel.org>
        <CGME20210608154402epcas1p401cdd1cd14425e2f542a344a0ebcc97e@epcas1p4.samsung.com>
        <20210608154341.10794-3-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 12:43 AM, Will Deacon wrote:
> The "mct_tick" is a per-cpu clockevents device. Set the
> CLOCK_EVT_FEAT_PERCPU feature to prevent e.g. mct_tick0 being unsafely
> designated as the global broadcast timer and instead treat the device as
> a per-cpu wakeup timer.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/clocksource/exynos_mct.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 804d3e01c8f4..5e3e96d3d1b9 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -465,7 +465,8 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>  	evt->set_state_oneshot = set_state_shutdown;
>  	evt->set_state_oneshot_stopped = set_state_shutdown;
>  	evt->tick_resume = set_state_shutdown;
> -	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> +	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
> +			CLOCK_EVT_FEAT_PERCPU;
>  	evt->rating = MCT_CLKEVENTS_RATING,
>  
>  	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
