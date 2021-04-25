Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA7D36A459
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 05:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhDYDPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 23:15:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:45425 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhDYDPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 23:15:21 -0400
IronPort-SDR: ZMcN30g/T7HSCq49lMUjQelANJU6Eb2rHj+Di9Omn93cTs5vEilLErx4FyH8SdCGjhT0o3hTOR
 WVT6YPwd1+Mg==
X-IronPort-AV: E=McAfee;i="6200,9189,9964"; a="196267711"
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="196267711"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 20:14:41 -0700
IronPort-SDR: wsHUTaW3CXFpl8ncYrwEjcsh8LP+NdcQWH3nyouj+W7Q9aNKLlGKVxhgt+msbM0L6q0aTbmR1U
 PXIkscNYKHCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="428919636"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga008.jf.intel.com with ESMTP; 24 Apr 2021 20:14:37 -0700
Date:   Sun, 25 Apr 2021 11:14:37 +0800
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
Message-ID: <20210425031437.GA38485@shbuild999.sh.intel.com>
References: <20210421134224.GR975577@paulmck-ThinkPad-P17-Gen-1>
 <ed77d2a5-aeb0-b7f5-ce91-4cac12cfdd61@linux.intel.com>
 <20210422074126.GA85095@shbuild999.sh.intel.com>
 <20210422142454.GD975577@paulmck-ThinkPad-P17-Gen-1>
 <20210422165743.GA162649@paulmck-ThinkPad-P17-Gen-1>
 <20210423061115.GA62813@shbuild999.sh.intel.com>
 <20210423140254.GM975577@paulmck-ThinkPad-P17-Gen-1>
 <20210424122920.GB85095@shbuild999.sh.intel.com>
 <20210424175322.GS975577@paulmck-ThinkPad-P17-Gen-1>
 <20210425021438.GA2942@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425021438.GA2942@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 10:14:38AM +0800, Feng Tang wrote:
> On Sat, Apr 24, 2021 at 10:53:22AM -0700, Paul E. McKenney wrote:
> > And if your 2/2 goes in, those who still distrust TSC will simply
> > revert it.  In their defense, their distrust was built up over a very
> > long period of time for very good reasons.
> > 
> > > > This last sentence is not a theoretical statement.  In the past, I have
> > > > suggested using the existing "tsc=reliable" kernel boot parameter,
> > > > which disables watchdogs on TSC, similar to your patch 2/2 above.
> > > > The discussion was short and that boot parameter was not set.  And the
> > > > discussion motivated to my current clocksource series.  ;-)
> > > > 
> > > > I therefore suspect that someone will want a "tsc=unreliable" boot
> > > > parameter (or similar) to go with your patch 2/2.
> > >  
> > > Possibly :)
> > > 
> > > But I wonder if tsc is disabled on that 'large system', what will be
> > > used instead? HPET is known to be much slower for clocksource, as shown
> > > in this regression report :) not mentioning the 'acpi_pm' timer. 
> > 
> > Indeed, the default switch to HPET often causes the system to be taken
> > out of service due to the resulting performance shortfall.  There is
> > of course some automated recovery, and no, I am not familiar with the
> > details, but I suspect that a simple reboot is an early recovery step.
> > However, if the problem were to persist, the system would of course be
> > considered to be permanently broken.
> 
> Thanks for the info, if a sever is taken out of service just because
> of a false alarm of tsc, then it's a big waste!
> 
> > > Again, I want to know the real tsc unstable case. I have spent lots
> > > of time searching these info from git logs and mail archives before
> > > writing the patches.
> > 
> > So do I, which is why I put together this patch series.  My employer has
> > a fairly strict upstream-first for things like this which are annoyances
> > that are likely hiding other bugs, but which are not causing significant
> > outages, which was of course the motivation for the fault-injection
> > patches.
> > 
> > As I said earlier, it would have been very helpful to you for a patch
> > series like this to have been applied many years ago.  If it had been,
> > we would already have the failure-rate data that you requested.  And of
> > course if that failure-rate data indicated that TSC was reliable, there
> > would be far fewer people still distrusting TSC.
>  
> Yes, if they can share the detailed info (like what's the 'watchdog')
> and debug info, it can enable people to debug and root cause the
> problem to be a false alarm or a real silicon platform. Personally, for
> newer platforms I tend to trust tsc much more than other clocksources.
 
I understand people may 'distrust' tsc, after seeing that 'tsc unstable'
cases. But for 'newer platforms', if the unstable was judged by hpet,
acpi_pm_timer or the software 'refined-jiffies', then it could possibly
be just a false alarm, and that's not too difficult to be root caused.
And if there is a real evidence of a broken tsc case, then the distrust
is not just in impression from old days :) 

Thanks,
Feng
