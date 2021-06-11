Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7574F3A4AFC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 00:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFKWrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 18:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhFKWrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 18:47:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0320613EA;
        Fri, 11 Jun 2021 22:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623451520;
        bh=2K9nrc6/h8SZXxfW0xUQmBfYCLsB3Ze2QObsjGHOoJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=paViCY1hdXy88QZBVkqfHE4gPzF64nFt8/jBqTNllLxKy9h4R2rultKlhaom4xIWC
         CgPdLhQwGiTZoLbYY3mCCf1EZ5Yz4hUGHLlCK9UFFsujYMSWrydh506gZou5Qp6d3K
         7EexHVXCAFWIU2TdPHp7qtMKQOWJ8lyRCNO7MQGR7lVF1qKRdFEg8o1irlFOX2O/kS
         SJRqXG5dXLoX2xiIMovIEaE8v3SQRR/Kn9Cf8ZP8+Da0OEPogiV+aFDzL9HpaBEdSQ
         aW2WvqLFCsCQ2u2mmpkdEKUuJ4WPxJHsY+SGzK74RVCcrBIu61DuF1tabOpyL+eOC5
         XSTsypPwyM2wQ==
Date:   Sat, 12 Jun 2021 00:45:17 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] rcu/doc: Add a quick quiz to explain further why we need
 smp_mb__after_unlock_lock()
Message-ID: <20210611224517.GA150081@lothringen>
References: <20210610155029.130812-1-frederic@kernel.org>
 <20210610165710.GT4397@paulmck-ThinkPad-P17-Gen-1>
 <20210611103432.GA143096@lothringen>
 <20210611172514.GG4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611172514.GG4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 10:25:14AM -0700, Paul E. McKenney wrote:
> On Fri, Jun 11, 2021 at 12:34:32PM +0200, Frederic Weisbecker wrote:
> Glad to help, and I will reach out to you should someone make the mistake
> of insisting that I write something in French.  ;-)

If that can help, we still have frenglish for neutral territories such as airports.
Not easy to master though...

> 
> > > ++-----------------------------------------------------------------------+
> > > +
> > >  This approach must be extended to include idle CPUs, which need
> > >  RCU's grace-period memory ordering guarantee to extend to any
> > >  RCU read-side critical sections preceding and following the current
> 
> How about like this?
> 
> +-----------------------------------------------------------------------+
> | **Quick Quiz**:                                                       |
> +-----------------------------------------------------------------------+
> | But the chain of rcu_node-structure lock acquisitions guarantees      |
> | that new readers will see all of the updater's pre-grace-period       |
> | accesses and also guarantees that the updater's post-grace-period     |
> | accesses will see all of the old reader's accesses.  So why do we     |
> | need all of those calls to smp_mb__after_unlock_lock()?               |
> +-----------------------------------------------------------------------+
> | **Answer**:                                                           |
> +-----------------------------------------------------------------------+
> | Because we must provide ordering for RCU's polling grace-period       |
> | primitives, for example, get_state_synchronize_rcu() and              |
> | poll_state_synchronize_rcu().  Consider this code::                   |
> |                                                                       |
> |  CPU 0                                     CPU 1                      |
> |  ----                                      ----                       |
> |  WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)           |
> |  g = get_state_synchronize_rcu()           smp_mb()                   |
> |  while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)          |
> |          continue;                                                    |
> |  r0 = READ_ONCE(Y)                                                    |
> |                                                                       |
> | RCU guarantees that the outcome r0 == 0 && r1 == 0 will not           |
> | happen, even if CPU 1 is in an RCU extended quiescent state           |
> | (idle or offline) and thus won't interact directly with the RCU       |
> | core processing at all.                                               |
> +-----------------------------------------------------------------------+

Very good, thanks a lot :o)
