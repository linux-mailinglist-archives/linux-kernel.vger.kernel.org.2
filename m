Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F55835D18C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245402AbhDLT5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 15:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237613AbhDLT5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 15:57:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4814B61206;
        Mon, 12 Apr 2021 19:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618257443;
        bh=lIhzNbCU8bE0h1h5jlI8gRg6GfQbTrvNYsJ1jHFdpZ8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uSswateWXHs6l2ezKctq9PInExFqDVxyzc7yTtn8+eDHhaHZYVuDTKPZtprDJbnF0
         lDTdMDZf3ktkBtdeYzAMyxSOCDCZRQxfAsd48F/IXoRy7dBGMQYu3fHiXB2EBMCpel
         ilD42TrYz7VRtCMyfeOV15Dd8/ARACPZJPlewguBuEOdzrERNiJ7wCrW8R4mYI7gzr
         ZcswAqoTdD99WrG+8UNoLxeK0QQbiPHNTNOcRUaWD0+Itx2m4sSEkdrV1vn1NDiQaN
         iO7C3GU741eov9U+0gupgbjaF1aKTlgGpLnMOMGA41dK4r2S86N9eKaC2G0nv25hEK
         mzmuRLxCLmXpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 017E45C0382; Mon, 12 Apr 2021 12:57:22 -0700 (PDT)
Date:   Mon, 12 Apr 2021 12:57:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource 3/5] clocksource: Check per-CPU clock
 synchronization when marked unstable
Message-ID: <20210412195722.GG4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210402224828.GA3683@paulmck-ThinkPad-P72>
 <20210402224906.3912-3-paulmck@kernel.org>
 <87blam4iqe.ffs@nanos.tec.linutronix.de>
 <20210411002020.GV4510@paulmck-ThinkPad-P17-Gen-1>
 <878s5p2jqv.ffs@nanos.tec.linutronix.de>
 <20210411164612.GZ4510@paulmck-ThinkPad-P17-Gen-1>
 <20210412042157.GA1889369@paulmck-ThinkPad-P17-Gen-1>
 <87k0p71whr.ffs@nanos.tec.linutronix.de>
 <20210412182049.GE4510@paulmck-ThinkPad-P17-Gen-1>
 <87y2dnz644.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2dnz644.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 08:54:03PM +0200, Thomas Gleixner wrote:
> Paul,
> 
> On Mon, Apr 12 2021 at 11:20, Paul E. McKenney wrote:
> > On Mon, Apr 12, 2021 at 03:08:16PM +0200, Thomas Gleixner wrote:
> >> The reason for irqsave is again historical AFAICT and nobody bothered to
> >> clean it up. spin_lock_bh() should be sufficient to serialize against
> >> the watchdog timer, though I haven't looked at all possible scenarios.
> >
> > Though if BH is disabled, there is not so much advantage to
> > invoking it from __clocksource_watchdog_kthread().  Might as
> > well just invoke it directly from clocksource_watchdog().
> >
> >> > 2.	Invoke clocksource_verify_percpu() from its original
> >> > 	location in clocksource_watchdog(), just before the call to
> >> > 	__clocksource_unstable().  This relies on the fact that
> >> > 	clocksource_watchdog() acquires watchdog_lock without
> >> > 	disabling interrupts.
> >> 
> >> That should be fine, but this might cause the softirq to 'run' for a
> >> very long time which is not pretty either.
> >> 
> >> Aside of that, do we really need to check _all_ online CPUs? What you
> >> are trying to figure out is whether the wreckage is CPU local or global,
> >> right?
> >> 
> >> Wouldn't a shirt-sleeve approach of just querying _one_ CPU be good
> >> enough? Either the other CPU has the same wreckage, then it's global or
> >> it hasn't which points to a per CPU local issue.
> >> 
> >> Sure it does not catch the case where a subset (>1) of all CPUs is
> >> affected, but I'm not seing how that really buys us anything.
> >
> > Good point!  My thought is to randomly pick eight CPUs to keep the
> > duration reasonable while having a good chance of hitting "interesting"
> > CPU choices in multicore and multisocket systems.
> >
> > However, if a hard-to-reproduce problem occurred, it would be good to take
> > the hit and scan all the CPUs.  Additionally, there are some workloads
> > for which the switch from TSC to HPET is fatal anyway due to increased
> > overhead.  For these workloads, the full CPU scan is no additional pain.
> >
> > So I am thinking in terms of a default that probes eight randomly selected
> > CPUs without worrying about duplicates (as in there would be some chance
> > that fewer CPUs would actually be probed), but with a boot-time flag
> > that does all CPUs.  I would add the (default) random selection as a
> > separate patch.
> 
> You can't do without making it complex, right? Keep it simple is not an
> option for a RCU hacker it seems :)

But it was simple!  It just hit all the CPUs.

However, you (quite rightly) pointed out that this simple approach had
a few shortcomings.  ;-)

> > I will send a new series out later today, Pacific Time.
> 
> Can you do me a favour and send it standalone and not as yet another
> reply to this existing thread maze. A trivial lore link to the previous
> version gives enough context.

Will do!

Of course, it turns out that lockdep also doesn't like waited-on
smp_call_function_single() invocations from timer handlers,
so I am currently looking at other options for dealing with that
potential use-after-free.  I am starting to like the looks of "only set
CLOCK_SOURCE_VERIFY_PERCPU on statically allocated clocksource structures
and let KASAN enforce this restriction", but I have not quite given up
on making it more general.

							Thanx, Paul
