Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617CE35EC06
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 06:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbhDNEsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 00:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhDNEst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 00:48:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FFA361166;
        Wed, 14 Apr 2021 04:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618375709;
        bh=JpduL3PSXNWxJQG51JygZsZSPDVcEvZtV5kbnz2VcL4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SsXAJjKSwBPsMniaosYQRrUrgpzM20HK6u779LpKXPbNGMtxKaTZqFWte8Yu7q8fR
         CmQV6+m/T8NPu2xia66/ldIFOIMjeG0x9T6p4Pl8CyDSCTlGBs087XoItGombYLTrQ
         rlKzcPeigvO7VjmDwACKchomCHPnUFKBe4P6lJKIfonRQzEUGNissntOqab5alV3j3
         WR79x9zsgUp27xyQlttuw8lc6h9S+SCOe672+YIDDxlQnKafpTaOj1pF5cRWjwmC6c
         8AMZXC7Gw/IhjnNbP+FQuNARlU5NPSMpjN3U7PCH3tYP2DcpOoJjzHlsDRE3H8vdvu
         BAXZLfK2YH3vw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CC96E5C23F6; Tue, 13 Apr 2021 21:48:28 -0700 (PDT)
Date:   Tue, 13 Apr 2021 21:48:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource 3/5] clocksource: Check per-CPU clock
 synchronization when marked unstable
Message-ID: <20210414044828.GL4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210412231809.GI4510@paulmck-ThinkPad-P17-Gen-1>
 <87r1jdykoo.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1jdykoo.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 10:49:11PM +0200, Thomas Gleixner wrote:
> Paul,
> 
> On Mon, Apr 12 2021 at 16:18, Paul E. McKenney wrote:
> > On Mon, Apr 12, 2021 at 10:37:10PM +0200, Thomas Gleixner wrote:
> >> On Mon, Apr 12 2021 at 12:57, Paul E. McKenney wrote:
> >> > On Mon, Apr 12, 2021 at 08:54:03PM +0200, Thomas Gleixner wrote:
> >> >> > I will send a new series out later today, Pacific Time.
> >> >> 
> >> >> Can you do me a favour and send it standalone and not as yet another
> >> >> reply to this existing thread maze. A trivial lore link to the previous
> >> >> version gives enough context.
> >> >
> >> > Will do!
> >> >
> >> > Of course, it turns out that lockdep also doesn't like waited-on
> >> > smp_call_function_single() invocations from timer handlers,
> >> > so I am currently looking at other options for dealing with that
> >> > potential use-after-free.  I am starting to like the looks of "only set
> >> > CLOCK_SOURCE_VERIFY_PERCPU on statically allocated clocksource structures
> >> > and let KASAN enforce this restriction", but I have not quite given up
> >> > on making it more general.
> >> 
> >> The simplest point is in the thread under the clocksource_mutex which
> >> prevents anything from vanishing under your feet.
> >
> > And lockdep is -much- happier with the setup shown below, so thank
> > you again!
> 
> But it is too simple now :) ...
> 
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index f047c6cb056c..34dc38b6b923 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -519,6 +515,13 @@ static int __clocksource_watchdog_kthread(void)
> >  	unsigned long flags;
> >  	int select = 0;
> >  
> > +	/* Do any required per-CPU skew verification. */
> > +	list_for_each_entry(cs, &watchdog_list, wd_list) {
> > +		if ((cs->flags & (CLOCK_SOURCE_UNSTABLE | CLOCK_SOURCE_VERIFY_PERCPU)) ==
> > +		    (CLOCK_SOURCE_UNSTABLE | CLOCK_SOURCE_VERIFY_PERCPU))
> > +			clocksource_verify_percpu(cs);
> > +	}
> 
> because that list is _NOT_ protected by the clocksource_mutex as you
> noticed yourself already.
> 
> But you don't have to walk that list at all because the only interesting
> thing is the currently active clocksource, which is about to be changed
> in case the watchdog marked it unstable and cannot be changed by any
> other code concurrently because clocksource_mutex is held.
> 
> So all you need is:
> 
> 	if (curr_clocksource &&
> 	    curr_clocksource->flags & CLOCK_SOURCE_UNSTABLE &&
> 	    curr_clocksource->flags & CLOCK_SOURCE_VERIFY_PERCPU)
> 		clocksource_verify_percpu_wreckage(curr_clocksource);
> 
> Hmm?

With the addition of a clocksource=tsc boot parameter, this approach
does appear to work, thank you!  I sent out the updated series.

							Thanx, Paul
