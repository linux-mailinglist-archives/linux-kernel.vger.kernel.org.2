Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D6F36A11F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 14:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhDXMaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 08:30:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:24827 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231799AbhDXMaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 08:30:05 -0400
IronPort-SDR: zVaWZGUh9lauCEQIIs7jXFh5TCfHMPxsdIzXyi+AU6zdz9NDnaiu7ps89mHzMUrGDZWV5pY7Q8
 nMDYlb6fdxLA==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="183660741"
X-IronPort-AV: E=Sophos;i="5.82,248,1613462400"; 
   d="scan'208";a="183660741"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 05:29:24 -0700
IronPort-SDR: 1ODtIshg6Q2oFAdGNBdY6ni/OWd5vkiCfmYBNE445erQf4C81d2os/leek/ycdlrDOyeueLM8+
 nxqYexbyyDew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,248,1613462400"; 
   d="scan'208";a="422064952"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga008.fm.intel.com with ESMTP; 24 Apr 2021 05:29:20 -0700
Date:   Sat, 24 Apr 2021 20:29:20 +0800
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
Message-ID: <20210424122920.GB85095@shbuild999.sh.intel.com>
References: <20210420134331.GM975577@paulmck-ThinkPad-P17-Gen-1>
 <20210420140552.GA3158164@paulmck-ThinkPad-P17-Gen-1>
 <04f4752e-6c5a-8439-fe75-6363d212c7b2@intel.com>
 <20210421134224.GR975577@paulmck-ThinkPad-P17-Gen-1>
 <ed77d2a5-aeb0-b7f5-ce91-4cac12cfdd61@linux.intel.com>
 <20210422074126.GA85095@shbuild999.sh.intel.com>
 <20210422142454.GD975577@paulmck-ThinkPad-P17-Gen-1>
 <20210422165743.GA162649@paulmck-ThinkPad-P17-Gen-1>
 <20210423061115.GA62813@shbuild999.sh.intel.com>
 <20210423140254.GM975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423140254.GM975577@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, Apr 23, 2021 at 07:02:54AM -0700, Paul E. McKenney wrote:
[...]
> > > > > Following is the tsc freq info from kernel log
> > > > > 
> > > > > [    0.000000] DMI: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> > > > > [    0.000000] tsc: Detected 2100.000 MHz processor
> > > > > ...
> > > > > [   13.859982] tsc: Refined TSC clocksource calibration: 2095.077 MHz
> > > > 
> > > > So what are our options?
> > > > 
> > > > 1.	Clear CLOCK_SOURCE_MUST_VERIFY from tsc-early.
> > > > 
> > 
> > I think option 1 is fine, as tsc will still get checked once 'tsc'
> > clocksource is registered, but Thomas and Peter should know more
> > background and corner cases of tsc.
> 
> I will look at adding such a patch to my series, preceding the change
> to 1/1000 deviation.
> 
> > Also we have been working on another patchset to skip watchdog check
> > for x86 platforms with stable tsc:
> > 
> > https://lore.kernel.org/lkml/1618291897-71581-1-git-send-email-feng.tang@intel.com/
> > https://lore.kernel.org/lkml/1618291897-71581-2-git-send-email-feng.tang@intel.com/
> 
> It will be interesting to see what fraction of those with large numbers
> of systems choose to revert your 2/2, and for what period of time.
> You really needed my clocksource patch series to have been in place some
> years back so that people wouldn't have been seeing the false-postive
> clock-skew complaints.  Those complaints did not help people build up
> their trust in the TSC.  :-/

I read you patchset, and I think the recheck to avoid false alarm makes
sense to me, as well as the debug method you adds, and they have no
conflict with my patches which tends to newer x86 platforms only.

And yes, I only have met and debugged tsc wrongly marked unstable cases
on several clients platforms, and in one case I disabled the HPET for
Baytrail 10 years ago. Our test farm has different kinds of servers,
only up to 4 sockets and 192 CPUs, where no tsc unstable issue has been
seen.

And I'm eager to know if there is any real case of an unreliable tsc
on the 'large numbers' of x86 system which complies with our cpu feature
check. And if there is, my 2/2 definitely should be dropped.   

> This last sentence is not a theoretical statement.  In the past, I have
> suggested using the existing "tsc=reliable" kernel boot parameter,
> which disables watchdogs on TSC, similar to your patch 2/2 above.
> The discussion was short and that boot parameter was not set.  And the
> discussion motivated to my current clocksource series.  ;-)
> 
> I therefore suspect that someone will want a "tsc=unreliable" boot
> parameter (or similar) to go with your patch 2/2.
 
Possibly :)

But I wonder if tsc is disabled on that 'large system', what will be
used instead? HPET is known to be much slower for clocksource, as shown
in this regression report :) not mentioning the 'acpi_pm' timer. 

Again, I want to know the real tsc unstable case. I have spent lots
of time searching these info from git logs and mail archives before
writing the patches.

Thanks,
Feng

> 							Thanx, Paul
