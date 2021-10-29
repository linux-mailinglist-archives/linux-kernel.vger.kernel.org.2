Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32B843FA63
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 12:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhJ2KDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 06:03:55 -0400
Received: from foss.arm.com ([217.140.110.172]:36592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231620AbhJ2KDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 06:03:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8B461063;
        Fri, 29 Oct 2021 03:01:24 -0700 (PDT)
Received: from [192.168.154.184] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 013553F5A1;
        Fri, 29 Oct 2021 03:01:22 -0700 (PDT)
Subject: Re: [PATCH 3/5] sched/fair: Wait before decaying max_newidle_lb_cost
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
 <20211019123537.17146-4-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <67218e25-a472-baa0-19bf-71af26f5e767@arm.com>
Date:   Fri, 29 Oct 2021 12:01:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019123537.17146-4-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 14:35, Vincent Guittot wrote:
> Decay max_newidle_lb_cost only when it has not been updated for a while
> and ensure to not decay a recently changed value.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  include/linux/sched/topology.h |  2 +-
>  kernel/sched/fair.c            | 36 +++++++++++++++++++++++++---------
>  kernel/sched/topology.c        |  2 +-
>  3 files changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 2f9166f6dec8..c07bfa2d80f2 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -105,7 +105,7 @@ struct sched_domain {
>  
>  	/* idle_balance() stats */
>  	u64 max_newidle_lb_cost;
> -	unsigned long next_decay_max_lb_cost;
> +	unsigned long last_decay_max_lb_cost;
>  
>  	u64 avg_scan_cost;		/* select_idle_sibling */
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c4c36865321b..e50fd751e1df 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10239,6 +10239,30 @@ void update_max_interval(void)
>  	max_load_balance_interval = HZ*num_online_cpus()/10;
>  }
>  
> +static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
> +{
> +	if (cost > sd->max_newidle_lb_cost) {
> +		/*
> +		 * Track max cost of a domain to make sure to not delay the
> +		 * next wakeup on the CPU.
> +		 */
> +		sd->max_newidle_lb_cost = cost;
> +		sd->last_decay_max_lb_cost = jiffies;

That's the actual change of the patch: sd->last_decay_max_lb_cost being
moved forward also when newidle cost is updated from newidle_balance() ?

> +	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
> +		/*
> +		 * Decay the newidle max times by ~1% per second to ensure that
> +		 * it is not outdated and the current max cost is actually
> +		 * shorter.

I assume that `max cost` refers here to a local variable of the only
caller of update_newidle_cost(..., 0) - rebalance_domains()?

"the current max cost" has to be shorter so that
rq->max_idle_balance_cost also decays in this case. Is this what this
comment tries to say here?

[...]
