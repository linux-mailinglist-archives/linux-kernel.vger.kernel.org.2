Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7193747E5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhEESSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 14:18:47 -0400
Received: from foss.arm.com ([217.140.110.172]:49952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229901AbhEESSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 14:18:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7BAC1FB;
        Wed,  5 May 2021 11:17:47 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BED53F718;
        Wed,  5 May 2021 11:17:46 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Beata Michalska <beata.michalska@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] sched/topology: Rework CPU capacity asymmetry detection
In-Reply-To: <1619602363-1305-3-git-send-email-beata.michalska@arm.com>
References: <1619602363-1305-1-git-send-email-beata.michalska@arm.com> <1619602363-1305-3-git-send-email-beata.michalska@arm.com>
Date:   Wed, 05 May 2021 19:17:39 +0100
Message-ID: <87czu5xcxo.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nitpicks ahead...

On 28/04/21 10:32, Beata Michalska wrote:
> @@ -1958,65 +1958,308 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
>
>       return true;
>  }
> +/**
> + * Asym capacity bits
> + */
> +
> +/**
> + * Cached cpu masks for those sched domains, at a given topology level,
> + * that do represent CPUs with asymmetric capacities.
> + *
> + * Each topology level will get the cached data assigned,
> + * with asym cap sched_flags (SD_ASYM_CPUCAPACITY and SD_ASYM_CPUCAPACITY_FULL
> + * accordingly) and the corresponding cpumask for:
> + * - domains that do span CPUs with different capacities
> + * - domains where all CPU capacities are visible for all CPUs within
> + *   the domain
> + *
> + * Within a single topology level there might be domains
> + * with different scope of asymmetry:
> + *	none     -> .
> + *	partial  -> SD_ASYM_CPUCAPACITY
> + *	full     -> SD_ASYM_CPUCAPACITY|SD_ASYM_CPUCAPACITY_FULL
> + */
> +struct asym_cache_data {
> +
  ^
That should go

[...]

> -	if (!asym)
> -		return NULL;
> +	/* No asymmetry detected so skip the rest */
> +	if (!(cap_count > 1))
> +		goto leave;
> +
> +	if (!alloc_cpumask_var(&cpu_mask, GFP_KERNEL))
> +		goto leave;
>
> +	/* Get the number of topology levels */
> +	for_each_sd_topology(tl) level_count++;
>       /*
> -	 * Examine topology from all CPU's point of views to detect the lowest
> -	 * sched_domain_topology_level where a highest capacity CPU is visible
> -	 * to everyone.
> +	 * Allocate an array to store cached data per each topology level
>        */

That comment can be squashed into a single line.

> -	for_each_cpu(i, cpu_map) {
> -		unsigned long max_capacity = arch_scale_cpu_capacity(i);
> -		int tl_id = 0;
> +	scan_data = kcalloc(level_count, sizeof(*scan_data), GFP_KERNEL);
> +	if (!scan_data) {
> +		free_cpumask_var(cpu_mask);
> +		goto leave;
> +	}
>
> -		for_each_sd_topology(tl) {
> -			if (tl_id < asym_level)
> -				goto next_level;
> +	level_count = 0;
> +
> +	for_each_sd_topology(tl) {
> +		unsigned int local_cap_count;
> +		bool full_asym = true;
> +		const struct cpumask *mask;
> +		struct asym_cache_data *data = &scan_data[level_count++];
>
> -			for_each_cpu_and(j, tl->mask(i), cpu_map) {
> -				unsigned long capacity;
> +#ifdef CONFIG_NUMA
> +		/*
> +		 * For NUMA we might end-up in a sched domain that spans numa
> +		 * nodes with cpus with different capacities which would not be
> +		 * caught  by the above scan as those will have separate
                          ^
Stray whitespace >>>>>>>>>^

> +		 * cpumasks - subject to numa level
> +		 * @see: sched_domains_curr_level & sd_numa_mask
> +		 * Considered to be a no-go
> +		 */
> +		if (WARN_ON_ONCE(tl->numa_level && !full_asym))
> +			goto leave;
> +#endif
>
> -				capacity = arch_scale_cpu_capacity(j);
> +		if (asym_tl) {
> +			data->sched_flags = SD_ASYM_CPUCAPACITY |
> +					    SD_ASYM_CPUCAPACITY_FULL;
> +			continue;
> +		}
>
> -				if (capacity <= max_capacity)
> -					continue;
> +		cpumask_copy(cpu_mask, cpu_map);
> +		cpu = cpumask_first(cpu_mask);
> +
> +		while (cpu < nr_cpu_ids) {
> +			int i;
> +
> +			/*
> +			 * Tracking each CPU capacity 'scan' id to distinguish
> +			 * discovered capacity sets between different CPU masks
> +			 * at each topology level: capturing unique capacity
> +			 * values at each scan stage
> +			 */
> +			++scan_id;
> +			local_cap_count = 0;
>
> -				max_capacity = capacity;
> -				asym_level = tl_id;
> -				asym_tl = tl;
> +			mask = tl->mask(cpu);
> +			for_each_cpu_and(i, mask, cpu_map) {
> +
  ^
This should go.

> +				capacity = arch_scale_cpu_capacity(i);
> +
> +				list_for_each_entry(entry, &capacity_set, link) {
> +					if (entry->capacity == capacity &&
> +					    entry->scan_level < scan_id) {
> +						entry->scan_level = scan_id;
> +						++local_cap_count;
> +					}
> +				}
> +				__cpumask_clear_cpu(i, cpu_mask);
>                       }
> -next_level:
> -			tl_id++;
> +			if (cap_count != local_cap_count)
> +				full_asym = false;
> +			if (local_cap_count > 1) {
> +				int flags = (cap_count != local_cap_count)
> +					 ? SD_ASYM_CPUCAPACITY
> +					 : SD_ASYM_CPUCAPACITY
> +					 | SD_ASYM_CPUCAPACITY_FULL;

I haven't found many ternaries split over several lines, but those seem to
still follow the "operand at EOL" thing. The end result isn't particularly
pretty here (which is quite subjective, I know); another way to express
this would be:

                                int flags = SD_ASYM_CPUCAPACITY |
                                        SD_ASYM_CPUCAPACITY_FULL *
                                        (cap_count == local_cap_count);

which is... Meh.
