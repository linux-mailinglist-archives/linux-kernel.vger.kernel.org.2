Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012643DA469
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbhG2NgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:36:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234314AbhG2NgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:36:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF65E6052B;
        Thu, 29 Jul 2021 13:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627565778;
        bh=K6ZbYvTSeAPFllbF4KPvUCWrVKio91AyMs/iHX7QjnI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g0uwBoN8D2Ydb6xm6sy66/kgHGBSIrCpfw0jFuoIEIrBwODZsHbhzi2paQwghy/un
         eU05yTwMYyd9aN4DvTQS2szlmuSHjyovVjZgeNzyGeTx0o7c7ozKNgNe5MAnXrvegb
         JgfbFMQAAu5fbU2Z4JGCIdhDiU08tR2IOmP75D4pKbRpGaSuTUMjbyvDkYFrWtYv7D
         9BMyG+JU0EALUQTSZXwHaU6YGDeho8GdnKX+zIbbwPPyyvsXGsB8PBNa7TcJZ24eta
         adcOj1/cjhN85ln1wpFuU9pmXlmxVxdzblVf/QK9HZB+HBB02C7+AxJOirJUVjx/Yn
         HUtCPq0Hclb+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9D5685C04E6; Thu, 29 Jul 2021 06:36:18 -0700 (PDT)
Date:   Thu, 29 Jul 2021 06:36:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH rcu 10/18] srcutiny: Mark read-side data races
Message-ID: <20210729133618.GS4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-10-paulmck@kernel.org>
 <YQJlbEgaAGJvx3iN@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQJlbEgaAGJvx3iN@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 04:23:08PM +0800, Boqun Feng wrote:
> On Wed, Jul 21, 2021 at 01:21:18PM -0700, Paul E. McKenney wrote:
> > This commit marks some interrupt-induced read-side data races in
> > __srcu_read_lock(), __srcu_read_unlock(), and srcu_torture_stats_print().
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  include/linux/srcutiny.h | 8 ++++----
> >  kernel/rcu/srcutiny.c    | 2 +-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > index 0e0cf4d6a72a0..6cfaa0a9a9b96 100644
> > --- a/include/linux/srcutiny.h
> > +++ b/include/linux/srcutiny.h
> > @@ -61,7 +61,7 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
> >  	int idx;
> >  
> >  	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
> > -	WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
> > +	WRITE_ONCE(ssp->srcu_lock_nesting[idx], READ_ONCE(ssp->srcu_lock_nesting[idx]) + 1);
> >  	return idx;
> >  }
> >  
> > @@ -81,11 +81,11 @@ static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
> >  {
> >  	int idx;
> >  
> > -	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
> > +	idx = ((data_race(READ_ONCE(ssp->srcu_idx)) + 1) & 0x2) >> 1;
> 
> This looks very weird, any explanation why we want to put data_race() on
> a READ_ONCE()?

We don't want KCSAN to check this read, but we also don't want the
compiler to mess it up.

							Thanx, Paul

> Regards,
> Boqun
> 
> >  	pr_alert("%s%s Tiny SRCU per-CPU(idx=%d): (%hd,%hd)\n",
> >  		 tt, tf, idx,
> > -		 READ_ONCE(ssp->srcu_lock_nesting[!idx]),
> > -		 READ_ONCE(ssp->srcu_lock_nesting[idx]));
> > +		 data_race(READ_ONCE(ssp->srcu_lock_nesting[!idx])),
> > +		 data_race(READ_ONCE(ssp->srcu_lock_nesting[idx])));
> >  }
> >  
> >  #endif
> > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > index 26344dc6483b0..a0ba2ed49bc61 100644
> > --- a/kernel/rcu/srcutiny.c
> > +++ b/kernel/rcu/srcutiny.c
> > @@ -96,7 +96,7 @@ EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
> >   */
> >  void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
> >  {
> > -	int newval = ssp->srcu_lock_nesting[idx] - 1;
> > +	int newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
> >  
> >  	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
> >  	if (!newval && READ_ONCE(ssp->srcu_gp_waiting))
> > -- 
> > 2.31.1.189.g2e36527f23
> > 
