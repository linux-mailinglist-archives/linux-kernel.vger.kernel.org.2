Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB4043D76D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 01:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhJ0XXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 19:23:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhJ0XXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:23:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B0E861073;
        Wed, 27 Oct 2021 23:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635376840;
        bh=k51HWgvuPMXlDX7Sellc5w3QqqhkKNP2bx5vba1UD9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OGhC4wFjIl4sCZZdbPpuWrUnoc9Da8pN9FkT7U0YSKu4kTthujnEd+ijBwiSGHsEL
         Dd1XY1TiNu6CHhjz9UZ0wwk6hSK01Ak4K05yDlZhqzKBCocif1EUe+IeGgq33hV1k6
         /qhLJaFVeJFVnylannrAUab3kQ3P6xi0E7NmYiDxTfkGAmec2E/B8/4dXeuAs4WbVv
         r6YYKpzqamwGFvG6CTq2Rl0z8r8q6SpWrRrD6+wBfWR/Ad4k11DU0nx6o3QJ54iBsf
         DlG3s0nuhHJ24LGcz8Omb5GGIHrxW9Yv4qF3s2ylFQPTdl2A4XVido1pbSUnl9Oygf
         wQQOVfJ8CXUpQ==
Date:   Thu, 28 Oct 2021 01:20:38 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH 1/2] sched: isolation: cpu isolation handles for cpuset
Message-ID: <20211027232038.GB73746@lothringen>
References: <20211027204319.22697-1-paul.gortmaker@windriver.com>
 <20211027204319.22697-2-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027204319.22697-2-paul.gortmaker@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 04:43:18PM -0400, Paul Gortmaker wrote:
> Assuming we want to drive isolation from cpuset and not something
> like /sys/devices/system/cpu/cpu*/hotplug/isolation then we'll
> need some kind of handle for cpuset to drive it from.
> 
> These would also serve as a collection point for all the isolation
> related operations - current and future.  While only RCU nocb toggle
> is currently deployed, I've left some guesses at what is probably to
> come in the future.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> [PG: RFC code - not for merge]
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  include/linux/sched/isolation.h |  4 ++++
>  kernel/sched/isolation.c        | 22 ++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index cc9f393e2a70..3ab9c667c441 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -25,6 +25,8 @@ extern bool housekeeping_enabled(enum hk_flags flags);
>  extern void housekeeping_affine(struct task_struct *t, enum hk_flags flags);
>  extern bool housekeeping_test_cpu(int cpu, enum hk_flags flags);
>  extern void __init housekeeping_init(void);
> +extern void isolate_cpu(int cpu);
> +extern void deisolate_cpu(int cpu);

I first read "desolate_cpu()". That gives me ideas to rename nohz_full.

>  
>  #else
>  
> @@ -46,6 +48,8 @@ static inline bool housekeeping_enabled(enum hk_flags flags)
>  static inline void housekeeping_affine(struct task_struct *t,
>  				       enum hk_flags flags) { }
>  static inline void housekeeping_init(void) { }
> +static void isolate_cpu(int cpu) { }
> +static void deisolate_cpu(int cpu) { }
>  #endif /* CONFIG_CPU_ISOLATION */
>  
>  static inline bool housekeeping_cpu(int cpu, enum hk_flags flags)
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 7f06eaf12818..57b105d42632 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -63,6 +63,28 @@ bool housekeeping_test_cpu(int cpu, enum hk_flags flags)
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
>  
> +void isolate_cpu(int cpu)
> +{
> +	pr_info("Isolating core %d\n", cpu);
> +	if (rcu_nocb_cpu_offload(cpu))
> +		pr_warn("RCU; unable to nocb offload CPU %d\n", cpu);
> +#if 0	/* TODO */
> +	housekeeping_clear_cpu(cpu);
> +	tick_nohz_full_add_cpus_to(cpumask_of(cpu));
> +#endif
> +}
> +
> +void deisolate_cpu(int cpu)
> +{
> +	pr_info("Deisolating core %d\n", cpu);
> +#if 0	/* TODO */
> +	tick_nohz_full_clear_cpus_from(cpumask_of(cpu));
> +	housekeeping_add_cpu(cpu);
> +#endif
> +	if (rcu_nocb_cpu_deoffload(cpu))
> +		pr_warn("RCU: unable to nocb reload CPU %d\n", cpu);
> +}

In my series I'm eventually splitting housekeeping cpumasks so that we
can modify HK_FLAG_RCU without modifying the others.

Thanks.

> +
>  void __init housekeeping_init(void)
>  {
>  	if (!housekeeping_flags)
> -- 
> 2.15.0
> 
