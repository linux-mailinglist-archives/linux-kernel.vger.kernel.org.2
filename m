Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3053A3A403F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhFKKgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230251AbhFKKgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:36:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEDF3613DE;
        Fri, 11 Jun 2021 10:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623407675;
        bh=Sv3Iu1ZCUTH4DacQZchxrXVJQeGtFx7vcCh45cHyi68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tptOtbVH0JVxOchi+QGUFUp229gpIOikem0QXey8QjdHySZu4flQerdcNNX0TnIrd
         d4R7MaXvVnFs2TlZ+/SHjVP2EyR7fj7shXZnL1H9rl9NynAsLy9U5OY1hKMRNd61Yd
         /S0cWeL1tF64s3Pc5RUQYNojwhFQfCA16C/tY3qfzQaBx2AABRNLXzil31cYBrsn/V
         r1PgEqN3hpUtNeMQBPinqNxXU982QxxTr9HNwbZZx2np9wnEUWn2bv31INlpXDj1ox
         C0CSzEk7EhBxGWkqU3KWqT8Uga7hB5oPKHAKI84kt5nZfsQYLYuq8s3ebathQRXPaT
         75MLNj2hKGPag==
Date:   Fri, 11 Jun 2021 12:34:32 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] rcu/doc: Add a quick quiz to explain further why we need
 smp_mb__after_unlock_lock()
Message-ID: <20210611103432.GA143096@lothringen>
References: <20210610155029.130812-1-frederic@kernel.org>
 <20210610165710.GT4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610165710.GT4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 09:57:10AM -0700, Paul E. McKenney wrote:
> diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> index 11cdab037bff..3cd5cb4d86e5 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> @@ -112,6 +112,35 @@ on PowerPC.
>  The ``smp_mb__after_unlock_lock()`` invocations prevent this
>  ``WARN_ON()`` from triggering.
>  
> ++-----------------------------------------------------------------------+
> +| **Quick Quiz**:                                                       |
> ++-----------------------------------------------------------------------+
> +| But the whole chain of rcu_node-structure locking guarantees that     |
> +| readers see all pre-grace-period accesses from the updater and        |
> +| also guarantees that the updater to see all post-grace-period         |

Should it be either "that the updater see" or "the updater to see"?

> +| accesses from the readers.

Is it really post-grace-period that you meant here? The updater can't see
the future. It's rather all reader accesses before the end of the grace period?

>  So why do we need all of those calls      |
> +| to smp_mb__after_unlock_lock()?                                       |
> ++-----------------------------------------------------------------------+
> +| **Answer**:                                                           |
> ++-----------------------------------------------------------------------+
> +| Because we must provide ordering for RCU's polling grace-period       |
> +| primitives, for example, get_state_synchronize_rcu() and              |
> +| poll_state_synchronize_rcu().  For example:                           |

Two times "for example" (sorry I'm nitpicking...)

> +|                                                                       |
> +| CPU 0                                     CPU 1                       |
> +| ----                                      ----                        |
> +| WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)            |
> +| g = get_state_synchronize_rcu()           smp_mb()                    |
> +| while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)           |
> +|         continue;                                                     |
> +| r0 = READ_ONCE(Y)                                                     |

Good point, it's a nice merge of the initial examples!

> +|                                                                       |
> +| RCU guarantees that that the outcome r0 == 0 && r1 == 0 will not      |

One "that" has to die here.

> +| happen, even if CPU 1 is in an RCU extended quiescent state (idle     |
> +| or offline) and thus won't interact directly with the RCU core        |
> +| processing at all.                                                    |

Thanks a lot!

> ++-----------------------------------------------------------------------+
> +
>  This approach must be extended to include idle CPUs, which need
>  RCU's grace-period memory ordering guarantee to extend to any
>  RCU read-side critical sections preceding and following the current
