Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3AE36E62A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhD2Hj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:39:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:1980 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239762AbhD2HjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:39:07 -0400
IronPort-SDR: jUrGf21yTe8sRKnxPPkd1nSS7eh1OpLcjLOwvEh8CoV/Rt2DVr5puR4y9l1NkwoG7QO7ltTYcq
 sXGmeZYOrt6Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="196502442"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="196502442"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 00:38:21 -0700
IronPort-SDR: qyNJhMyS573341bMtMyQx7/cmndiTpoc0zlhI+GheSQDEwbQVSpGI+WeIO1n2To/9vI8oiR1Qo
 qqtznY9tO1DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="423944954"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2021 00:38:16 -0700
Date:   Thu, 29 Apr 2021 15:38:16 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, paulmck@kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel-team@fb.com, neeraju@codeaurora.org,
        zhengjun.xing@intel.com, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [clocksource]  8c30ace35d:
 WARNING:at_kernel/time/clocksource.c:#clocksource_watchdog
Message-ID: <20210429073816.GA317@shbuild999.sh.intel.com>
References: <87y2d3mo2q.ffs@nanos.tec.linutronix.de>
 <87a6pimt1f.ffs@nanos.tec.linutronix.de>
 <YImBlV8l7bjZ7Q6G@hirez.programming.kicks-ass.net>
 <871raumjj4.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871raumjj4.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 07:00:15PM +0200, Thomas Gleixner wrote:
> On Wed, Apr 28 2021 at 17:39, Peter Zijlstra wrote:
> > On Wed, Apr 28, 2021 at 03:34:52PM +0200, Thomas Gleixner wrote:
> >> #4 is the easy case because we can check MSR_TSC_ADJUST to figure out
> >>    whether something has written to MSR_TSC or MSR_TSC_ADJUST and undo
> >>    the damage in a sane way.
> >
> > This is after the fact though; userspace (and kernel space) will have
> > observed non-linear time and things will be broken in various subtle and
> > hard to tell ways.
> 
> What I observed in the recent past is that _IF_ that happens it's a
> small amount of cycles so it's not a given that this can be observed
> accross CPUs. But yes, it's daft.

Currently when tsc_adjust overriden is detected, the warning msg is
"[Firmware Bug]: TSC ADJUST differs: CPU%u %lld --> %lld. Restoring",
which is kind of gentle. With Borislav's patch of preventing user space
from writing to tsc_adjust msr, the warning could be stronger? Adding
something after that like: 

"Writing to TSC_ADJUST MSR is dangerous, and may cause the lost of
your best clocksource: tsc, please check with your BIOS/OS vendors"

Thanks,
Feng

> >> I can live with that and maybe we should have done that 15 years ago
> >> instead of trying to work around it at the symptom level.
> >
> > Anybody that still has runtime BIOS wreckage will then silently suffer
> > nonlinear time, doubly so for anybody not having TSC_ADJUST. Are we sure
> > we can tell them all to bugger off and buy new hardware?
> >
> > At the very least we need something like tsc=broken, to explicitly mark
> > TSC bad on machines, so that people that see TSC fail on their current
> > kernels can continue to use the new kernels. This requires a whole lot
> > of care on the part of users though, and will raise a ruckus, because I
> > bet a fair number of these people are not even currently aware we're
> > disabling TSC for them :/
> 
> I'm still allowed to dream, right? :)
> 
> Thanks,
> 
>         tglx
