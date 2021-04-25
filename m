Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347C736A8FC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 21:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhDYTPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 15:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230359AbhDYTPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 15:15:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3B5361354;
        Sun, 25 Apr 2021 19:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619378109;
        bh=IDhdXhEWkP8+zyOMVwKhjzel5WhHS2X+9rCIiGVqR9A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PEOAgm7jk4DdnRK1y8nuEzeAimZkY3ZE5moJkKaSieeMDa3eHXRKKf9mMl4RGC4ZL
         pkqctbRlinR40akw/B4Secjf9BqlAZMbmRKzRc8fIwMKxRmgfSFinJU3/ge7e4SJva
         xqT/k9YInZ34yuPryDdwv+GIXPO4tnvO3BkYrfUn98WwgKgJ06ibv15CvB7/cB3adu
         b/8ajRZtkH/3e+X1DRyBcODBC05uNFnjBn/3BY00AkXrvOt4D4cdYK1JDVpx1XXROW
         41fgOECbcfNXCjFi7QBuxY7z2/aMiG3/1QBGmT0WcBDk+1z8540u+crHJPIevo0baY
         G6wvc2EDGKUmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 96A915C010F; Sun, 25 Apr 2021 12:15:09 -0700 (PDT)
Date:   Sun, 25 Apr 2021 12:15:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
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
Message-ID: <20210425191509.GV975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <ed77d2a5-aeb0-b7f5-ce91-4cac12cfdd61@linux.intel.com>
 <20210422074126.GA85095@shbuild999.sh.intel.com>
 <20210422142454.GD975577@paulmck-ThinkPad-P17-Gen-1>
 <20210422165743.GA162649@paulmck-ThinkPad-P17-Gen-1>
 <20210423061115.GA62813@shbuild999.sh.intel.com>
 <20210423140254.GM975577@paulmck-ThinkPad-P17-Gen-1>
 <20210424122920.GB85095@shbuild999.sh.intel.com>
 <20210424175322.GS975577@paulmck-ThinkPad-P17-Gen-1>
 <20210425021438.GA2942@shbuild999.sh.intel.com>
 <20210425031437.GA38485@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425031437.GA38485@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 11:14:37AM +0800, Feng Tang wrote:
> On Sun, Apr 25, 2021 at 10:14:38AM +0800, Feng Tang wrote:
> > On Sat, Apr 24, 2021 at 10:53:22AM -0700, Paul E. McKenney wrote:
> > > And if your 2/2 goes in, those who still distrust TSC will simply
> > > revert it.  In their defense, their distrust was built up over a very
> > > long period of time for very good reasons.
> > > 
> > > > > This last sentence is not a theoretical statement.  In the past, I have
> > > > > suggested using the existing "tsc=reliable" kernel boot parameter,
> > > > > which disables watchdogs on TSC, similar to your patch 2/2 above.
> > > > > The discussion was short and that boot parameter was not set.  And the
> > > > > discussion motivated to my current clocksource series.  ;-)
> > > > > 
> > > > > I therefore suspect that someone will want a "tsc=unreliable" boot
> > > > > parameter (or similar) to go with your patch 2/2.
> > > >  
> > > > Possibly :)
> > > > 
> > > > But I wonder if tsc is disabled on that 'large system', what will be
> > > > used instead? HPET is known to be much slower for clocksource, as shown
> > > > in this regression report :) not mentioning the 'acpi_pm' timer. 
> > > 
> > > Indeed, the default switch to HPET often causes the system to be taken
> > > out of service due to the resulting performance shortfall.  There is
> > > of course some automated recovery, and no, I am not familiar with the
> > > details, but I suspect that a simple reboot is an early recovery step.
> > > However, if the problem were to persist, the system would of course be
> > > considered to be permanently broken.
> > 
> > Thanks for the info, if a sever is taken out of service just because
> > of a false alarm of tsc, then it's a big waste!
> > 
> > > > Again, I want to know the real tsc unstable case. I have spent lots
> > > > of time searching these info from git logs and mail archives before
> > > > writing the patches.
> > > 
> > > So do I, which is why I put together this patch series.  My employer has
> > > a fairly strict upstream-first for things like this which are annoyances
> > > that are likely hiding other bugs, but which are not causing significant
> > > outages, which was of course the motivation for the fault-injection
> > > patches.
> > > 
> > > As I said earlier, it would have been very helpful to you for a patch
> > > series like this to have been applied many years ago.  If it had been,
> > > we would already have the failure-rate data that you requested.  And of
> > > course if that failure-rate data indicated that TSC was reliable, there
> > > would be far fewer people still distrusting TSC.
> >  
> > Yes, if they can share the detailed info (like what's the 'watchdog')
> > and debug info, it can enable people to debug and root cause the
> > problem to be a false alarm or a real silicon platform. Personally, for
> > newer platforms I tend to trust tsc much more than other clocksources.
>  
> I understand people may 'distrust' tsc, after seeing that 'tsc unstable'
> cases. But for 'newer platforms', if the unstable was judged by hpet,
> acpi_pm_timer or the software 'refined-jiffies', then it could possibly
> be just a false alarm, and that's not too difficult to be root caused.
> And if there is a real evidence of a broken tsc case, then the distrust
> is not just in impression from old days :) 

Agreed!

And I am hoping that my patch series can provide more clarity in the
future.

							Thanx, Paul
