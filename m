Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64A74565F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhKRXCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 18:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229909AbhKRXCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 18:02:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CE5161A70;
        Thu, 18 Nov 2021 22:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637276363;
        bh=JxxLdwDNWrYY94wD+T6ANyV028YCiS/1GL3ybNCA0bc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LFfXXvDK/VQCRGV8Nt/GGqaZVYjY8z+gG27ADugzJlYzjDAZMCAmo3OFWKClS6X7g
         SZvJPRJxXKEjPgDWvtQRD+kewqinNQBK2zNHwS2TqEaOg9jd8iNg0Zycz520BH6J/1
         VvPvIVmO3ihCm3AaLMj7z3nRo7TM96Bu4rSZYElskwf95O/LjClvmyyssRLx9ath9I
         G8BvVyjFrstuSnQm+7BGzVV6fFor2HVowfQ3YGWulgkV2yLJxXr52eU4BSqYfP/D+s
         Pmwuk58y/HE02ybuDAv1QXuBDvu1yqlCDM6Q3krX8f+xKsEAvTbvW+olkKHyjAxFUd
         F9KUUCVdbsqnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4BFED5C16A1; Thu, 18 Nov 2021 14:59:23 -0800 (PST)
Date:   Thu, 18 Nov 2021 14:59:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Daniel Vacek <neelx@redhat.com>
Cc:     guillaume@morinfr.org, linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Message-ID: <20211118225923.GX641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210927161046.GU880162@paulmck-ThinkPad-P17-Gen-1>
 <20211118184128.1335912-1-neelx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118184128.1335912-1-neelx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 07:41:28PM +0100, Daniel Vacek wrote:
> On Fri, 17 Sep 2021 15:07:00 -0700, Paul E. McKenney wrote:
> > OK, please see below.  This is a complete shot in the dark, but could
> > potentially prevent the problem.  Or make it worse, which would at the
> > very least speed up debugging.  It might needs a bit of adjustment to
> > apply to the -stable kernels, but at first glance should apply cleanly.
> > 
> > Oh, and FYI I am having to manually paste your email address into the To:
> > line in order to get this to go back to you.  Please check your email
> > configuration.
> > 
> > Which might mean that you need to pull this from my -rcu tree here:
> > 
> > 1a792b59071b ("EXP rcu: Tighten rcu_advance_cbs_nowake() checks")
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 6a1e9d3374db..6d692a591f66 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1590,10 +1590,14 @@ static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
> >  						  struct rcu_data *rdp)
> >  {
> >  	rcu_lockdep_assert_cblist_protected(rdp);
> > -	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) ||
> > +	// Don't do anything unless the current grace period is guaranteed
> > +	// not to end.  This means a grace period in progress and at least
> > +	// one holdout CPU.
> > +	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) || !READ_ONCE(rnp->qsmask) ||
> >  	    !raw_spin_trylock_rcu_node(rnp))
> >  		return;
> > -	WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
> > +	if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) && READ_ONCE(rnp->qsmask))
> > +		WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
> >  	raw_spin_unlock_rcu_node(rnp);
> >  }
> >  
> 
> Hello Paul,
> 
> We've received a few reports of this warning. Reviewing the code I don't really
> see any reason for the READ_ONCE(rnp->qsmask) part here and hence I started
> tracing the data before applying the patch to see the actual values before
> and after the lock is acquired to better understand the situation.
> 
> This can be done with a short bash script:
> 
> ~~~
> perf probe 'prelock1=rcu_advance_cbs_nowake+0x29 gp_seq=%ax:x64 rnp->qsmask rnp->lock'			# gp_seq from register after the condition check so this one will always be &3!=0
> perf probe 'prelock2=rcu_advance_cbs_nowake+0x2c rnp->gp_seq    rnp->qsmask rnp->lock'			# gp_seq refetched from memory. it could already be &0x3==0
> perf probe 'acquired=rcu_advance_cbs_nowake+0x35 rnp->gp_seq    rnp->qsmask rnp->lock'			# gp_seq refetched again after taking the lock, ditto - which is bug
> perf probe 'warning_=rcu_advance_cbs_nowake+0x40 rnp->gp_seq    rnp->qsmask rnp->lock condition=%ax:s8'	# 'condition' is the return value from rcu_advance_cbs() call
> trace-cmd stream \
> 	-e probe:prelock1 \
> 	-e probe:prelock2 -f '!gp_seq&3' \
> 	-e probe:acquired -f '!gp_seq&3' \
> 	-e probe:warning_ -f condition==1
> ~~~
> 
> The best part is that adding the kprobes opened the race window so that with
> the tracing enabled I could reproduce the bug in matter of seconds on my VM.
> One 'top' on an idle system is enough to hit it, though to accelerate I was
> using a bunch of them (but still just enough so that the machine remains
> mostly idle - the VM has 8 vCPUs):
> 
> # for i in {1..40}; do top -b -d 0.1 >/dev/null & done	# kill %{1..40}
> 
> Note, that 'rcu_nocbs=1-7' kernel option needs to be used otherwise
> rcu_advance_cbs_nowake() is not even beeing called at all as well as there
> are no offload threads it could race with.

Agreed.

> The results show that indeed (confirming the code review) the node qsmask can
> be zero while still there is no warning and no subsequent stall. As long as
> rcu_seq_state(...) is true, everything is fine.
> 
> Only when the GP state check is true before taking the lock and false after
> acquiring it is when rcu_advance_cbs() returns with true and the system is
> doomed (with the warning warmly announcing it) as the 'rcu_sched' thread is
> never woken again. The system will eventually run out of memory or the tasks
> get blocked on synchronize_rcu() indefinitely.
> 
> With this observation I was confident enough to finally apply just the grace
> period part of your patch (below). After that the system survived 12 hours
> over night. Since I could reproduce in matter of seconds before I call it a
> success.
> 
> So what is your opinion about the quiescent state mask part? Is it needed or
> rather really redundant? Perhaps upstream differs to RHEL kernel but on RHEL
> I don't really see the need and the below patch is sufficient IMO.

Well, let's see...

We hold the rcu_node structure's ->lock, which means that if the grace
period is in progress (rcu_seq_state(rcu_seq_current(&rnp->gp_seq))),
we know that rcu_gp_cleanup() will be visiting that rcu_node structure.
When it does so, it will check rcu_future_gp_cleanup().  This function
looks at rnp->gp_seq_needed to see if more grace periods are required.

And this field will be updated by rcu_start_this_gp(), which is invoked
from rcu_accelerate_cbs() which is in turn invoked from rcu_advance_cbs().
And the return value from rcu_start_this_gp() is passed through by both
rcu_accelerate_cbs() and rcu_advance_cbs().  And rcu_start_this_gp()
is guaranteed to return false (thus avoiding triggering the assertion)
when a grace period is in progress.  And, as noted above, because the
grace period cannot officially end while we are holding the ->lock of
an rcu_node structure that believes that a grace period is in progress,
we are guaranteed of that false return.

So good catch!

(My paranoia stemmed from the fact that there was a time when the
rcu_state strucure's idea of the grace period was updated before those
of the rcu_node structures.  In case you were wondering.)

> Or perhaps I'm missing the part where the qsmask check is not really needed
> but it's just an optimization because in that case we do not need to advance
> the callbacks here as they will be advanced soon anyways?

Well, the lockless ->qsmask check could be considered an optimization
because it would reduce the probability of the grace period ending while
we were acquiring the lock.  But that optimization is not likely to be
worth it.

> With or without the qsmask part, in both cases I believe this should go to
> stable 5.4+ and of course we want it in RHEL asap, so once Linus merges a
> version of it, we are going to backport. Since this is only reproducible
> with the 'rcu_nocbs' option I understand that the v5.17 merge window is
> a reasonable target for upstream. Nevertheless this is still a bugfix.

If I was sending it upstream as-is, it -might- be worth jamming into v5.16.
But I am updating that commit with attribution, so some additional time
testing is not a bad thing.

Either way, I believe you are good backporting this patch given suitable
additional testing, at your option (your distro, your rules!).

							Thanx, Paul

> --nX
> 
> ----
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1aebb2dfbf90..96df7f68ff4d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1389,7 +1389,8 @@ static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
>  	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) ||
>  	    !raw_spin_trylock_rcu_node(rnp))
>  		return;
> -	WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
> +	if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))
> +		WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
>  	raw_spin_unlock_rcu_node(rnp);
>  }
>  
> -- 
> 
