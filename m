Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EC73BDBA7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 18:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhGFQsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 12:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229773AbhGFQsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:48:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B264B6141C;
        Tue,  6 Jul 2021 16:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625589971;
        bh=cxIj3CzvYTLOvEpXHb0tmcp6J0NLoUQL46n72iJcSXU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GtNDWMvk0ePwRzNsWC1jI0tguNtTJheKtIJF/M1NtPFQ+guFk/0yWRozHt6ylam61
         ZMY3YERzoxMiQdLrfVz3rT7MWfzlMCVKTnDgbmIKRw9Pc4CJxxIX6S78aRChsAKELq
         nAPcKxMeXtFMnGVcZ28Avkk5EMlhknE/vbunl4aZeMNFbvlGQ1bFN5jA15ptzY8s7t
         xvDf3SlKhC7znQeDDjhctkk8WSnHENeYd22oE7UJVzukbzWMzT+Kt+duN4We/PB0MZ
         VQYuoZzZj9XOQlOfUetE47uLiBU5PjklixBDU57paWzdxaA49TWnv423JEKyRiwJa8
         ZCZm4cNmUaEOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 888795C016B; Tue,  6 Jul 2021 09:46:11 -0700 (PDT)
Date:   Tue, 6 Jul 2021 09:46:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/2] rcu: Explain why rcu_all_qs() is a stub in
 preemptible TREE RCU
Message-ID: <20210706164611.GD4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210705234344.104239-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705234344.104239-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 01:43:43AM +0200, Frederic Weisbecker wrote:
> cond_resched() reports an RCU quiescent state only in non-preemptible
> TREE RCU implementation. Provide an explanation for the different
> behaviour in CONFIG_PREEMPT_RCU=y.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/sched/core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index cf16f8fda9a6..db374cb38eb2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7780,6 +7780,19 @@ int __sched __cond_resched(void)
>  		preempt_schedule_common();
>  		return 1;
>  	}
> +	/*
> +	 * A process spending a long time in the kernel space might
> +	 * have too few opportunities to report quiescent states
> +	 * when CONFIG_PREEMPT_RCU=n because then the tick can't know
> +	 * if it's interrupting an RCU read side critical section. In the
> +	 * absence of voluntary sleeps, the last resort resides in tracking
> +	 * calls to cond_resched() which always imply quiescent states.
> +	 *
> +	 * On the other hand, preemptible RCU has a real RCU read side
> +	 * tracking that allows the tick for reporting interrupted quiescent
> +	 * states or, in the worst case, deferred quiescent states after
> +	 * rcu_read_unlock().
> +	 */
>  #ifndef CONFIG_PREEMPT_RCU
>  	rcu_all_qs();
>  #endif

Looks like a good addition!  I have wordsmithed the comment and
commit log a bit.  If Peter wants to take either version of this:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

In the meantime, I have queued it for v5.15.

							Thanx, Paul

------------------------------------------------------------------------

commit 41a95363ac9f020cc0e4fcc4b73015c60b6620f0
Author: Frederic Weisbecker <frederic@kernel.org>
Date:   Tue Jul 6 01:43:43 2021 +0200

    rcu: Explain why rcu_all_qs() is a stub in preemptible TREE RCU
    
    The cond_resched() function reports an RCU quiescent state only in
    non-preemptible TREE RCU implementation.  This commit therefore adds a
    comment explaining why cond_resched() does nothing in preemptible kernels.
    
    Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
    Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
    Cc: Joel Fernandes <joel@joelfernandes.org>
    Cc: Uladzislau Rezki <urezki@gmail.com>
    Cc: Boqun Feng <boqun.feng@gmail.com>
    Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
    Cc: Ingo Molnar <mingo@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cf16f8fda9a6..eae24fdf3820 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7780,6 +7780,17 @@ int __sched __cond_resched(void)
 		preempt_schedule_common();
 		return 1;
 	}
+	/*
+	 * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
+	 * whether the current CPU is in an RCU read-side critical section,
+	 * so the tick can report quiescent states even for CPUs looping
+	 * in kernel context.  In contrast, in non-preemptible kernels,
+	 * RCU readers leave no in-memory hints, which means that CPU-bound
+	 * processes executing in kernel context might never report an
+	 * RCU quiescent state.  Therefore, the following code causes
+	 * cond_resched() to report a quiescent state, but only when RCU
+	 * is in urgent need of one.
+	 */
 #ifndef CONFIG_PREEMPT_RCU
 	rcu_all_qs();
 #endif
