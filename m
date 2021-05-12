Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF30137BDF5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhELNT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:19:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:58117 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhELNT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:19:28 -0400
IronPort-SDR: KvVGnP12J4OkXHhBg2IWYbzXoWNAYuRBEkYhItsbsw4aijIE9yoIQyyTnI1AHj4Byl+0ixdzqg
 0KnOR+OCo+ew==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="197725896"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="197725896"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 06:18:19 -0700
IronPort-SDR: hDC1EPD4jIQJWFtmEFffflQBmH7KzkRZofmxG7tE5yyfCgysRZhaJseDxvUP+mDpcXp5ISPLf7
 B6cT/U896XrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="622414803"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga006.fm.intel.com with ESMTP; 12 May 2021 06:18:15 -0700
Date:   Wed, 12 May 2021 21:18:15 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, ak@linux.intel.com,
        zhengjun.xing@intel.com,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v14 clocksource 4/6] clocksource: Reduce clocksource-skew
 threshold for TSC
Message-ID: <20210512131815.GA37641@shbuild999.sh.intel.com>
References: <20210511233403.GA2896757@paulmck-ThinkPad-P17-Gen-1>
 <20210511233455.2897068-4-paulmck@kernel.org>
 <20210512021849.GB78351@shbuild999.sh.intel.com>
 <20210512035156.GT975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512035156.GT975577@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, May 11, 2021 at 08:51:56PM -0700, Paul E. McKenney wrote:
> On Wed, May 12, 2021 at 10:18:49AM +0800, Feng Tang wrote:
> > Hi Paul,
> > 
> > On Tue, May 11, 2021 at 04:34:53PM -0700, Paul E. McKenney wrote:

[SNIP]
> > >  	 * Ensure clocksources that have large 'mult' values don't overflow
> > >  	 * when adjusted.
> > > diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
> > > index a492e4da69ba..b3f608c2b936 100644
> > > --- a/kernel/time/jiffies.c
> > > +++ b/kernel/time/jiffies.c
> > > @@ -49,13 +49,14 @@ static u64 jiffies_read(struct clocksource *cs)
> > >   * for "tick-less" systems.
> > >   */
> > >  static struct clocksource clocksource_jiffies = {
> > > -	.name		= "jiffies",
> > > -	.rating		= 1, /* lowest valid rating*/
> > > -	.read		= jiffies_read,
> > > -	.mask		= CLOCKSOURCE_MASK(32),
> > > -	.mult		= TICK_NSEC << JIFFIES_SHIFT, /* details above */
> > > -	.shift		= JIFFIES_SHIFT,
> > > -	.max_cycles	= 10,
> > > +	.name			= "jiffies",
> > > +	.rating			= 1, /* lowest valid rating*/
> > > +	.uncertainty_margin	= TICK_NSEC,
> > 
> > 'jiffies' is known to be very bad as a watchdog ("worse bandaid" in
> > Thomas' words :)), and TICK_NSEC just turns to 1ms for HZ=1000 case. 
> > Maybe we should give it a bigger margin, like the 32ms margin for 
> > 'tsc-early'?
> > 
> > Other than this, it looks good to me, thanks!
> 
> As in the fixup diff below?

Yep, thanks,

> 
> Would you be willing to provide an ack or tested-by for the rest
> of the series?  (I have your ack on 1/6.)

I haven't figured out a way to check 5/6 patch yet, but feel free
to add my ack for the first 4 patches (1/6 ~ 4/6) 

	Acked-by: Feng Tang <feng.tang@intel.com>

Thanks,
Feng

> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
> index b3f608c2b936..01935aafdb46 100644
> --- a/kernel/time/jiffies.c
> +++ b/kernel/time/jiffies.c
> @@ -51,7 +51,7 @@ static u64 jiffies_read(struct clocksource *cs)
>  static struct clocksource clocksource_jiffies = {
>  	.name			= "jiffies",
>  	.rating			= 1, /* lowest valid rating*/
> -	.uncertainty_margin	= TICK_NSEC,
> +	.uncertainty_margin	= 32 * NSEC_PER_MSEC,
>  	.read			= jiffies_read,
>  	.mask			= CLOCKSOURCE_MASK(32),
>  	.mult			= TICK_NSEC << JIFFIES_SHIFT, /* details above */
