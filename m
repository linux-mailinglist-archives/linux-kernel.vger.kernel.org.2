Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710A736D8FB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 15:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbhD1N6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 09:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhD1N6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:58:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C419613FC;
        Wed, 28 Apr 2021 13:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619618246;
        bh=f09yXmNOKh092Vqv9UgMaDkw85ffvGRDzR/X1T62meU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VZV4Q36rsti0GFqpeS/iW4dB76ufspKxRPfZGIGKUjU39p/KXuLL7xrpCYbYFO1oo
         11SDjiJmZhAqH2s8kzmvgF680sYsgZdDveprO/jzMcY3RM+LsL2OzagL6X4eXPB7F9
         Vw04lg/Mi2ClJVNGqi0JFjd9i0YPJCUBoXhi38BaxdoDBI4GNFokcZws2KNC0o1Uxv
         Poy7QE5NiaOK9cVnCgmO0WwcSRHXMBSc3qDY/EqtD6pvy53XOxfzqvKgDlvbJRmrC2
         YbmTPyelFTf7D/JIlQCeNQv39b7bVmY8UDU1JHVHa72sNFA9rBEoir10AYPfUmvsaZ
         vjNDLhc1oPpIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A1ED25C0163; Wed, 28 Apr 2021 06:57:25 -0700 (PDT)
Date:   Wed, 28 Apr 2021 06:57:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Luming Yu <luming.yu@gmail.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        feng.tang@intel.com, zhengjun.xing@intel.com,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH v10 clocksource 1/7] clocksource: Provide module
 parameters to inject delays in watchdog
Message-ID: <20210428135725.GN975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
 <20210425224709.1312655-1-paulmck@kernel.org>
 <20210426040736.GS1401198@tassilo.jf.intel.com>
 <20210426152801.GY975577@paulmck-ThinkPad-P17-Gen-1>
 <20210426160008.GY1401198@tassilo.jf.intel.com>
 <20210426161425.GC975577@paulmck-ThinkPad-P17-Gen-1>
 <20210426175627.GZ1401198@tassilo.jf.intel.com>
 <20210426182433.GD975577@paulmck-ThinkPad-P17-Gen-1>
 <CAJRGBZxgJuc2OJfvT_k3Xmk_qsxzm=xX5wm4NqeRo7vkTcZk6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJRGBZxgJuc2OJfvT_k3Xmk_qsxzm=xX5wm4NqeRo7vkTcZk6w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 12:49:12PM +0800, Luming Yu wrote:
> We 'd expect to see clock_source watchdog can avoid to do wrong thing
> due to the injected delay or
> in real life delay by doing tsc sync-re-check by applying the patch-set.
> However , the noise is still cause wrong actions and the patch doesn't
> defeat the injected's delay
> please correct me if  I'm wrong.

Injecting delay is just a test.  In real life, if you got four delays
in a row, the cause is likely that the clock read is broken and taking
a very long time.  In which case marking that clock unstable is a
reasonable response.

Other causes include having an NMI or SMI storm, getting extremely
unlucky with vCPU preemptions, and so on.  In these cases, you are not
making much forward progress anyway, so marked-unstable clock is the
least of your worries.

I ran this (without injected delays) for more than a thousand hours on
rcutorture guest OSes and didn't see any instances of even two consecutive
bad reads.   There was the very occasional single instance of a bad read.

Therefore, the code marks the clock unstable if it has four bad reads
in a row, as it should.

							Thanx, Paul

> parameters]# cat *
> 1
> 1
> -1
> 3
> 8
> 
> [62939.809615] clocksource: clocksource_watchdog_inject_delay():
> Injecting delay.
> [62939.816867] clocksource: clocksource_watchdog_inject_delay():
> Injecting delay.
> [62939.824094] clocksource: clocksource_watchdog_inject_delay():
> Injecting delay.
> [62939.831314] clocksource: clocksource_watchdog_inject_delay():
> Injecting delay.
> [62939.838536] clocksource: timekeeping watchdog on CPU26: hpet
> read-back delay of 7220833ns, attempt 4, marking unstable
> [62939.849230] tsc: Marking TSC unstable due to clocksource watchdog
> [62939.855340] TSC found unstable after boot, most likely due to
> broken BIOS. Use 'tsc=unstable'.
> [62939.863972] sched_clock: Marking unstable (62943398530130,
> -3543150114)<-(62941186607503, -1331276112)
> [62939.875104] clocksource: Checking clocksource tsc synchronization
> from CPU 123 to CPUs 0,6,26,62,78,97-98,137.
> [62939.886518] clocksource: Switched to clocksource hpet
> 
> On Tue, Apr 27, 2021 at 2:27 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Apr 26, 2021 at 10:56:27AM -0700, Andi Kleen wrote:
> > > > ------------------------------------------------------------------------
> > > >
> > > > - module parameters
> > > >
> > > >   If the scope of the fault injection capability is limited to a
> > > >   single kernel module, it is better to provide module parameters to
> > > >   configure the fault attributes.
> > > >
> > > > ------------------------------------------------------------------------
> > > >
> > > > And in this case, the fault injection capability is in fact limited to
> > > > kernel/clocksource.c.
> > >
> > >
> > > I disagree with this recommendation because it prevents fuzzer coverage.
> > >
> > > Much better to have an uniform interface that can be automatically
> > > explored.
> >
> > The permissions for these module parameters is 0644, so there is no
> > reason why the fuzzers cannot use them via sysfs.
> >
> >                                                         Thanx, Paul
