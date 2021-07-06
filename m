Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F5C3BD6B1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbhGFMmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238114AbhGFMdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:33:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9581619C6;
        Tue,  6 Jul 2021 12:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625574661;
        bh=YX2FqAvReZaprtAKcAtlTHtMbKsoJC8hMnxjJo8l1TY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OcaMqQtwpOFDwUl/FzAnEYR4xzzL1zHG3qKygyj4wUr0MZztGHN8WDkxBJkMiMuKu
         q6NghdCk/pVGtxHWJavSyRhj0fLW434Zlh5s5GP7k8Pf1oUaD3uweuJ++U7STfH3cR
         2TATd0TITCfpuXRFWe8I/q4FaXjoHRVFgbRX42LFLjEzV7m4xNVsKGXN8sz73tSgWC
         YmAU6PMkPKgD+gPuXbeM4/vS0fFYGXp1UCavHw8Ytewl9N3h+VV5jy4nAuUXAp1YSC
         KFYZT11Ydqi7pxTvqMrYgbJJrOtvPTI6OJ/FxDfhavfbL7TXh+BPjQ/XBF0Z4Zl1fW
         /3j/V8s+IEQpQ==
Date:   Tue, 6 Jul 2021 14:30:58 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/2] rcu: Remove needless preemption disablement in
 rcu_all_qs()
Message-ID: <20210706123058.GB107277@lothringen>
References: <20210705234344.104239-1-frederic@kernel.org>
 <20210705234344.104239-2-frederic@kernel.org>
 <YOQLZR3lESyLVkex@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOQLZR3lESyLVkex@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 09:51:01AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 06, 2021 at 01:43:44AM +0200, Frederic Weisbecker wrote:
> > The preemption is already disabled when we write rcu_data.rcu_urgent_qs.
> > We can use __this_cpu_write() directly, although that path is mostly
> > used when CONFIG_PREEMPT=n.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Uladzislau Rezki <urezki@gmail.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  kernel/rcu/tree_plugin.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 27b74352cccf..38b3d01424d7 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -871,7 +871,7 @@ void rcu_all_qs(void)
> >  		preempt_enable();
> >  		return;
> >  	}
> > -	this_cpu_write(rcu_data.rcu_urgent_qs, false);
> > +	__this_cpu_write(rcu_data.rcu_urgent_qs, false);
> 
> There's another subtle difference between this_cpu_write() and
> __this_cpu_write() aside from preempt. this_cpu_write() is also
> IRQ-safe, while __this_cpu_write() is not.
> 
> I've not looked at the usage here to see if that is relevant, but the
> Changelog only mentioned the preempt side of things, and that argument
> is incomplete in general.

You're right, I missed that. I see this rcu_urgent_qs is set by
RCU TASKS from rcu_tasks_wait_gp() (did I missed another path?).
Not sure if this is called from IRQ nor if it actually matters to
protect against IRQs for that single write.

I'm not quite used to rcu_tasks. Paul?
