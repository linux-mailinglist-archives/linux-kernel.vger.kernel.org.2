Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559F741999F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhI0QvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:51:25 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:8470 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235485AbhI0QvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:51:24 -0400
Received: from bender.morinfr.org (unknown [82.64.86.27])
        by smtp4-g21.free.fr (Postfix) with ESMTPS id 6CB0619F5C4;
        Mon, 27 Sep 2021 18:49:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
        ; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SoVmLCixo8vvy5jaw3rsSeV3DJrcjyFmlB9X3/o3iPI=; b=h056tP0EG+oBqXm39Vi8h404Qi
        pDSXsSUO9Z54SL1nd2Dd8KohaT2HZNeOsjXIsJobYZNPrWGrYuRj0iinbk1Z+HPHBzVcyuV5tJZio
        USksvO7wjuxIwRvzxaYBnSEPKKBvMUyAcZuPFchN3uMiHUKHv+GnU7JnfHPJUwAFO3ss=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.92)
        (envelope-from <guillaume@morinfr.org>)
        id 1mUtp3-0005zs-4T; Mon, 27 Sep 2021 18:49:45 +0200
Date:   Mon, 27 Sep 2021 18:49:45 +0200
From:   Guillaume Morin <guillaume@morinfr.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Message-ID: <20210927164944.GA20372@bender.morinfr.org>
References: <20210917220700.GV4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918003933.GA25868@bender.morinfr.org>
 <20210918040035.GX4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918070836.GA19555@bender.morinfr.org>
 <20210919163539.GD880162@paulmck-ThinkPad-P17-Gen-1>
 <20210920160540.GA31426@bender.morinfr.org>
 <20210922191406.GA31531@bender.morinfr.org>
 <20210922192448.GB880162@paulmck-ThinkPad-P17-Gen-1>
 <20210927153842.GA12620@bender.morinfr.org>
 <20210927161046.GU880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927161046.GU880162@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Sep  9:10, Paul E. McKenney wrote:
> Very good!  Would you be willing to give me your Tested-by?

Of course! Added below after the patch.

> > The first patch is already in your rcu tree and my gut feeling is that
> > it is the one that fixes the issue but you're the expert here... Though
> > I think it should be probably fast tracked and marked for stable?
> > 
> > Are you planning on committing the 2nd patch to your tree?
> 
> This is the second patch, correct?  (Too many patches!)

Correct. And to be 100% clear, the first one is
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=2431774f04d1050292054c763070021bade7b151

> If so, I add your Tested-by and fill out the commit log.  It would be
> slated for the v5.17 merge window by default, that is, not the upcoming
> merge window but the one after that.  Please let me know if you need
> it sooner.

I personally don't need it sooner. But it's been broken for a while (5.4
based on the bugzilla report) and I can't imagine the original reporter
and we are the only ones hitting this. So my personal opinion would be
to get both patches into Linus's tree and stable branches asap, but
obviously this is entirely up to you.

I do appreciate the help!

> ------------------------------------------------------------------------
> 
> commit 1a792b59071b697defd4ccdc8b951cce49de9d2f
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Sep 17 15:04:48 2021 -0700
> 
>     EXP rcu: Tighten rcu_advance_cbs_nowake() checks
>     
>     This is an experimental shot-in-the-dark debugging patch.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 6a1e9d3374db..6d692a591f66 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1590,10 +1590,14 @@ static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
>  						  struct rcu_data *rdp)
>  {
>  	rcu_lockdep_assert_cblist_protected(rdp);
> -	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) ||
> +	// Don't do anything unless the current grace period is guaranteed
> +	// not to end.  This means a grace period in progress and at least
> +	// one holdout CPU.
> +	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) || !READ_ONCE(rnp->qsmask) ||
>  	    !raw_spin_trylock_rcu_node(rnp))
>  		return;
> -	WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
> +	if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) && READ_ONCE(rnp->qsmask))
> +		WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
>  	raw_spin_unlock_rcu_node(rnp);
>  }
>  

Tested-By: Guillaume Morin <guillaume@morinfr.org>

-- 
Guillaume Morin <guillaume@morinfr.org>
