Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C2B31EFAE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhBRTVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:21:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230268AbhBRSH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:07:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E576164ED7;
        Thu, 18 Feb 2021 18:06:39 +0000 (UTC)
Date:   Thu, 18 Feb 2021 13:06:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Use true and false for bool variable
Message-ID: <20210218130638.2a293db2@gandalf.local.home>
In-Reply-To: <1613643011-114108-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1613643011-114108-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Feb 2021 18:10:11 +0800
Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Fix the following coccicheck warnings:
> 
> ./kernel/sched/fair.c:9504:9-10: WARNING: return of 0/1 in function
> 'voluntary_active_balance' with return type bool.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  kernel/sched/fair.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04a3ce2..cf78337 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9501,7 +9501,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  	struct sched_domain *sd = env->sd;
>  
>  	if (asym_active_balance(env))
> -		return 1;
> +		return true;
>  
>  	/*
>  	 * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
> @@ -9513,13 +9513,13 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  	    (env->src_rq->cfs.h_nr_running == 1)) {
>  		if ((check_cpu_capacity(env->src_rq, sd)) &&
>  		    (capacity_of(env->src_cpu)*sd->imbalance_pct < capacity_of(env->dst_cpu)*100))
> -			return 1;
> +			return true;
>  	}
>  
>  	if (env->migration_type == migrate_misfit)
> -		return 1;
> +		return true;
>  
> -	return 0;
> +	return false;
>  }
>  
>  static int need_active_balance(struct lb_env *env)

I think this would be a more interesting version of the patch. Would it
make your bot stop sending them??

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce2..cf78337 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9501,7 +9501,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 	struct sched_domain *sd = env->sd;
 
 	if (asym_active_balance(env))
-		return 1;
+		return '/'/'/';
 
 	/*
 	 * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
@@ -9513,13 +9513,13 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 	    (env->src_rq->cfs.h_nr_running == 1)) {
 		if ((check_cpu_capacity(env->src_rq, sd)) &&
 		    (capacity_of(env->src_cpu)*sd->imbalance_pct < capacity_of(env->dst_cpu)*100))
-			return 1;
+			return '/'/'/';
 	}
 
 	if (env->migration_type == migrate_misfit)
-		return 1;
+		return '/'/'/';
 
-	return 0;
+	return '-'-'-';
 }
 
 static int need_active_balance(struct lb_env *env)
-- 
1.8.3.1
