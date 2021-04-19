Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C443638C6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 02:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhDSAYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 20:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:32972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231489AbhDSAYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 20:24:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2534161090;
        Mon, 19 Apr 2021 00:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618791827;
        bh=4nQQZktcRwbFXkGLQoWNp1vnXQ6rYS6YMIBW6CFcolM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWOT6wTVYUyoqnDZedE0cSFPTivuQ3yLy8b3k74gKDgOZCftGwVIY0Fzr7i9luN50
         TrLzRrPO6GFWmmw4rZn0q0vcjBwK+qp+F2Du3iEQ9GKpFkd3TrjZq4xKAo9auH1loP
         OaPu126pQGA85rKr7zn9Gp4U1AJslnSmL9cwZL4Edo3zTr/9DTPRebd+aO9pOr+lmf
         cAuLXX2rm3aJY+KPLzfjRXABlw51IzTVG6l5CD7FCbsAX1ppJsi6Xc/FK2dPxPm+hx
         IloWMOVaVqcVsJwwOYx70bRGcWqjlnMw2m+qIdgcDg5kZgX04PFha4KDU3p0p1jghX
         bYiOgaY8i7T7g==
Date:   Mon, 19 Apr 2021 02:23:45 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/2] srcu: Fix broken node geometry after early ssp init
Message-ID: <20210419002345.GA161053@lothringen>
References: <20210414132413.98062-1-frederic@kernel.org>
 <20210414132413.98062-2-frederic@kernel.org>
 <20210414155538.GO4510@paulmck-ThinkPad-P17-Gen-1>
 <20210417131649.GA146778@lothringen>
 <20210418044616.GE5006@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418044616.GE5006@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 09:46:16PM -0700, Paul E. McKenney wrote:
> On Sat, Apr 17, 2021 at 03:16:49PM +0200, Frederic Weisbecker wrote:
> > On Wed, Apr 14, 2021 at 08:55:38AM -0700, Paul E. McKenney wrote:
> > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > index 75ed367d5b60..24db97cbf76b 100644
> > > > --- a/kernel/rcu/rcu.h
> > > > +++ b/kernel/rcu/rcu.h
> > > > @@ -278,6 +278,7 @@ extern void resched_cpu(int cpu);
> > > >  extern int rcu_num_lvls;
> > > >  extern int num_rcu_lvl[];
> > > >  extern int rcu_num_nodes;
> > > > +extern bool rcu_geometry_initialized;
> > > 
> > > Can this be a static local variable inside rcu_init_geometry()?
> > > 
> > > After all, init_srcu_struct() isn't called all that often, and its overhead
> > > is such that an extra function call and check is going to hurt it.  This
> > > of course requires removing __init from rcu_init_geometry(), but it is not
> > > all that large, so why not just remove the __init?
> > > 
> > > But if we really are worried about reclaiming rcu_init_geometry()'s
> > > instructions (maybe we are?), then rcu_init_geometry() can be split
> > > into a function that just does the check (which is not __init) and the
> > > remainder of the function, which could remain __init.
> > 
> > There you go:
> 
> Queued, thank you!

Thanks!

And please also consider "[PATCH 2/2] srcu: Early test SRCU polling start"
if you want to expand testing coverage to polling.
