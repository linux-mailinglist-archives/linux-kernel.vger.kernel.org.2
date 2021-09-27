Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7711741A17A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbhI0Vsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:48:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236299AbhI0Vsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:48:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0713360F4A;
        Mon, 27 Sep 2021 21:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632779220;
        bh=zeGEbGI/ZXAXs9PdO+lmHDPPAF/0tujqW+e0ABCxmV4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=srkHJptHb/Wlhe5x0x9V8aXoohytmjiImRLdY4TP9teoCK01bWfP3Lk/OQvBiJ9hK
         ICPrSCNHdFfnKW18EC8TVqE/hGvbfxkdgNJb7sjqK4E4x1RLNoQZCXcHb7Wywudtde
         o9F2k7MLI9i3QCMt1N4mkfypp9wjn86Vquqst9cthSS/aozdVRSw7BuDIyHOHP+Ve6
         G+Mgq0vNq58JSKLY2sHg4vWwrP2OaKXIJGXJkbeS0I/yuSifBZmdooC4d3SHBGNFEe
         Oj3NiefkWODt3+8L/QhE3HkiK7RH81pp+g5JF9giKYVsTPsqUFOI0e1jIcaE7yqFxo
         haG9GasHxq1xA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C0A6C5C0926; Mon, 27 Sep 2021 14:46:59 -0700 (PDT)
Date:   Mon, 27 Sep 2021 14:46:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Guillaume Morin <guillaume@morinfr.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Message-ID: <20210927214659.GV880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210918003933.GA25868@bender.morinfr.org>
 <20210918040035.GX4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918070836.GA19555@bender.morinfr.org>
 <20210919163539.GD880162@paulmck-ThinkPad-P17-Gen-1>
 <20210920160540.GA31426@bender.morinfr.org>
 <20210922191406.GA31531@bender.morinfr.org>
 <20210922192448.GB880162@paulmck-ThinkPad-P17-Gen-1>
 <20210927153842.GA12620@bender.morinfr.org>
 <20210927161046.GU880162@paulmck-ThinkPad-P17-Gen-1>
 <20210927164944.GA20372@bender.morinfr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927164944.GA20372@bender.morinfr.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 06:49:45PM +0200, Guillaume Morin wrote:
> On 27 Sep  9:10, Paul E. McKenney wrote:
> > Very good!  Would you be willing to give me your Tested-by?
> 
> Of course! Added below after the patch.
> 
> > > The first patch is already in your rcu tree and my gut feeling is that
> > > it is the one that fixes the issue but you're the expert here... Though
> > > I think it should be probably fast tracked and marked for stable?
> > > 
> > > Are you planning on committing the 2nd patch to your tree?
> > 
> > This is the second patch, correct?  (Too many patches!)
> 
> Correct. And to be 100% clear, the first one is
> https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=2431774f04d1050292054c763070021bade7b151
> 
> > If so, I add your Tested-by and fill out the commit log.  It would be
> > slated for the v5.17 merge window by default, that is, not the upcoming
> > merge window but the one after that.  Please let me know if you need
> > it sooner.
> 
> I personally don't need it sooner. But it's been broken for a while (5.4
> based on the bugzilla report) and I can't imagine the original reporter
> and we are the only ones hitting this. So my personal opinion would be
> to get both patches into Linus's tree and stable branches asap, but
> obviously this is entirely up to you.

I have it in -next with your Tested-by (thank you!), so let's see how
testing and review go.

> I do appreciate the help!

And thank you for giving that patch a go!

							Thanx, Paul

> > ------------------------------------------------------------------------
> > 
> > commit 1a792b59071b697defd4ccdc8b951cce49de9d2f
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Fri Sep 17 15:04:48 2021 -0700
> > 
> >     EXP rcu: Tighten rcu_advance_cbs_nowake() checks
> >     
> >     This is an experimental shot-in-the-dark debugging patch.
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
> Tested-By: Guillaume Morin <guillaume@morinfr.org>
> 
> -- 
> Guillaume Morin <guillaume@morinfr.org>
