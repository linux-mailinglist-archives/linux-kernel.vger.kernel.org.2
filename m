Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3860A3CB7CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 15:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbhGPNWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:22:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:12143 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232804AbhGPNWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:22:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="207704388"
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="207704388"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 06:19:52 -0700
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="494935556"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 06:19:49 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m4Nkk-00EEoF-L8; Fri, 16 Jul 2021 16:19:42 +0300
Date:   Fri, 16 Jul 2021 16:19:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH v1 2/3] clk: fractional-divider: Introduce NO_PRESCALER
 flag
Message-ID: <YPGHbvaCv/x/JlgH@smile.fi.intel.com>
References: <20210715120752.29174-1-andriy.shevchenko@linux.intel.com>
 <20210715120752.29174-2-andriy.shevchenko@linux.intel.com>
 <7941107fda10f075395870528f0e52d42e502d92.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7941107fda10f075395870528f0e52d42e502d92.camel@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 10:43:57AM +0800, Liu Ying wrote:
> On Thu, 2021-07-15 at 15:07 +0300, Andy Shevchenko wrote:
> > The newly introduced flag, when set, makes the flow to skip
> > the assumption that the caller will use an additional 2^scale
> > prescaler to get the desired clock rate.
> 
> Now, I start to be aware of the reason why the "left shifting" is
> needed but still not 100% sure that details are all right. IIUC, you
> are considering a potential HW prescaler here, while I thought the HW
> model is just a fractional divider(M/N) and the driver is fully
> agnostic to the potential HW prescaler.

It's not AFAICS. Otherwise we will get saturated values which is much worse
then shifted left frequency. Anyway, this driver appeared first for the hardware
that has it for all users, so currently the assumption stays.

...

> >  	scale = fls_long(*parent_rate / rate - 1);
> > -	if (scale > fd->nwidth)
> > +	if (scale > fd->nwidth && !(fd->flags & CLK_FRAC_DIVIDER_NO_PRESCALER))
> >  		rate <<= scale - fd->nwidth;
> 
> First of all, check the CLK_FRAC_DIVIDER_NO_PRESCALER flag for the
> entire above snippet of code?

OK.

> Second and more important, it seems that it would be good to decouple
> the prescaler knowledge from this fractional divider clk driver so as
> to make it simple(Output rate = (m / n) * parent_rate).  This way, the
> CLK_FRAC_DIVIDER_NO_PRESCALER flag is not even needed at the first
> place, which means rational_best_approximation() just _directly_
> offer best_{numerator,denominator} for all cases.

Feel free to submit a patch, just give a good test to avoid breakage of almost
all users of this driver.

> Further more, is it
> possilbe for rational_best_approximation() to make sure there is no
> risk of overflow for best_{numerator,denominator}, since
> max_{numerator,denominator} are already handed over to
> rational_best_approximation()?

How? It can not be satisfied for all possible inputs.

> Overflowed/unreasonable
> best_{numerator,denominator} don't sound like the "best" offered value.

I don't follow here. If you got saturated values it means that your input is
not convergent. In practice it means that we will supply quite a bad value to
the caller.

> If that's impossible, then audit best_{numerator,denominator} after
> calling rational_best_approximation()?

And? I do not understand what you will do if you get the values of m and n
as m = 1, n = 2^nlim - 1.

> Make sense?

Not really. I probably miss your point, sorry.

So, I will submit v2 with addressed first comment and LKP noticed compiler
error.

-- 
With Best Regards,
Andy Shevchenko


