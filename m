Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A8931D156
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 21:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBPUBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 15:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhBPUBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 15:01:21 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4E5C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 12:00:41 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id g24so5439574qts.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 12:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QkCbXEfKtFtgbOsaV9Lm7/VvN2N858cnNZqv/n/FBeQ=;
        b=THm5ETw9RqjuU1mItgn3Lg74soiD8NifKR0pYacXdspEOoFHVb9OslcWxLT+zy6nya
         laQzK38GQZe+ZO0SoUjz//up/w9UR6pm7Lw+VmHL3RhXs7Pa0g2jvcF1D1+LCDfWHKzy
         x0/tQZ2L8UJluGbMxc1VXiaGmZDCY0426qd3qn+qFSZ0kUagBoxAYBRGDDX0GPxxOodm
         OtwTeNr1W9yLu2bPSSLPH+fz983fHEy7OsjcI1svtxMN9C7DAZx8QS9jXXpf/z+Kaec+
         11sn0Frx05zHx9SOtUtTQsITg0Da648BSShyv+Qpht4jBE4ogzgIwPLu6jhWAx29PBg7
         FJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QkCbXEfKtFtgbOsaV9Lm7/VvN2N858cnNZqv/n/FBeQ=;
        b=jzlAK1VwTVRjqUyDDoJ81vH3alPZmKGEtIyUmjXWR39k//T7LvgYEnLVuCGXctKQyS
         OC1BntcPaj3ggL28xniyldcZC/1Gojdj+WFPautLNzRN0SgdTERYc+8rnMVi6J9V3fCl
         om3NvP/+HiTfwQI4X6EiXEponJ4HwbOhvE4HP/M3GAX8z96qMlyapNoggw3horRxoGHf
         hPozweX4cN9LkIkj19Dit3FxdHr/AiXm3+joliNr0ezmkGUrIYiRLsoukQBtiMDYtXGd
         pRkLjvZWPbPNCIaSnJr4PSArTdqywcQRFepFU+g6FexPg4vb4hMg1NCr31XMsiByCZmy
         rxrg==
X-Gm-Message-State: AOAM532e7qiCPmLkxbVt2yHU1HXIljUfFreOD+/RoEeIJ/qj9R8A5gIj
        AnNTikhnRlJdMxzt+hqmLjLIRw==
X-Google-Smtp-Source: ABdhPJzZuuEdtS7YQcGzZpfBZcfZf/bo9QF+4FRcPkHmJV5nKfWNkDqYCFItzlXFK0dT+YJV6YcGQA==
X-Received: by 2002:a05:622a:2c6:: with SMTP id a6mr20518205qtx.375.1613505640490;
        Tue, 16 Feb 2021 12:00:40 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id x63sm15258380qkb.22.2021.02.16.12.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 12:00:39 -0800 (PST)
Date:   Tue, 16 Feb 2021 15:00:39 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH] psi: Optimize task switch inside shared cgroups
Message-ID: <YCwkZ+UwDzQVXUyc@cmpxchg.org>
References: <20210209071413.17097-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209071413.17097-1-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chengming,

This patch looks useful to me. A couple of comments below:

On Tue, Feb 09, 2021 at 03:14:13PM +0800, Chengming Zhou wrote:
> The commit 36b238d57172 ("psi: Optimize switching tasks inside shared
> cgroups") only update cgroups whose state actually changes during a
> task switch only in task preempt case, not in task sleep case.
> 
> We actually don't need to clear and set TSK_ONCPU state for common cgroups
> of next and prev task in sleep case, that can save many psi_group_change
> especially when most activity comes from one leaf cgroup.

Can you please make this a bit more concrete? Maybe include this:

sleep before:
psi_dequeue()
  while ((group = iterate_groups(prev)))			# all ancestors
    psi_group_change(prev, .clear=TSK_RUNNING|TSK_ONCPU)
psi_task_switch()
  while ((group = iterate_groups(next)))			# all ancestors
    psi_group_change(next, .set=TSK_ONCPU)

sleep after:
psi_dequeue()
  nop
psi_task_switch()
  while ((group = iterate_groups(next)))			# until (prev & next)
    psi_group_change(next, .set=TSK_ONCPU)
  while ((group = iterate_groups(prev)))			# all ancestors
    psi_group_change(prev, .clear = common ? TSK_RUNNING : TSK_RUNNING|TSK_ONCPU)

When a voluntary sleep switches to another task, we remove one call of
psi_group_change() for every common cgroup ancestor of the two tasks.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/psi.c   | 27 +++++++++++++++++----------
>  kernel/sched/stats.h | 17 +++--------------
>  2 files changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 6e46d9eb279b..6061e87089ac 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -836,20 +836,27 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		}
>  	}
>  
> -	/*
> -	 * If this is a voluntary sleep, dequeue will have taken care
> -	 * of the outgoing TSK_ONCPU alongside TSK_RUNNING already. We
> -	 * only need to deal with it during preemption.
> -	 */
> -	if (sleep)
> -		return;
> -
>  	if (prev->pid) {
> -		psi_flags_change(prev, TSK_ONCPU, 0);
> +		int clear = 0, set = 0;
> +
> +		if (sleep) {
> +			clear |= TSK_RUNNING;
> +			if (prev->in_iowait)
> +				set |= TSK_IOWAIT;
> +		}

This needs a comment why it's doing psi_dequeue()'s job. How about this?

		/*
		 * When we're going to sleep, psi_dequeue() lets us handle
		 * TSK_RUNNING and TSK_IOWAIT here, where we can combine it
		 * with TSK_ONCPU and save walking common ancestors twice.
		 */
		if (sleep) {
			...

> +		psi_flags_change(prev, clear | TSK_ONCPU, set);
>  
>  		iter = NULL;
>  		while ((group = iterate_groups(prev, &iter)) && group != common)
> -			psi_group_change(group, cpu, TSK_ONCPU, 0, true);
> +			psi_group_change(group, cpu, clear | TSK_ONCPU, set, true);
> +
> +		if (sleep) {
> +			while (group) {
> +				psi_group_change(group, cpu, clear, set, true);
> +				group = iterate_groups(prev, &iter);
> +			}
> +		}

This function is *primarily* about handling TSK_ONCPU and secondarily
optimizes the dequeue. It would be a bit clearer to do:

	int clear = TSK_ONCPU, set = 0;

	...

	/*
	 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
	 * with dequeuing too, finish that for the rest of the hierarchy.
	 */
	if (sleep) {
		clear &= TSK_ONCPU;
		for (; group; group = iterate_groups(prev, &iter))
			psi_group_change(group, cpu, clear, set, true);			
	}


> diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
> index 9e4e67a94731..2d92c8467678 100644
> --- a/kernel/sched/stats.h
> +++ b/kernel/sched/stats.h
> @@ -84,28 +84,17 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
>  
>  static inline void psi_dequeue(struct task_struct *p, bool sleep)
>  {
> -	int clear = TSK_RUNNING, set = 0;
> -
>  	if (static_branch_likely(&psi_disabled))
>  		return;
>  
>  	if (!sleep) {
> +		int clear = TSK_RUNNING;
> +
>  		if (p->in_memstall)
>  			clear |= TSK_MEMSTALL;
> -	} else {
> -		/*
> -		 * When a task sleeps, schedule() dequeues it before
> -		 * switching to the next one. Merge the clearing of
> -		 * TSK_RUNNING and TSK_ONCPU to save an unnecessary
> -		 * psi_task_change() call in psi_sched_switch().
> -		 */
> -		clear |= TSK_ONCPU;
>  
> -		if (p->in_iowait)
> -			set |= TSK_IOWAIT;
> +		psi_task_change(p, clear, 0);
>  	}

Likewise, this really should have a comment for why it's not handling
TSK_RUNNING to match psi_enqueue()!

	int clear = TSK_RUNNING;

	/*
	 * A voluntary sleep is a dequeue followed by a task switch. To
	 * avoid walking all ancestors twice, psi_task_switch() handles
	 * TSK_RUNNING and TSK_IOWAIT for us when it moves TSK_ONCPU.
	 * Do nothing here.
	 */
	 if (sleep)
		return;

	if (p->in_memstall)
		clear |= TSK_MEMSTALL;

	psi_task_change(p, clear, 0);
	
Thanks
