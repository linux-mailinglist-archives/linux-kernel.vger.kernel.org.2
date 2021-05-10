Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5C9378A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 14:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhEJLsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234016AbhEJLCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:02:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E974061108;
        Mon, 10 May 2021 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620644043;
        bh=TLLlvGAs4hL4JF1E9xTbjkLlvWbBt4JKhCr2YX0T1BU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vEBxY3xvjoJF9tu3AylZTlYt1tS/kQxluqU1dNLC4opoQ+uu6DayCj/lgRWgZfyv3
         Ui9W0XVxPmlfX1nAUMYeNyi0oETEGRADwo+q/E3RJOMWZb8Kk1ZeHVqpbqvpf0ybO0
         ioc258bAQqmEwjsQshtXz5FMGkvWxwuWgf5LlERprgDBwA+R249uB67sjNeYAad+uA
         6PbmZWc3BgbTtTF2emiuW1ll4VhJwMZeniywTHU51sjEs3eKZT7JqBJhrxmwodgigS
         S/wQ+ZKv7UJZRfAH66nwOHT8tUfqQo8BNpIwc4P2aw2svZHhuKB8tJdjuqROIQgzvM
         ayRjEg/2EB0tA==
Date:   Mon, 10 May 2021 12:54:00 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 6/8] tick/nohz: Only wakeup a single target cpu when
 kicking a task
Message-ID: <20210510105400.GC97481@lothringen>
References: <20210422120158.33629-1-frederic@kernel.org>
 <20210422120158.33629-7-frederic@kernel.org>
 <YJKhAFAbOXzopp6/@hirez.programming.kicks-ass.net>
 <20210510103901.GA97481@lothringen>
 <YJkPbkMiteUCYFru@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJkPbkMiteUCYFru@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 12:48:14PM +0200, Peter Zijlstra wrote:
> On Mon, May 10, 2021 at 12:39:01PM +0200, Frederic Weisbecker wrote:
> > On Wed, May 05, 2021 at 03:43:28PM +0200, Peter Zijlstra wrote:
> > > That had me looking at tick_nohz_task_switch(), does we want the below?
> > > 
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 9143163fa678..ff45fc513ba7 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -4207,6 +4207,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
> > >  	vtime_task_switch(prev);
> > >  	perf_event_task_sched_in(prev, current);
> > >  	finish_task(prev);
> > > +	tick_nohz_task_switch();
> > >  	finish_lock_switch(rq);
> > >  	finish_arch_post_lock_switch();
> > >  	kcov_finish_switch(current);
> > > @@ -4252,7 +4253,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
> > >  		put_task_struct_rcu_user(prev);
> > >  	}
> > >  
> > > -	tick_nohz_task_switch();
> > >  	return rq;
> > >  }
> > >  
> > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > index 828b091501ca..ea079be9097f 100644
> > > --- a/kernel/time/tick-sched.c
> > > +++ b/kernel/time/tick-sched.c
> > > @@ -447,13 +447,10 @@ void tick_nohz_dep_clear_signal(struct signal_struct *sig, enum tick_dep_bits bi
> > >   */
> > >  void __tick_nohz_task_switch(void)
> > >  {
> > > -	unsigned long flags;
> > >  	struct tick_sched *ts;
> > >  
> > > -	local_irq_save(flags);
> > > -
> > >  	if (!tick_nohz_full_cpu(smp_processor_id()))
> > > -		goto out;
> > > +		return;
> > >  
> > >  	ts = this_cpu_ptr(&tick_cpu_sched);
> > >  
> > > @@ -462,8 +459,6 @@ void __tick_nohz_task_switch(void)
> > >  		    atomic_read(&current->signal->tick_dep_mask))
> > >  			tick_nohz_full_kick();
> > >  	}
> > > -out:
> > > -	local_irq_restore(flags);
> > >  }
> > >  
> > >  /* Get the boot-time nohz CPU list from the kernel parameters. */
> > 
> > 
> > Sure, I'll take your SoB on that too, ok?
> 
> OK, but please also test it :-) I didn't even ask a compiler it's
> opinion on the thing.

Of course, there will be another version of the patchset + usual testing :-)
