Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A89B3B10C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 01:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFVXtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 19:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229746AbhFVXtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 19:49:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E2216113D;
        Tue, 22 Jun 2021 23:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624405612;
        bh=eDidqUCi0B/ZziFJA1v2poKwgZ1oRVVh6CdrHkKZChc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mmuEhYkGZD+TESbC9GNiFDT9o4AEHYB8GnXflItHA5GOWNmrLmzphbWa8K8/yAVvc
         vy+P09SfDkv6TjrS0oP/7ExKWvUFn48DW59KI6pmewxqbO29EJ25eQQLWOl8YMeKOE
         pn+fQm3c7uT+I1D0ksiU1gkDyxl5DEbqzqn8FLkcDilTK5NbIlEN+RFKwPVRf/gK+y
         n070D0OmmbsEFELBom7hMxa4Q8LJ/JOnc4EaDDSZqUCuhtbz8uUZb5UQCiLEEjQtxx
         6jr1hbSYPKVBxqJ44Iwyj+YcvCZX7+IYZMD/Lj/F0XO9T6A6VoOH2v71Pl9IImhy91
         zs0/PvsuUuu4A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5049C5C0168; Tue, 22 Jun 2021 16:46:52 -0700 (PDT)
Date:   Tue, 22 Jun 2021 16:46:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com, frederic@kernel.org
Subject: Re: [PATCH] rcu: update: Check rcu_bh_lock_map state in
 rcu_read_lock_bh_held
Message-ID: <20210622234652.GL4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1624363521-19702-1-git-send-email-neeraju@codeaurora.org>
 <20210622175855.GE4397@paulmck-ThinkPad-P17-Gen-1>
 <61bed875-5ebf-03d8-58ea-e9263c534201@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61bed875-5ebf-03d8-58ea-e9263c534201@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 12:38:09AM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 6/22/2021 11:28 PM, Paul E. McKenney wrote:
> > On Tue, Jun 22, 2021 at 05:35:21PM +0530, Neeraj Upadhyay wrote:
> > > In addition to irq and softirq state, check rcu_bh_lock_map
> > > state, to decide whether RCU bh lock is held.
> > > 
> > > Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > 
> > My initial reaction was that "in_softirq() || irqs_disabled()" covers
> > it because rcu_read_lock_bh() disables BH.  But you are right that it
> > does seem a bit silly to ignore lockdep.
> > 
> > So would it also make sense to have a WARN_ON_ONCE() if lockdep claims
> > we are under rcu_read_lock_bh() protection, but "in_softirq() ||
> > irqs_disabled()" think otherwise?
> 
> After thinking more on this, looks like one intention of not
> having lockdep check here was to catch scenarios where some code enables bh
> after doing rcu_read_lock_bh(), as is mentioned in the comment above
> rcu_read_lock_bh_held():
> 
>   Note that if someone uses
>   rcu_read_lock_bh(), but then later enables BH, lockdep (if enabled)
>   will show the situation.  This is useful for debug checks in functions
>   that require that they be called within an RCU read-side critical
>   section.
> 
> Client users seem to be doing lockdep checks on returned value:
> drivers/net/wireguard/peer.c
>    RCU_LOCKDEP_WARN(!rcu_read_lock_bh_held(),
> 
> Similarly, any rcu_dereference_check(..., rcu_read_lock_bh_held()) usage
> also triggers warning, if bh is enabled, inside rcu_read_lock_bh()
> section.
> 
> So, using 'in_softirq() || irqs_disabled()' condition looks to be sufficient
> condition, to mark all read lock bh regions and adding '||
> lock_is_held(&rcu_bh_lock_map)' to this condition does not seem to fit
> well with the RCU_LOCKDEP_WARN(!rcu_read_lock_bh_held()) and
> rcu_dereference_check(..., rcu_read_lock_bh_held()) calls, if we hit
> the scenario, where bh lockmap state (shows bh lock acquired) conflicts with
> the softirq/irq state .

That makes sense to me!

But should there be checks somewhere for something like
"lock_is_held(&rcu_bh_lock_map) && !in_softirq() && !irqs_disabled()"?

							Thanx, Paul

> Thanks
> Neeraj
> 
> > > ---
> > >   kernel/rcu/update.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > > index c21b38c..d416f1c 100644
> > > --- a/kernel/rcu/update.c
> > > +++ b/kernel/rcu/update.c
> > > @@ -333,7 +333,7 @@ int rcu_read_lock_bh_held(void)
> > >   	if (rcu_read_lock_held_common(&ret))
> > >   		return ret;
> > > -	return in_softirq() || irqs_disabled();
> > > +	return lock_is_held(&rcu_bh_lock_map) || in_softirq() || irqs_disabled();
> > >   }
> > >   EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
> > > -- 
> > > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > > hosted by The Linux Foundation
> > > 
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> the Code Aurora Forum, hosted by The Linux Foundation
