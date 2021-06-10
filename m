Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A30B3A318B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 18:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhFJQ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:59:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbhFJQ7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:59:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC589613C9;
        Thu, 10 Jun 2021 16:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623344230;
        bh=hPzF3JJ08+uolh2AjL4CPlo6jg8ZUJv7Mm0OOsHZoh8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qZNA0q+QjG+nlHY+dv5xa/+qi8G/JLGtlPLZxqtcMDJFfrFOZ590SWecrRLrEJeyg
         5ulONcsKR7kpRj2fvYlDPBWSciZGhOVSlPt5qfuwfs5SA0KOAeXm+3jVuwrMF9B4Pj
         VPHAdMyRc6xu8lekdIZvhq5Yr5PgGMhXLA+pDyDcZW16uc9IOrx+jH5BDsd2O7yWHm
         ghelUS3u3NfS8kswGuicH8As4jdxVzVRCEU33ZXLqWOn9mKGL8gnOgVcrKIjC+t0IH
         g/I0ZJOEQWIdikiO/ElekHWP1Af9JAjUjkOG0L393111vOu8NXHEU39ZGU3mCuugX6
         +kSdf1chH1sEw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8AE935C0611; Thu, 10 Jun 2021 09:57:10 -0700 (PDT)
Date:   Thu, 10 Jun 2021 09:57:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] rcu/doc: Add a quick quiz to explain further why we need
 smp_mb__after_unlock_lock()
Message-ID: <20210610165710.GT4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210610155029.130812-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610155029.130812-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 05:50:29PM +0200, Frederic Weisbecker wrote:
> Add some missing critical pieces of explanation to understand the need
> for full memory barriers throughout the whole grace period state machine,
> thanks to Paul's explanations.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>

Nice!!!  And not bad wording either, though I still could not resist the
urge to wordsmith further.  Plus I combined your two examples, in order to
provide a trivial example use of the polling interfaces, if nothing else.

Please let me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit f21b8fbdf9a59553da825265e92cedb639b4ba3c
Author: Frederic Weisbecker <frederic@kernel.org>
Date:   Thu Jun 10 17:50:29 2021 +0200

    rcu/doc: Add a quick quiz to explain further why we need smp_mb__after_unlock_lock()
    
    Add some missing critical pieces of explanation to understand the need
    for full memory barriers throughout the whole grace period state machine,
    thanks to Paul's explanations.
    
    Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
    Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
    Cc: Joel Fernandes <joel@joelfernandes.org>
    Cc: Uladzislau Rezki <urezki@gmail.com>
    Cc: Boqun Feng <boqun.feng@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 11cdab037bff..3cd5cb4d86e5 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -112,6 +112,35 @@ on PowerPC.
 The ``smp_mb__after_unlock_lock()`` invocations prevent this
 ``WARN_ON()`` from triggering.
 
++-----------------------------------------------------------------------+
+| **Quick Quiz**:                                                       |
++-----------------------------------------------------------------------+
+| But the whole chain of rcu_node-structure locking guarantees that     |
+| readers see all pre-grace-period accesses from the updater and        |
+| also guarantees that the updater to see all post-grace-period         |
+| accesses from the readers.  So why do we need all of those calls      |
+| to smp_mb__after_unlock_lock()?                                       |
++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Because we must provide ordering for RCU's polling grace-period       |
+| primitives, for example, get_state_synchronize_rcu() and              |
+| poll_state_synchronize_rcu().  For example:                           |
+|                                                                       |
+| CPU 0                                     CPU 1                       |
+| ----                                      ----                        |
+| WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)            |
+| g = get_state_synchronize_rcu()           smp_mb()                    |
+| while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)           |
+|         continue;                                                     |
+| r0 = READ_ONCE(Y)                                                     |
+|                                                                       |
+| RCU guarantees that that the outcome r0 == 0 && r1 == 0 will not      |
+| happen, even if CPU 1 is in an RCU extended quiescent state (idle     |
+| or offline) and thus won't interact directly with the RCU core        |
+| processing at all.                                                    |
++-----------------------------------------------------------------------+
+
 This approach must be extended to include idle CPUs, which need
 RCU's grace-period memory ordering guarantee to extend to any
 RCU read-side critical sections preceding and following the current
