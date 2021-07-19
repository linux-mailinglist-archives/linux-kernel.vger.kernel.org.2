Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0A93CD45F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbhGSL3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:29:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:56346 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236505AbhGSL3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:29:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="209139606"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="209139606"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 05:10:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="494044797"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 05:09:59 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m5S5o-00FVMa-Pg; Mon, 19 Jul 2021 15:09:52 +0300
Date:   Mon, 19 Jul 2021 15:09:52 +0300
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
Message-ID: <YPVrkAarqSBMY1tV@smile.fi.intel.com>
References: <20210715120752.29174-1-andriy.shevchenko@linux.intel.com>
 <20210715120752.29174-2-andriy.shevchenko@linux.intel.com>
 <7941107fda10f075395870528f0e52d42e502d92.camel@nxp.com>
 <YPGHbvaCv/x/JlgH@smile.fi.intel.com>
 <bfa0c16e88c0d445137290b2bef104e5fa74d78a.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfa0c16e88c0d445137290b2bef104e5fa74d78a.camel@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 11:16:07AM +0800, Liu Ying wrote:
> On Fri, 2021-07-16 at 16:19 +0300, Andy Shevchenko wrote:
> > On Fri, Jul 16, 2021 at 10:43:57AM +0800, Liu Ying wrote:
> > > On Thu, 2021-07-15 at 15:07 +0300, Andy Shevchenko wrote:

...

> > > Second and more important, it seems that it would be good to decouple
> > > the prescaler knowledge from this fractional divider clk driver so as
> > > to make it simple(Output rate = (m / n) * parent_rate).  This way, the
> > > CLK_FRAC_DIVIDER_NO_PRESCALER flag is not even needed at the first
> > > place, which means rational_best_approximation() just _directly_
> > > offer best_{numerator,denominator} for all cases.
> > 
> > Feel free to submit a patch, just give a good test to avoid breakage of almost
> > all users of this driver.
> 
> Maybe someone may do that.

Perhaps. The idea per se is good I think, but I doubt that the implementation
will be plausible.

> I just shared my thought that it sounds
> like a good idea

Thanks!

> to decouple the prescaler knowledge from this
> fractional divider clk driver.

Are you suggesting that each of the device that has _private_ pre-scaler has to
be a clock provider at the same time?

OTOH you will probably need irrespresentable hierarchy to avoid saturated values.

At least those two issues I believe makes the idea fade in complications of the
actual implementation. But again, send the code (you or anybody else) and we will
see how it looks like.

...

> > > Further more, is it
> > > possilbe for rational_best_approximation() to make sure there is no
> > > risk of overflow for best_{numerator,denominator}, since
> > > max_{numerator,denominator} are already handed over to
> > > rational_best_approximation()?
> > 
> > How? It can not be satisfied for all possible inputs.
> 
> Just have rational_best_approximation() make sure
> best_{numerator,denominator} are in the range of
> [1, max_{numerator,denominator}] for all given_{numerator,denominator}.
> At the same time, best_numerator/best_denominator should be as close
> to given_numerator/given_denominator as possible. For this particular
> fractional divider clk use case, clk_round_rate() can be called
> multiple times until users find rounded rate is ok.

How is it supposed to work IRL? E.g. this driver is being used for UART. Serial
core (or even TTY) has a specific function to approximate the baud rate and it
tries it 2 or 3 times. In case of *saturated* values it won't progress anyhow
because from best rational approximation algorithm the very first attempt would
be done against the best possible clock rate.

Can you provide some code skeleton to see?

...

> > > Overflowed/unreasonable
> > > best_{numerator,denominator} don't sound like the "best" offered value.
> > 
> > I don't follow here. If you got saturated values it means that your input is
> > not convergent. In practice it means that we will supply quite a bad value to
> > the caller.
> 
> Just like I mentioned above, if given_{numerator,denominator} are not
> convergent, best_numerator/best_denominator should be as close
> to given_numerator/given_denominator as possible and at the same time
> best_{numerator,denominator} are in the range of
> [1, max_{numerator,denominator}].  This way, caller may have chance to
> propose convergent inputs.

How? Again, provide some code to understand this better.
(Spoiler: arithmetics won't allow you to do this. Or maybe
 I'm badly missing something very simple and obvious...)

And, if it's possible to achieve, are you suggesting that part of
what CCF driver should do the users will have been doing by their
own?

TL;DR: please send a code to discuss.

Thanks for review and you review of v2 is warmly welcomed!

-- 
With Best Regards,
Andy Shevchenko


