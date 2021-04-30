Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF9D36F35C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 02:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhD3BAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 21:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhD3BAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 21:00:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E1F6613ED;
        Fri, 30 Apr 2021 00:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619744359;
        bh=GZNvsGnrPxvovRidLnOihcjHTpLGj9pQkIEbFHJe7UA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ji7kRmZ3VS2RmjiM8EjIZPT5xnmxoZUPzOK7vE5oBSaprYIT5zVAcAsL9HwAU2dEy
         XEA08Zwqexp+B+qBLK7pSKqz0m0VbYBGR+BxUIISmSoUqEwwy6TnxI6Ctg5dZ2YJV4
         Yttj2pJyesdqIXK09xZI2psobWMwfgiapU03fNKPkiIyH/aH3S7VKLEZACI9ds3Wf5
         xLBK6yzUrFBHT8AW8U9wbYG2f7KY/mJwVe+DUpAmw4lrf46M6SBntdL0W02PYVJHf/
         9bFdiKnkFsiUMG3Fk1W8ULU0DXsVvgcbxw9G/kgHVd8+7VDzIUJm6Nox4skslNB4qu
         +JpMFfPtjQfOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 538AB5C051D; Thu, 29 Apr 2021 17:59:19 -0700 (PDT)
Date:   Thu, 29 Apr 2021 17:59:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel-team@fb.com, neeraju@codeaurora.org,
        zhengjun.xing@intel.com, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [clocksource]  8c30ace35d:
 WARNING:at_kernel/time/clocksource.c:#clocksource_watchdog
Message-ID: <20210430005919.GA983840@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <87y2d3mo2q.ffs@nanos.tec.linutronix.de>
 <87a6pimt1f.ffs@nanos.tec.linutronix.de>
 <20210428183118.GR975577@paulmck-ThinkPad-P17-Gen-1>
 <878s517axu.ffs@nanos.tec.linutronix.de>
 <20210429142641.GU975577@paulmck-ThinkPad-P17-Gen-1>
 <87lf91f177.ffs@nanos.tec.linutronix.de>
 <20210429230411.GK4032392@tassilo.jf.intel.com>
 <20210430002459.GB975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430002459.GB975577@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 05:24:59PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 29, 2021 at 04:04:11PM -0700, Andi Kleen wrote:
> > > > The idea is to leave the watchdog code in kernel/time/clocksource.c,
> > > > but to move the fault injection into kernel/time/clocksourcefault.c or
> > > > some such.  In this new file, new clocksource structures are created that
> > > > use some existing timebase/clocksource under the covers.  These then
> > > > inject delays based on module parameters (one senstive to CPU number,
> > > > the other unconditional).  They register these clocksources using the
> > > > normal interfaces, and verify that they are eventually marked unstable
> > > > when the fault-injection parameters warrant it.  This is combined with
> > > > the usual checking of the console log.
> > > >
> > > > Or am I missing your point?
> > > 
> > > That's what I meant.
> > 
> > I still think all this stuff should be in the fault injection framework,
> > like other fault injections, to have a consistent discoverable interface. 
> > 
> > I actually checked now and the standard fault injection supports boot arguments,
> > so needing it at boot time shouldn't be a barrier.
> 
> Per Thomas's feedback, I am in the midst of converting this to a unit
> test implemented as a kernel module, at which point the only fault
> injection will be in the unit test.
> 
> At the moment, the code just registers, reads, unregisters, and verifies
> that the bogus unit-test clocksources act normally.  Fault injection is
> next on the list for the fine-grained clocksource.  Which, as Thomas
> noted, is quite a bit simpler, as I just need to force a delay until
> the clocksource gets marked unstable with no need for fancy counting.

And this is what I currently get on the console from a successful test:

------------------------------------------------------------------------

clocksource_wdtest: --- holdoff=20
clocksource_wdtest: --- Verify jiffies-like uncertainty margin.
clocksource: wdtest-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
clocksource_wdtest: --- Verify tsc-like uncertainty margin.
clocksource: wdtest-ktime: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
clocksource_wdtest: --- tsc-like times: 1619743817068433427 - 1619743817068432303 = 1124.
clocksource_wdtest: --- Watchdog without error injection.
clocksource_wdtest: --- Watchdog with singleton error injection.
clocksource_wdtest: --- Watchdog with doublet error injection, expect console messages.
clocksource: timekeeping watchdog on CPU4: kvm-clock retried 2 times before success
clocksource_wdtest: --- Watchdog with quadruplet error injection, expect clock skew.
clocksource: timekeeping watchdog on CPU8: kvm-clock read-back delay of 401209ns, attempt 4, marking unstable
clocksource_wdtest: --- Marking wdtest-ktime unstable due to clocksource watchdog.
clocksource_wdtest: --- Done with test.

------------------------------------------------------------------------

The code currently looks like a dog's breakfast, so I will clean it
up before sending it out.  And of course add the time-readout error
injection to test the other clock-skew code path.

And yes, there are WARNs to verify that skew happens when it is supposed
to and so on.

							Thanx, Paul
