Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0D23F8C08
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 18:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243055AbhHZQZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 12:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243044AbhHZQZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:25:04 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DE4C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 09:24:16 -0700 (PDT)
Date:   Fri, 27 Aug 2021 00:24:58 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629995053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eeA/EblnvWIy9V7dZ552OXTY1UGszfZzpi/NUgGy4SU=;
        b=mjWiEZgVq4SEQTk+Zop2fdzgYirnncPUw/G7ra2npWRudz5plazHu9a7zPziB4Jqoh+XOe
        MWFvwDJrn5wFWG94sKLJqLBU1LmIIv9AOYdntDz3Wkk3cjSFep7InIh6h7Z0g1PZbv40Ww
        QMOu9pgBJM4NQ0RLXEbon/+VMea7/8k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, tao.zhou@linux.dev
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched: Fix get_push_task() vs migrate_disable()
Message-ID: <YSfAWkWvd+4MJcvu@geo.homenetwork>
References: <20210826133738.yiotqbtdaxzjsnfj@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826133738.yiotqbtdaxzjsnfj@linutronix.de>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Thu, Aug 26, 2021 at 03:37:38PM +0200, Sebastian Andrzej Siewior wrote:

> push_rt_task() attempts to move the currently running task away if the
> next runnable task has migration disabled and therefore is pinned on the
> current CPU.
> 
> The current task is retrieved via get_push_task() which only checks for
> nr_cpus_allowed == 1, but does not check whether the task has migration
> disabled and therefore cannot be moved either. The consequence is a
> pointless invocation of the migration thread which correctly observes
> that the task cannot be moved.
> 
> Return NULL if the task has migration disabled and cannot be moved to
> another CPU.
> 
> Fixes: a7c81556ec4d3 ("sched: Fix migrate_disable() vs rt/dl balancing")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/sched/sched.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e205b63d6db07..32a4945730a9b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2259,6 +2259,9 @@ static inline struct task_struct *get_push_task(struct rq *rq)
>  	if (p->nr_cpus_allowed == 1)
>  		return NULL;
>  
> +	if (p->migration_disabled)
> +		return NULL;

Not much I can restore here..

Is is_migration_disabled(p) be more correct to check migration disable.
And get_push_task() being called in pull_rt_task() has checked migration
disable first and then call get_push_task(). That means this check in
get_push_task() in patch is a second repeatly check.

>  	rq->push_busy = true;
>  	return get_task_struct(p);
>  }
> -- 
> 2.33.0
> 



Thanks,
Tao
