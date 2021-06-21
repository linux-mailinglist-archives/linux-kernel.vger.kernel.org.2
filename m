Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C216F3AE6CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFUKNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhFUKNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:13:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C41F860FE9;
        Mon, 21 Jun 2021 10:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624270264;
        bh=bVbHmO+KD1RJdeZ8rCLmbHPMTnDTtKhwg9BcddwTEwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=avT6x6VkGk5MZHaL6aTfxrWF7tmL/lqPZr2/16klm8yIwdt1+1jlFalN/qXiBG2u5
         7+DsBi3PBzf3Y9/vj0d2I0b1dZMaI2ER7HDUISNzseQnJtiwTmz/e9ulfDzQcSwd07
         H+2DkCGabRisfCfE5DqJk1F4/dpcwKrhSGRRQpAuZszgVPTcqfUSKt4woZNYlmcgBx
         YmnuDqP3B3z6gD3xiBj6OTbzbtSR9de+vZ2BtEAD7g37c8zBQyFmT9h6hJ/MPfvzv2
         s2Ld76p3IghlOt9nojHfhXaOWt70pvYm3Ho2QAEmtcLDsmNC9vU25SbLWRBUTWdRiD
         XMlTI9UPOlQzA==
Date:   Mon, 21 Jun 2021 11:10:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] clocksource/drivers/exynos_mct: Prioritise Arm arch
 timer on arm64
Message-ID: <20210621101058.GB28788@willie-the-truck>
References: <20210608154341.10794-1-will@kernel.org>
 <CGME20210608154400epcas1p1b22fd50629611a9475cb4d2b8dd9442d@epcas1p1.samsung.com>
 <20210608154341.10794-2-will@kernel.org>
 <466bfc19-2260-87c6-c458-b43cf23617e3@samsung.com>
 <2a0181ea-a26e-65e9-16f6-cc233b6b296f@linaro.org>
 <fbcd234d-3ea0-d609-1f1d-b557ea329c37@samsung.com>
 <20210617214748.GC25403@willie-the-truck>
 <d79ebd58-1c4e-834c-fc06-482f25f6f3de@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d79ebd58-1c4e-834c-fc06-482f25f6f3de@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 11:25:47AM +0200, Daniel Lezcano wrote:
> On 17/06/2021 23:47, Will Deacon wrote:
> > On Thu, Jun 17, 2021 at 09:58:35AM +0900, Chanwoo Choi wrote:
> >> On 6/17/21 12:25 AM, Daniel Lezcano wrote:
> >>> On 10/06/2021 03:03, Chanwoo Choi wrote:
> >>>> On 6/9/21 12:43 AM, Will Deacon wrote:
> >>>>> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> >>>>> index fabad79baafc..804d3e01c8f4 100644
> >>>>> --- a/drivers/clocksource/exynos_mct.c
> >>>>> +++ b/drivers/clocksource/exynos_mct.c
> >>>>> @@ -51,6 +51,15 @@
> >>>>>  
> >>>>>  #define TICK_BASE_CNT	1
> >>>>>  
> >>>>> +#ifdef CONFIG_ARM
> >>>>> +/* Use values higher than ARM arch timer. See 6282edb72bed. */
> >>>>> +#define MCT_CLKSOURCE_RATING		450
> >>>>> +#define MCT_CLKEVENTS_RATING		500
> >>>>> +#else
> >>>>> +#define MCT_CLKSOURCE_RATING		350
> >>>>> +#define MCT_CLKEVENTS_RATING		350
> >>>>> +#endif
> >>>>> +
> >>>>>  enum {
> >>>>>  	MCT_INT_SPI,
> >>>>>  	MCT_INT_PPI
> >>>>> @@ -206,7 +215,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
> >>>>>  
> >>>>>  static struct clocksource mct_frc = {
> >>>>>  	.name		= "mct-frc",
> >>>>> -	.rating		= 450,	/* use value higher than ARM arch timer */
> >>>>> +	.rating		= MCT_CLKSOURCE_RATING,
> >>>>>  	.read		= exynos4_frc_read,
> >>>>>  	.mask		= CLOCKSOURCE_MASK(32),
> >>>>>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> >>>>> @@ -457,7 +466,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
> >>>>>  	evt->set_state_oneshot_stopped = set_state_shutdown;
> >>>>>  	evt->tick_resume = set_state_shutdown;
> >>>>>  	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> >>>>> -	evt->rating = 500;	/* use value higher than ARM arch timer */
> >>>>> +	evt->rating = MCT_CLKEVENTS_RATING,
> >>>>>  
> >>>>>  	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
> >>>>>  
> >>>>>
> >>>>
> >>>> I'm not sure that exynos mct is working without problem
> >>>> such as the case of 6282edb72bed.
> >>>> As described on On ,6282edb72bed the arch timer on exynos SoC
> >>>> depends on Exynos MCT device. the arch timer is not able to work
> >>>> without Exynos MCT because of using the common module.
> >>>
> >>> Is it possible to change the DT to have a phandle to the exynos_mct, so
> >>> it will be probed before the arch_arm_timer ?
> >>
> >> I think that DT changes is not proper way to keep the order between
> >> exynos_mct and arch timer.
> > 
> > exynos4_mct_frc_start() is called unconditionally from probe via
> > exynos4_clocksource_init() so as long as the mct probes first, then the
> > arch timer should work, no? The rating shouldn't affect that.
> 
> How do you ensure the exynos mct is probed before the arch timer ?
> 
> The Makefile provides the right order, but the dependency is implicit.

Currently, I think it's done by the order of the CPU hotplug notifiers (
see the hunk of 6282edb72bed which touches cpuhotplug.h).

Will
