Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A3E348B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 09:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhCYIeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 04:34:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:14176 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhCYIeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:34:14 -0400
IronPort-SDR: 9Jo34+0KrxjXYZBKLT5/7E9+o2i8o66p5lc8eO4UBWY46nqlp3XbSUDUdy/7LhqJ6lKcWvVWAE
 JXy+mgPUl4gA==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="170861313"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="170861313"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 01:34:14 -0700
IronPort-SDR: f7umMfxLMhJFEaCKajx7Vw0idnOLH0b974cZHDevSvX3T7tcCao4wFEQ1i0cpNHB706t7LdZje
 5eKQwDoVAaug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="409265359"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2021 01:34:11 -0700
Date:   Thu, 25 Mar 2021 16:34:11 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>, andi.kleen@intel.com
Subject: Re: [PATCH] clocksource: don't run watchdog forever
Message-ID: <20210325083411.GA77653@shbuild999.sh.intel.com>
References: <1614653665-20905-1-git-send-email-feng.tang@intel.com>
 <YD4CdQqX5Lea1rB5@hirez.programming.kicks-ass.net>
 <20210302120634.GB76460@shbuild999.sh.intel.com>
 <875z286xtk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z286xtk.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wed, Mar 03, 2021 at 04:50:31PM +0100, Thomas Gleixner wrote:
> On Tue, Mar 02 2021 at 20:06, Feng Tang wrote:
> > On Tue, Mar 02, 2021 at 10:16:37AM +0100, Peter Zijlstra wrote:
> >> On Tue, Mar 02, 2021 at 10:54:24AM +0800, Feng Tang wrote:
> >> > clocksource watchdog runs every 500ms, which creates some OS noise.
> >> > As the clocksource wreckage (especially for those that has per-cpu
> >> > reading hook) usually happens shortly after CPU is brought up or
> >> > after system resumes from sleep state, so add a time limit for
> >> > clocksource watchdog to only run for a period of time, and make
> >> > sure it run at least twice for each CPU.
> >> > 
> >> > Regarding performance data, there is no improvement data with the
> >> > micro-benchmarks we have like hackbench/netperf/fio/will-it-scale
> >> > etc. But it obviously reduces periodic timer interrupts, and may
> >> > help in following cases:
> >> > * When some CPUs are isolated to only run scientific or high
> >> >   performance computing tasks on a NOHZ_FULL kernel, where there
> >> >   is almost no interrupts, this could make it more quiet
> >> > * On a cluster which runs a lot of systems in parallel with
> >> >   barriers there are always enough systems which run the watchdog
> >> >   and make everyone else wait
> >> > 
> >> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> >> 
> >> Urgh.. so this hopes and prays that the TSC wrackage happens in the
> >> first 10 minutes after boot.
> 
> which is wishful thinking....
> 
> > Yes, the 10 minutes part is only based on our past experience and we
> > can make it longer. But if there was real case that the wrackage happened
> > long after CPU is brought up like days, then this patch won't help
> > much.
> 
> It really depends on the BIOS wreckage. On one of my machine it takes up
> to a day depending on the workload.
> 
> Anything pre TSC_ADJUST wants the watchdog on. With TSC ADJUST available
> we can probably avoid it.
> 
> There is a caveat though. If the machine never goes idle then TSC adjust
> is not able to detect a potential wreckage. OTOH, most of the broken
> BIOSes tweak TSC only by a few cycles and that is usually detectable
> during boot. So we might be clever about it and schedule a check every
> hour when during the first 10 minutes a modification of TSC adjust is
> seen on any CPU.

I've thought about implementing this (sorry for delay), and would
clarify something to understand it correctly. This hourly check is only
for x86's tsc_adjust overriden by BIOS, and not the general kernel watchdog?
As the current clocksources have different wrap time, like acpi_pm timer
will wrap around every 4 seconds, and hpet wraps about every 300 scconds,
we can only either keep doing the watchdog check or cancel it.

If so, we can start a timer fired 10 minutes later to check it, and extend
the timer to 1 hour if there is no tsc_adjust overridden.

I've checked one open-sourced BIOS code project: EDK2 (https://github.com/tianocore/edk2),
where I did some grep and can't find places writting to tsc_adjust msr,
which can give us more confidence that fewer and fewer BIOS will wrongly
write to tsc_adjust msr :)

Thanks,
Feng
