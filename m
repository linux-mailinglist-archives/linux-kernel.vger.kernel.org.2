Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41C637EB84
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380899AbhELTc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245496AbhELRPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:15:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC36661352;
        Wed, 12 May 2021 17:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620839662;
        bh=dWtwTdYyX6BmM5lSZGuheEnUFMO4sMEUcsMdS8sFEDg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Uh9vWd4QPDeAOfYC9eQD3U5qtmiLUXr63kId9DU5lRE8v6IqegNrZUKNaX+FOTRfs
         8Yn3y1RUqSSV6T2L7yT2T9pWBNvIgKFXMI1NKbG2bSEY/b+kXGgm32dKgLvJm52Iaq
         VgrH+3tmZ4BGuKRrIY4X3Zzw9SKOtle3N2SQhKdJAQ/oqyMve0eHZ4LUrT0ytGWS38
         LJX7tPH0JarRDQ1Gk1BQSUG4bGvIHFulZys6zED6ZVTOgkhQDDLe2UJH21bGUBb7RX
         99HkeQoKi0cIB+9cK0k6pyaeVlqa3zVdc3u43JHxGd/nBSojTuu95hoDGi5nVIGFoW
         iZUFQ91+cdIrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2FEA05C00DA; Wed, 12 May 2021 10:14:22 -0700 (PDT)
Date:   Wed, 12 May 2021 10:14:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, ak@linux.intel.com,
        zhengjun.xing@intel.com,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v14 clocksource 4/6] clocksource: Reduce clocksource-skew
 threshold for TSC
Message-ID: <20210512171422.GU975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210511233403.GA2896757@paulmck-ThinkPad-P17-Gen-1>
 <20210511233455.2897068-4-paulmck@kernel.org>
 <20210512021849.GB78351@shbuild999.sh.intel.com>
 <20210512035156.GT975577@paulmck-ThinkPad-P17-Gen-1>
 <20210512131815.GA37641@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512131815.GA37641@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 09:18:15PM +0800, Feng Tang wrote:
> Hi Paul,
> 
> On Tue, May 11, 2021 at 08:51:56PM -0700, Paul E. McKenney wrote:
> > On Wed, May 12, 2021 at 10:18:49AM +0800, Feng Tang wrote:
> > > Hi Paul,
> > > 
> > > On Tue, May 11, 2021 at 04:34:53PM -0700, Paul E. McKenney wrote:
> 
> [SNIP]
> > > >  	 * Ensure clocksources that have large 'mult' values don't overflow
> > > >  	 * when adjusted.
> > > > diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
> > > > index a492e4da69ba..b3f608c2b936 100644
> > > > --- a/kernel/time/jiffies.c
> > > > +++ b/kernel/time/jiffies.c
> > > > @@ -49,13 +49,14 @@ static u64 jiffies_read(struct clocksource *cs)
> > > >   * for "tick-less" systems.
> > > >   */
> > > >  static struct clocksource clocksource_jiffies = {
> > > > -	.name		= "jiffies",
> > > > -	.rating		= 1, /* lowest valid rating*/
> > > > -	.read		= jiffies_read,
> > > > -	.mask		= CLOCKSOURCE_MASK(32),
> > > > -	.mult		= TICK_NSEC << JIFFIES_SHIFT, /* details above */
> > > > -	.shift		= JIFFIES_SHIFT,
> > > > -	.max_cycles	= 10,
> > > > +	.name			= "jiffies",
> > > > +	.rating			= 1, /* lowest valid rating*/
> > > > +	.uncertainty_margin	= TICK_NSEC,
> > > 
> > > 'jiffies' is known to be very bad as a watchdog ("worse bandaid" in
> > > Thomas' words :)), and TICK_NSEC just turns to 1ms for HZ=1000 case. 
> > > Maybe we should give it a bigger margin, like the 32ms margin for 
> > > 'tsc-early'?
> > > 
> > > Other than this, it looks good to me, thanks!
> > 
> > As in the fixup diff below?
> 
> Yep, thanks,
> 
> > Would you be willing to provide an ack or tested-by for the rest
> > of the series?  (I have your ack on 1/6.)
> 
> I haven't figured out a way to check 5/6 patch yet, but feel free
> to add my ack for the first 4 patches (1/6 ~ 4/6) 
> 
> 	Acked-by: Feng Tang <feng.tang@intel.com>

Thank you, and I will apply this.

On the unlikely off-chance that this works in your environtment, here
is how I test it:

	tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --bootargs "clocksource.max_cswd_read_retries=1" --trust-make > /tmp/kvm.sh.out 2>&1

	tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make > /tmp/kvm.sh.out 2>&1

	tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --trust-make > /tmp/kvm.sh.out 2>&1

If there are no splats, the test passed.  The third is tests running the
kernel without the module loaded, so it is probably redundant with your
other testing.  The test completes in a few minutes, give or take your
kernel build time compared to mine.

These create VMs running rcutorture, and test the clocksource watchdog
as a side effect.

							Thanx, Paul
