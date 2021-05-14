Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C0F3806F8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhENKOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 06:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhENKOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 06:14:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23837C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M/7y5EkrfYTBaBjiq870ckQ1ElVicAMuNCIaRlr+8Qk=; b=npqZrMvHDT5FPyQ+47VwhKiCHO
        do2utyIMTsIK5d+tZLz6EpYoLq/NqkCM3sxn7rWksQ3LVVlKh1Gm6sWIUiCqasoTzbO8d/aGVKtj/
        /KFNd9emJu/561rLMRBktu3sVBar1lCmiXtNHSb/syKyqQ6hK5v8aVX3iKEXgRwFfFWm3mkbWZV7U
        ShTeqEE+yn17S6aM+hXv4cEIkcOhAjmMD37qK9DmAmZTu5yge1T8lQxYDzsKSpgrY/LsK/H/Z36dX
        1l/TSnG6FUe7nHLSYhOvrevTmLtCmabSAt9lsAZSTLjxmIrv58EWvTGidzgM2Sxj16KO/3A5revNO
        edtmX0Og==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhUov-007jww-4K; Fri, 14 May 2021 10:13:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E82CE30001C;
        Fri, 14 May 2021 12:13:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FB5820829FB9; Fri, 14 May 2021 12:13:22 +0200 (CEST)
Date:   Fri, 14 May 2021 12:13:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [entry]  47b8ff194c:  will-it-scale.per_process_ops -3.0%
 regression
Message-ID: <YJ5NQtTdQm29dO9p@hirez.programming.kicks-ass.net>
References: <20210428071653.GC13086@xsang-OptiPlex-9020>
 <YJzhCX/CqrMQDB+y@hirez.programming.kicks-ass.net>
 <20210513174636.GB975577@paulmck-ThinkPad-P17-Gen-1>
 <20210513231127.GA165500@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513231127.GA165500@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 01:11:27AM +0200, Frederic Weisbecker wrote:

> That sounds good, but two things:
> 
> 1) Even if context tracking is not running, we still need to handle
>    deferred wakeups on idle. But all user/guest/idle currently use the
>    same function.
> 
> 2) Context tracking may be running even when full nohz is not. But here only
>    full nohz is concerned.
> 
> So the change should rather be as follows (completely untested!).
> I rather put the static key check in tick.h in order not to involve
> deep dependencies inside rcupdate.h (especially rcupdate.h -> tick.h -> sched.h)

Compiles and boots for me, 0day folks, could you please test this makes
the reported regression go away?

> diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
> index 8b2b1d68b954..136b8d97d8c0 100644
> --- a/include/linux/entry-kvm.h
> +++ b/include/linux/entry-kvm.h
> @@ -3,6 +3,7 @@
>  #define __LINUX_ENTRYKVM_H
>  
>  #include <linux/entry-common.h>
> +#include <linux/tick.h>
>  
>  /* Transfer to guest mode work */
>  #ifdef CONFIG_KVM_XFER_TO_GUEST_WORK
> @@ -57,7 +58,7 @@ int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu);
>  static inline void xfer_to_guest_mode_prepare(void)
>  {
>  	lockdep_assert_irqs_disabled();
> -	rcu_nocb_flush_deferred_wakeup();
> +	tick_nohz_user_enter_prepare();
>  }
>  
>  /**
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index 0bb80a7f05b9..bfd571f18cfd 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -11,6 +11,7 @@
>  #include <linux/context_tracking_state.h>
>  #include <linux/cpumask.h>
>  #include <linux/sched.h>
> +#include <linux/rcupdate.h>
>  
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
>  extern void __init tick_init(void);
> @@ -304,4 +305,10 @@ static inline void tick_nohz_task_switch(void)
>  		__tick_nohz_task_switch();
>  }
>  
> +static inline void tick_nohz_user_enter_prepare(void)
> +{
> +	if (tick_nohz_full_cpu(smp_processor_id()))
> +		rcu_nocb_flush_deferred_wakeup();
> +}
> +
>  #endif
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index a0b3b04fb596..bf16395b9e13 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -5,6 +5,7 @@
>  #include <linux/highmem.h>
>  #include <linux/livepatch.h>
>  #include <linux/audit.h>
> +#include <linux/tick.h>
>  
>  #include "common.h"
>  
> @@ -186,7 +187,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>  		local_irq_disable_exit_to_user();
>  
>  		/* Check if any of the above work has queued a deferred wakeup */
> -		rcu_nocb_flush_deferred_wakeup();
> +		tick_nohz_user_enter_prepare();
>  
>  		ti_work = READ_ONCE(current_thread_info()->flags);
>  	}
> @@ -202,7 +203,7 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
>  	lockdep_assert_irqs_disabled();
>  
>  	/* Flush pending rcuog wakeup before the last need_resched() check */
> -	rcu_nocb_flush_deferred_wakeup();
> +	tick_nohz_user_enter_prepare();
>  
>  	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
>  		ti_work = exit_to_user_mode_loop(regs, ti_work);
