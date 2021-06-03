Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3158B399F2F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhFCKoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:44:25 -0400
Received: from foss.arm.com ([217.140.110.172]:37850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhFCKoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:44:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C5001063;
        Thu,  3 Jun 2021 03:42:40 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EEAB3F774;
        Thu,  3 Jun 2021 03:42:38 -0700 (PDT)
Subject: Re: [PATCH] sched/pelt: check that *_avg are null when *_sum are
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     odin@uged.al
References: <20210601155328.19487-1-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <438d95b4-330b-8a4b-a800-bab15db4f170@arm.com>
Date:   Thu, 3 Jun 2021 12:42:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210601155328.19487-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2021 17:53, Vincent Guittot wrote:
> Check that we never break the rule that pelt's avg values are null if
> pelt's sum are.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> This is what I used for patch 20210601085832.12626-1-vincent.guittot@linaro.org
> 
>  kernel/sched/fair.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a2c30e52de76..c17feadeafcc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8021,6 +8021,15 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  	if (cfs_rq->avg.runnable_sum)
>  		return false;
>  
> +	/*
> +	 * _avg must be null when _sum are null because _avg = _sum / divider
> +	 * Make sure that rounding and/or propagation of PELT values never
> +	 * break this.
> +	 */
> +	SCHED_WARN_ON(cfs_rq->avg.load_avg ||
> +		      cfs_rq->avg.util_avg ||
> +		      cfs_rq->avg.runnable_avg);
> +
>  	return true;
>  }

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
