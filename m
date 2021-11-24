Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE8B45C6F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352675AbhKXOQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:16:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350768AbhKXOQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:16:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A13B6140D;
        Wed, 24 Nov 2021 14:13:18 +0000 (UTC)
Date:   Wed, 24 Nov 2021 09:13:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Aili Yao <yaoaili126@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org,
        yaoaili@kingsoft.com
Subject: Re: [PATCH] sched/isolation: delete redundant
 housekeeping_overridden check
Message-ID: <20211124091316.5259d22f@gandalf.local.home>
In-Reply-To: <20211124154214.43972a31@gmail.com>
References: <20211123154535.48be4399@gmail.com>
        <20211123123852.11a84a9e@gandalf.local.home>
        <20211124092103.64e93376@gmail.com>
        <20211123204200.0976e065@rorschach.local.home>
        <20211124154214.43972a31@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 15:42:14 +0800
Aili Yao <yaoaili126@gmail.com> wrote:

> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> ---
>  include/linux/sched/isolation.h | 9 ++-------
>  kernel/sched/isolation.c        | 4 ++--
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index cc9f393e2a70..3ccc19e52186 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -23,9 +23,8 @@ extern int housekeeping_any_cpu(enum hk_flags flags);
>  extern const struct cpumask *housekeeping_cpumask(enum hk_flags flags);
>  extern bool housekeeping_enabled(enum hk_flags flags);
>  extern void housekeeping_affine(struct task_struct *t, enum hk_flags flags);
> -extern bool housekeeping_test_cpu(int cpu, enum hk_flags flags);
> +extern bool housekeeping_cpu(int cpu, enum hk_flags flags);

Now you added an unneeded function call (which is also expensive).

There's a reason the static_branch was inlined.

-- Steve

>  extern void __init housekeeping_init(void);
> -
>  #else
>  
>  static inline int housekeeping_any_cpu(enum hk_flags flags)
> @@ -46,15 +45,11 @@ static inline bool housekeeping_enabled(enum hk_flags flags)
>  static inline void housekeeping_affine(struct task_struct *t,
>  				       enum hk_flags flags) { }
>  static inline void housekeeping_init(void) { }
> -#endif /* CONFIG_CPU_ISOLATION */
>  
>  static inline bool housekeeping_cpu(int cpu, enum hk_flags flags)
>  {
> -#ifdef CONFIG_CPU_ISOLATION
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		return housekeeping_test_cpu(cpu, flags);
> -#endif
>  	return true;
>  }
> +#endif /* CONFIG_CPU_ISOLATION */
>  
>  #endif /* _LINUX_SCHED_ISOLATION_H */
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 7f06eaf12818..b5e81df4b04a 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -54,14 +54,14 @@ void housekeeping_affine(struct task_struct *t, enum hk_flags flags)
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_affine);
>  
> -bool housekeeping_test_cpu(int cpu, enum hk_flags flags)
> +bool housekeeping_cpu(int cpu, enum hk_flags flags)
>  {
>  	if (static_branch_unlikely(&housekeeping_overridden))
>  		if (housekeeping_flags & flags)
>  			return cpumask_test_cpu(cpu, housekeeping_mask);
>  	return true;
>  }
> -EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
> +EXPORT_SYMBOL_GPL(housekeeping_cpu);
