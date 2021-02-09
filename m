Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AF4315667
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 20:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhBIS5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 13:57:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233277AbhBIRu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:50:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6E1864EB6;
        Tue,  9 Feb 2021 17:49:44 +0000 (UTC)
Date:   Tue, 9 Feb 2021 12:49:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] sched: Use SCHED_WARN_ON() instead of WARN_ON_ONCE()
 with CONFIG_SCHED_DEBUG
Message-ID: <20210209124943.4a97b1d2@gandalf.local.home>
In-Reply-To: <20210203095012.627-1-zbestahu@gmail.com>
References: <20210203095012.627-1-zbestahu@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Feb 2021 17:50:12 +0800
Yue Hu <zbestahu@gmail.com> wrote:

> From: Yue Hu <huyue2@yulong.com>
> 
> Since SCHED_WARN_ON() is provided as a wrapper for WARN_ON_ONCE().

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Peter, care to take this?

Also, looks like we can get rid of the #ifdef CONFIG_SCHED_DEBUG in
set_task_cpu() by replacing all the WARN_ON_ONCE() with SCHED_WARN_ON().

-- Steve


> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  kernel/sched/core.c | 2 +-
>  kernel/sched/rt.c   | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8c54810..8f1f345 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5347,7 +5347,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
>  int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
>  			  void *key)
>  {
> -	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~WF_SYNC);
> +	SCHED_WARN_ON(wake_flags & ~WF_SYNC);
>  	return try_to_wake_up(curr->private, mode, wake_flags);
>  }
>  EXPORT_SYMBOL(default_wake_function);
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 8f720b7..a90eab3 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -114,9 +114,7 @@ static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
>  
>  static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
>  {
> -#ifdef CONFIG_SCHED_DEBUG
> -	WARN_ON_ONCE(!rt_entity_is_task(rt_se));
> -#endif
> +	SCHED_WARN_ON(!rt_entity_is_task(rt_se));
>  	return container_of(rt_se, struct task_struct, rt);
>  }
>  

