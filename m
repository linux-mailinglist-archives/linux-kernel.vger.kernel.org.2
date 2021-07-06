Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A386B3BDB4E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhGFQ1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 12:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhGFQ1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:27:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F7EB61C26;
        Tue,  6 Jul 2021 16:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625588662;
        bh=YsYkZubJJjCoLzPUhl/QuE2E+XD6qj3d4PuzTeoxUmM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=V+h/QgmK95WRgyoOiXMoRnrgSY2YXp45qEBq6/CsXoWCVgdaYjZYN19Yz+aBlWutj
         fLlxqpWrHBpllE9rEmKGEpMCWdZYZ+CrRn/Ou4LMJ6D8GLg8RrDkfGCJ+zNYXenTb3
         Xjtw8uKx36n/kAniY+VNhnI29oiSs/rrT6KII/jTiYMG79pZ28y2i1/l8peLCX4VuD
         P8Uhz4GdnBlZeEyjfJAKl2jqurRroFjdyFmedmvl7TpBqgpMJAiSyla4cqYTdfLghm
         3z6melMMxvZs9d2YOuezxBJrB+Dp7JJ+t6Ru4adikSPAKSgyYTH0FeuvSJQech2418
         V3A5PnE4SznRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 03D2C5C03E0; Tue,  6 Jul 2021 09:24:22 -0700 (PDT)
Date:   Tue, 6 Jul 2021 09:24:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/2] rcu: Remove needless preemption disablement in
 rcu_all_qs()
Message-ID: <20210706162421.GC4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210705234344.104239-1-frederic@kernel.org>
 <20210705234344.104239-2-frederic@kernel.org>
 <YOQLZR3lESyLVkex@hirez.programming.kicks-ass.net>
 <20210706123058.GB107277@lothringen>
 <YORahrFT56utjlc/@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YORahrFT56utjlc/@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 09:28:38PM +0800, Boqun Feng wrote:
> On Tue, Jul 06, 2021 at 02:30:58PM +0200, Frederic Weisbecker wrote:
> > On Tue, Jul 06, 2021 at 09:51:01AM +0200, Peter Zijlstra wrote:
> > > On Tue, Jul 06, 2021 at 01:43:44AM +0200, Frederic Weisbecker wrote:
> > > > The preemption is already disabled when we write rcu_data.rcu_urgent_qs.
> > > > We can use __this_cpu_write() directly, although that path is mostly
> > > > used when CONFIG_PREEMPT=n.
> > > > 
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > > Cc: Uladzislau Rezki <urezki@gmail.com>
> > > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > > ---
> > > >  kernel/rcu/tree_plugin.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > index 27b74352cccf..38b3d01424d7 100644
> > > > --- a/kernel/rcu/tree_plugin.h
> > > > +++ b/kernel/rcu/tree_plugin.h
> > > > @@ -871,7 +871,7 @@ void rcu_all_qs(void)
> > > >  		preempt_enable();
> > > >  		return;
> > > >  	}
> > > > -	this_cpu_write(rcu_data.rcu_urgent_qs, false);
> > > > +	__this_cpu_write(rcu_data.rcu_urgent_qs, false);
> > > 
> > > There's another subtle difference between this_cpu_write() and
> > > __this_cpu_write() aside from preempt. this_cpu_write() is also
> > > IRQ-safe, while __this_cpu_write() is not.
> > > 
> > > I've not looked at the usage here to see if that is relevant, but the
> > > Changelog only mentioned the preempt side of things, and that argument
> > > is incomplete in general.
> > 
> > You're right, I missed that. I see this rcu_urgent_qs is set by
> > RCU TASKS from rcu_tasks_wait_gp() (did I missed another path?).
> > Not sure if this is called from IRQ nor if it actually matters to
> > protect against IRQs for that single write.
> 
> I think __this_cpu_write() being IRQ-unsafe means it may overwrite
> percpu writes to other bytes in the same word? Let's say the
> rcu_urgent_qs is the lowest byte in the word, the pseduo asm code of
> __this_cpu_write() may be:
> 
> 	__this_cpu_write(ptr, v):
> 		long tmp = *ptr;
> 		tmp &= ~(0xff);
> 		tmp |= v;
> 		*ptr = tmp;
> 
> and the following sequence introduces an overwrite:
> 
> 	__this_cpu_write(ptr, v): // v is 0, and *ptr is 1
> 		long tmp = *ptr; // tmp is 1
> 		<interrupted>
> 		this_cpu_write() // modify another byte of *ptr, make it
> 				 // 0xff01
> 		<ret from interrupt>
> 		tmp &= ~(0xff) // tmp is 0
> 		tmp |=v;       // tmp is 0
> 		*ptr = tmp;    // *ptr is 0, overwrite a percpu write on
> 			       // another field.
> 
> I know that many archs have byte-wise store, so compilers don't really
> have the reason to generate code as above, but __this_cpu_write() is
> just a normal write, nothing prevents this from happenning, unless I'm
> missing something here?

There can indeed be writes to .rcu_urgent_qs from interrupt
handlers, for example in CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels
from rcu_read_unlock().  More conventionally, the RCU_SOFTIRQ
handler can run on the back of an interrupts, and can invoke
rcu_check_quiescent_state(), which invokes rcu_report_qs_rdp(), which
invokes rcu_disable_urgency_upon_qs(), which writes to ->rcu_urgent_qs.

RCU takes a strict view of data races, so this wants the existing
this_cpu_write().

However, RCU very likely has this_cpu_write() calls that should instead
be __this_cpu_write() calls and vice versa, so please do continue treating
any that you see with an appropriate level of suspicion.

							Thanx, Paul

> Regards,
> Boqun
> 
> > 
> > I'm not quite used to rcu_tasks. Paul?
