Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67E13AA837
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 02:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbhFQAls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 20:41:48 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:64115 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbhFQAlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 20:41:47 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210617003939epoutp019f263d861cbdf744f192b2c919cd0579~JN7I6Tuct2660426604epoutp01p
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:39:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210617003939epoutp019f263d861cbdf744f192b2c919cd0579~JN7I6Tuct2660426604epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623890379;
        bh=1mJCT+OLxTOy0dFMz+hw4mqKoSdTNkc5H2OBV1G6e60=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MeDIvnzfwqy1BpPs5/eg+qAaAdcwQDE+zOoeVD/al7cPUbH6lR+nKv1WpezV7V2vv
         ScgUg/ivITI1i4vhl5Oue96tmQLsqqirRMFE+ZIF+uBMSPXs5cUBzLShxUwj88iSVu
         A5tvjRjnS+zGgXoeica0i9DaI99pB+DpIo525C6s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210617003938epcas1p33232ad18e38490bb620cc4463a222f38~JN7IhpAXF0368503685epcas1p3z;
        Thu, 17 Jun 2021 00:39:38 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4G53933rdlz4x9Px; Thu, 17 Jun
        2021 00:39:35 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.59.09578.7C99AC06; Thu, 17 Jun 2021 09:39:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210617003934epcas1p203d1eb05a5f24c0a055c1a1d99e3cb4a~JN7EwEHU80081400814epcas1p2u;
        Thu, 17 Jun 2021 00:39:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210617003934epsmtrp2c98c88abc62cdb585da490893c4c4ef8~JN7EuinpC1111911119epsmtrp2C;
        Thu, 17 Jun 2021 00:39:34 +0000 (GMT)
X-AuditID: b6c32a35-fcfff7000000256a-7c-60ca99c77b01
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.5A.08637.6C99AC06; Thu, 17 Jun 2021 09:39:34 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210617003934epsmtip295c75d50b47e416acd41227c90b1b34c~JN7Ec-2p70800708007epsmtip2N;
        Thu, 17 Jun 2021 00:39:34 +0000 (GMT)
Subject: Re: [PATCH 1/2] clocksource/drivers/exynos_mct: Prioritise Arm arch
 timer on arm64
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <fbcd234d-3ea0-d609-1f1d-b557ea329c37@samsung.com>
Date:   Thu, 17 Jun 2021 09:58:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <2a0181ea-a26e-65e9-16f6-cc233b6b296f@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmru7xmacSDP7Nk7CY91nW4vz5DewW
        G9/+YLLY9Pgaq8XlXXPYLNYeuctusXnTVGaLljumDhwesxp62Tw2repk87hzbQ+bx7tz59g9
        Ni+p9+jbsorR4/MmuQD2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTc
        VFslF58AXbfMHKCTlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFlgV6xYm5xaV5
        6XrJ+blWhgYGRqZAhQnZGfePrGUueCZVMXnWTeYGxi+iXYycHBICJhLNTX/Zuhi5OIQEdjBK
        /Lh/ggnC+cQoseXMBUaQKiGBb4wSd1YKwnR8nNjHDBHfyyixplkCouE9o8Sj+c+AGjg4hAVi
        Ja4vVQapERHIldjZ1csMUsMs8JBR4tnyMywgCTYBLYn9L26wgdj8AooSV388BlvGK2AnMXfS
        drA4i4CqxP5De1lBbFGBMImT21qgagQlTs58AjaHE6j+3o6LYAcxC4hL3HoynwnClpfY/nYO
        2GIJgZUcErfOXGOC+MBFYv/d9WwQtrDEq+Nb2CFsKYnP7/ZCxaslVp48wgbR3AEMiv0XWCES
        xhL7l05mAvmSWUBTYv0ufYiwosTO33MZIRbzSbz72sMKUiIhwCvR0SYEUaIscfnBXagTJCUW
        t3eyTWBUmoXknVlIXpiF5IVZCMsWMLKsYhRLLSjOTU8tNiwwRI7sTYzg1KpluoNx4tsPeocY
        mTgYDzFKcDArifDqFp9IEOJNSaysSi3Kjy8qzUktPsRoCgzgicxSosn5wOSeVxJvaGpkbGxs
        YWJoZmpoqCTOu5PtUIKQQHpiSWp2ampBahFMHxMHp1QD0zybMMVkIbvu2cZnfGtXhy28OmN1
        1EG7b3qhVoXJfKnt4csXOO50CghYrbD9hP7Etw4bpRbca+Bc9UvpVLtFVcki1Vd8czcdmj9d
        /dfd44URDD4JG1ZruHjHShf2bbnSFb6T6Y3Ezka+mR6ay5n3eS3nsuMxm55WdUjFnf2bzl+p
        gh3c+jLc03z6PLdMt9avyXR5vX96e4Ni2u+0kG17tk0v5ZW7ZvQsryJ11jtZ29drUpxOBc83
        ifwdyKFrp8ohMeU1p7TUs7gFCyMZOqtZd4rLeQXHGvcasVtuYN/QI3vl4RemY/vWpzx9brPH
        g1F1c95zhhNLAhWu9XALqlxR5wxWTD29oebUZl7lA8eUWIozEg21mIuKEwEAFeGuNgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXvfYzFMJBp/XaljM+yxrcf78BnaL
        jW9/MFlsenyN1eLyrjlsFmuP3GW32LxpKrNFyx1TBw6PWQ29bB6bVnWyedy5tofN4925c+we
        m5fUe/RtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfG/SNrmQueSVVMnnWTuYHxi2gXIyeHhICJ
        xMeJfcxdjFwcQgK7GSWebdzPDpGQlJh28ShQggPIFpY4fLgYouYto8ScrntMIHFhgViJ60uV
        QcpFBHIlnk65xARSwyzwmFHixYV1bBANc5gkXt5ZwwhSxSagJbH/xQ02EJtfQFHi6o/HYHFe
        ATuJuZO2g8VZBFQl9h/aywpiiwqESexc8pgJokZQ4uTMJywgNidQ/b0dF5lBbGYBdYk/8y5B
        2eISt57MZ4Kw5SW2v53DPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE
        3OLSvHS95PzcTYzgONPS3MG4fdUHvUOMTByMhxglOJiVRHh1i08kCPGmJFZWpRblxxeV5qQW
        H2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cAk8bxtr8uN0oQJAc3fC9rnXbYvFTp/
        hFM2r9gqvnvNyrUhfr/yZtt9LvpzWjNRfp7IxaDJrCbSylMrD6ak+R8PLBM76r8quWXKHoeH
        openidhvyFYvZBf3jgidsfNeVEO6mK3S0qQ5saqX9+ewT+YMnW318qc9v3O2lEZDZYfqhicd
        8UyBj5WKaqU4y1IeePcnNDkIRErxmfW8O9rx45brjY2HZ1/XObpD58eXKfnLRL7uu2W02ubU
        vNBOgbtyAZ4fFhwJzPh2QLN6u6xT+1s2TYPjRU2LdPiu5b3btEbnniw/1xrBhIqc5U8U53dO
        YE58fSSMzTlovtzyPY71nU1+HM8+J8/aekNqV4fUMyWW4oxEQy3mouJEAN1UjF0iAwAA
X-CMS-MailID: 20210617003934epcas1p203d1eb05a5f24c0a055c1a1d99e3cb4a
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
        <466bfc19-2260-87c6-c458-b43cf23617e3@samsung.com>
        <2a0181ea-a26e-65e9-16f6-cc233b6b296f@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/21 12:25 AM, Daniel Lezcano wrote:
> On 10/06/2021 03:03, Chanwoo Choi wrote:
>> Hi,
>>
>> On 6/9/21 12:43 AM, Will Deacon wrote:
>>> All arm64 CPUs feature an architected timer, which offers a relatively
>>> low-latency interface to a per-cpu clocksource and timer. For the most
>>> part, using this interface is a no-brainer, with the exception of SoCs
>>> where it cannot be used to wake up from deep idle state (i.e.
>>> CLOCK_EVT_FEAT_C3STOP is set).
>>>
>>> On the contrary, the Exynos MCT is extremely slow to access yet can be
>>> used as a wakeup source. In preparation for using the Exynos MCT as a
>>> potential wakeup timer for the Arm architected timer, reduce its ratings
>>> so that the architected timer is preferred.
>>>
>>> This effectively reverts the decision made in 6282edb72bed
>>> ("clocksource/drivers/exynos_mct: Increase priority over ARM arch timer")
>>> for arm64, as the reasoning for the original change was to work around
>>> a 32-bit SoC design.
>>>
>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Signed-off-by: Will Deacon <will@kernel.org>
>>> ---
>>>  drivers/clocksource/exynos_mct.c | 13 +++++++++++--
>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
>>> index fabad79baafc..804d3e01c8f4 100644
>>> --- a/drivers/clocksource/exynos_mct.c
>>> +++ b/drivers/clocksource/exynos_mct.c
>>> @@ -51,6 +51,15 @@
>>>  
>>>  #define TICK_BASE_CNT	1
>>>  
>>> +#ifdef CONFIG_ARM
>>> +/* Use values higher than ARM arch timer. See 6282edb72bed. */
>>> +#define MCT_CLKSOURCE_RATING		450
>>> +#define MCT_CLKEVENTS_RATING		500
>>> +#else
>>> +#define MCT_CLKSOURCE_RATING		350
>>> +#define MCT_CLKEVENTS_RATING		350
>>> +#endif
>>> +
>>>  enum {
>>>  	MCT_INT_SPI,
>>>  	MCT_INT_PPI
>>> @@ -206,7 +215,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
>>>  
>>>  static struct clocksource mct_frc = {
>>>  	.name		= "mct-frc",
>>> -	.rating		= 450,	/* use value higher than ARM arch timer */
>>> +	.rating		= MCT_CLKSOURCE_RATING,
>>>  	.read		= exynos4_frc_read,
>>>  	.mask		= CLOCKSOURCE_MASK(32),
>>>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>>> @@ -457,7 +466,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>>>  	evt->set_state_oneshot_stopped = set_state_shutdown;
>>>  	evt->tick_resume = set_state_shutdown;
>>>  	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
>>> -	evt->rating = 500;	/* use value higher than ARM arch timer */
>>> +	evt->rating = MCT_CLKEVENTS_RATING,
>>>  
>>>  	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
>>>  
>>>
>>
>> I'm not sure that exynos mct is working without problem
>> such as the case of 6282edb72bed.
>> As described on On ,6282edb72bed the arch timer on exynos SoC
>> depends on Exynos MCT device. the arch timer is not able to work
>> without Exynos MCT because of using the common module.
> 
> Is it possible to change the DT to have a phandle to the exynos_mct, so
> it will be probed before the arch_arm_timer ?

I think that DT changes is not proper way to keep the order between exynos_mct and arch timer.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
