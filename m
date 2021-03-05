Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2CC32DFAA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 03:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCECaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 21:30:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:16282 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhCECaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 21:30:15 -0500
IronPort-SDR: qGvEhvfXPROf3fTcRsM8tSzle86f1UMz6UofxtLwtu7ck/bReVaNMVuAtmJz13J4QML0wufedt
 Ou3QaugqVZFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="167447704"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="167447704"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 18:30:15 -0800
IronPort-SDR: ePoY6QpTi/YcC2rfLPO5FlABIqcjkcpS6UhOKFpjT9hHdg4qRLciLJgl1lnl5PEb76rITYYLnZ
 Kl5i8vYBWM9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="401082713"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.165])
  by fmsmga008.fm.intel.com with ESMTP; 04 Mar 2021 18:30:13 -0800
Date:   Fri, 5 Mar 2021 10:30:12 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>, andi.kleen@intel.com
Subject: Re: [PATCH] clocksource: don't run watchdog forever
Message-ID: <20210305023012.GB17707@shbuild999.sh.intel.com>
References: <1614653665-20905-1-git-send-email-feng.tang@intel.com>
 <YD4CdQqX5Lea1rB5@hirez.programming.kicks-ass.net>
 <20210302120634.GB76460@shbuild999.sh.intel.com>
 <875z286xtk.fsf@nanos.tec.linutronix.de>
 <20210304074316.GA43191@shbuild999.sh.intel.com>
 <87wnun57ke.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnun57ke.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 03:15:13PM +0100, Thomas Gleixner wrote:
> Feng,
> 
> On Thu, Mar 04 2021 at 15:43, Feng Tang wrote:
> > On Wed, Mar 03, 2021 at 04:50:31PM +0100, Thomas Gleixner wrote:
> >> Anything pre TSC_ADJUST wants the watchdog on. With TSC ADJUST available
> >> we can probably avoid it.
> >> 
> >> There is a caveat though. If the machine never goes idle then TSC adjust
> >> is not able to detect a potential wreckage. OTOH, most of the broken
> >> BIOSes tweak TSC only by a few cycles and that is usually detectable
> >> during boot. So we might be clever about it and schedule a check every
> >> hour when during the first 10 minutes a modification of TSC adjust is
> >> seen on any CPU.
> >
> > I don't have much experience with tsc_adjust, and try to understand it:
> > The 'modification of TSC' here has 2 cases: ? 
> > * First read of 'TSC_ADJUST' MSR of a just boot CPU returns non-zero
> > value
> 
> That's catching stupid BIOSes which set the TSC to random values during
> boot/reboot. That's a one off boot issue and not a real problem. The
> kernel fixes it up and is done with it. Nothing to care about.
> 
> > * Following read of 'TSC_ADJUST' doesn't equal to the 'tsc_adjust' value
> >   saved in per-cpu data.
> 
> That's where we catch broken BIOS/SMI implementations which try to
> "hide" the time wasted in BIOS/SMI by setting the TSC back to the value
> they saved on SMI entry. That was a popular BIOS "feature" some years
> ago, but it seems the BIOS tinkerers finally gave up on it.
 
Thanks for the detailed explaination! I understand now.

> >> Where is this TSC_DISABLE_WRITE bit again?
> 
> I'm serious about this. Once the kernel has taken over a CPU there is
> absolutely no reason for any context to write to the TSC/TSC_ADJUST
> register ever again. So having a mechanism to prevent writes would
> surely help to make the TSC more trustworthy.
> 
> > Also, does the patch ("x86/tsc: mark tsc reliable for qualified platforms")
> > need to wait till this caveat case is solved?
> 
> Yes, but that should be trivial to do. 

Ok, I see.

Thanks,
Feng

> 
> Thanks,
> 
>         tglx
