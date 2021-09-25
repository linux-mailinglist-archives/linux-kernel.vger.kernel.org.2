Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19D9418211
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 14:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245336AbhIYMwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 08:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244795AbhIYMwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 08:52:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C97D61268;
        Sat, 25 Sep 2021 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632574225;
        bh=ZbuAn2sQrDTft13W7eIt0oMpLbDcS63ttfV2RR/iY/w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qka+leYvAu2WtWeoBHkiKT6ei9g6kV18gY9svg8yQHkFGFYbb2XOUANnv0MhN1Kmy
         pL7t8fVScyzuvqyP4/JD0vU0VHdG0XEpZ4frwYKwrrVmYMTj64CNbCAO/51KbEFTme
         SXgFBJxA3P/C4sVbOnyKue2V43J4AmGEpt6vkkeYUZFxXi9x8eQrcoOVzwCf0AZAQQ
         XmKDuwULYkejqlqDIhOJq4g4DIdHoJZMbX+FIsgwdZ3dM0IaW1/BNbOe2gosVGbQE1
         IYsW/17pOVVKrX/0UEcTpETd+yWecxJrHbn6IE6yPZhIlE4DV3G+Fq9+1oeO6gYmRq
         qJWuTBJ49/How==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 33DD85C08E8; Sat, 25 Sep 2021 05:50:25 -0700 (PDT)
Date:   Sat, 25 Sep 2021 05:50:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Waiman Long <llong@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        richard@nod.at
Subject: Re: Confusing lockdep splat
Message-ID: <20210925125025.GO880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210924210247.GA3877322@paulmck-ThinkPad-P17-Gen-1>
 <d8cb4445-cb01-4405-8800-a3eefa253af1@redhat.com>
 <20210924224337.GL880162@paulmck-ThinkPad-P17-Gen-1>
 <YU6LpI+nSmFcVP4G@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU6LpI+nSmFcVP4G@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 10:38:28AM +0800, Boqun Feng wrote:
> On Fri, Sep 24, 2021 at 03:43:37PM -0700, Paul E. McKenney wrote:
> > On Fri, Sep 24, 2021 at 05:41:17PM -0400, Waiman Long wrote:
> > > On 9/24/21 5:02 PM, Paul E. McKenney wrote:
> > > > Hello!
> > > > 
> > > > I got the lockdep splat below from an SRCU-T rcutorture run, which uses
> > > > a !SMP !PREEMPT kernel.  This is a random event, and about half the time
> > > > it happens within an hour or two.  My reproducer (on current -rcu "dev"
> > > > branch for a 16-CPU system) is:
> > > > 
> > > > 	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 16 --configs "16*SRCU-T" --duration 7200
> > > > 
> > > > My points of confusion are as follows:
> > > > 
> > > > 1.	The locks involved in this deadlock cycle are irq-disabled
> > > > 	raw spinlocks.	The claimed deadlock cycle uses two CPUs.
> > > > 	There is only one CPU.	There is no possibility of preemption
> > > > 	or interrupts.	So how can this deadlock actually happen?
> > > > 
> > > > 2.	If there was more than one CPU, then yes, there would be
> > > > 	a deadlock.  The PI lock is acquired by the wakeup code after
> > > > 	acquiring the workqueue lock, and rcutorture tests the new ability
> > > > 	of the scheduler to hold the PI lock across rcu_read_unlock(),
> > > > 	and while it is at it, across the rest of the unlock primitives.
> > > > 
> > > > 	But if there was more than one CPU, Tree SRCU would be used
> > > > 	instead of Tiny SRCU, and there would be no wakeup invoked from
> > > > 	srcu_read_unlock().
> > > > 
> > > > 	Given only one CPU, there is no way to complete the deadlock
> > > > 	cycle.
> > > > 
> > > > For now, I am working around this by preventing rcutorture from holding
> > > > the PI lock across Tiny srcu_read_unlock().
> > > > 
> > > > Am I missing something subtle here?
> > > 
> > > I would say that the lockdep code just doesn't have enough intelligence to
> > > identify that deadlock is not possible in this special case. There are
> > > certainly false positives, and it can be hard to get rid of them.
> > 
> > Would it make sense for lockdep to filter out reports involving more
> > than one CPU unless there is at least one sleeplock in the cycle?
> 
> I think SRCU is special here, because it has different implementations
> in SMP and UP. For other code, if the implemenation in SMP and UP is the
> same, we want lockdep to detect the deadlock even if it's not in UP.

Ah, fair point!  There are a few others, for example, kernel/up.c, but
it seems to just disable interrupts as its "big UP kernel lock".

> We can provide an annotation similar to data_race() for SRCU to mark
> UP-only code
> 
> 	#define LOCKDEP_UP_ONLY(expr) ({			\
> 		BUILD_BUG_ON(IS_ENABLED(CONFIG_SMP));		\
> 
> 		<disable lockdep>
> 		<...> v = expr;
> 		<enable lockdep>
> 		v
> 	})
> 
> and in __srcu_read_unlock():
> 
> 	LOCKDEP_UP_ONLY(swake_up_one(...));
> 
> Thoughts?

With the workaround I have now, all is well unless someone needs to hold
a PI lock across an rcu_read_unlock(), which seems unlikely.  If such a
case does arise, lockdep will let us know.  In which case what you are
suggesting might be a good way to go.  Alternatively, I could use the
trick that RCU Tasks Trace uses, with the swake_up_one() deferred to an
irq_work_queue() handler.

It does appear that !SMP kernels are nowhere near as important to the
community as they were 20 years ago.  ;-)

							Thanx, Paul
