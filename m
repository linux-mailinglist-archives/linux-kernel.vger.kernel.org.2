Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2833B38866B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhESFLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:11:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:53831 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230183AbhESFLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:11:31 -0400
IronPort-SDR: SRczaqCZ8cDW24OGELxYBGkU2ba72VKe6Q0pOOm6F5ksm2lfoT79nkTa8bpJNFif99GEL87uXM
 QbFITeh1vJFQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="188302708"
X-IronPort-AV: E=Sophos;i="5.82,311,1613462400"; 
   d="scan'208";a="188302708"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 22:10:12 -0700
IronPort-SDR: CXRD1DRSQUGsL/YALgRnMnL3+AeRmzLgYV3ZfiQNUPiG3W09hZ5apStdfTZsXX4aMRE/OzbjIA
 nzPi3g0v9dTw==
X-IronPort-AV: E=Sophos;i="5.82,311,1613462400"; 
   d="scan'208";a="473309301"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 22:10:08 -0700
Date:   Wed, 19 May 2021 13:27:00 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [entry]  47b8ff194c:  will-it-scale.per_process_ops -3.0%
 regression
Message-ID: <20210519052700.GC29704@xsang-OptiPlex-9020>
References: <20210428071653.GC13086@xsang-OptiPlex-9020>
 <YJzhCX/CqrMQDB+y@hirez.programming.kicks-ass.net>
 <20210513174636.GB975577@paulmck-ThinkPad-P17-Gen-1>
 <20210513231127.GA165500@lothringen>
 <YJ5NQtTdQm29dO9p@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ5NQtTdQm29dO9p@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Peter Zijlstra,

On Fri, May 14, 2021 at 12:13:22PM +0200, Peter Zijlstra wrote:
> On Fri, May 14, 2021 at 01:11:27AM +0200, Frederic Weisbecker wrote:
> 
> > That sounds good, but two things:
> > 
> > 1) Even if context tracking is not running, we still need to handle
> >    deferred wakeups on idle. But all user/guest/idle currently use the
> >    same function.
> > 
> > 2) Context tracking may be running even when full nohz is not. But here only
> >    full nohz is concerned.
> > 
> > So the change should rather be as follows (completely untested!).
> > I rather put the static key check in tick.h in order not to involve
> > deep dependencies inside rcupdate.h (especially rcupdate.h -> tick.h -> sched.h)
> 
> Compiles and boots for me, 0day folks, could you please test this makes
> the reported regression go away?

sorry for late.

on which base should we apply below patch?
we tried to apply upon 4ae7dc97f726e ("entry/kvm: Explicitly flush pending rcuog
wakeup before last rescheduling point") and v5.12, but both build failed like below:

ERROR: modpost: "tick_nohz_full_mask" [arch/x86/kvm/kvm.ko] undefined!

or is there any particular kconfig need to enable?
(the kconfig which we used to build 47b8ff194c is in original report
which maybe you could help have a look what we may miss)

Thanks

> 
> > diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
> > index 8b2b1d68b954..136b8d97d8c0 100644
> > --- a/include/linux/entry-kvm.h
> > +++ b/include/linux/entry-kvm.h
> > @@ -3,6 +3,7 @@
> >  #define __LINUX_ENTRYKVM_H
> >  
> >  #include <linux/entry-common.h>
> > +#include <linux/tick.h>
> >  
> >  /* Transfer to guest mode work */
> >  #ifdef CONFIG_KVM_XFER_TO_GUEST_WORK
> > @@ -57,7 +58,7 @@ int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu);
> >  static inline void xfer_to_guest_mode_prepare(void)
> >  {
> >  	lockdep_assert_irqs_disabled();
> > -	rcu_nocb_flush_deferred_wakeup();
> > +	tick_nohz_user_enter_prepare();
> >  }
> >  
> >  /**
> > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > index 0bb80a7f05b9..bfd571f18cfd 100644
> > --- a/include/linux/tick.h
> > +++ b/include/linux/tick.h
> > @@ -11,6 +11,7 @@
> >  #include <linux/context_tracking_state.h>
> >  #include <linux/cpumask.h>
> >  #include <linux/sched.h>
> > +#include <linux/rcupdate.h>
> >  
> >  #ifdef CONFIG_GENERIC_CLOCKEVENTS
> >  extern void __init tick_init(void);
> > @@ -304,4 +305,10 @@ static inline void tick_nohz_task_switch(void)
> >  		__tick_nohz_task_switch();
> >  }
> >  
> > +static inline void tick_nohz_user_enter_prepare(void)
> > +{
> > +	if (tick_nohz_full_cpu(smp_processor_id()))
> > +		rcu_nocb_flush_deferred_wakeup();
> > +}
> > +
> >  #endif
> > diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> > index a0b3b04fb596..bf16395b9e13 100644
> > --- a/kernel/entry/common.c
> > +++ b/kernel/entry/common.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/highmem.h>
> >  #include <linux/livepatch.h>
> >  #include <linux/audit.h>
> > +#include <linux/tick.h>
> >  
> >  #include "common.h"
> >  
> > @@ -186,7 +187,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> >  		local_irq_disable_exit_to_user();
> >  
> >  		/* Check if any of the above work has queued a deferred wakeup */
> > -		rcu_nocb_flush_deferred_wakeup();
> > +		tick_nohz_user_enter_prepare();
> >  
> >  		ti_work = READ_ONCE(current_thread_info()->flags);
> >  	}
> > @@ -202,7 +203,7 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
> >  	lockdep_assert_irqs_disabled();
> >  
> >  	/* Flush pending rcuog wakeup before the last need_resched() check */
> > -	rcu_nocb_flush_deferred_wakeup();
> > +	tick_nohz_user_enter_prepare();
> >  
> >  	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
> >  		ti_work = exit_to_user_mode_loop(regs, ti_work);
