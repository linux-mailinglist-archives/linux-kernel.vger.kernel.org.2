Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259983ABE56
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 23:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFQVuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 17:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhFQVuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 17:50:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3845160FF1;
        Thu, 17 Jun 2021 21:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623966473;
        bh=crOECdcknuYs0DVwsxA5B1XKYsVXzWlHpvBwCMZLrQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uoJ8WFf7moEOMp9OdehLkeJ1ptbp+d7H9R825gWRr4nZbieLQm9nMi5h28L3QOrmE
         hwhh8zX7ETdX+DpTGT47wa8wO440xhrT8Xl3eGR/63l62cAYWEyILWc/Yi4k9v/Km3
         fDW4Q47fj2R9bvNwqCSaZBkfJ8bHbiCmNGj8lZP6Ns+dfR4mLEMhpnh9HJ2uQDWECM
         aTFKO1b+nS60/mG2Fi60JTgucljTreXLoBdTXIGxLDZwaY1NNEsfZaaTcJOPdJraVg
         PgYpTHEjMnXRWp6UyTWxm8Kg2pxe8J/Z3O/3gYrvoLfQBZhgEOINRghdL/ZQIu9BsN
         awDQHlJ6NgbXQ==
Date:   Thu, 17 Jun 2021 22:47:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] clocksource/drivers/exynos_mct: Prioritise Arm arch
 timer on arm64
Message-ID: <20210617214748.GC25403@willie-the-truck>
References: <20210608154341.10794-1-will@kernel.org>
 <CGME20210608154400epcas1p1b22fd50629611a9475cb4d2b8dd9442d@epcas1p1.samsung.com>
 <20210608154341.10794-2-will@kernel.org>
 <466bfc19-2260-87c6-c458-b43cf23617e3@samsung.com>
 <2a0181ea-a26e-65e9-16f6-cc233b6b296f@linaro.org>
 <fbcd234d-3ea0-d609-1f1d-b557ea329c37@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbcd234d-3ea0-d609-1f1d-b557ea329c37@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 09:58:35AM +0900, Chanwoo Choi wrote:
> On 6/17/21 12:25 AM, Daniel Lezcano wrote:
> > On 10/06/2021 03:03, Chanwoo Choi wrote:
> >> On 6/9/21 12:43 AM, Will Deacon wrote:
> >>> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> >>> index fabad79baafc..804d3e01c8f4 100644
> >>> --- a/drivers/clocksource/exynos_mct.c
> >>> +++ b/drivers/clocksource/exynos_mct.c
> >>> @@ -51,6 +51,15 @@
> >>>  
> >>>  #define TICK_BASE_CNT	1
> >>>  
> >>> +#ifdef CONFIG_ARM
> >>> +/* Use values higher than ARM arch timer. See 6282edb72bed. */
> >>> +#define MCT_CLKSOURCE_RATING		450
> >>> +#define MCT_CLKEVENTS_RATING		500
> >>> +#else
> >>> +#define MCT_CLKSOURCE_RATING		350
> >>> +#define MCT_CLKEVENTS_RATING		350
> >>> +#endif
> >>> +
> >>>  enum {
> >>>  	MCT_INT_SPI,
> >>>  	MCT_INT_PPI
> >>> @@ -206,7 +215,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
> >>>  
> >>>  static struct clocksource mct_frc = {
> >>>  	.name		= "mct-frc",
> >>> -	.rating		= 450,	/* use value higher than ARM arch timer */
> >>> +	.rating		= MCT_CLKSOURCE_RATING,
> >>>  	.read		= exynos4_frc_read,
> >>>  	.mask		= CLOCKSOURCE_MASK(32),
> >>>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> >>> @@ -457,7 +466,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
> >>>  	evt->set_state_oneshot_stopped = set_state_shutdown;
> >>>  	evt->tick_resume = set_state_shutdown;
> >>>  	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> >>> -	evt->rating = 500;	/* use value higher than ARM arch timer */
> >>> +	evt->rating = MCT_CLKEVENTS_RATING,
> >>>  
> >>>  	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
> >>>  
> >>>
> >>
> >> I'm not sure that exynos mct is working without problem
> >> such as the case of 6282edb72bed.
> >> As described on On ,6282edb72bed the arch timer on exynos SoC
> >> depends on Exynos MCT device. the arch timer is not able to work
> >> without Exynos MCT because of using the common module.
> > 
> > Is it possible to change the DT to have a phandle to the exynos_mct, so
> > it will be probed before the arch_arm_timer ?
> 
> I think that DT changes is not proper way to keep the order between
> exynos_mct and arch timer.

exynos4_mct_frc_start() is called unconditionally from probe via
exynos4_clocksource_init() so as long as the mct probes first, then the
arch timer should work, no? The rating shouldn't affect that.

Will
