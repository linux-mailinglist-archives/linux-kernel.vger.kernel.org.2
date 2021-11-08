Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E79447EAD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 12:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhKHLRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 06:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbhKHLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:17:26 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1CAC06120A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 03:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6LeBVXEEkfDG4XZfeocFTtH7tQHJXwcvP1bIONx7BfY=; b=JgIx4gtY4DvoxTEpdZB5cPSdef
        TWAZGjv6MvjFep+EqydrBYraYk1j+wBracHkKPVi01ej04s9ewmHP52dj1HGSsRuojfxEZa7a+e4o
        p0b4KVHw7aaE3TLSfBi2r+9EWtt9nWNbxbDYp5xEEuwVYTpfGqRC5hXb7u9R6Zyys4tDUU6MjmS+n
        Vntgm07nRQJ3ewjZLCFncPCE1GOVCtd7KsMvRIe+kAzYfb4+ZzeDOXXd6sbAmqxi/ezysuaL475Dd
        /6fz4FiqowjtxZc3fKBJ2Quu1IdnifxpZY61yUJkOetfQTtQHrSfmUq3F/8xxxJemF9BdyjpLiV7X
        qjnHHivg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mk2bd-00EsBO-MG; Mon, 08 Nov 2021 11:14:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1770530030B;
        Mon,  8 Nov 2021 12:14:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DAC63202A012E; Mon,  8 Nov 2021 12:14:27 +0100 (CET)
Date:   Mon, 8 Nov 2021 12:14:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Srinivasan, Sadagopan" <Sadagopan.Srinivasan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <YYkGkx+Wq6Ol2N9i@hirez.programming.kicks-ass.net>
References: <20211028130305.GS3959@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028130305.GS3959@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 02:03:05PM +0100, Mel Gorman wrote:

> @@ -1926,8 +1926,8 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>  		src_running = env->src_stats.nr_running - 1;
>  		dst_running = env->dst_stats.nr_running + 1;
>  		imbalance = max(0, dst_running - src_running);
> -		imbalance = adjust_numa_imbalance(imbalance, dst_running,
> -							env->dst_stats.weight);
> +		imbalance = adjust_numa_imbalance(imbalance, env->dst_cpu,
> +					dst_running, env->dst_stats.weight);

Can we please align at (0 ?

>  
>  		/* Use idle CPU if there is no imbalance */
>  		if (!imbalance) {

> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 4e8698e62f07..08fb02510967 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -644,6 +644,7 @@ static void destroy_sched_domains(struct sched_domain *sd)
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DEFINE_PER_CPU(int, sd_llc_size);
>  DEFINE_PER_CPU(int, sd_llc_id);
> +DEFINE_PER_CPU(int, sd_numaimb_shift);

Why does it make sense for this to be a per-cpu variable? Yes, I suppose
people can get creative with cpusets, but what you're trying to capture
seems like a global system propery, no?

At most this seems to want to be a sched_domain value.

>  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> @@ -672,6 +673,20 @@ static void update_top_cache_domain(int cpu)
>  	sd = lowest_flag_domain(cpu, SD_NUMA);
>  	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
>  
> +	/*
> +	 * Save the threshold where an imbalance is allowed between SD_NUMA
> +	 * domains. If LLC spans the entire node, then imbalances are allowed
> +	 * until 25% of the domain is active. Otherwise, allow an imbalance
> +	 * up to the point where LLCs between NUMA nodes should be balanced
> +	 * to maximise cache and memory bandwidth utilisation.
> +	 */
> +	if (sd) {
> +		if (sd->span_weight == size)
> +			per_cpu(sd_numaimb_shift, cpu) = 2;
> +		else
> +			per_cpu(sd_numaimb_shift, cpu) = max(2, ilog2(sd->span_weight / size * num_online_nodes()));
> +	}
> +
>  	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
>  	rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);

I think I'm with Valentin here, this seems like something that wants to
use the sd/sd->child relation.

That also makes this the wrong place to do things since this is after
the degenerate code.

Perhaps this can be done in sd_init(), after all, we build the thing
bottom-up, so by the time we initialize the NODE, the MC level should
already be present.

I'm thinking you can perhaps use something like:

	if (!(sd->flags & SD_SHARE_PKG_RESROUCES) &&
	    (child->flags & SD_SHARE_PKG_RESOURCES)) {

		/* this is the first domain not sharing LLC */
		sd->new_magic_imb = /*  magic incantation goes here */
	}
