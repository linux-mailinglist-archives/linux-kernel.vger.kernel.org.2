Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE313524E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhDBA6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:58:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234683AbhDBA6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:58:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C94BC610A0;
        Fri,  2 Apr 2021 00:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617325096;
        bh=pg06mUz1XZo7DZ+aUR1VnFOhVKDjq41IfxIgOUtoii4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CcMovbIRc8RDw2w7xm+p3UXBM/OlfFOb0iKCbmXNbBXMthffS8oB1zIXTAXWtFmcA
         ufKVL2SBZsvhe1tpurVfI1ZG4Qo3lDkYMNIR56miVgJL8kakJ9fEIc5U9FWpZuUxhM
         BEiizvP37+vQ4cDFSQ5O2Qr1OxLVsizQXThKf7N/y621ZGmwFTjH1FZUAjALC0yDs/
         +xA7OqvU9rwwKRZYf7fjvhe3GC9H413TjEo3hu0Hnk72KW9rHXcX521x7ls08tHOih
         iiU7DNyPEQLERA2CEjLgHJ5wZ3d9s9DRrHQw24IzfX0zjNwwdaGunF1Es4TaFr21NN
         DNtbXtu4ZPYfQ==
Date:   Fri, 2 Apr 2021 02:58:13 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/3] srcu: Remove superfluous ssp initialization on
 deferred work queue
Message-ID: <20210402005813.GE116405@lothringen>
References: <20210401234704.125498-1-frederic@kernel.org>
 <20210401234704.125498-2-frederic@kernel.org>
 <20210402004856.GM2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402004856.GM2696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 05:48:56PM -0700, Paul E. McKenney wrote:
> On Fri, Apr 02, 2021 at 01:47:02AM +0200, Frederic Weisbecker wrote:
> > When an ssp has already started a grace period and queued an early work
> > to flush after SRCU workqueues are created, we expect the ssp to be
> > properly initialized already. So we can skip this step at this stage.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Uladzislau Rezki <urezki@gmail.com>
> > ---
> >  kernel/rcu/srcutree.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 036ff5499ad5..7197156418e4 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1396,7 +1396,6 @@ void __init srcu_init(void)
> >  	while (!list_empty(&srcu_boot_list)) {
> >  		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
> >  				      work.work.entry);
> > -		check_init_srcu_struct(ssp);
> 
> You lost me on this one.  What happens if the only pre-initialization
> invocation on the statically allocated srcu_struct pointed to by ssp
> was call_srcu()?  I am not seeing how the initialization has already
> happened in that case.
> 
> What am I missing here?

call_srcu() -> __call_srcu() -> srcu_gp_start_if_needed() ->
check_init_srcu_struct() ?

Or is it me missing something?
