Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3A13A2195
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 02:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFJAqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 20:46:55 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:16798 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhFJAqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 20:46:53 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210610004454epoutp0328f608ef655604f165d0c5d232375586~HEeumJV522826628266epoutp03t
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:44:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210610004454epoutp0328f608ef655604f165d0c5d232375586~HEeumJV522826628266epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623285894;
        bh=ChGSmDfVZ/bQ1bPpr+KHGi6lUL3KDygGBIdbNX9o+e4=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=ORQHQWNSINgLpd2B8od7JG9w8C5h5l1bTFxAdCcbuvmFLP9Mt+M0NVmyg6C4J/q0B
         e2RfkvnDKZYZzLGiguF3t71/l0SUQURp3caQ6PUisOOs7YjJKuEYQlPQQt8w8k6dvJ
         SQeMmPUYDnFTSGMWq4qqXLJElMRP+9G21y3OQFBk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210610004454epcas1p3679973ff4fb36e1e407d4a55a4037068~HEeuLL3iC1697916979epcas1p3C;
        Thu, 10 Jun 2021 00:44:54 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4G0lcL2qyDz4x9Pv; Thu, 10 Jun
        2021 00:44:50 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.5A.10258.67061C06; Thu, 10 Jun 2021 09:44:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210610004438epcas1p1a1df2f2aeea52e5fcce0e0280fd4a810~HEefm21sY2866128661epcas1p1v;
        Thu, 10 Jun 2021 00:44:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210610004438epsmtrp1f43a4511ba0e398fbab1277d96905f34~HEefmBswg1263912639epsmtrp12;
        Thu, 10 Jun 2021 00:44:38 +0000 (GMT)
X-AuditID: b6c32a38-42fff70000002812-e6-60c16076a947
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.0B.08637.67061C06; Thu, 10 Jun 2021 09:44:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210610004438epsmtip275d1c2e76c99d6586d8d991f4e9853ce~HEefWU2wt1158011580epsmtip2D;
        Thu, 10 Jun 2021 00:44:38 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/2] clocksource/drivers/exynos_mct: Prioritise Arm arch
 timer on arm64
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Organization: Samsung Electronics
Message-ID: <466bfc19-2260-87c6-c458-b43cf23617e3@samsung.com>
Date:   Thu, 10 Jun 2021 10:03:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210608154341.10794-2-will@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmgW5ZwsEEgyMf9SzmfZa1OH9+A7vF
        xrc/mCw2Pb7GanF51xw2i7VH7rJbbN40ldmi5Y6pA4fHrIZeNo9NqzrZPO5c28Pm8e7cOXaP
        zUvqPfq2rGL0+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
        1VbJxSdA1y0zB+gkJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWle
        ul5yfq6VoYGBkSlQYUJ2RuOJDUwF08Qrmnf9YWlgfC3UxcjJISFgItE5az5bFyMXh5DADkaJ
        CetvQDmfGCUez/3HCuF8Y5Q42XKesYuRA6zl7kILiPheRomns59CdbxnlGh4eIcRZC6bgJbE
        /hcgozg4hAViJa4vVQYJiwjYS9ye+JgFpJ5ZoJdJYtGKZnaQBL+AosTVH4/BenkF7CTmbTjJ
        DNLLIqAq8f25DEhYVCBM4uS2FqgSQYmTM5+wgNicAqYSf15cARvDLCAucevJfCYIW15i+9s5
        zBBvruWQaH5dC2G7SNx/cpsdwhaWeHV8C5QtJfGyvw3KrpZYefII2F8SAh2MElv2X2CFSBhL
        7F86mQnkNmYBTYn1u/QhwooSO3/PZYTYyyfx7msPKySseCU62qAhrSxx+cFdJghbUmJxeyfb
        BEalWUi+mYXkg1lIPpiFsGwBI8sqRrHUguLc9NRiwwIT5LjexAhOrFoWOxjnvv2gd4iRiYPx
        EKMEB7OSCG+Z4b4EId6UxMqq1KL8+KLSnNTiQ4ymwOCdyCwlmpwPTO15JfGGpkbGxsYWJoZm
        poaGSuK86c7VCUIC6YklqdmpqQWpRTB9TBycUg1MdU/meDQuCmu3jcy6oeJxUf5XcM8eno2r
        bNlV3HivlK48r3HIIWthxlqRGB3DRT7sL+u6HsVPYZzzbFfqjp8/mx/k7n50i5W759wbRq+3
        J5YwbP3wzEAyqufVJbXkBZGLnbVcnz/aVL8jRu1YK9/NFF/jMJXVHJLlbVyJyrZfXbc2//i8
        /F9ojni8qMGGWU/OPvieY9ZSVc8lO8fu5bUb4UY9n3YtX9ft1Wfz9tiE8nfh99jFVn/VaX8f
        4D7f48aPGWY3r6V9PPhM1qpjrU3H7PTt/7ZouHsU68SVnA3qY/uYtEHuZONk43WOFyQeqT1o
        +VLtHXwnZ+mKr5+OpL/nyLrSJHRRZFLW7bUZF2K0lViKMxINtZiLihMBWPD0vjUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXrcs4WCCwbLFQhbzPstanD+/gd1i
        49sfTBabHl9jtbi8aw6bxdojd9ktNm+aymzRcsfUgcNjVkMvm8emVZ1sHneu7WHzeHfuHLvH
        5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJXReGIDU8E08YrmXX9YGhhfC3UxcnBICJhI
        3F1o0cXIxSEksJtRYs6F7exdjJxAcUmJaRePMkPUCEscPlwMUfOWUeLcpeOMIDVsAloS+1/c
        YAOpERaIlbi+VBkkLCJgL3F74mMWkHpmgYlMEgtuLWSFaN7MKNF24wUzSBW/gKLE1R+PwQbx
        CthJzNtwEmwZi4CqxPfnMiBhUYEwiZ1LHjNBlAhKnJz5hAXE5hQwlfjz4grYncwC6hJ/5l1i
        hrDFJW49mc8EYctLbH87h3kCo/AsJO2zkLTMQtIyC0nLAkaWVYySqQXFuem5xYYFhnmp5XrF
        ibnFpXnpesn5uZsYwTGmpbmDcfuqD3qHGJk4GA8xSnAwK4nwlhnuSxDiTUmsrEotyo8vKs1J
        LT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBab/v4zk3V5xiexxvvGezttK9LWF+
        vGE7WoIiGc9m9j53ztO+eiBmtfUboY/cppvNIg9c39T/P6h+TjXP3Nw/gux5r6zuF9/deW7t
        jPTQxcvzIuVv/ZwT/jVt9gvvpXebqncxPf/kYXLj7cMt6yfpnf3bISRe257M/CjaL/jDu0Ub
        l21zTzzY9Ii/IG/vlZwf704dauC+ObmcmZGhV0IpMfu/d61wtzPHUhdWnh1d006Z+agUWVkc
        MeWeG69xfMHuW3PnHGZKjS/stYuInhyillr6laHR29K09LqblJn5YvalyRsEnmU6nPtlVfp3
        f4lTW5dl7E8ph+UsXWsTN0iG2v1n+/ti+0b2O7NvhT02VWIpzkg01GIuKk4EAD/8S00gAwAA
X-CMS-MailID: 20210610004438epcas1p1a1df2f2aeea52e5fcce0e0280fd4a810
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210608154400epcas1p1b22fd50629611a9475cb4d2b8dd9442d
References: <20210608154341.10794-1-will@kernel.org>
        <CGME20210608154400epcas1p1b22fd50629611a9475cb4d2b8dd9442d@epcas1p1.samsung.com>
        <20210608154341.10794-2-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/9/21 12:43 AM, Will Deacon wrote:
> All arm64 CPUs feature an architected timer, which offers a relatively
> low-latency interface to a per-cpu clocksource and timer. For the most
> part, using this interface is a no-brainer, with the exception of SoCs
> where it cannot be used to wake up from deep idle state (i.e.
> CLOCK_EVT_FEAT_C3STOP is set).
> 
> On the contrary, the Exynos MCT is extremely slow to access yet can be
> used as a wakeup source. In preparation for using the Exynos MCT as a
> potential wakeup timer for the Arm architected timer, reduce its ratings
> so that the architected timer is preferred.
> 
> This effectively reverts the decision made in 6282edb72bed
> ("clocksource/drivers/exynos_mct: Increase priority over ARM arch timer")
> for arm64, as the reasoning for the original change was to work around
> a 32-bit SoC design.
> 
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/clocksource/exynos_mct.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index fabad79baafc..804d3e01c8f4 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -51,6 +51,15 @@
>  
>  #define TICK_BASE_CNT	1
>  
> +#ifdef CONFIG_ARM
> +/* Use values higher than ARM arch timer. See 6282edb72bed. */
> +#define MCT_CLKSOURCE_RATING		450
> +#define MCT_CLKEVENTS_RATING		500
> +#else
> +#define MCT_CLKSOURCE_RATING		350
> +#define MCT_CLKEVENTS_RATING		350
> +#endif
> +
>  enum {
>  	MCT_INT_SPI,
>  	MCT_INT_PPI
> @@ -206,7 +215,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
>  
>  static struct clocksource mct_frc = {
>  	.name		= "mct-frc",
> -	.rating		= 450,	/* use value higher than ARM arch timer */
> +	.rating		= MCT_CLKSOURCE_RATING,
>  	.read		= exynos4_frc_read,
>  	.mask		= CLOCKSOURCE_MASK(32),
>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> @@ -457,7 +466,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>  	evt->set_state_oneshot_stopped = set_state_shutdown;
>  	evt->tick_resume = set_state_shutdown;
>  	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> -	evt->rating = 500;	/* use value higher than ARM arch timer */
> +	evt->rating = MCT_CLKEVENTS_RATING,
>  
>  	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
>  
> 

I'm not sure that exynos mct is working without problem
such as the case of 6282edb72bed.
As described on On ,6282edb72bed the arch timer on exynos SoC
depends on Exynos MCT device. the arch timer is not able to work
without Exynos MCT because of using the common module.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
