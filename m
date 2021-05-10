Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52F0378A96
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 14:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242861AbhEJLru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbhEJLAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:00:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489FEC034611
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y0sDlSb6soTPH2aehOLflGIYyxgnPAEKF3ObJMM7PY8=; b=pWvGFBX88AJupe0oZdGgshZxpQ
        7jfNCPup37emsX+xl8PNefjYUVb7cBY/zifR1JlyIuzbIVskXG4CMKzCCFgoTO/OTXTfcKfVMklCL
        o46gP61KTn8dJ6M9OnAYaaXXZ/z0sFhWVSPRiWor+dq2s174eIGMAu9X0u2L9fChUPwiYVET5duOD
        ngz6ek8+jVthUy0Drzpidm8VxrCx8kW1MepWurn0ZuxHuTUbu1mhhrRRrBoaxcnOmVSkgM8JneHsR
        xd3ETwqAu9DdedqCOf30XDYy55i47JMaoazLNaPlENldKGWeBJtbeCNemWNUN/TqsEuOft6Uyi32a
        DZ/Vgg5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lg3SR-005yZD-P6; Mon, 10 May 2021 10:49:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92CC230022A;
        Mon, 10 May 2021 12:48:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 278252020B52D; Mon, 10 May 2021 12:48:14 +0200 (CEST)
Date:   Mon, 10 May 2021 12:48:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 6/8] tick/nohz: Only wakeup a single target cpu when
 kicking a task
Message-ID: <YJkPbkMiteUCYFru@hirez.programming.kicks-ass.net>
References: <20210422120158.33629-1-frederic@kernel.org>
 <20210422120158.33629-7-frederic@kernel.org>
 <YJKhAFAbOXzopp6/@hirez.programming.kicks-ass.net>
 <20210510103901.GA97481@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510103901.GA97481@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 12:39:01PM +0200, Frederic Weisbecker wrote:
> On Wed, May 05, 2021 at 03:43:28PM +0200, Peter Zijlstra wrote:
> > That had me looking at tick_nohz_task_switch(), does we want the below?
> > 
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9143163fa678..ff45fc513ba7 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4207,6 +4207,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
> >  	vtime_task_switch(prev);
> >  	perf_event_task_sched_in(prev, current);
> >  	finish_task(prev);
> > +	tick_nohz_task_switch();
> >  	finish_lock_switch(rq);
> >  	finish_arch_post_lock_switch();
> >  	kcov_finish_switch(current);
> > @@ -4252,7 +4253,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
> >  		put_task_struct_rcu_user(prev);
> >  	}
> >  
> > -	tick_nohz_task_switch();
> >  	return rq;
> >  }
> >  
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 828b091501ca..ea079be9097f 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -447,13 +447,10 @@ void tick_nohz_dep_clear_signal(struct signal_struct *sig, enum tick_dep_bits bi
> >   */
> >  void __tick_nohz_task_switch(void)
> >  {
> > -	unsigned long flags;
> >  	struct tick_sched *ts;
> >  
> > -	local_irq_save(flags);
> > -
> >  	if (!tick_nohz_full_cpu(smp_processor_id()))
> > -		goto out;
> > +		return;
> >  
> >  	ts = this_cpu_ptr(&tick_cpu_sched);
> >  
> > @@ -462,8 +459,6 @@ void __tick_nohz_task_switch(void)
> >  		    atomic_read(&current->signal->tick_dep_mask))
> >  			tick_nohz_full_kick();
> >  	}
> > -out:
> > -	local_irq_restore(flags);
> >  }
> >  
> >  /* Get the boot-time nohz CPU list from the kernel parameters. */
> 
> 
> Sure, I'll take your SoB on that too, ok?

OK, but please also test it :-) I didn't even ask a compiler it's
opinion on the thing.
