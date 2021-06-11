Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D363A4B67
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 01:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFKXud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 19:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhFKXu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 19:50:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F7FD61019;
        Fri, 11 Jun 2021 23:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623455310;
        bh=6pFfyqWxtThZEcLQVmbRwzFXz6eVsnf2S88SIDwK+FQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SHNNaBFgfILptE2RYsa6thf3bZ6nfKOeQony87rHaMqnI5OTkHrWUSdIvXPE8ke8x
         dvuqpYing3iRCcd+L3XiOg2iS57Dsbnj4HuIfRWSagge1vNTRRZ2UvddPmmp4l2xMg
         zf/0dTzMQf3uE7+UxsK0gC6JYF8jbXszaMpQyyTeB+X429eZcHVPvuE6A2lXMUJ61e
         kUutzQ8+lO/Vjai6K2B+SU9WtrTrrh0jyejUVyfMgOKUJAcLiEd2jqG905d0Ow+7Tr
         laV4MwhG2LTlw57YecJRlQ+00IbWHw9EmlG+s0s6SkuFXsmS3ndcb1ZINtCyr7PGX+
         k4nbwteeD20MA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CBCA25C084C; Fri, 11 Jun 2021 16:48:29 -0700 (PDT)
Date:   Fri, 11 Jun 2021 16:48:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] rcu/doc: Add a quick quiz to explain further why we need
 smp_mb__after_unlock_lock()
Message-ID: <20210611234829.GJ4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210610155029.130812-1-frederic@kernel.org>
 <20210610165710.GT4397@paulmck-ThinkPad-P17-Gen-1>
 <20210611103432.GA143096@lothringen>
 <20210611172514.GG4397@paulmck-ThinkPad-P17-Gen-1>
 <20210611224517.GA150081@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611224517.GA150081@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 12:45:17AM +0200, Frederic Weisbecker wrote:
> On Fri, Jun 11, 2021 at 10:25:14AM -0700, Paul E. McKenney wrote:
> > On Fri, Jun 11, 2021 at 12:34:32PM +0200, Frederic Weisbecker wrote:
> > Glad to help, and I will reach out to you should someone make the mistake
> > of insisting that I write something in French.  ;-)
> 
> If that can help, we still have frenglish for neutral territories such as airports.
> Not easy to master though...

That does sound dangerous!  ;-)

> > > > ++-----------------------------------------------------------------------+
> > > > +
> > > >  This approach must be extended to include idle CPUs, which need
> > > >  RCU's grace-period memory ordering guarantee to extend to any
> > > >  RCU read-side critical sections preceding and following the current
> > 
> > How about like this?
> > 
> > +-----------------------------------------------------------------------+
> > | **Quick Quiz**:                                                       |
> > +-----------------------------------------------------------------------+
> > | But the chain of rcu_node-structure lock acquisitions guarantees      |
> > | that new readers will see all of the updater's pre-grace-period       |
> > | accesses and also guarantees that the updater's post-grace-period     |
> > | accesses will see all of the old reader's accesses.  So why do we     |
> > | need all of those calls to smp_mb__after_unlock_lock()?               |
> > +-----------------------------------------------------------------------+
> > | **Answer**:                                                           |
> > +-----------------------------------------------------------------------+
> > | Because we must provide ordering for RCU's polling grace-period       |
> > | primitives, for example, get_state_synchronize_rcu() and              |
> > | poll_state_synchronize_rcu().  Consider this code::                   |
> > |                                                                       |
> > |  CPU 0                                     CPU 1                      |
> > |  ----                                      ----                       |
> > |  WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)           |
> > |  g = get_state_synchronize_rcu()           smp_mb()                   |
> > |  while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)          |
> > |          continue;                                                    |
> > |  r0 = READ_ONCE(Y)                                                    |
> > |                                                                       |
> > | RCU guarantees that the outcome r0 == 0 && r1 == 0 will not           |
> > | happen, even if CPU 1 is in an RCU extended quiescent state           |
> > | (idle or offline) and thus won't interact directly with the RCU       |
> > | core processing at all.                                               |
> > +-----------------------------------------------------------------------+
> 
> Very good, thanks a lot :o)

And thank you!

							Thanx, Paul
