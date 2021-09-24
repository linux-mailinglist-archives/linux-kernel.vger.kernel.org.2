Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDFD417DD9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 00:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbhIXWpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 18:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243488AbhIXWpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 18:45:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 572A361260;
        Fri, 24 Sep 2021 22:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632523417;
        bh=jnWK7gX36RAGkOy4wGOmDoUB/ZEQWFwYpNwggV9fzGE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NuIi6eJiqCdtxgQI15zGb2Z5pI2D/gTQCf8sTJ+XboOIRjpoDcScUqwwo21mDy1Mh
         p9NPXDk88fTPpiQq4vfyCPpzS8akSE6+jiqk+vNwHRyrtkMA0UD2EyduuIGLlHJeBf
         SL2czuXabJCnAFlYc59QZWmRPXutvfS4BzQKws4thpHsQxHE8+mAmYCas99RxwhnY7
         34GOErjntbj5UnY4khMb011buAwuWbyQUhAn+E+8945GwsDkuGlz+FZQDCmf4NwC6r
         o+UsBAk8WzKopFELLbcMEmHhyOOz07yH4n7J3EgAffivnozstTg/JIMXSA1yar0OXg
         0ARtqGA5g8C+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2B7D15C0800; Fri, 24 Sep 2021 15:43:37 -0700 (PDT)
Date:   Fri, 24 Sep 2021 15:43:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <llong@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org, richard@nod.at
Subject: Re: Confusing lockdep splat
Message-ID: <20210924224337.GL880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210924210247.GA3877322@paulmck-ThinkPad-P17-Gen-1>
 <d8cb4445-cb01-4405-8800-a3eefa253af1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8cb4445-cb01-4405-8800-a3eefa253af1@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 05:41:17PM -0400, Waiman Long wrote:
> On 9/24/21 5:02 PM, Paul E. McKenney wrote:
> > Hello!
> > 
> > I got the lockdep splat below from an SRCU-T rcutorture run, which uses
> > a !SMP !PREEMPT kernel.  This is a random event, and about half the time
> > it happens within an hour or two.  My reproducer (on current -rcu "dev"
> > branch for a 16-CPU system) is:
> > 
> > 	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 16 --configs "16*SRCU-T" --duration 7200
> > 
> > My points of confusion are as follows:
> > 
> > 1.	The locks involved in this deadlock cycle are irq-disabled
> > 	raw spinlocks.	The claimed deadlock cycle uses two CPUs.
> > 	There is only one CPU.	There is no possibility of preemption
> > 	or interrupts.	So how can this deadlock actually happen?
> > 
> > 2.	If there was more than one CPU, then yes, there would be
> > 	a deadlock.  The PI lock is acquired by the wakeup code after
> > 	acquiring the workqueue lock, and rcutorture tests the new ability
> > 	of the scheduler to hold the PI lock across rcu_read_unlock(),
> > 	and while it is at it, across the rest of the unlock primitives.
> > 
> > 	But if there was more than one CPU, Tree SRCU would be used
> > 	instead of Tiny SRCU, and there would be no wakeup invoked from
> > 	srcu_read_unlock().
> > 
> > 	Given only one CPU, there is no way to complete the deadlock
> > 	cycle.
> > 
> > For now, I am working around this by preventing rcutorture from holding
> > the PI lock across Tiny srcu_read_unlock().
> > 
> > Am I missing something subtle here?
> 
> I would say that the lockdep code just doesn't have enough intelligence to
> identify that deadlock is not possible in this special case. There are
> certainly false positives, and it can be hard to get rid of them.

Would it make sense for lockdep to filter out reports involving more
than one CPU unless there is at least one sleeplock in the cycle?

Of course, it gets more complicated when interrupts are involved...

							Thanx, Paul
