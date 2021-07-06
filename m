Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B973BD8ED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhGFOvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:51:43 -0400
Received: from foss.arm.com ([217.140.110.172]:44068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232441AbhGFOvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:51:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8D3831B;
        Tue,  6 Jul 2021 07:49:02 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BFAE3F73B;
        Tue,  6 Jul 2021 07:49:01 -0700 (PDT)
Subject: Re: [PATCH] sched/rt: Fix double enqueue caused by rt_effective_prio
To:     Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bristot@redhat.com, bsegall@google.com,
        mgorman@suse.de, Mark Simmons <msimmons@redhat.com>
References: <20210701091431.256457-1-juri.lelli@redhat.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <29c071b5-5dd9-42df-9e00-f3df644eeccc@arm.com>
Date:   Tue, 6 Jul 2021 16:48:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701091431.256457-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2021 11:14, Juri Lelli wrote:
> Double enqueues in rt runqueues (list) have been reported while running
> a simple test that spawns a number of threads doing a short sleep/run
> pattern while being concurrently setscheduled between rt and fair class.

I tried to recreate this in rt-app (with `pi-mutex` resource and
`pi_enabled=true` but I can't bring the system into hitting this warning.

[...]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0c22cd026440..c84ac1d675f4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6823,7 +6823,8 @@ static void __setscheduler_params(struct task_struct *p,
>  
>  /* Actually do priority change: must hold pi & rq lock. */
>  static void __setscheduler(struct rq *rq, struct task_struct *p,
> -			   const struct sched_attr *attr, bool keep_boost)
> +			   const struct sched_attr *attr, bool keep_boost,
> +			   int new_effective_prio)
>  {
>  	/*
>  	 * If params can't change scheduling class changes aren't allowed
> @@ -6840,7 +6841,7 @@ static void __setscheduler(struct rq *rq, struct task_struct *p,
>  	 */
>  	p->prio = normal_prio(p);
>  	if (keep_boost)
> -		p->prio = rt_effective_prio(p, p->prio);
> +		p->prio = new_effective_prio;

So in case __sched_setscheduler() is called for p (SCHED_NORMAL, NICE0)
you want to avoid that this 2. rt_effective_prio() call returns
p->prio=120 in case the 1. call (in __sched_setscheduler()) did return 0
(due to pi_task->prio=0 (FIFO rt_priority=99 task))?

>  
>  	if (dl_prio(p->prio))
>  		p->sched_class = &dl_sched_class;
> @@ -6873,7 +6874,7 @@ static int __sched_setscheduler(struct task_struct *p,
>  	int newprio = dl_policy(attr->sched_policy) ? MAX_DL_PRIO - 1 :
>  		      MAX_RT_PRIO - 1 - attr->sched_priority;
>  	int retval, oldprio, oldpolicy = -1, queued, running;
> -	int new_effective_prio, policy = attr->sched_policy;
> +	int new_effective_prio = newprio, policy = attr->sched_policy;
>  	const struct sched_class *prev_class;
>  	struct callback_head *head;
>  	struct rq_flags rf;
> @@ -7072,6 +7073,9 @@ static int __sched_setscheduler(struct task_struct *p,
>  	oldprio = p->prio;
>  
>  	if (pi) {
> +		newprio = fair_policy(attr->sched_policy) ?
> +			NICE_TO_PRIO(attr->sched_nice) : newprio;
> +

Why is this necessary? p (SCHED_NORMAL) would get newprio=99 now and
with this it gets [100...120...139] which is still greater than any RT
(0-98)/DL (-1) prio?

[...]
