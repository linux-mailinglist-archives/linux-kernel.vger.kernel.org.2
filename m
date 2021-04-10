Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A67235AE73
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbhDJOi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:38:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:33744 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234392AbhDJOiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:38:25 -0400
IronPort-SDR: 3A5nh6npGNkZsOzKdKqZOElNwhP2rgNppeNjTsPtskqxg107820oCeaVWb2N2ENOeSy52+95Lm
 +MF4BCPGwAFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="191791719"
X-IronPort-AV: E=Sophos;i="5.82,212,1613462400"; 
   d="scan'208";a="191791719"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 07:38:11 -0700
IronPort-SDR: jMU+wOPrpembSVI60RjEd3PJNJ4BOpyFcRciyjgLZ8XU+/L07+IInni+GSA/nXVPrejze5+89y
 fvlkAA++jeJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,212,1613462400"; 
   d="scan'208";a="416685390"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga008.fm.intel.com with ESMTP; 10 Apr 2021 07:38:07 -0700
Date:   Sat, 10 Apr 2021 22:38:04 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, dave.hansen@intel.com, len.brown@intel.com
Subject: Re: [RFC 1/2] x86/tsc: add a timer to make sure tsc_adjust is always
 checked
Message-ID: <20210410143804.GB22054@shbuild999.sh.intel.com>
References: <1617092747-15769-1-git-send-email-feng.tang@intel.com>
 <87y2dq32xc.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2dq32xc.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sat, Apr 10, 2021 at 11:27:11AM +0200, Thomas Gleixner wrote:
> On Tue, Mar 30 2021 at 16:25, Feng Tang wrote:
> > Normally the tsc_sync will be checked every time system enters idle state,
> > but there is still caveat that a system won't enter idle, either because
> > it's too busy or configured purposely to not enter idle. Setup a periodic
> > timer to make sure the check is always on.
> 
> Bah. I really hate the fact that we don't have a knob to disable writes
> to the TSC/TSC_ADJUST msrs. That would spare this business alltogether.
> 
> > +/*
> > + * Normally the tsc_sync will be checked every time system enters idle state,
> > + * but there is still caveat that a system won't enter idle, either because
> > + * it's too busy or configured purposely to not enter idle.
> > + *
> > + * So setup a periodic timer to make sure the check is always on.
> > + */
> > +
> > +#define SYNC_CHECK_INTERVAL		(HZ * 600)
> > +static void tsc_sync_check_timer_fn(struct timer_list *unused)
> 
> I've surely mentioned this before that glueing a define without an empty
> newline to a function definition is horrible to read.
 
Got it, will add a newline.

> > +{
> > +	int next_cpu;
> > +
> > +	tsc_verify_tsc_adjust(false);
> > +
> > +	/* Loop to do the check for all onlined CPUs */
> 
> I don't see a loop here.

I meant to loop all onlined CPUs, and the comment could be
changed to

	/* Run the check for all onlined CPUs in turn */  
 
> > +	next_cpu = cpumask_next(raw_smp_processor_id(), cpu_online_mask);
> 
> Why raw_smp_processor_id()? What's wrong with smp_processor_id()?

Will change to smp_processor_id() for this timer function.

> > +	if (next_cpu >= nr_cpu_ids)
> > +		next_cpu = cpumask_first(cpu_online_mask);
> > +
> > +	tsc_sync_check_timer.expires += SYNC_CHECK_INTERVAL;
> > +	add_timer_on(&tsc_sync_check_timer, next_cpu);
> > +}
> > +
> > +static int __init start_sync_check_timer(void)
> > +{
> > +	if (!boot_cpu_has(X86_FEATURE_TSC_ADJUST))
> > +		return 0;
> > +
> > +	timer_setup(&tsc_sync_check_timer, tsc_sync_check_timer_fn, 0);
> > +	tsc_sync_check_timer.expires = jiffies + SYNC_CHECK_INTERVAL;
> > +	add_timer(&tsc_sync_check_timer);
> > +
> > +	return 0;
> > +}
> > +late_initcall(start_sync_check_timer);
> 
> So right now, if someone adds 'tsc=reliable' on the kernel command line
> then all of the watchdog checking, except for the idle enter TSC_ADJUST
> check is disabled. The NOHZ full people are probably going to be pretty
> unhappy about yet another unconditional timer they have to chase down.
> 
> So this needs some more thought.

'tsc=reliable' in cmdline will set 'tsc_clocksource_reliable' to 1, so
we can skip starting this timer if 'tsc_clocksource_reliable==1' ?

Thanks,
Feng

> 
> Thanks,
> 
>         tglx
