Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8317367E20
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhDVJtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:49:19 -0400
Received: from foss.arm.com ([217.140.110.172]:49160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235824AbhDVJtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:49:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C691B11D4;
        Thu, 22 Apr 2021 02:48:41 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82AA53F774;
        Thu, 22 Apr 2021 02:48:39 -0700 (PDT)
Subject: Re: [PATCH 1/2] sched/fair: Filter out locally-unsolvable misfit
 imbalances
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
References: <20210415175846.494385-1-valentin.schneider@arm.com>
 <20210415175846.494385-2-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <519f7b86-851b-24f7-39aa-4bbdce5c7cd3@arm.com>
Date:   Thu, 22 Apr 2021 11:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210415175846.494385-2-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2021 19:58, Valentin Schneider wrote:

[...]

> Aggregate a misfit task's load into sgs->group_misfit_task_load only if
> env->dst_cpu would grant it a capacity uplift.
> 
> Note that the aforementioned capacity vs sgc->max_capacity comparison was
> meant to prevent misfit task downmigration: candidate groups classified as
> group_misfit_task but with a higher (max) CPU capacity than the destination CPU
> would be discarded. This change makes it so said group_misfit_task
> classification can't happen anymore, which may cause some undesired
> downmigrations.
> 
> Further tweak find_busiest_queue() to ensure this doesn't happen. 

Maybe you can describe shortly here what's the new mechanism is you
replace the old 'prevent misfit task downmigration' with.

Also note
> find_busiest_queue() can now iterate over CPUs with a higher capacity than
> the local CPU's, so add a capacity check there.

[...]

> +static inline void update_sg_lb_misfit_stats(struct lb_env *env,
> +					     struct sched_group *group,

Seems to be not used.

> +					     struct sg_lb_stats *sgs,
> +					     int *sg_status,
> +					     int cpu)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +
> +	if (!(env->sd->flags & SD_ASYM_CPUCAPACITY) ||
> +	    !rq->misfit_task_load)
> +		return;
> +
> +	*sg_status |= SG_OVERLOAD;
> +
> +	/*
> +	 * Don't attempt to maximize load for misfit tasks that can't be
> +	 * granted a CPU capacity uplift.
> +	 */
> +	if (cpu_capacity_greater(env->dst_cpu, cpu)) {
> +		sgs->group_misfit_task_load = max(
> +			sgs->group_misfit_task_load,
> +			rq->misfit_task_load);
> +	}
> +
> +}
> +

[...]

> @@ -9288,6 +9310,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  	if (!sds.busiest)
>  		goto out_balanced;
>  
> +	env->src_grp_type = busiest->group_type;

Maybe a short comment why you set it here in fbg(). It's only used later
in fbq() for asym. CPU capacity sd but is set unconditionally.

[...]
