Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D135D32CDE1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 08:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhCDHob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 02:44:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:56889 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234004AbhCDHoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 02:44:00 -0500
IronPort-SDR: MUJUc5zc91o06FwILsUcVMVJpC+q0PbIaYfYkPSGcvv3TdWzfOK4Kwr0tKlDmlfcNQzfEaMSc/
 Mu5cVIs2vpsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="251405986"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="251405986"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 23:43:19 -0800
IronPort-SDR: X+lhFq2jE+49MOKqh2RIFvZwLNhxxmnjr9k13r76rSJlphJS74pH23BZEbSdSEfN7v3CfqWU38
 4ie11g8/cfXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="507259809"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.165])
  by fmsmga001.fm.intel.com with ESMTP; 03 Mar 2021 23:43:17 -0800
Date:   Thu, 4 Mar 2021 15:43:16 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>, andi.kleen@intel.com
Subject: Re: [PATCH] clocksource: don't run watchdog forever
Message-ID: <20210304074316.GA43191@shbuild999.sh.intel.com>
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

Thanks for sharing the info.

> Anything pre TSC_ADJUST wants the watchdog on. With TSC ADJUST available
> we can probably avoid it.
> 
> There is a caveat though. If the machine never goes idle then TSC adjust
> is not able to detect a potential wreckage. OTOH, most of the broken
> BIOSes tweak TSC only by a few cycles and that is usually detectable
> during boot. So we might be clever about it and schedule a check every
> hour when during the first 10 minutes a modification of TSC adjust is
> seen on any CPU.

I don't have much experience with tsc_adjust, and try to understand it:
The 'modification of TSC' here has 2 cases: ? 
* First read of 'TSC_ADJUST' MSR of a just boot CPU returns non-zero value
* Following read of 'TSC_ADJUST' doesn't equal to the 'tsc_adjust' value
  saved in per-cpu data.

Also, does the patch ("x86/tsc: mark tsc reliable for qualified platforms")
need to wait till this caveat case is solved? 

Thanks,
Feng




> 
> Where is this TSC_DISABLE_WRITE bit again?
> 
> Thanks,
> 
>         tglx
> 
