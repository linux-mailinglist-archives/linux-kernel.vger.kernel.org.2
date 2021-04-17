Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876403632AC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 01:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhDQXnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 19:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbhDQXnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 19:43:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 486DB6121D;
        Sat, 17 Apr 2021 23:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618702977;
        bh=gbxJJgwzLRLnhX1i6KaId8XkJ7sBCOQyVwkRfcOf/pM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OkWpgOHcK5Uvgl/EBuOJA0YHPNzOqIn+0fTpxEpYPQyLAgf/yIjU8Doq77Fz3oJIy
         VdPhPmuLT0WaPKBqIQUtP3ouvIsL2HPEL2HyEGLm7VSkqnPHVHmMASmFPSNEynp0vj
         FBhNfc+9iljiN2XLj2Orw8VGn4NsHs1gKIMha35DTVmMRFelFSzc6Br/KVfhW4CksX
         vQRDbj4z6DKhL0UHEffLXz0TGGYKHaOzLp80MvvFhe1ZsaWO823XfXk3jqyoyg34Z5
         3R+5NZbekBCCRxhX6TQurUHbkS3VPDCHzl/FzSUU1BjQ0mt2JzrcwWxJG8Hd3KrX2A
         qGmc3ZiBbBLZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 154225C051E; Sat, 17 Apr 2021 16:42:57 -0700 (PDT)
Date:   Sat, 17 Apr 2021 16:42:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v8 clocksource 3/5] clocksource: Check per-CPU clock
 synchronization when marked unstable
Message-ID: <20210417234257.GC5006@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1>
 <20210414043602.2812981-3-paulmck@kernel.org>
 <87v98lrt7d.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v98lrt7d.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 02:28:22PM +0200, Thomas Gleixner wrote:
> On Tue, Apr 13 2021 at 21:36, Paul E. McKenney wrote:
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > index 1fc0962c89c0..97eeaf164296 100644
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> > @@ -169,7 +169,7 @@ struct clocksource kvm_clock = {
> >  	.read	= kvm_clock_get_cycles,
> >  	.rating	= 400,
> >  	.mask	= CLOCKSOURCE_MASK(64),
> > -	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
> > +	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_VERIFY_PERCPU,
> 
> kvm_clock is not marked with CLOCK_SOURCE_MUST_VERIFY, so what's the
> point of adding this here? It's not subject to be monitored by the
> watchdog muck.

Good point, removed.

> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index f70dffc2771f..56289170753c 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1151,7 +1151,8 @@ static struct clocksource clocksource_tsc = {
> >  	.mask			= CLOCKSOURCE_MASK(64),
> >  	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
> >  				  CLOCK_SOURCE_VALID_FOR_HRES |
> > -				  CLOCK_SOURCE_MUST_VERIFY,
> > +				  CLOCK_SOURCE_MUST_VERIFY |
> > +				  CLOCK_SOURCE_VERIFY_PERCPU,
> 
> While this one is part of the horror show.

It probably would be good to decorate other arch's per-CPU clocks
with CLOCK_SOURCE_VERIFY_PERCPU, but no takers thus far.

							Thanx, Paul

> > +static u64 csnow_mid;
> > +static cpumask_t cpus_ahead;
> > +static cpumask_t cpus_behind;
> > +
> > +static void clocksource_verify_one_cpu(void *csin)
> > +{
> > +	struct clocksource *cs = (struct clocksource *)csin;
> > +
> > +	csnow_mid = cs->read(cs);
> > +}
> > +
> > +static void clocksource_verify_percpu(struct clocksource *cs)
> > +{
> > +	int64_t cs_nsec, cs_nsec_max, cs_nsec_min;
> > +	u64 csnow_begin, csnow_end;
> > +	bool firsttime = 1;
> > +	int testcpu;
> > +	s64 delta;
> > +	int cpu;
> 
>         int testcpu, cpu; :)
> 
