Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEAE380493
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhENHoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:44:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:50506 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230102AbhENHod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:44:33 -0400
IronPort-SDR: iU7McgdhDO1W3jEywjiW/zKguaSHLjnRoJluUideNKYa9NO45SkvMtK1jVDYViPnTVekCutegP
 kl0KoLdSqFPA==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="285654579"
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="285654579"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 00:43:21 -0700
IronPort-SDR: uGd6Dzj01XqWZyWW5NQBPa1UT+JhZwyssbmhP19KKa1UMhJbDTXrSasAxmg48S0Unn/xcyb5Ps
 k6BpBba3uneA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="626726936"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga005.fm.intel.com with ESMTP; 14 May 2021 00:43:17 -0700
Date:   Fri, 14 May 2021 15:43:14 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, zhengjun.xing@intel.com, kernel-team@fb.com,
        neeraju@codeaurora.org
Subject: Re: [clocksource]  388450c708:  netperf.Throughput_tps -65.1%
 regression
Message-ID: <20210514074314.GB5384@shbuild999.sh.intel.com>
References: <20210501003247.2448287-4-paulmck@kernel.org>
 <20210513155515.GB23902@xsang-OptiPlex-9020>
 <20210513170707.GA975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513170707.GA975577@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, May 13, 2021 at 10:07:07AM -0700, Paul E. McKenney wrote:
> On Thu, May 13, 2021 at 11:55:15PM +0800, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed a -65.1% regression of netperf.Throughput_tps due to commit:
> > 
> > 
> > commit: 388450c7081ded73432e2b7148c1bb9a0b039963 ("[PATCH v12 clocksource 4/5] clocksource: Reduce clocksource-skew threshold for TSC")
> > url: https://github.com/0day-ci/linux/commits/Paul-E-McKenney/Do-not-mark-clocks-unstable-due-to-delays-for-v5-13/20210501-083404
> > base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 2d036dfa5f10df9782f5278fc591d79d283c1fad
> > 
> > in testcase: netperf
> > on test machine: 96 threads 2 sockets Ice Lake with 256G memory
> > with following parameters:
> > 
> > 	ip: ipv4
> > 	runtime: 300s
> > 	nr_threads: 25%
> > 	cluster: cs-localhost
> > 	test: UDP_RR
> > 	cpufreq_governor: performance
> > 	ucode: 0xb000280
> > 
> > test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
> > test-url: http://www.netperf.org/netperf/
> > 
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > 
> > 
> > also as Feng Tang checked, this is a "unstable clocksource" case.
> > attached dmesg FYI.
> 
> Agreed, given the clock-skew event and the resulting switch to HPET,
> performance regressions are expected behavior.
> 
> That dmesg output does demonstrate the value of Feng Tang's patch!
> 
> I don't see how to obtain the values of ->mult and ->shift that would
> allow me to compute the delta.  So if you don't tell me otherwise, I
> will assume that the skew itself was expected on this hardware, perhaps
> somehow due to the tpm_tis_status warning immediately preceding the
> clock-skew event.  If my assumption is incorrect, please let me know.

I run the case with the debug patch applied, the info is:

[   13.796429] clocksource: timekeeping watchdog on CPU19: Marking clocksource 'tsc' as unstable because the skew is too large:
[   13.797413] clocksource:                       'hpet' wd_nesc: 505192062 wd_now: 10657158 wd_last: fac6f97 mask: ffffffff
[   13.797413] clocksource:                       'tsc' cs_nsec: 504008008 cs_now: 3445570292aa5 cs_last: 344551f0cad6f mask: ffffffffffffffff
[   13.797413] clocksource:                       'tsc' is current clocksource.
[   13.797413] tsc: Marking TSC unstable due to clocksource watchdog
[   13.844513] clocksource: Checking clocksource tsc synchronization from CPU 50 to CPUs 0-1,12,22,32-33,60,65.
[   13.855080] clocksource: Switched to clocksource hpet

So the delta is 1184 us (505192062 - 504008008), and I agree with
you that it should be related with the tpm_tis_status warning stuff.

But this re-trigger my old concerns, that if the margins calculated
for tsc, hpet are too small?

With current math algorithm, the 'uncertainty_margin' is
calculated against the frequency, and those tsc/hpet/acpi_pm
timer is multiple of MHz or GHz, which gives them to have margin of
100 us. It works with normal systems. But in the wild world, there
could be some sparkles due to some immature HW components, their
firmwares or drivers etc, just like this case. 

Thanks,
Feng


> 							Thanx, Paul
> 
