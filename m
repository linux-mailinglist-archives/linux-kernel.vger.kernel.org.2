Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421F141D588
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348616AbhI3IgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:36:00 -0400
Received: from foss.arm.com ([217.140.110.172]:50450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348460AbhI3IgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:36:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D4A5D6E;
        Thu, 30 Sep 2021 01:34:17 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C83BF3F70D;
        Thu, 30 Sep 2021 01:34:16 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Drop the redundant setting of recent_used_cpu
To:     Li RongQing <lirongqing@baidu.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org
References: <1632985154-12890-1-git-send-email-lirongqing@baidu.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c4e8cbef-4708-cd4d-306f-6eab5bb32b95@arm.com>
Date:   Thu, 30 Sep 2021 10:34:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1632985154-12890-1-git-send-email-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2021 08:59, Li RongQing wrote:
> recent_used_cpu has been set to prev before check
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  kernel/sched/fair.c |    8 +-------
>  1 files changed, 1 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7b9fe8c..ec42eaa 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6437,14 +6437,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	    cpus_share_cache(recent_used_cpu, target) &&
>  	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
>  	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
> -	    asym_fits_capacity(task_util, recent_used_cpu)) {
> -		/*
> -		 * Replace recent_used_cpu with prev as it is a potential
> -		 * candidate for the next wake:
> -		 */
> -		p->recent_used_cpu = prev;
> +	    asym_fits_capacity(task_util, recent_used_cpu))
>  		return recent_used_cpu;
> -	}
>  
>  	/*
>  	 * For asymmetric CPU capacity systems, our domain of interest is
> 

Looks like this has been already fixed in:

https://lore.kernel.org/r/20210928103544.27489-1-vincent.guittot@linaro.org
