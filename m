Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC7237A614
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 13:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhEKLwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 07:52:54 -0400
Received: from foss.arm.com ([217.140.110.172]:45968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231276AbhEKLwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 07:52:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCAC4D6E;
        Tue, 11 May 2021 04:51:45 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B0813F719;
        Tue, 11 May 2021 04:51:44 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: [PATCH v2 6/8] sched/idle: Move busy_cpu accounting to idle callback
In-Reply-To: <20210506164543.90688-7-srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com> <20210506164543.90688-7-srikar@linux.vnet.ibm.com>
Date:   Tue, 11 May 2021 12:51:41 +0100
Message-ID: <87tun91oaa.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/21 22:15, Srikar Dronamraju wrote:
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 8db40c8a6ad0..00e4669bb241 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -647,6 +647,7 @@ DEFINE_PER_CPU(int, sd_llc_id);
>  #ifdef CONFIG_SCHED_SMT
>  DEFINE_PER_CPU(int, smt_id);
>  #endif
> +DEFINE_PER_CPU(int, is_idle);

This + patch 8 immediately reminds me of Aubrey's patch:

  http://lore.kernel.org/r/1615872606-56087-1-git-send-email-aubrey.li@intel.com

last I looked it seemed OK, even the test bot seems happy. Aubrey, did you
have any more work to do on that one (other than rebasing)?

>  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> @@ -673,6 +674,7 @@ static void update_top_cache_domain(int cpu)
>  #ifdef CONFIG_SCHED_SMT
>       per_cpu(smt_id, cpu) = cpumask_first(cpu_smt_mask(cpu));
>  #endif
> +	per_cpu(is_idle, cpu) = 1;
>       rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
>
>       sd = lowest_flag_domain(cpu, SD_NUMA);
> --
> 2.18.2
