Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2C936A418
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 04:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhDYCPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 22:15:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:26892 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhDYCPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 22:15:21 -0400
IronPort-SDR: 0DJgAeEuwH4kBPNrIQH2OdI+Pd/P/JytrbsHmAHc481SzOXXYPRs5tcNo0hC8Cf8mgaEyHhOQY
 W+LI2P4IYiow==
X-IronPort-AV: E=McAfee;i="6200,9189,9964"; a="281535768"
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="281535768"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 19:14:42 -0700
IronPort-SDR: rPIttA8+TcU7dG3IK3887GQTGcSMdGOHt+OzZHUG+WeBjKgZ7YCCJl9pflYIvbtST5iocNxeP7
 5cwuxu/FT2Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="428908859"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga008.jf.intel.com with ESMTP; 24 Apr 2021 19:14:38 -0700
Date:   Sun, 25 Apr 2021 10:14:38 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [LKP] Re: [clocksource] 6c52b5f3cf: stress-ng.opcode.ops_per_sec
 -14.4% regression
Message-ID: <20210425021438.GA2942@shbuild999.sh.intel.com>
References: <04f4752e-6c5a-8439-fe75-6363d212c7b2@intel.com>
 <20210421134224.GR975577@paulmck-ThinkPad-P17-Gen-1>
 <ed77d2a5-aeb0-b7f5-ce91-4cac12cfdd61@linux.intel.com>
 <20210422074126.GA85095@shbuild999.sh.intel.com>
 <20210422142454.GD975577@paulmck-ThinkPad-P17-Gen-1>
 <20210422165743.GA162649@paulmck-ThinkPad-P17-Gen-1>
 <20210423061115.GA62813@shbuild999.sh.intel.com>
 <20210423140254.GM975577@paulmck-ThinkPad-P17-Gen-1>
 <20210424122920.GB85095@shbuild999.sh.intel.com>
 <20210424175322.GS975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210424175322.GS975577@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2021 at 10:53:22AM -0700, Paul E. McKenney wrote:
> On Sat, Apr 24, 2021 at 08:29:20PM +0800, Feng Tang wrote:
> > Hi Paul,
> > 
> > On Fri, Apr 23, 2021 at 07:02:54AM -0700, Paul E. McKenney wrote:
> > [...]
> > > > > > > Following is the tsc freq info from kernel log
> > > > > > > 
> > > > > > > [    0.000000] DMI: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> > > > > > > [    0.000000] tsc: Detected 2100.000 MHz processor
> > > > > > > ...
> > > > > > > [   13.859982] tsc: Refined TSC clocksource calibration: 2095.077 MHz
> > > > > > 
> > > > > > So what are our options?
> > > > > > 
> > > > > > 1.	Clear CLOCK_SOURCE_MUST_VERIFY from tsc-early.
> > > > > > 
> > > > 
> > > > I think option 1 is fine, as tsc will still get checked once 'tsc'
> > > > clocksource is registered, but Thomas and Peter should know more
> > > > background and corner cases of tsc.
> > > 
> > > I will look at adding such a patch to my series, preceding the change
> > > to 1/1000 deviation.
> > > 
> > > > Also we have been working on another patchset to skip watchdog check
> > > > for x86 platforms with stable tsc:
> > > > 
> > > > https://lore.kernel.org/lkml/1618291897-71581-1-git-send-email-feng.tang@intel.com/
> > > > https://lore.kernel.org/lkml/1618291897-71581-2-git-send-email-feng.tang@intel.com/
> > > 
> > > It will be interesting to see what fraction of those with large numbers
> > > of systems choose to revert your 2/2, and for what period of time.
> > > You really needed my clocksource patch series to have been in place some
> > > years back so that people wouldn't have been seeing the false-postive
> > > clock-skew complaints.  Those complaints did not help people build up
> > > their trust in the TSC.  :-/
> > 
> > I read you patchset, and I think the recheck to avoid false alarm makes
> > sense to me, as well as the debug method you adds, and they have no
> > conflict with my patches which tends to newer x86 platforms only.
> 
> Would you be willing to give your Tested-by, Acked-by, or Reviewed-by
> to those patches?

I haven't ack because I'm afraid I may overlook some corner case as I
don't have the overall picture of it.

And I will check more and do some tests on them.

> Obviously, you would not be willing to do so for the patch that reduces
> the skew threshold, at least not until my most recent patch is beaten
> into shape.

I still tend to agree with Zhengjun's 1/100 suggestion, though that
may not be safe enough :)

> > And yes, I only have met and debugged tsc wrongly marked unstable cases
> > on several clients platforms, and in one case I disabled the HPET for
> > Baytrail 10 years ago. Our test farm has different kinds of servers,
> > only up to 4 sockets and 192 CPUs, where no tsc unstable issue has been
> > seen.
> 
> That is encouraging, but how many systems are in your test farm?

Good point, we only have less than 20 servers, which is tiny comparing
to the real server centers.


> > And I'm eager to know if there is any real case of an unreliable tsc
> > on the 'large numbers' of x86 system which complies with our cpu feature
> > check. And if there is, my 2/2 definitely should be dropped.   
> 
> If you have enough systems, you see all sorts of strange things just
> due to the normal underlying failure rate of hardware.
> 
> So my question is instead whether we will see any TSC failures
> unaccompanied by any other signs of trouble.
> 
> And if your 2/2 goes in, those who still distrust TSC will simply
> revert it.  In their defense, their distrust was built up over a very
> long period of time for very good reasons.
> 
> > > This last sentence is not a theoretical statement.  In the past, I have
> > > suggested using the existing "tsc=reliable" kernel boot parameter,
> > > which disables watchdogs on TSC, similar to your patch 2/2 above.
> > > The discussion was short and that boot parameter was not set.  And the
> > > discussion motivated to my current clocksource series.  ;-)
> > > 
> > > I therefore suspect that someone will want a "tsc=unreliable" boot
> > > parameter (or similar) to go with your patch 2/2.
> >  
> > Possibly :)
> > 
> > But I wonder if tsc is disabled on that 'large system', what will be
> > used instead? HPET is known to be much slower for clocksource, as shown
> > in this regression report :) not mentioning the 'acpi_pm' timer. 
> 
> Indeed, the default switch to HPET often causes the system to be taken
> out of service due to the resulting performance shortfall.  There is
> of course some automated recovery, and no, I am not familiar with the
> details, but I suspect that a simple reboot is an early recovery step.
> However, if the problem were to persist, the system would of course be
> considered to be permanently broken.

Thanks for the info, if a sever is taken out of service just because
of a false alarm of tsc, then it's a big waste!

> > Again, I want to know the real tsc unstable case. I have spent lots
> > of time searching these info from git logs and mail archives before
> > writing the patches.
> 
> So do I, which is why I put together this patch series.  My employer has
> a fairly strict upstream-first for things like this which are annoyances
> that are likely hiding other bugs, but which are not causing significant
> outages, which was of course the motivation for the fault-injection
> patches.
> 
> As I said earlier, it would have been very helpful to you for a patch
> series like this to have been applied many years ago.  If it had been,
> we would already have the failure-rate data that you requested.  And of
> course if that failure-rate data indicated that TSC was reliable, there
> would be far fewer people still distrusting TSC.
 
Yes, if they can share the detailed info (like what's the 'watchdog')
and debug info, it can enable people to debug and root cause the
problem to be a false alarm or a real silicon platform. Personally, for
newer platforms I tend to trust tsc much more than other clocksources.

Thanks,
Feng

> 							Thanx, Paul
