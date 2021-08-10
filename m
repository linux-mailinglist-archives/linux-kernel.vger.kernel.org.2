Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036183E190A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242923AbhHEQEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242898AbhHEQDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:03:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74E2F61158;
        Thu,  5 Aug 2021 16:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628179417;
        bh=z3+3rHbh3BGe8m3lIRaEQE45M23IAVa/0uDCSTyuS9Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qxffhPfPWkkKtO9v3hwPjRjOBZ6aQMH/o/pQlAAfBIK527+gjaA2hzYs9VjJnp/M7
         hv9dqoO8r9UDmnJGCZtpOU7MCzG5w5nK+Ol4Mvi5mzTr+4LrPIPStww10op79i+c04
         3O63FVWMvQ4OV3cjU6AmJhmTPXw3KgRU/NdBYp5JMW+SDpFsu06o8Nu7+hIvxUz9/Q
         JDqAGvBZmOa0nr7uOc7l/PgzRpltMij91d8XDrjkMFKv7jrLvAZ3f/llzwQl51JfUK
         7uYHrNgJVa7l1IQLV9DdHxRwGR+pg1UOr0PqhDI2+C5HAUVj7lPHqOsLSUvohxty4J
         6yto/LUXf20fQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 375555C098A; Thu,  5 Aug 2021 09:03:37 -0700 (PDT)
Date:   Thu, 5 Aug 2021 09:03:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Make rcu_normal_after_boot writable on RT
Message-ID: <20210805160337.GI4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210805080123.16320-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805080123.16320-1-juri.lelli@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 10:01:23AM +0200, Juri Lelli wrote:
> Certain configurations (e.g., systems that make heavy use of netns)
> need to use synchronize_rcu_expedited() to service RCU grace periods
> even after boot.
> 
> Even though synchronize_rcu_expedited() has been traditionally
> considered harmful for RT for the heavy use of IPIs, it is perfectly
> usable under certain conditions (e.g. nohz_full).
> 
> Make rcupdate.rcu_normal_after_boot= again writeable on RT, but keep
> its default value to 1 (enabled) to avoid regressions. Users who need
> synchronize_rcu_expedited() will boot with rcupdate.rcu_normal_after_
> boot=0 in the kernel cmdline.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Makes sense to me!

But would another of the -rt people be willing to give an Acked-by?
For example, maybe they would prefer this kernel boot parameter to be
exposed only if (!PREEMPT_RT || NO_HZ_FULL).  Or are there !NO_HZ_FULL
situations where rcu_normal_after_boot makes sense?

							Thanx, Paul

> ---
>  kernel/rcu/update.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index c21b38cc25e9..0fdbf937edac 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -57,9 +57,7 @@
>  module_param(rcu_expedited, int, 0);
>  module_param(rcu_normal, int, 0);
>  static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
> -#ifndef CONFIG_PREEMPT_RT
>  module_param(rcu_normal_after_boot, int, 0);
> -#endif
>  #endif /* #ifndef CONFIG_TINY_RCU */
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> -- 
> 2.31.1
> 
