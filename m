Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600333A47DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhFKR1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:27:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhFKR1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:27:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B256D6124C;
        Fri, 11 Jun 2021 17:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623432314;
        bh=czXkMxMAPEzKbCHh4TsBax2n3VRR8od40WCAFWumcPo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bc06JkJZYRFufu8UqmCfqPvRsr5FxQx1Gjnm1ZMUyVOgIK0i8Mp2phrLi/6Cu0Tiz
         vGXBl0oNjZnsNcPDmx4MZJSArxx/IUcHcqepwDcMDU+NqWoWBXS0CLGFch1jzNC31/
         SIIDxLnia2pMlyj3evzlIk2Kr6kQmEHls2+GSkfsZiqdBWdrJRyyuEy3J5leuTkPh5
         k+hsTGRyMhP+UY+SfcPf9MJPf5BAm1w7MrFxG0az+zNR0YzLT1BTQz8zyqvaHvRTli
         Bd1w2rXfbDOONrkeypia8y7+IIQRKiFjwybhCvyUg3M4ls1TPaCEFqpKhSktBrSkFV
         M+8hRP/WlUEoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 865C75C0990; Fri, 11 Jun 2021 10:25:14 -0700 (PDT)
Date:   Fri, 11 Jun 2021 10:25:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] rcu/doc: Add a quick quiz to explain further why we need
 smp_mb__after_unlock_lock()
Message-ID: <20210611172514.GG4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210610155029.130812-1-frederic@kernel.org>
 <20210610165710.GT4397@paulmck-ThinkPad-P17-Gen-1>
 <20210611103432.GA143096@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611103432.GA143096@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 12:34:32PM +0200, Frederic Weisbecker wrote:
> On Thu, Jun 10, 2021 at 09:57:10AM -0700, Paul E. McKenney wrote:
> > diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> > index 11cdab037bff..3cd5cb4d86e5 100644
> > --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> > +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> > @@ -112,6 +112,35 @@ on PowerPC.
> >  The ``smp_mb__after_unlock_lock()`` invocations prevent this
> >  ``WARN_ON()`` from triggering.
> >  
> > ++-----------------------------------------------------------------------+
> > +| **Quick Quiz**:                                                       |
> > ++-----------------------------------------------------------------------+
> > +| But the whole chain of rcu_node-structure locking guarantees that     |
> > +| readers see all pre-grace-period accesses from the updater and        |
> > +| also guarantees that the updater to see all post-grace-period         |
> 
> Should it be either "that the updater see" or "the updater to see"?

Good catch, I have reworked this paragraph.

> > +| accesses from the readers.
> 
> Is it really post-grace-period that you meant here? The updater can't see
> the future. It's rather all reader accesses before the end of the grace period?

I have reworked this to talk about old and new readers on the one hand
and the updater's pre- and post-grace-period accesses on the other.

> >  So why do we need all of those calls      |
> > +| to smp_mb__after_unlock_lock()?                                       |
> > ++-----------------------------------------------------------------------+
> > +| **Answer**:                                                           |
> > ++-----------------------------------------------------------------------+
> > +| Because we must provide ordering for RCU's polling grace-period       |
> > +| primitives, for example, get_state_synchronize_rcu() and              |
> > +| poll_state_synchronize_rcu().  For example:                           |
> 
> Two times "for example" (sorry I'm nitpicking...)

But the example has two threads!

Kidding aside, I substituted "Consider this code" for the second
"For example".

> > +|                                                                       |
> > +| CPU 0                                     CPU 1                       |
> > +| ----                                      ----                        |
> > +| WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)            |
> > +| g = get_state_synchronize_rcu()           smp_mb()                    |
> > +| while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)           |
> > +|         continue;                                                     |
> > +| r0 = READ_ONCE(Y)                                                     |
> 
> Good point, it's a nice merge of the initial examples!

Glad you like it!

> > +|                                                                       |
> > +| RCU guarantees that that the outcome r0 == 0 && r1 == 0 will not      |
> 
> One "that" has to die here.

Can we instead show clemency and banish it to some other paragraph?

> > +| happen, even if CPU 1 is in an RCU extended quiescent state (idle     |
> > +| or offline) and thus won't interact directly with the RCU core        |
> > +| processing at all.                                                    |
> 
> Thanks a lot!

Glad to help, and I will reach out to you should someone make the mistake
of insisting that I write something in French.  ;-)

> > ++-----------------------------------------------------------------------+
> > +
> >  This approach must be extended to include idle CPUs, which need
> >  RCU's grace-period memory ordering guarantee to extend to any
> >  RCU read-side critical sections preceding and following the current

How about like this?

+-----------------------------------------------------------------------+
| **Quick Quiz**:                                                       |
+-----------------------------------------------------------------------+
| But the chain of rcu_node-structure lock acquisitions guarantees      |
| that new readers will see all of the updater's pre-grace-period       |
| accesses and also guarantees that the updater's post-grace-period     |
| accesses will see all of the old reader's accesses.  So why do we     |
| need all of those calls to smp_mb__after_unlock_lock()?               |
+-----------------------------------------------------------------------+
| **Answer**:                                                           |
+-----------------------------------------------------------------------+
| Because we must provide ordering for RCU's polling grace-period       |
| primitives, for example, get_state_synchronize_rcu() and              |
| poll_state_synchronize_rcu().  Consider this code::                   |
|                                                                       |
|  CPU 0                                     CPU 1                      |
|  ----                                      ----                       |
|  WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)           |
|  g = get_state_synchronize_rcu()           smp_mb()                   |
|  while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)          |
|          continue;                                                    |
|  r0 = READ_ONCE(Y)                                                    |
|                                                                       |
| RCU guarantees that the outcome r0 == 0 && r1 == 0 will not           |
| happen, even if CPU 1 is in an RCU extended quiescent state           |
| (idle or offline) and thus won't interact directly with the RCU       |
| core processing at all.                                               |
+-----------------------------------------------------------------------+

							Thanx, Paul
