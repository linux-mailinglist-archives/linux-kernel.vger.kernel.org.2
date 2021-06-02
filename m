Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5739933C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhFBTLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:11:46 -0400
Received: from foss.arm.com ([217.140.110.172]:52440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhFBTLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:11:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA1021063;
        Wed,  2 Jun 2021 12:10:01 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37F793F774;
        Wed,  2 Jun 2021 12:10:00 -0700 (PDT)
Subject: Re: [PATCH v6 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
To:     Beata Michalska <beata.michalska@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        corbet@lwn.net, rdunlap@infradead.org, linux-doc@vger.kernel.org
References: <20210527153842.17567-1-beata.michalska@arm.com>
 <20210527153842.17567-3-beata.michalska@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <8ea4cfc2-514b-6b5c-7269-7720a54dbb39@arm.com>
Date:   Wed, 2 Jun 2021 21:09:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210527153842.17567-3-beata.michalska@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2021 17:38, Beata Michalska wrote:

[...]

> +/*
> + * Verify whether there is any CPU capacity asymmetry in a given sched domain.
> + * Provides sd_flags reflecting the asymmetry scope.
> + */
> +static inline int
> +asym_cpu_capacity_classify(struct sched_domain *sd,
> +			   const struct cpumask *cpu_map)
> +{
> +	struct asym_cap_data *entry;
> +	int sd_asym_flags = 0;
> +	int asym_cap_count = 0;
> +	int asym_cap_miss = 0;
> +
> +	/*
> +	 * Count how many unique CPU capacities this domain spans across
> +	 * (compare sched_domain CPUs mask with ones representing  available
> +	 * CPUs capacities). Take into account CPUs that might be offline:
> +	 * skip those.
> +	 */
> +	list_for_each_entry(entry, &asym_cap_list, link) {
> +		if (cpumask_intersects(sched_domain_span(sd),
> +				       cpu_capacity_span(entry)))
> +			++asym_cap_count;
> +		else if (cpumask_intersects(cpu_capacity_span(entry), cpu_map))

nit: `sd span, entry span` but `entry span, cpu_map`. Why not `cpu_map, entry span`?

> +			++asym_cap_miss;
> +	}
> +	/* No asymmetry detected */
> +	if (WARN_ON_ONCE(!asym_cap_count) || asym_cap_count == 1)
> +		goto leave;
> +
> +	sd_asym_flags |= SD_ASYM_CPUCAPACITY;
> +
> +	/*
> +	 * All the available capacities have been found within given sched
> +	 * domain: no misses reported.
> +	 */
> +	if (!asym_cap_miss)
> +		sd_asym_flags |= SD_ASYM_CPUCAPACITY_FULL;
> +
> +leave:
> +	return sd_asym_flags;
> +}

Everything looks good except that I like this more compact version better, proposed in:  

https://lkml.kernel.org/r/YK9ESqNEo+uacyMD@hirez.programming.kicks-ass.net

And passing `const struct cpumask *sd_span` instead of `struct
sched_domain *sd` into the function.


diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 77b73abbb9a4..0de8eebded9f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1290,13 +1290,11 @@ static LIST_HEAD(asym_cap_list);
  * Provides sd_flags reflecting the asymmetry scope.
  */  
 static inline int 
-asym_cpu_capacity_classify(struct sched_domain *sd,
+asym_cpu_capacity_classify(const struct cpumask *sd_span,
                           const struct cpumask *cpu_map)
 {
        struct asym_cap_data *entry;
-       int sd_asym_flags = 0;
-       int asym_cap_count = 0;
-       int asym_cap_miss = 0;
+       int count = 0, miss = 0;
 
        /*
         * Count how many unique CPU capacities this domain spans across
@@ -1305,27 +1303,20 @@ asym_cpu_capacity_classify(struct sched_domain *sd,
         * skip those.
         */
        list_for_each_entry(entry, &asym_cap_list, link) {
-               if (cpumask_intersects(sched_domain_span(sd),
-                                      cpu_capacity_span(entry)))
-                       ++asym_cap_count;
-               else if (cpumask_intersects(cpu_capacity_span(entry), cpu_map))
-                       ++asym_cap_miss;
+               if (cpumask_intersects(sd_span, cpu_capacity_span(entry)))
+                       ++count;
+               else if (cpumask_intersects(cpu_map, cpu_capacity_span(entry)))
+                       ++miss;
        }
-       /* No asymmetry detected */
-       if (WARN_ON_ONCE(!asym_cap_count) || asym_cap_count == 1)
-               goto leave;
 
-       sd_asym_flags |= SD_ASYM_CPUCAPACITY;
+       if (WARN_ON_ONCE(!count) || count == 1) /* No asymmetry */
+               return 0;
 
-       /*
-        * All the available capacities have been found within given sched
-        * domain: no misses reported.
-        */
-       if (!asym_cap_miss)
-               sd_asym_flags |= SD_ASYM_CPUCAPACITY_FULL;
+       if (miss) /* Partial asymmetry */
+               return SD_ASYM_CPUCAPACITY;
 
-leave:
-       return sd_asym_flags;
+       /* Full asymmetry */
+       return SD_ASYM_CPUCAPACITY | SD_ASYM_CPUCAPACITY_FULL;
 }
 
 static inline void asym_cpu_capacity_update_data(int cpu)
@@ -1510,6 +1501,7 @@ sd_init(struct sched_domain_topology_level *tl,
        struct sd_data *sdd = &tl->data;
        struct sched_domain *sd = *per_cpu_ptr(sdd->sd, cpu);
        int sd_id, sd_weight, sd_flags = 0;
+       struct cpumask *sd_span;
 
 #ifdef CONFIG_NUMA
        /*
@@ -1557,10 +1549,11 @@ sd_init(struct sched_domain_topology_level *tl,
 #endif
        };
 
-       cpumask_and(sched_domain_span(sd), cpu_map, tl->mask(cpu));
-       sd_id = cpumask_first(sched_domain_span(sd));
+       sd_span = sched_domain_span(sd);
+       cpumask_and(sd_span, cpu_map, tl->mask(cpu));
+       sd_id = cpumask_first(sd_span);
 
-       sd->flags |= asym_cpu_capacity_classify(sd, cpu_map);
+       sd->flags |= asym_cpu_capacity_classify(sd_span, cpu_map);
 
        WARN_ONCE((sd->flags & (SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY)) ==
                  (SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY),
-- 
2.25.1
