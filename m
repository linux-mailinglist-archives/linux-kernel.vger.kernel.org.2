Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE9E3648B3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbhDSRBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 13:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232217AbhDSRBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:01:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62A8161166;
        Mon, 19 Apr 2021 17:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618851632;
        bh=2l2EQFlLHfGvWsRAulraJGol2gXGNz0VePpPLXfokTc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rc8jyjU3cJW3gkUwM2BUJR7KGhLZmb/tYdMABKz02yPItKI9wsrhlc/cWJZQZOwfV
         EU79doz/bwhPU+3kPOJnlCJNAgit5SfvtucDTkgo1RuFy/6PTi3UD2FNgo2JgLmSk/
         EvvryvTB5nKhUXxLpwREDVpiYWphv2TAVr0AgEON09IgfmppeGkAKy7TUY+BHFlYQ5
         sSzCetlRx5jhEBkma7mU2vamNPGe/qFRjFUINQFTakYJUVjD7b4sI6fZY5dXfq5ctF
         /gNItvuXCcm4ZjMQOcSYkjPvJl8yX7kU8YuAIgNyXWW2i3WYqY7jFEpSUqbtSt2mmk
         Ff6U3KnjqXtKw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 293805C0127; Mon, 19 Apr 2021 10:00:32 -0700 (PDT)
Date:   Mon, 19 Apr 2021 10:00:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/2] srcu: Fix broken node geometry after early ssp init
Message-ID: <20210419170032.GB975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210414132413.98062-1-frederic@kernel.org>
 <20210414132413.98062-2-frederic@kernel.org>
 <20210414155538.GO4510@paulmck-ThinkPad-P17-Gen-1>
 <20210417131649.GA146778@lothringen>
 <20210418044616.GE5006@paulmck-ThinkPad-P17-Gen-1>
 <20210419002345.GA161053@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419002345.GA161053@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 02:23:45AM +0200, Frederic Weisbecker wrote:
> On Sat, Apr 17, 2021 at 09:46:16PM -0700, Paul E. McKenney wrote:
> > On Sat, Apr 17, 2021 at 03:16:49PM +0200, Frederic Weisbecker wrote:
> > > On Wed, Apr 14, 2021 at 08:55:38AM -0700, Paul E. McKenney wrote:
> > > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > > index 75ed367d5b60..24db97cbf76b 100644
> > > > > --- a/kernel/rcu/rcu.h
> > > > > +++ b/kernel/rcu/rcu.h
> > > > > @@ -278,6 +278,7 @@ extern void resched_cpu(int cpu);
> > > > >  extern int rcu_num_lvls;
> > > > >  extern int num_rcu_lvl[];
> > > > >  extern int rcu_num_nodes;
> > > > > +extern bool rcu_geometry_initialized;
> > > > 
> > > > Can this be a static local variable inside rcu_init_geometry()?
> > > > 
> > > > After all, init_srcu_struct() isn't called all that often, and its overhead
> > > > is such that an extra function call and check is going to hurt it.  This
> > > > of course requires removing __init from rcu_init_geometry(), but it is not
> > > > all that large, so why not just remove the __init?
> > > > 
> > > > But if we really are worried about reclaiming rcu_init_geometry()'s
> > > > instructions (maybe we are?), then rcu_init_geometry() can be split
> > > > into a function that just does the check (which is not __init) and the
> > > > remainder of the function, which could remain __init.
> > > 
> > > There you go:
> > 
> > Queued, thank you!
> 
> Thanks!
> 
> And please also consider "[PATCH 2/2] srcu: Early test SRCU polling start"
> if you want to expand testing coverage to polling.

Ah, thank you for the reminder!  Queued and pushed.

							Thanx, Paul
