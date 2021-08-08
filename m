Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364E83E3B37
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 17:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhHHP5O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 8 Aug 2021 11:57:14 -0400
Received: from foss.arm.com ([217.140.110.172]:43082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229923AbhHHP5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 11:57:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E20F31B;
        Sun,  8 Aug 2021 08:56:54 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3680A3F718;
        Sun,  8 Aug 2021 08:56:52 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] sched/topology: Skip updating masks for non-online nodes
In-Reply-To: <20210723143914.GI3836887@linux.vnet.ibm.com>
References: <20210701041552.112072-1-srikar@linux.vnet.ibm.com> <20210701041552.112072-2-srikar@linux.vnet.ibm.com> <875yxu85wi.mognet@arm.com> <20210712124856.GA3836887@linux.vnet.ibm.com> <87zguqmay9.mognet@arm.com> <20210723143914.GI3836887@linux.vnet.ibm.com>
Date:   Sun, 08 Aug 2021 16:56:47 +0100
Message-ID: <87h7g09bgg.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A bit late, but technically the week isn't over yet! :D

On 23/07/21 20:09, Srikar Dronamraju wrote:
> * Valentin Schneider <valentin.schneider@arm.com> [2021-07-13 17:32:14]:
>> Now, let's take examples from your cover letter:
>>
>>   node distances:
>>   node   0   1   2   3   4   5   6   7
>>     0:  10  20  40  40  40  40  40  40
>>     1:  20  10  40  40  40  40  40  40
>>     2:  40  40  10  20  40  40  40  40
>>     3:  40  40  20  10  40  40  40  40
>>     4:  40  40  40  40  10  20  40  40
>>     5:  40  40  40  40  20  10  40  40
>>     6:  40  40  40  40  40  40  10  20
>>     7:  40  40  40  40  40  40  20  10
>>
>> But the system boots with just nodes 0 and 1, thus only this distance
>> matrix is valid:
>>
>>   node   0   1
>>     0:  10  20
>>     1:  20  10
>>
>> topology_span_sane() is going to use tl->mask(cpu), and as you reported the
>> NODE topology level should cause issues. Let's assume all offline nodes say
>> they're 10 distance away from everyone else, and that we have one CPU per
>> node. This would give us:
>>
>
> No,
> All offline nodes would be at a distance of 10 from node 0 only.
> So here node distance of all offline nodes from node 1 would be 20.
>
>>   NODE->mask(0) == 0,2-7
>>   NODE->mask(1) == 1-7
>
> so
>
> NODE->mask(0) == 0,2-7
> NODE->mask(1) should be 1
> and NODE->mask(2-7) == 0,2-7
>

Ok, so that shouldn't trigger the warning.

>>
>> The intersection is 2-7, we'll trigger the WARN_ON().
>> Now, with the above snippet, we'll check if that intersection covers any
>> online CPU. For sched_init_domains(), cpu_map is cpu_active_mask, so we'd
>> end up with an empty intersection and we shouldn't warn - that's the theory
>> at least.
>
> Now lets say we onlined CPU 3 and node 3 which was at a actual distance
> of 20 from node 0.
>
> (If we only consider online CPUs, and since scheduler masks like
> sched_domains_numa_masks arent updated with offline CPUs,)
> then
>
> NODE->mask(0) == 0
> NODE->mask(1) == 1
> NODE->mask(3) == 0,3
>

Wait, doesn't the distance matrix (without any offline node) say

  distance(0, 3) == 40

? We should have at the very least:

  node   0   1   2   3
    0:  10  20  ??  40
    1:  20  20  ??  40
    2:  ??  ??  ??  ??
    3:  40  40  ??  10

Regardless, NODE->mask(x) is sched_domains_numa_masks[0][x], if

  distance(0,3) > LOCAL_DISTANCE

then

  node0 ∉ NODE->mask(3)

> cpumask_and(intersect, tl->mask(cpu), tl->mask(i));
> if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) && cpumask_intersects(intersect, cpu_map))
>
> cpu_map is 0,1,3
> intersect is 0
>
> From above NODE->mask(0) is !equal to NODE->mask(1) and
> cpumask_intersects(intersect, cpu_map) is also true.
>
> I picked Node 3 since if Node 1 is online, we would have faked distance
> for Node 2 to be at distance of 40.
>
> Any node from 3 to 7, we would have faced the same problem.
>
>>
>> Looking at sd_numa_mask(), I think there's a bug with topology_span_sane():
>> it doesn't run in the right place wrt where sched_domains_curr_level is
>> updated. Could you try the below on top of the previous snippet?
>>
>> If that doesn't help, could you share the node distances / topology masks
>> that lead to the WARN_ON()? Thanks.
>>
>> ---
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index b77ad49dc14f..cda69dfa4065 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1516,13 +1516,6 @@ sd_init(struct sched_domain_topology_level *tl,
>>      int sd_id, sd_weight, sd_flags = 0;
>>      struct cpumask *sd_span;
>>
>> -#ifdef CONFIG_NUMA
>> -	/*
>> -	 * Ugly hack to pass state to sd_numa_mask()...
>> -	 */
>> -	sched_domains_curr_level = tl->numa_level;
>> -#endif
>> -
>>      sd_weight = cpumask_weight(tl->mask(cpu));
>>
>>      if (tl->sd_flags)
>> @@ -2131,7 +2124,12 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>>
>>              sd = NULL;
>>              for_each_sd_topology(tl) {
>> -
>> +#ifdef CONFIG_NUMA
>> +			/*
>> +			 * Ugly hack to pass state to sd_numa_mask()...
>> +			 */
>> +			sched_domains_curr_level = tl->numa_level;
>> +#endif
>>                      if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
>>                              goto error;
>>
>>
>
> I tested with the above patch too. However it still not helping.
>
> Here is the log from my testing.
>
> At Boot.
>
> (Do remember to arrive at sched_max_numa_levels we faked the
> numa_distance of node 1 to be at 20 from node 0. All other offline
> nodes are at a distance of 10 from node 0.)
>

[...]

> ( First addition of a CPU to a non-online node esp node whose node
> distance was not faked.)
>
> numactl -H
> available: 3 nodes (0,5,7)
> node 0 cpus: 0 1 2 3 4 5 6 7
> node 0 size: 0 MB
> node 0 free: 0 MB
> node 5 cpus: 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 32 33 34 35 40 41 42 43 48 49 50 51 56 57 58 59 64 65 66 67 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87
> node 5 size: 32038 MB
> node 5 free: 29024 MB
> node 7 cpus: 88 89 90 91 92 93 94 95
> node 7 size: 0 MB
> node 7 free: 0 MB
> node distances:
> node   0   5   7
>   0:  10  40  40
>   5:  40  10  20
>   7:  40  20  10
> ------------------------------------------------------------------
> grep -r . /sys/kernel/debug/sched/domains/cpu0/domain{0,1,2,3,4}/{name,flags}
> ------------------------------------------------------------------
> awk '/domain/{print $1, $2}' /proc/schedstat | sort -u | sed -e 's/00000000,//g'
> ==================================================================
>
> I had added a debug patch to dump some variables that may help to
> understand the problem
> ------------------->8--------------------------------------------8<----------
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 5e1abd9a8cc5..146f59381bcc 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2096,7 +2096,8 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
>               cpumask_and(intersect, tl->mask(cpu), tl->mask(i));
>               if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
>                   cpumask_intersects(intersect, cpu_map)) {
> -			pr_err("name=%s mask(%d/%d)=%*pbl mask(%d/%d)=%*pbl", tl->name, cpu, cpu_to_node(cpu), cpumask_pr_args(tl->mask(cpu)), i, cpu_to_node(i), cpumask_pr_args(tl->mask(i)));
> +			pr_err("name=%s mask(%d/%d)=%*pbl mask(%d/%d)=%*pbl numa-level=%d curr_level=%d", tl->name, cpu, cpu_to_node(cpu), cpumask_pr_args(tl->mask(cpu)), i, cpu_to_node(i), cpumask_pr_args(tl->mask(i)), tl->numa_level, sched_domains_curr_level);
> +			pr_err("intersect=%*pbl cpu_map=%*pbl", cpumask_pr_args(intersect), cpumask_pr_args(cpu_map));
>                       return false;
>               }
>       }
> ------------------->8--------------------------------------------8<----------
>
> From dmesg:
>
> [  167.626915] name=NODE mask(0/0)=0-7 mask(88/7)=0-7,88 numa-level=0 curr_level=0    <-- hunk above
> [  167.626925] intersect=0-7 cpu_map=0-19,24-27,32-35,40-43,48-51,56-59,64-67,72-88

> [  168.026621] name=NODE mask(0/0)=0-7 mask(88/7)=0-7,88-89 numa-level=0 curr_level=0
> [  168.026626] intersect=0-7 cpu_map=0-19,24-27,32-35,40-43,48-51,56-59,64-67,72-89
>

Ok so to condense the info, we have:

  node   0   5   7
    0:  10  40  40
    5:  40  10  20
    7:  40  20  10

  node0: 0-7
  node5: 8-29, 32-35, 40-43, 48-51, 56-59, 64-67, 72-87
  node7: 88-95

With the above distance map, we should have

  NODE->mask(CPU0) == 0-7
  NODE->mask(CPU8) == 8-29, 32-35, 40-43, 48-51, 56-59, 64-67, 72-87
  NODE->mask(CPU88) == 88-95

(this is sched_domains_numa_masks[0][CPUx], and
sched_domains_numa_distance[0] == LOCAL_DISTANCE, thus the mask of CPUs
LOCAL_DISTANCE away from CPUx).

For some reason you end up with node0 being part of node7's NODE
mask. Neither nodes are offline, and per the above distance table that
shouldn't happen.

> Now this keeps repeating.
>
> I know I have mentioned this before. (So sorry for repeating)

It can't hurt to reformulate ;)

> Generally on Power node distance is not populated for offline nodes.
> However to arrive at sched_max_numa_levels, we thought of faking few
> node distances. In the above case, we faked distance of node 1 as 20
> (from node 0) node 5 was already at distance of 40 from node 0.
>

Right, again that gives us the right set of unique distances (10, 20, 40).

> So when sched_domains_numa_masks_set is called to update sd_numa_mask or
> sched_domains_numa_masks, all CPUs under node 0 get updated for node 2
> too. (since node 2 is shown as at a local distance from node 0). Do
> look at the node mask of CPU 88 in the dmesg. It should have been 88,
> however its 0-7,88 where 0-7 are coming from node 0.
>
> Even if we skip updation of sched_domains_numa_masks for offline nodes,
> on online of a node (i.e when we get the correct node distance), we have
> to update the sched_domains_numa_masks to ensure CPUs that were already
> present within a certain distance and skipped are added back. And this
> was what I tried to do in my patch.
>

Ok, so it looks like we really can't do without that part - even if we get
"sensible" distance values for the online nodes, we can't divine values for
the offline ones.

> --
> Thanks and Regards
> Srikar Dronamraju
