Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE14C32E76A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCELtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:49:17 -0500
Received: from foss.arm.com ([217.140.110.172]:52220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhCELtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:49:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE51E31B;
        Fri,  5 Mar 2021 03:49:07 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 544D33F766;
        Fri,  5 Mar 2021 03:49:06 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Barry Song <song.bao.hua@hisilicon.com>,
        vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxarm@openeuler.org,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] sched/topology: remove redundant cpumask_and in init_overlap_sched_group
In-Reply-To: <20210304222944.32504-1-song.bao.hua@hisilicon.com>
References: <20210304222944.32504-1-song.bao.hua@hisilicon.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Fri, 05 Mar 2021 11:48:59 +0000
Message-ID: <jhjeegt7rdg.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/21 11:29, Barry Song wrote:
> mask is built in build_balance_mask() by for_each_cpu(i, sg_span), so
> it must be a subset of sched_group_span(sg).

So we should indeed have

  cpumask_subset(sched_group_span(sg), mask)

but that doesn't imply

  cpumask_first(sched_group_span(sg)) == cpumask_first(mask)

does it? I'm thinking if in your topology of N CPUs, CPUs 0 and N-1 are the
furthest away, you will most likely hit

  !cpumask_equal(sg_pan, sched_domain_span(sibling->child))
                 ^^^^^^                    ^^^^^^^^^^^^^
                 CPUN-1                        CPU0

which should be the case on your Kunpeng920 system.

> Though cpumask_first_and
> doesn't lead to a wrong result of balance cpu, it is pointless to do
> cpumask_and again.
>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  kernel/sched/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 12f8058..45f3db2 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -934,7 +934,7 @@ static void init_overlap_sched_group(struct sched_domain *sd,
>  	int cpu;
>  
>  	build_balance_mask(sd, sg, mask);
> -	cpu = cpumask_first_and(sched_group_span(sg), mask);
> +	cpu = cpumask_first(mask);
>  
>  	sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
>  	if (atomic_inc_return(&sg->sgc->ref) == 1)
> -- 
> 1.8.3.1
