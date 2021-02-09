Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24BB3150BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhBINsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:48:09 -0500
Received: from foss.arm.com ([217.140.110.172]:51906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhBINqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:46:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50C491042;
        Tue,  9 Feb 2021 05:45:23 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDB4A3F73D;
        Tue,  9 Feb 2021 05:45:20 -0800 (PST)
Subject: Re: [PATCH 2/6] sched/fair: remove unused parameter of
 update_nohz_stats
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, fweisbec@gmail.com,
        tglx@linutronix.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org
Cc:     qais.yousef@arm.com
References: <20210205114830.781-1-vincent.guittot@linaro.org>
 <20210205114830.781-3-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <a5083b2f-31b7-f23d-092b-6442c01ef23a@arm.com>
Date:   Tue, 9 Feb 2021 14:45:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205114830.781-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2021 12:48, Vincent Guittot wrote:
> idle load balance is the only user of update_nohz_stats and doesn't use
> force parameter. Remove it

Wasn't the 'force=true' from ilb eclipsing the jiffy resolution rate
limiting '!time_after(jiffies, rq->last_blocked_load_update_tick)' of
update_blocked_averages()?

So IMHO this has the (maybe intended) side effect that (formerly forced
updates) are now rate limited on one jiffy resolution too.

> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bfe1e235fe01..60b8c1c68ab9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8352,7 +8352,7 @@ group_type group_classify(unsigned int imbalance_pct,
>  	return group_has_spare;
>  }
>  
> -static bool update_nohz_stats(struct rq *rq, bool force)
> +static bool update_nohz_stats(struct rq *rq)
>  {
>  #ifdef CONFIG_NO_HZ_COMMON
>  	unsigned int cpu = rq->cpu;
> @@ -8363,7 +8363,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
>  	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
>  		return false;
>  
> -	if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))
> +	if (!time_after(jiffies, rq->last_blocked_load_update_tick))
>  		return true;
>  
>  	update_blocked_averages(cpu);
> @@ -10404,7 +10404,7 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>  
>  		rq = cpu_rq(balance_cpu);
>  
> -		has_blocked_load |= update_nohz_stats(rq, true);
> +		has_blocked_load |= update_nohz_stats(rq);
>  
>  		/*
>  		 * If time for next balance is due,
> 

