Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C97363694
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 18:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhDRQVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 12:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhDRQVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 12:21:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B911610EA;
        Sun, 18 Apr 2021 16:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618762850;
        bh=COixeEboG3W0lGeK1dfVFzDjBPPWWXmTg8ljA/mofJI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hMd4O5DOq0LBjJHi2PPJ/sayfrZgNG+oEuEzd5HRGFZE8yoJNXs/J93PKSKRDCIEx
         m2+lcuFC7XuqGN8HmcwOxhva2V52EVWYtUlQdoanoHMUPMh1gwJn9XuK2fTCuHx1xv
         qs8wz2pUckmflf5+WHM1Aw+MmrrvO8Jv3Vf/2S7yPUEyEPr60hK6byJvNMk6rp2uc3
         4zjiaISRfLTmd3QRQJdpneKyX5kNpnH/MpspzA0crYP5Nkhs1wjY24jsq2+QyS8KB3
         9AZh5sYQWVXKRsG6ZlSYYt9aBjUN0agNQvmlA9YWm0lEdxbm0jv6H6B7ov8lHQX07n
         X/Ja2AH5HwR+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 23C6F5C00F8; Sun, 18 Apr 2021 09:20:50 -0700 (PDT)
Date:   Sun, 18 Apr 2021 09:20:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v8 clocksource 3/5] clocksource: Check per-CPU clock
 synchronization when marked unstable
Message-ID: <20210418162050.GA2206685@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1>
 <20210414043602.2812981-3-paulmck@kernel.org>
 <87sg3prsbt.ffs@nanos.tec.linutronix.de>
 <20210417235136.GD5006@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417235136.GD5006@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 04:51:36PM -0700, Paul E. McKenney wrote:
> On Sat, Apr 17, 2021 at 02:47:18PM +0200, Thomas Gleixner wrote:

[ . . . ]

> > > +		delta = (s64)((csnow_mid - csnow_begin) & cs->mask);
> > > +		if (delta < 0)
> > > +			cpumask_set_cpu(cpu, &cpus_behind);
> > > +		delta = (csnow_end - csnow_mid) & cs->mask;
> > > +		if (delta < 0)
> > > +			cpumask_set_cpu(cpu, &cpus_ahead);
> > > +		delta = clocksource_delta(csnow_end, csnow_begin, cs->mask);
> > > +		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
> > 
> > > +		if (firsttime || cs_nsec > cs_nsec_max)
> > > +			cs_nsec_max = cs_nsec;
> > > +		if (firsttime || cs_nsec < cs_nsec_min)
> > > +			cs_nsec_min = cs_nsec;
> > > +		firsttime = 0;
> > 
> >   int64_t cs_nsec_max = 0, cs_nsec_min = LLONG_MAX;
> > 
> > and then the firsttime muck is not needed at all.
> 
> Good point, will fix!
> 
> And again, thank you for looking all of this over.

And overnight testing with a 50-microsecond WATCHDOG_MAX_SKEW was
uneventful.  However, I managed to miss printing when a retry was
necessary, so all that says is that no more than three retries were
ever required.  So I added test code to print a message whenever two
or more retries are required and restarted the tests.  Shorter run,
but more systems, so hopefully similar coverage.

If that works OK, I will resend the series this evening, Pacific Time.

							Thanx, Paul
