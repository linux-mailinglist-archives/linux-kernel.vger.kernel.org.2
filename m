Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9AF3150BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhBINsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:48:35 -0500
Received: from foss.arm.com ([217.140.110.172]:51940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231694AbhBINqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:46:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62DA6106F;
        Tue,  9 Feb 2021 05:46:09 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1327F3F73D;
        Tue,  9 Feb 2021 05:46:06 -0800 (PST)
Subject: Re: [PATCH 4/6] sched/fair: reorder newidle_balance pulled_task test
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, fweisbec@gmail.com,
        tglx@linutronix.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org
Cc:     qais.yousef@arm.com
References: <20210205114830.781-1-vincent.guittot@linaro.org>
 <20210205114830.781-5-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4ab3693c-615d-6ef0-f4b3-0f01b820b826@arm.com>
Date:   Tue, 9 Feb 2021 14:46:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205114830.781-5-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2021 12:48, Vincent Guittot wrote:
> Reorder the tests and skip prevent useless test when no load balance has
> been performed.

LGTM.

But IMHO the reason why those two if conditions can be skipped for the
'goto out' path is that we don't release the rq lock rather the actual
lb. Might be worth saying this in the patch header? It's already
mentioned on top of the first if condition though.

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c587af230010..935594cd5430 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10592,7 +10592,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	if (curr_cost > this_rq->max_idle_balance_cost)
>  		this_rq->max_idle_balance_cost = curr_cost;
>  
> -out:
>  	/*
>  	 * While browsing the domains, we released the rq lock, a task could
>  	 * have been enqueued in the meantime. Since we're not going idle,
> @@ -10601,14 +10600,15 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	if (this_rq->cfs.h_nr_running && !pulled_task)
>  		pulled_task = 1;
>  
> -	/* Move the next balance forward */
> -	if (time_after(this_rq->next_balance, next_balance))
> -		this_rq->next_balance = next_balance;
> -
>  	/* Is there a task of a high priority class? */
>  	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
>  		pulled_task = -1;
>  
> +out:
> +	/* Move the next balance forward */
> +	if (time_after(this_rq->next_balance, next_balance))
> +		this_rq->next_balance = next_balance;
> +
>  	if (pulled_task)
>  		this_rq->idle_stamp = 0;
>  	else
> 

