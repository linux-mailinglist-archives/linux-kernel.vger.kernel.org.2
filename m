Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D61A34FF87
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbhCaLf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:35:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38319 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235284AbhCaLfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:35:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617190521; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=98yvjg8uN7rArkdP8FF11rFh+sbQunmzYH5Enq8SXyM=; b=nSqA30ddotgEpAjUltlWU7CLrjUfnfL0Hu/caw7Ijf3cUANOuYvkDJoEeTpZB7nu8wc6OQOI
 F5lUj9p9eV992KMdwTwq0lvVoexoGXuSyIMlC8EvdQIXsYeefGXQP3bNLTlrVgFR0GzdseMV
 gXAGVcQytlFvJ9OQo0qgb8aZZ+k=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60645e739a9ff96d95ba8403 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 31 Mar 2021 11:35:15
 GMT
Sender: clingutla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6D6D7C43462; Wed, 31 Mar 2021 11:35:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.43.40] (unknown [223.185.99.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: clingutla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70D86C433C6;
        Wed, 31 Mar 2021 11:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70D86C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=clingutla@codeaurora.org
Subject: Re: [PATCH v3 5/7] sched/fair: Employ capacity_greater() throughout
 load_balance()
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
References: <20210311120527.167870-1-valentin.schneider@arm.com>
 <20210311120527.167870-6-valentin.schneider@arm.com>
From:   Chandra Sekhar Lingutla <clingutla@codeaurora.org>
Message-ID: <3f5c3f78-0d0d-af89-56d7-cb9a91b98898@codeaurora.org>
Date:   Wed, 31 Mar 2021 17:05:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210311120527.167870-6-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

The reduced margin is helping our platforms, Please feel free to add my 
tested-by tag:

Tested-by:  Lingutla Chandrasekhar <clingutla@codeaurora.org>

On 3/11/2021 5:35 PM, Valentin Schneider wrote:
> While at it, replace group_smaller_{min, max}_cpu_capacity() with
> comparisons of the source group's min/max capacity and the destination
> CPU's capacity.
>
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>   kernel/sched/fair.c | 33 ++++-----------------------------
>   1 file changed, 4 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ddb2ab3edf6d..1e8a242cd1f7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8350,26 +8350,6 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>   	return false;
>   }
>   
> -/*
> - * group_smaller_min_cpu_capacity: Returns true if sched_group sg has smaller
> - * per-CPU capacity than sched_group ref.
> - */
> -static inline bool
> -group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
> -{
> -	return fits_capacity(sg->sgc->min_capacity, ref->sgc->min_capacity);
> -}
> -
> -/*
> - * group_smaller_max_cpu_capacity: Returns true if sched_group sg has smaller
> - * per-CPU capacity_orig than sched_group ref.
> - */
> -static inline bool
> -group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
> -{
> -	return fits_capacity(sg->sgc->max_capacity, ref->sgc->max_capacity);
> -}
> -
>   static inline enum
>   group_type group_classify(unsigned int imbalance_pct,
>   			  struct sched_group *group,
> @@ -8518,15 +8498,10 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>   	if (!sgs->sum_h_nr_running)
>   		return false;
>   
> -	/*
> -	 * Don't try to pull misfit tasks we can't help.
> -	 * We can use max_capacity here as reduction in capacity on some
> -	 * CPUs in the group should either be possible to resolve
> -	 * internally or be covered by avg_load imbalance (eventually).
> -	 */
> +	/* Don't try to pull misfit tasks we can't help */
>   	if (static_branch_unlikely(&sched_asym_cpucapacity) &&
>   	    sgs->group_type == group_misfit_task &&
> -	    (!group_smaller_max_cpu_capacity(sg, sds->local) ||
> +	    (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
>   	     sds->local_stat.group_type != group_has_spare))
>   		return false;
>   
> @@ -8610,7 +8585,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>   	 */
>   	if (sd_has_asym_cpucapacity(env->sd) &&
>   	    (sgs->group_type <= group_fully_busy) &&
> -	    (group_smaller_min_cpu_capacity(sds->local, sg)))
> +	    (capacity_greater(sg->sgc->min_capacity, capacity_of(env->dst_cpu))))
>   		return false;
>   
>   	return true;
> @@ -9410,7 +9385,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>   		 * average load.
>   		 */
>   		if (sd_has_asym_cpucapacity(env->sd) &&
> -		    capacity_of(env->dst_cpu) < capacity &&
> +		    !capacity_greater(capacity_of(env->dst_cpu), capacity) &&
>   		    nr_running == 1)
>   			continue;
>   
