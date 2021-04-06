Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F348135528A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbhDFLmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:42:51 -0400
Received: from foss.arm.com ([217.140.110.172]:41616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245690AbhDFLmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:42:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8548113E;
        Tue,  6 Apr 2021 04:42:38 -0700 (PDT)
Received: from [192.168.1.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF0F23F73D;
        Tue,  6 Apr 2021 04:42:36 -0700 (PDT)
Subject: Re: [PATCH] sched/cpupri: fix the task priority BUG_ON checks
To:     Zeng Tao <prime.zeng@hisilicon.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linuxarm@huawei.com, Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
References: <1616728512-54749-1-git-send-email-prime.zeng@hisilicon.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <ae49ad23-f577-d5d7-7541-42a5c056151e@arm.com>
Date:   Tue, 6 Apr 2021 13:42:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1616728512-54749-1-git-send-email-prime.zeng@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2021 04:15, Zeng Tao wrote:
> The BUG_ON checks are intended to check if the task priotity is valid,
> but in the function convert_prio, if the task priority is not valid, it
> will be converted to an uninitialized stack variable. Fix it by moving
> the BUG_ON checks to the default branch of convert_prio.
> 
> Fixes: 934fc3314b39 ("sched/cpupri: Remap CPUPRI_NORMAL to MAX_RT_PRIO-1")
> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> ---
>  kernel/sched/cpupri.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
> index ec9be78..c5a0e6e 100644
> --- a/kernel/sched/cpupri.c
> +++ b/kernel/sched/cpupri.c
> @@ -60,6 +60,8 @@ static int convert_prio(int prio)
>  	case MAX_RT_PRIO:
>  		cpupri = CPUPRI_HIGHER;		/* 100 */
>  		break;
> +	default:
> +		BUG();
>  	}
>  
>  	return cpupri;
> @@ -148,8 +150,6 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
>  	int task_pri = convert_prio(p->prio);
>  	int idx, cpu;
>  
> -	BUG_ON(task_pri >= CPUPRI_NR_PRIORITIES);
> -
>  	for (idx = 0; idx < task_pri; idx++) {
>  
>  		if (!__cpupri_find(cp, p, lowest_mask, idx))
> @@ -215,8 +215,6 @@ void cpupri_set(struct cpupri *cp, int cpu, int newpri)
>  
>  	newpri = convert_prio(newpri);
>  
> -	BUG_ON(newpri >= CPUPRI_NR_PRIORITIES);
> -
>  	if (newpri == oldpri)
>  		return;
>  
> 

LGTM. Currently, convert_prio() is never called with prio <
CPUPRI_INVALID (-1) or prio > MAX_RT_PRIO (100) but in case it would
then this would be caught much easier with this patch.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
