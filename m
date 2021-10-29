Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4608543FA66
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 12:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhJ2KE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 06:04:29 -0400
Received: from foss.arm.com ([217.140.110.172]:36622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231620AbhJ2KEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 06:04:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C0361FB;
        Fri, 29 Oct 2021 03:01:57 -0700 (PDT)
Received: from [192.168.154.184] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F6D43F5A1;
        Fri, 29 Oct 2021 03:01:54 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] sched/fair: Remove sysctl_sched_migration_cost
 condition
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
 <20211019123537.17146-5-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2fb13962-0432-2e36-26e6-d05534464294@arm.com>
Date:   Fri, 29 Oct 2021 12:01:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019123537.17146-5-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 14:35, Vincent Guittot wrote:
> With a default value of 500us, sysctl_sched_migration_cost is
> significanlty higher than the cost of load_balance. Remove the

Shouldn't this be rather `load balance cost on the lowest sd`? I assume
here that lb cost stands for sd->max_newidle_lb_cost of the 1st sd.

We still use sysctl_sched_migration_cost as a floor against max_cost
(i.e. lb cost of all sd's) when setting rq->max_idle_balance_cost in
rebalance_domains().

And in the add-on discussion (disabling the call to
nohz_newidle_balance() you mention that sd->max_newidle_lb_cost can be
higher than sysctl_sched_migration_cost (even when default 500us).


> condition and rely on the sd->max_newidle_lb_cost to abort
> newidle_balance.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e50fd751e1df..57eae0ebc492 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10895,8 +10895,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	rcu_read_lock();
>  	sd = rcu_dereference_check_sched_domain(this_rq->sd);
>  
> -	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
> -	    !READ_ONCE(this_rq->rd->overload) ||
> +	if (!READ_ONCE(this_rq->rd->overload) ||
>  	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>  
>  		if (sd)
> 

