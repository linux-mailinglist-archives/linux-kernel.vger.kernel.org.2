Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1159C34A6E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCZMJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:09:29 -0400
Received: from foss.arm.com ([217.140.110.172]:58124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhCZMI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:08:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A88F1476;
        Fri, 26 Mar 2021 05:08:59 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 130723F7D7;
        Fri, 26 Mar 2021 05:08:56 -0700 (PDT)
Subject: Re: [PATCH 9/9] sched,fair: Alternative sched_slice()
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        mgorman@suse.de, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, greg@kroah.com
References: <20210326103352.603456266@infradead.org>
 <20210326103935.444833549@infradead.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <6c36c39a-d2da-a110-3f83-fda70a73a1fd@arm.com>
Date:   Fri, 26 Mar 2021 13:08:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210326103935.444833549@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2021 11:34, Peter Zijlstra wrote:
> The current sched_slice() seems to have issues; there's two possible
> things that could be improved:
> 
>  - the 'nr_running' used for __sched_period() is daft when cgroups are
>    considered. Using the RQ wide h_nr_running seems like a much more
>    consistent number.
> 
>  - (esp) cgroups can slice it real fine, which makes for easy
>    over-scheduling, ensure min_gran is what the name says.

So ALT_PERIOD considers all runnable CFS tasks now and BASE_SLICE
guarantees min_gran as a floor for cgroup (hierarchies) with small
weight value(s)?

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/fair.c     |   15 ++++++++++++++-
>  kernel/sched/features.h |    3 +++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -680,7 +680,16 @@ static u64 __sched_period(unsigned long
>   */
>  static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> -	u64 slice = __sched_period(cfs_rq->nr_running + !se->on_rq);
> +	unsigned int nr_running = cfs_rq->nr_running;
> +	u64 slice;
> +
> +	if (sched_feat(ALT_PERIOD))
> +		nr_running = rq_of(cfs_rq)->cfs.h_nr_running;
> +
> +	slice = __sched_period(nr_running + !se->on_rq);
> +
> +	if (sched_feat(BASE_SLICE))
> +		slice -= sysctl_sched_min_granularity;
>  
>  	for_each_sched_entity(se) {
>  		struct load_weight *load;
> @@ -697,6 +706,10 @@ static u64 sched_slice(struct cfs_rq *cf
>  		}
>  		slice = __calc_delta(slice, se->load.weight, load);
>  	}
> +
> +	if (sched_feat(BASE_SLICE))
> +		slice += sysctl_sched_min_granularity;
> +
>  	return slice;
>  }
>  
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -90,3 +90,6 @@ SCHED_FEAT(WA_BIAS, true)
>   */
>  SCHED_FEAT(UTIL_EST, true)
>  SCHED_FEAT(UTIL_EST_FASTUP, true)
> +
> +SCHED_FEAT(ALT_PERIOD, true)
> +SCHED_FEAT(BASE_SLICE, true)
> 
> 

