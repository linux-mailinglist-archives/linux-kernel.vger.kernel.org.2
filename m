Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EE8410115
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 00:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbhIQWIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 18:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233843AbhIQWIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:08:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73851600AA;
        Fri, 17 Sep 2021 22:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631916420;
        bh=X6iYnKLi3ShBIYCyMnZmU3ebRd4W1sPA8+0YDmkF5c8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kTDvtRNikZ9TX/ElBQZazVXXc8wvvEo5bju7vkJOs7pD4A+emHGVJ9rk54Ah9cjqh
         vK2MG9KNxAcfk7BR0tA7ebA1Ge+/0S1H3L/nOATXXcukSH4qU1J8BTsDGud3Fxj/xu
         xrbkJmKQOKRqYKTzFk6ahI/rjipC9YujYIRIYmcgVcYDjNtrDTMxWUMssjBJW63Bao
         4oCcyv5GSDfDJChhiagZk63+o3TswuapY6K774CY1cISgf4V119m1k+RNEc36dyj2R
         I70jKzV2l50nJ/BtaBACswMcE8Ll1f4j3UVNF+yR6E/PbGQA7tMS9awXv0w2cE6SDy
         fIH4J9DccQPIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 557EF5C0892; Fri, 17 Sep 2021 15:07:00 -0700 (PDT)
Date:   Fri, 17 Sep 2021 15:07:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     guillaume@morinfr.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Message-ID: <20210917220700.GV4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210917191555.GA2198@bender.morinfr.org>
 <20210917211148.GU4156@paulmck-ThinkPad-P17-Gen-1>
 <20210917213404.GA14271@bender.morinfr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917213404.GA14271@bender.morinfr.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 11:34:06PM +0200, Guillaume Morin wrote:
> On 17 Sep 14:11, Paul E. McKenney wrote:
> > On Fri, Sep 17, 2021 at 09:15:57PM +0200, Guillaume Morin wrote:
> > > Hello Paul,
> > > 
> > > I've been researching some RCU warnings we see that lead to full lockups
> > > with longterm 5.x kernels.
> > > 
> > > Basically the rcu_advance_cbs() == true warning in
> > > rcu_advance_cbs_nowake() is firing then everything eventually gets
> > > stuck on RCU synchronization because the GP thread stays asleep while
> > > rcu_state.gp_flags & 1 == 1 (this is a bunch of nohz_full cpus)
> > > 
> > > During that search I found your patch from July 12th
> > > https://www.spinics.net/lists/rcu/msg05731.html that seems related (all
> > > warnings we've seen happened in the __fput call path). Is there a reason
> > > this patch was not pushed? Is there an issue with this patch or did it
> > > fall just through the cracks?
> > 
> > It is still in -rcu:
> > 
> > 2431774f04d1 ("rcu: Mark accesses to rcu_state.n_force_qs")
> > 
> > It is slated for the v5.16 merge window.  But does it really fix the
> > problem that you are seeing?
> 
> I am going to try it soon. Since I could not see it in Linus' tree, I
> wanted to make sure there was nothing wrong with the patch, hence my
> email :-)
> 
> To my dismay, I can't reproduce this issue so this has made debugging
> and testing very complicated.

Welcome to my world!  ;-)

> I have a few kdumps from 5.4 and 5.10 kernels (that's how I was able to
> observe that the gp thread was sleeping for a long time) and that
> rcu_state.gp_flags & 1 == 1.
> 
> But this warning has happened a couple of dozen times on multiple
> machines in the __fput path (different kind of HW as well). Removing
> nohz_full from the command line makes the problem disappear.
> 
> Most machines have had fairly long uptime (30+ days) before showing the
> warning, though it has happened on a couple occasions only after a few
> hours.
> 
> That's pretty much all I have been able to gather so far, unfortunately.

What are these systems doing?  Running mostly in nohz_full usermode?
Mostly idle?  Something else?

If it happens again, could you please also capture the state of the
various rcuo kthreads?  Of these, the rcuog kthreads start grace
periods and the rcuoc kthreads invoke callbacks.

> > > PS: FYI during my research, I've found another similar report in
> > > bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=208685
> > 
> > Huh.  First I have heard of it.  It looks like they hit this after about
> > nine days of uptime.  I have run way more than nine days of testing of
> > nohz_full RCU operation with rcutorture, and have never seen it myself.
> > 
> > Can you reproduce this?  If so, can you reproduce it on mainline kernels
> > (as opposed to -stable kernels as in that bugzilla)?
> 
> I have at least one prod machine where the problem happens usually
> within a couple of days. All my attempts to reproduce on any testing
> environment have failed.

Again, welcome to my world!

> > The theory behind that WARN_ON_ONCE() is as follows:
> > 
> > o	The check of rcu_seq_state(rcu_seq_current(&rnp->gp_seq))
> > 	says that there is a grace period either in effect or just
> > 	now ending.
> > 
> > o	In the latter case, the grace-period cleanup has not yet
> > 	reached the current rcu_node structure, which means that
> > 	it has not yet checked to see if another grace period
> > 	is needed.
> > 
> > o	Either way, the RCU_GP_FLAG_INIT will cause the next grace
> > 	period to start.  (This flag is protected by the root
> > 	rcu_node structure's ->lock.)
> > 
> > Again, can you reproduce this, especially in mainline?
> 
> I have not tried because running a mainline kernel in our prod
> enviroment is quite difficult and requires lot of work for validation.
> Though I could probably make it happen but it would take some time.
> Patches that I can apply on a stable kernel are much easier for me to
> try, as you probably have guessed.

OK, please see below.  This is a complete shot in the dark, but could
potentially prevent the problem.  Or make it worse, which would at the
very least speed up debugging.  It might needs a bit of adjustment to
apply to the -stable kernels, but at first glance should apply cleanly.

Oh, and FYI I am having to manually paste your email address into the To:
line in order to get this to go back to you.  Please check your email
configuration.

Which might mean that you need to pull this from my -rcu tree here:

1a792b59071b ("EXP rcu: Tighten rcu_advance_cbs_nowake() checks")

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6a1e9d3374db..6d692a591f66 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1590,10 +1590,14 @@ static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
 						  struct rcu_data *rdp)
 {
 	rcu_lockdep_assert_cblist_protected(rdp);
-	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) ||
+	// Don't do anything unless the current grace period is guaranteed
+	// not to end.  This means a grace period in progress and at least
+	// one holdout CPU.
+	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) || !READ_ONCE(rnp->qsmask) ||
 	    !raw_spin_trylock_rcu_node(rnp))
 		return;
-	WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
+	if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) && READ_ONCE(rnp->qsmask))
+		WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
 	raw_spin_unlock_rcu_node(rnp);
 }
 
