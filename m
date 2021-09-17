Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2146B410109
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 00:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344356AbhIQWBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 18:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhIQWBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:01:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 475B661052;
        Fri, 17 Sep 2021 22:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631916013;
        bh=+TnN3rkhiKJL7FE663JtdQS0i9k7JNLeEkBjc2XurBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGoM7B/0gvT7Ldv7SGJa+EIIt3SzyBKqbHNemIc2aCLG5kR+Ze2fv1ZEJrHpWonYI
         H6ks9lYl+sQfSXf5oLUl+DXiOVq1or/UeQjExWAjdTi50keWwxsQ0nKMqZNmSvMydz
         3nRSQXadC7+Twt9WHU7oGmvd2PHRW7dCu7xO5zFpxzZGBW+UR5kTaJs8JHxZcA6s43
         k1Jc+rrCeCv+Y/wgpHEn3glvS3+3m3AgW3/TR60UVOLtNNq8G0hGPmFMAAvQFQkNct
         hKSjUrc9/jlxrvCmoBeU1PEysd9BAoS30NkRzT1xO40H42nakcMkeKKihh8BsURTEl
         NkVCIid8eEG9Q==
Date:   Sat, 18 Sep 2021 00:00:11 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        urezki@gmail.com, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        joel@joelfernandes.org
Subject: Re: [PATCH 2/4] rcu: Remove useless WRITE_ONCE() on
 rcu_data.exp_deferred_qs
Message-ID: <20210917220011.GB48873@lothringen>
References: <20210916121048.36623-1-frederic@kernel.org>
 <20210916121048.36623-3-frederic@kernel.org>
 <20210916164340.GF4156@paulmck-ThinkPad-P17-Gen-1>
 <20210916210514.GA40064@lothringen>
 <20210917181024.GS4156@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917181024.GS4156@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 11:10:24AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 16, 2021 at 11:05:14PM +0200, Frederic Weisbecker wrote:
> > On Thu, Sep 16, 2021 at 09:43:40AM -0700, Paul E. McKenney wrote:
> > > On Thu, Sep 16, 2021 at 02:10:46PM +0200, Frederic Weisbecker wrote:
> > > > This variable is never written nor read remotely. Remove this confusion.
> > > > 
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > ---
> > > >  kernel/rcu/tree_exp.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > > index f3947c49eee7..4266610b4587 100644
> > > > --- a/kernel/rcu/tree_exp.h
> > > > +++ b/kernel/rcu/tree_exp.h
> > > > @@ -255,7 +255,7 @@ static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
> > > >   */
> > > >  static void rcu_report_exp_rdp(struct rcu_data *rdp)
> > > >  {
> > > > -	WRITE_ONCE(rdp->exp_deferred_qs, false);
> > > > +	rdp->exp_deferred_qs = false;
> > > 
> > > Are you sure that this can never be invoked from an interrupt handler?
> > > And that rdp->exp_deferred_qs is never read from an interrupt handler?
> > > If either can happen, then the WRITE_ONCE() does play a role, right?
> > 
> > Well, the only effect I can imagine is that it can partly prevent from an
> > interrupt to report concurrently the quiescent state during the few
> > instructions before we mask interrupts and lock the node.
> > 
> > That's a micro performance benefit that avoid a second call to
> > rcu_report_exp_cpu_mult() with the extra locking and early exit.
> 
> I am not claiming that current compilers would mess this up, though I
> have learned to have great respect for what future compilers might do...

:)

> 
> > But then that racy interrupt can still happen before we clear exp_deferred_qs.
> > In this case __this_cpu_cmpxchg() would have been more efficient.
> 
> Except that __this_cpu_cmpxchg() would have a possibility of failure,
> and thus an extra branch not needed by WRITE_ONCE().  Or am I missing
> your point here?

Right, but an extra branch that could spare a call to rcu_report_exp_cpu_mult().

Anyway I don't mind the WRITE_ONCE(), but you know how ordering (whether
compiler or CPU) makes me anxious when undocumented or not self-explanatory,
(although arguably the latter can vary depending on the reviewer :)

Thanks.
