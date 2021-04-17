Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE263632B2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 01:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhDQXwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 19:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbhDQXwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 19:52:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A154361003;
        Sat, 17 Apr 2021 23:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618703496;
        bh=LXopkOhhl+hg905PlppDQu3gHCzhO/sgoiNygitt54s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fkYFZcRQ4dctdR5dMM8m3W3E9l3kVGWr27TPwosHOY8cYTOuB19NWKLAMUS17ARwk
         biMMCntr8XKraskP7io3Falq9McgHaXZx2kjJSeqZE6cHOwNmm+p05N6t1Auwy1Mb+
         FbGZT/f0VGl3dG/7mWNsd9x1xwcFhDCl3c3qrvGCCODx0GPkJ6wxxDVctHH9/KbAWi
         F4mxr8MC3Y+4Uyd7/4i17lziKgegfJ/DTx72ZUb1aorwAW11D6E39ZdLAyXV6BS4XM
         25Eze1FxcNvOm8cWMzF21wkouzbjY/0Vs8zUTyK9Z2a1sz07BSAhaEm+SkJm1UGwUt
         emDYi/vYKvgpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6E82F5C051E; Sat, 17 Apr 2021 16:51:36 -0700 (PDT)
Date:   Sat, 17 Apr 2021 16:51:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v8 clocksource 3/5] clocksource: Check per-CPU clock
 synchronization when marked unstable
Message-ID: <20210417235136.GD5006@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1>
 <20210414043602.2812981-3-paulmck@kernel.org>
 <87sg3prsbt.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg3prsbt.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 02:47:18PM +0200, Thomas Gleixner wrote:
> On Tue, Apr 13 2021 at 21:36, Paul E. McKenney wrote:
> 
> Bah, hit send too quick.
> 
> > +	cpumask_clear(&cpus_ahead);
> > +	cpumask_clear(&cpus_behind);
> > +	preempt_disable();
> 
> Daft. 

Would migrate_disable() be better?

Yes, I know, in virtual environments, the hypervisor can migrate anyway,
but this does limit the potential damage to one out of the two schedulers.

> > +	testcpu = smp_processor_id();
> > +	pr_warn("Checking clocksource %s synchronization from CPU %d.\n", cs->name, testcpu);
> > +	for_each_online_cpu(cpu) {
> > +		if (cpu == testcpu)
> > +			continue;
> > +		csnow_begin = cs->read(cs);
> > +		smp_call_function_single(cpu, clocksource_verify_one_cpu, cs, 1);
> > +		csnow_end = cs->read(cs);
> 
> As this must run with interrupts enabled, that's a pretty rough
> approximation like measuring wind speed with a wet thumb.
> 
> Wouldn't it be smarter to let the remote CPU do the watchdog dance and
> take that result? i.e. split out more of the watchdog code so that you
> can get the nanoseconds delta on that remote CPU to the watchdog.

First, an interrupt, NMI, SMI, vCPU preemption, or whatever could
not cause a false positive.  A false negative, perhaps, but no
false positives.  Second, in normal operation, these are rare, so that
hitting the (eventual) default of eight CPUs is very likely to result in
tight bounds on the delay-based error for most of those CPUs.  Third,
we really need to compare the TSC on one CPU to the TSC on the other
in order to have a very clear indication of a problem, should a real
TSC-synchronization issue arise.  In contrast, comparisons against the
watchdog timer will be more complicated and any errors detected will be
quite hard to prove to be due to TSC issues.

Or am I once again missing something?

> > +		delta = (s64)((csnow_mid - csnow_begin) & cs->mask);
> > +		if (delta < 0)
> > +			cpumask_set_cpu(cpu, &cpus_behind);
> > +		delta = (csnow_end - csnow_mid) & cs->mask;
> > +		if (delta < 0)
> > +			cpumask_set_cpu(cpu, &cpus_ahead);
> > +		delta = clocksource_delta(csnow_end, csnow_begin, cs->mask);
> > +		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
> 
> > +		if (firsttime || cs_nsec > cs_nsec_max)
> > +			cs_nsec_max = cs_nsec;
> > +		if (firsttime || cs_nsec < cs_nsec_min)
> > +			cs_nsec_min = cs_nsec;
> > +		firsttime = 0;
> 
>   int64_t cs_nsec_max = 0, cs_nsec_min = LLONG_MAX;
> 
> and then the firsttime muck is not needed at all.

Good point, will fix!

And again, thank you for looking all of this over.

							Thanx, Paul
