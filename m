Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7225E41988E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhI0QMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235261AbhI0QMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:12:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F93A60F24;
        Mon, 27 Sep 2021 16:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632759046;
        bh=F+UegogzQUd6lQGfpVddtwodkH6FMEhe5nAdym7ukz4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hyR9PMh5ejEwybOGdxb6WLqLhNYOsg228WFDNgq4h4JAYZuN4zhHixjHpzG9nUSO0
         Io9+0oY/Etdl4/F5/UFBaYeACVsq7Dw7uxX2TtUMTu5lgtPsrkFYGk/BvLdx7dyqb9
         PngD7G64G49V0Nl7YXySEpL87xztC/iqmyZhGwv/VWwIeExEE8MKDjPyeDb5whxvrl
         HmBoqUdtXtCWWoL3LxktTyh/G9YzL/lnnyD154Urf75a9+InCN2635SnY9BjY71zw1
         m/t/rRW/mjf6uiLAeQuM0m1tZImkO9sXD0azIJlxPcqAv45E2ukAzPp1TFqGVkiYpW
         80b3xPrFnTOcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5D4A95C0926; Mon, 27 Sep 2021 09:10:46 -0700 (PDT)
Date:   Mon, 27 Sep 2021 09:10:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Guillaume Morin <guillaume@morinfr.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Message-ID: <20210927161046.GU880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210917213404.GA14271@bender.morinfr.org>
 <20210917220700.GV4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918003933.GA25868@bender.morinfr.org>
 <20210918040035.GX4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918070836.GA19555@bender.morinfr.org>
 <20210919163539.GD880162@paulmck-ThinkPad-P17-Gen-1>
 <20210920160540.GA31426@bender.morinfr.org>
 <20210922191406.GA31531@bender.morinfr.org>
 <20210922192448.GB880162@paulmck-ThinkPad-P17-Gen-1>
 <20210927153842.GA12620@bender.morinfr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927153842.GA12620@bender.morinfr.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 05:38:42PM +0200, Guillaume Morin wrote:
> On 22 Sep 12:24, Paul E. McKenney wrote:
> > On Wed, Sep 22, 2021 at 09:14:07PM +0200, Guillaume Morin wrote:
> > > I am little afraid of jinxing it :) but so far so good. I have the a
> > > patched kernel running on a few machines (including my most "reliable
> > > crasher") and they've been stable so far.
> > > 
> > > It's definitely too early to declare victory though. I will keep you
> > > posted.
> > 
> > Here is hoping!  ;-)
> 
> Things are still stable. So I am pretty optimistic. How are you planning
> to proceeed?

Very good!  Would you be willing to give me your Tested-by?

> The first patch is already in your rcu tree and my gut feeling is that
> it is the one that fixes the issue but you're the expert here... Though
> I think it should be probably fast tracked and marked for stable?
> 
> Are you planning on committing the 2nd patch to your tree?

This is the second patch, correct?  (Too many patches!)

If so, I add your Tested-by and fill out the commit log.  It would be
slated for the v5.17 merge window by default, that is, not the upcoming
merge window but the one after that.  Please let me know if you need
it sooner.

							Thanx, Paul

------------------------------------------------------------------------

commit 1a792b59071b697defd4ccdc8b951cce49de9d2f
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Sep 17 15:04:48 2021 -0700

    EXP rcu: Tighten rcu_advance_cbs_nowake() checks
    
    This is an experimental shot-in-the-dark debugging patch.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

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
 
