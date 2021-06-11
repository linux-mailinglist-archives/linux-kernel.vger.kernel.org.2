Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFCE3A38FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 02:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFKAuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 20:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhFKAuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:50:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FF426100A;
        Fri, 11 Jun 2021 00:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623372493;
        bh=4zYi9thIGW5qJlQM1FRLU1OGpfG2faR+dNCbBeDRVLE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TRqs0iVCDAxticJHKdD2XC9eVePjeShWWWXT76yYlyse3XXzzIr+ipNvUOw/3YNJo
         TeoYWe6Dowk1KY7m5m5kbEwj0MPcvVlyRTaGBCIgyt2YKd1iN8RjlQwiMD7vOToKG2
         Pf0eRcsfRiGaLjPrGnNqy5sdP+em1TbxGk/AodBeKm+vyAiaWzqzkR3XN3vvezdsNo
         NUHiiMeD77yO5eV53hhcQpEAVviAbxjQDyWkAk9yhT4mifz4s7oB0fkVBtKQzYA8lZ
         kOkif+uZ6a4qWUx5wQMiefu4WU/kxrbqAuhqcHA6vnhimwxBaFXXBXyVqotwYLHERc
         BSX/3Bfmymjkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 545B85C0D93; Thu, 10 Jun 2021 17:48:13 -0700 (PDT)
Date:   Thu, 10 Jun 2021 17:48:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     boqun.feng@gmail.com, frederic@kernel.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, neeraju@codeaurora.org,
        urezki@gmail.com
Subject: Re: [PATCH] rcu/doc: Add a quick quiz to explain further why we need
 smp_mb__after_unlock_lock()
Message-ID: <20210611004813.GA4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210610165710.GT4397@paulmck-ThinkPad-P17-Gen-1>
 <41a783b3-db66-a30d-4ff1-d1fa77135db0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a783b3-db66-a30d-4ff1-d1fa77135db0@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 09:28:10AM +0900, Akira Yokosawa wrote:
> On Thu, 10 Jun 2021 09:57:10 -0700, Paul E. McKenney wrote:
> > On Thu, Jun 10, 2021 at 05:50:29PM +0200, Frederic Weisbecker wrote:
> >> Add some missing critical pieces of explanation to understand the need
> >> for full memory barriers throughout the whole grace period state machine,
> >> thanks to Paul's explanations.
> >> 
> >> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> >> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> >> Cc: Joel Fernandes <joel@joelfernandes.org>
> >> Cc: Uladzislau Rezki <urezki@gmail.com>
> >> Cc: Boqun Feng <boqun.feng@gmail.com>
> > 
> > Nice!!!  And not bad wording either, though I still could not resist the
> > urge to wordsmith further.  Plus I combined your two examples, in order to
> > provide a trivial example use of the polling interfaces, if nothing else.
> > 
> > Please let me know if I messed anything up.
> 
> Hi Paul,
> 
> See minor tweaks below to satisfy sphinx.
> 
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit f21b8fbdf9a59553da825265e92cedb639b4ba3c
> > Author: Frederic Weisbecker <frederic@kernel.org>
> > Date:   Thu Jun 10 17:50:29 2021 +0200
> > 
> >     rcu/doc: Add a quick quiz to explain further why we need smp_mb__after_unlock_lock()
> >     
> >     Add some missing critical pieces of explanation to understand the need
> >     for full memory barriers throughout the whole grace period state machine,
> >     thanks to Paul's explanations.
> >     
> >     Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> >     Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> >     Cc: Joel Fernandes <joel@joelfernandes.org>
> >     Cc: Uladzislau Rezki <urezki@gmail.com>
> >     Cc: Boqun Feng <boqun.feng@gmail.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
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
> > +| accesses from the readers.  So why do we need all of those calls      |
> > +| to smp_mb__after_unlock_lock()?                                       |
> > ++-----------------------------------------------------------------------+
> > +| **Answer**:                                                           |
> > ++-----------------------------------------------------------------------+
> > +| Because we must provide ordering for RCU's polling grace-period       |
> > +| primitives, for example, get_state_synchronize_rcu() and              |
> > +| poll_state_synchronize_rcu().  For example:                           |
> > +|                                                                       |
> > +| CPU 0                                     CPU 1                       |
> > +| ----                                      ----                        |
> > +| WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)            |
> > +| g = get_state_synchronize_rcu()           smp_mb()                    |
> > +| while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)           |
> > +|         continue;                                                     |
> 
> This indent causes warnings from sphinx:
> 
> Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst:135: WARNING: Unexpected indentation.
> Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst:137: WARNING: Block quote ends without a blank line; unexpected unindent
> 
> > +| r0 = READ_ONCE(Y)                                                     |
> > +|                                                                       |
> > +| RCU guarantees that that the outcome r0 == 0 && r1 == 0 will not      |
> > +| happen, even if CPU 1 is in an RCU extended quiescent state (idle     |
> > +| or offline) and thus won't interact directly with the RCU core        |
> > +| processing at all.                                                    |
> > ++-----------------------------------------------------------------------+
> > +
> >  This approach must be extended to include idle CPUs, which need
> >  RCU's grace-period memory ordering guarantee to extend to any
> >  RCU read-side critical sections preceding and following the current
> 
> The code block in the answer can be fixed as follows:
> 
> ++-----------------------------------------------------------------------+
> +| **Answer**:                                                           |
> ++-----------------------------------------------------------------------+
> +| Because we must provide ordering for RCU's polling grace-period       |
> +| primitives, for example, get_state_synchronize_rcu() and              |
> +| poll_state_synchronize_rcu().  For example::                          |
> +|                                                                       |
> +|  CPU 0                                     CPU 1                      |
> +|  ----                                      ----                       |
> +|  WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)           |
> +|  g = get_state_synchronize_rcu()           smp_mb()                   |
> +|  while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)          |
> +|          continue;                                                    |
> +|  r0 = READ_ONCE(Y)                                                    |
> +|                                                                       |
> +| RCU guarantees that that the outcome r0 == 0 && r1 == 0 will not      |
> +| happen, even if CPU 1 is in an RCU extended quiescent state (idle     |
> +| or offline) and thus won't interact directly with the RCU core        |
> +| processing at all.                                                    |
> ++-----------------------------------------------------------------------+
> 
> Hint: Use of "::" and indented code block.

Thank you!

As in with the following patch to be merged into Frederic's original,
with attribution?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 3cd5cb4d86e5..bc884ebf88bb 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -125,15 +125,15 @@ The ``smp_mb__after_unlock_lock()`` invocations prevent this
 +-----------------------------------------------------------------------+
 | Because we must provide ordering for RCU's polling grace-period       |
 | primitives, for example, get_state_synchronize_rcu() and              |
-| poll_state_synchronize_rcu().  For example:                           |
+| poll_state_synchronize_rcu().  For example::                          |
 |                                                                       |
-| CPU 0                                     CPU 1                       |
-| ----                                      ----                        |
-| WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)            |
-| g = get_state_synchronize_rcu()           smp_mb()                    |
-| while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)           |
-|         continue;                                                     |
-| r0 = READ_ONCE(Y)                                                     |
+|  CPU 0                                     CPU 1                      |
+|  ----                                      ----                       |
+|  WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)           |
+|  g = get_state_synchronize_rcu()           smp_mb()                   |
+|  while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)          |
+|          continue;                                                    |
+|  r0 = READ_ONCE(Y)                                                    |
 |                                                                       |
 | RCU guarantees that that the outcome r0 == 0 && r1 == 0 will not      |
 | happen, even if CPU 1 is in an RCU extended quiescent state (idle     |
