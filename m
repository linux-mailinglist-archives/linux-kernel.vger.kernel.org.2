Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8D944685A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 19:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhKESZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 14:25:42 -0400
Received: from foss.arm.com ([217.140.110.172]:34414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231475AbhKESZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 14:25:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 343672F;
        Fri,  5 Nov 2021 11:22:56 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 321B33F7F5;
        Fri,  5 Nov 2021 11:22:55 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Srinivasan\, Sadagopan" <Sadagopan.Srinivasan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCs
In-Reply-To: <20211028130305.GS3959@techsingularity.net>
References: <20211028130305.GS3959@techsingularity.net>
Date:   Fri, 05 Nov 2021 18:22:52 +0000
Message-ID: <875yt6tqbn.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/21 14:03, Mel Gorman wrote:
> Commit 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA
> nodes") allowed an imbalance between NUMA nodes such that communicating
> tasks would not be pulled apart by the load balancer. This works fine when
> there is a 1:1 relationship between LLC and node but can be suboptimal
> for multiple LLCs if independent tasks prematurely use CPUs sharing cache.
>
> Zen* has multiple LLCs per node with local memory channels and due to
> the allowed imbalance, it's far harder to tune some workloads to run
> optimally than it is on hardware that has 1 LLC per node. This patch
> adjusts the imbalance on multi-LLC machines to allow an imbalance up to
> the point where LLCs should be balanced between nodes.
>

I've run out of brain juice for today and didn't get to decipher the logic
you're implementing, but for now I do have a comment on the topology
detection side of things (see inline).

> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -644,6 +644,7 @@ static void destroy_sched_domains(struct sched_domain *sd)
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DEFINE_PER_CPU(int, sd_llc_size);
>  DEFINE_PER_CPU(int, sd_llc_id);
> +DEFINE_PER_CPU(int, sd_numaimb_shift);
>  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> @@ -672,6 +673,20 @@ static void update_top_cache_domain(int cpu)
>       sd = lowest_flag_domain(cpu, SD_NUMA);
>       rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
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

So nodes are covered by the NODE topology level which *doesn't* have
SD_NUMA set. I always get confused on how MC/DIE/NODE is supposed to look
on those sub-NUMA clustering thingies, but either way consider:

  NUMA-20 [              ]
  NODE    [      ][      ]
  DIE     [      ][      ]
  MC      [  ][  ][  ][  ]

NODE level gets degenerated, update_top_cache_domain() is invoked with:

  NUMA-20 [              ]
  DIE     [      ][      ]
  MC      [  ][  ][  ][  ]

That lowest_flag_domain(cpu, SD_NUMA) will span the entire system.

Conversely, with this topology where node == LLC:

  NUMA-20 [              ]
  NODE    [      ][      ]
  DIE     [      ][      ]
  MC      [      ][      ]

You get

  NUMA-20 [              ]
  MC      [      ][      ]

lowest_flag_domain(cpu, SD_NUMA)->span_weight > size, even though LLC =
node.

Long story short, I think you want to use sd->child here - that *should*
point to a domain that spans exactly one node (it's gonna be NODE, or some
other domain that has the same span because NODE was degenerated).

>       sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
>       rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
>
