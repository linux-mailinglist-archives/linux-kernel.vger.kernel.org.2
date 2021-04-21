Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF77B3673D4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245537AbhDUT6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:58:42 -0400
Received: from foss.arm.com ([217.140.110.172]:40816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235767AbhDUT6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:58:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 960DA11D4;
        Wed, 21 Apr 2021 12:58:07 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 441B13F774;
        Wed, 21 Apr 2021 12:58:06 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Beata Michalska <beata.michalska@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] sched/topology: Rework CPU capacity asymmetry detection
In-Reply-To: <1618578085-29584-3-git-send-email-beata.michalska@arm.com>
References: <1618578085-29584-1-git-send-email-beata.michalska@arm.com> <1618578085-29584-3-git-send-email-beata.michalska@arm.com>
Date:   Wed, 21 Apr 2021 20:58:01 +0100
Message-ID: <871rb3v29i.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Beata,

On 16/04/21 14:01, Beata Michalska wrote:
> Currently the CPU capacity asymmetry detection, performed through
> asym_cpu_capacity_level, tries to identify the lowest topology level
> at which the highest CPU capacity is being observed, not necessarily
> finding the level at which all possible capacity values are visible
> to all CPUs

Despite the latter being what it says on the tin! (see comment atop
asym_cpu_capacity_level())

>, which might be bit problematic for some possible/valid
> asymmetric topologies i.e.:
>
> DIE      [                                ]
> MC       [                       ][       ]
>
> CPU       [0] [1] [2] [3] [4] [5]  [6] [7]
> Capacity  |.....| |.....| |.....|  |.....|
>            L	     M       B        B
>
> Where:
>  arch_scale_cpu_capacity(L) = 512
>  arch_scale_cpu_capacity(M) = 871
>  arch_scale_cpu_capacity(B) = 1024
>
> In this particular case, the asymmetric topology level will point
> at MC, as all possible CPU  masks for that level do cover the CPU
> with the highest capacity. It will work just fine for the first
> cluster, not so much for the second one though (consider the
> find_energy_efficient_cpu which might end up attempting the energy
> aware wake-up for a domain that does not see any asymmetry at all)
>

Another problematic topology is something the likes of

  DIE [          ]
  MC  [    ][    ]
       L  M  B  B

Because here the asymmetric tl will be DIE, so we won't properly recognize
that MC domain with L+M as having CPU asymmetry. That means no misfit
upmigration from L to M, for one.

The Exynos-based Galaxy S10 *almost* matches that topology - from what I've
been able to scrounge, all CPUs are hooked up to the same LLC *but* the big
CPUs have exclusive access to some part of it. From the devicetree files
I've been able to see, the big cores are actually described as having their
own LLC.

Regardless, the topology you describe in this changelog is something that's
achievable by cobbling two DynamIQ clusters (each with their own LLC) to an
interconnect, which the architecture supports (IIRC up to something like 32
clusters).

> Rework the way the capacity asymmetry levels are being detected,
> to point to the lowest topology level( for a given CPU), where full
> range of available CPU capacities is visible to all CPUs within given
> domain. As a result, the per-cpu sd_asym_cpucapacity might differ
> across the domains. This will have an impact on EAS wake-up placement
> in a way that it might see different range of CPUs to be considered,
> depending on the given current and target CPUs.
>
> Additionally, those levels, where any range of asymmetry (not
> necessarily full) is being detected will get identified as well.
> The selected asymmetric topology level will be denoted by
> SD_ASYM_CPUCAPACITY_FULL sched domain flag whereas the 'sub-levels'
> would receive the already used SD_ASYM_CPUCAPACITY flag. This allows
> maintaining the current behaviour for asymmetric topologies, with
> misfit migration operating correctly on lower levels, if applicable,
> as any asymmetry is enough to trigger the misfit migration.
> The logic there relies on the SD_ASYM_CPUCAPACITY flag and does not
> relate to the full asymmetry level denoted by the sd_asym_cpucapacity
> pointer.
>
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>

Most of this looks OK to me, I have a few comments below but nothing
major. FWIW I've appended a diff at the tail of that email which covers
(most) said comments.

> ---
>  kernel/sched/topology.c | 339 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 299 insertions(+), 40 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 09d3504..9dfa66b 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -675,7 +675,7 @@ static void update_top_cache_domain(int cpu)
>       sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
>       rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
>
> -	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
> +	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY_FULL);
>       rcu_assign_pointer(per_cpu(sd_asym_cpucapacity, cpu), sd);
>  }
>
> @@ -1958,65 +1958,322 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
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
> +	struct sched_domain_topology_level *tl;
> +	unsigned int			   sched_flags;
> +	struct cpumask			   *asym_mask;
> +	struct cpumask			   *asym_full_mask;
> +};
> +

I'll dump this here because I think it can be useful to whoever else will
stare at this:

This is pretty much an extension of struct sched_domain_topology_level,
providing a new / modified tl->sd_flags() output. Unfortunately, said
output requires either a cpumask per flag per topology level or a flag
accumulator per topology level per CPU.

In light of this, it's preferable to keep this extra data outside of the
sched_domain_topology_level struct and have its lifespan limited to the
domain build, which is what's being done here.

> +*asym_cpu_capacity_scan(const struct cpumask *cpu_map)
>  {
> -	int i, j, asym_level = 0;
> -	bool asym = false;
> +	/*
> +	 * Simple data structure to record all available CPU capacities.
> +	 * Additional scan level allows tracking unique capacities per each
> +	 * topology level and each separate topology level CPU mask.
> +	 * During each scan phase, the scan level will allow to determine,
> +	 * whether given capacity has been already accounted for, by syncing
> +	 * it with the scan stage id.
> +	 */
> +	struct capacity_entry {
> +		struct list_head link;
> +		unsigned long    capacity;
> +		unsigned int     scan_level;
> +	};
> +
>       struct sched_domain_topology_level *tl, *asym_tl = NULL;
> -	unsigned long cap;
> +	struct asym_cache_data *scan_data = NULL;
> +	struct capacity_entry *entry = NULL, *tmp;
> +	unsigned int level_count = 0;
> +	unsigned int cap_count = 0;
> +	unsigned int scan_id = 0;
> +	LIST_HEAD(capacity_set);
> +	unsigned long capacity;
> +	cpumask_var_t cpu_mask;
> +	int cpu;
>
> -	/* Is there any asymmetry? */
> -	cap = arch_scale_cpu_capacity(cpumask_first(cpu_map));
> +	/* Build-up a list of all CPU capacities, verifying on the way
> +	 * if there is any asymmetry at all

That's a wrong comment style.

>       /*
> -	 * Examine topology from all CPU's point of views to detect the lowest
> -	 * sched_domain_topology_level where a highest capacity CPU is visible
> -	 * to everyone.
> +	 * Allocate an array to store cached data
> +	 * per each topology level + sentinel
>        */
> -	for_each_cpu(i, cpu_map) {
> -		unsigned long max_capacity = arch_scale_cpu_capacity(i);
> -		int tl_id = 0;
> +	scan_data = kcalloc(level_count + 1, sizeof(*scan_data), GFP_KERNEL);

Given we have one cache per tl, do we need the sentinel? I gave that a shot
and it didn't explode, also further simplified asym_cpu_capacity_verify(),
see appended diff.

> +	if (!scan_data) {
> +		free_cpumask_var(cpu_mask);
> +		goto leave;
> +	}
[...]
> +			for_each_cpu_and(i, mask, cpu_map) {
> +
> +				capacity = arch_scale_cpu_capacity(i);
>
> -				max_capacity = capacity;
> -				asym_level = tl_id;
> -				asym_tl = tl;
> +				list_for_each_entry(entry, &capacity_set, link) {
> +					if (entry->capacity == capacity
> +					&&  entry->scan_level < scan_id) {
                                        ^^
Operand should be at EOL.

> +						entry->scan_level = scan_id;
> +						++local_cap_count;
> +					}
> +				}
> +				__cpumask_clear_cpu(i, cpu_mask);
> +			}
> @@ -2049,9 +2306,10 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>
>               sd = NULL;
>               for_each_sd_topology(tl) {
> -			if (tl == tl_asym) {
> -				dflags |= SD_ASYM_CPUCAPACITY;
> -				has_asym = true;
> +			if (!(dflags & SD_ASYM_CPUCAPACITY_FULL)) {
> +				dflags |= asym_cpu_capacity_verify(asym_scan_data,
> +								   tl, i);
> +				has_asym = dflags & SD_ASYM_CPUCAPACITY;
>                       }

Given this dflags & SD_ASYM_CPUCAPACITY_FULL check, is the maskless
optimization thing actually required?

AIUI, for any CPU, the first topology level where we'll set
SD_ASYM_CPUCAPACITY_FULL should have a matching
asym_scan_data[tlid]->asym_full_mask, and all subsequent tl's will see that
in dflags and not call into asym_cpu_capacity_verify().

>
>                       if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
> @@ -2068,6 +2326,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>               }
>       }
>
> +	asym_cpu_capacity_release_data(asym_scan_data);
>       /* Build the groups for the domains */
>       for_each_cpu(i, cpu_map) {
>               for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> --
> 2.7.4

---
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 1f965293cc7e..31d89868f208 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2011,102 +2011,80 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
  *	full     -> SD_ASYM_CPUCAPACITY|SD_ASYM_CPUCAPACITY_FULL
  */
 struct asym_cache_data {
-
-	struct sched_domain_topology_level *tl;
 	unsigned int			   sched_flags;
 	struct cpumask			   *asym_mask;
 	struct cpumask			   *asym_full_mask;
 };
 
-static inline int asym_cpu_capacity_verify(struct asym_cache_data *data,
-			struct sched_domain_topology_level *tl, int cpu)
+static inline int asym_cpu_capacity_verify(struct asym_cache_data *data, int cpu)
 {
-	int flags = 0;
-
 	if (!data)
 		goto leave;
 
-	while (data->tl) {
-		if (data->tl != tl) {
-			++data;
-			continue;
-		}
-
-		if (!data->sched_flags)
-			break;
-		/*
-		 * For topology levels above one, where all CPUs observe
-		 * all available capacities, CPUs mask is not being
-		 * cached for optimization reasons, assuming, that at this
-		 * point, all possible CPUs are being concerned.
-		 * Those levels will have both:
-		 * SD_ASYM_CPUCAPACITY and SD_ASYM_CPUCAPACITY_FULL
-		 * flags set.
-		 */
-		if (data->sched_flags & SD_ASYM_CPUCAPACITY_FULL &&
-		   !data->asym_full_mask) {
-			flags = data->sched_flags;
-			break;
-		}
-
-		if (data->asym_full_mask &&
-		    cpumask_test_cpu(cpu, data->asym_full_mask)) {
-			flags = data->sched_flags;
-			break;
-		}
-		/*
-		 * A given topology level might be marked with
-		 * SD_ASYM_CPUCAPACITY_FULL mask but only for a certain subset
-		 * of CPUs.
-		 * Consider the following:
-		 * #1
-		 *
-		 * DIE [                                ]
-		 * MC  [                       ][       ]
-		 *      [0] [1] [2] [3] [4] [5]  [6] [7]
-		 *      |.....| |.....| |.....|  |.....|
-		 *         L       M       B        B
-		 *
-		 * where:
-		 * arch_scale_cpu_capacity(L) = 512
-		 * arch_scale_cpu_capacity(M) = 871
-		 * arch_scale_cpu_capacity(B) = 1024
-		 *
-		 * MC topology level will be marked with both
-		 * SD_ASYM_CPUCAPACITY flags, but the relevant masks will be:
-		 *	asym_full_mask = [0-5]
-		 *	asym_mask empty (no other asymmetry apart from
-		 *                       already covered [0-5])
-		 *
-		 * #2
-		 *
-		 * DIE [                                        ]
-		 * MC  [                       ][               ]
-		 *      [0] [1] [2] [3] [4] [5]  [6] [7] [8] [9]
-		 *      |.....| |.....| |.....|  |.....| |.....|
-		 *         L       M       B        L       B
-		 *
-		 * MC topology level will be marked with both
-		 * SD_ASYM_CPUCAPACITY flags, but the relevant masks will be:
-		 *	asym_full_mask = [0-5]
-		 *	asym_mask      = [6-9]
-		 */
-		if (data->asym_mask && cpumask_test_cpu(cpu, data->asym_mask))
-			flags = SD_ASYM_CPUCAPACITY;
-		break;
+	if (!data->sched_flags)
+		goto leave;
+	/*
+	 * For topology levels above one, where all CPUs observe all available
+	 * capacities, CPUs mask is not being cached for optimization reasons,
+	 * assuming, that at this point, all possible CPUs are being concerned.
+	 * Those levels will have both: SD_ASYM_CPUCAPACITY and
+	 * SD_ASYM_CPUCAPACITY_FULL flags set.
+	 */
+	if (data->sched_flags & SD_ASYM_CPUCAPACITY_FULL && !data->asym_full_mask)
+		return data->sched_flags;
 
-	}
+	if (data->asym_full_mask && cpumask_test_cpu(cpu, data->asym_full_mask))
+		return data->sched_flags;
+	/*
+	 * A given topology level might be marked with SD_ASYM_CPUCAPACITY_FULL
+	 * mask but only for a certain subset of CPUs.
+	 * Consider the following:
+	 * #1
+	 *
+	 * DIE [                                ]
+	 * MC  [                       ][       ]
+	 *      [0] [1] [2] [3] [4] [5]  [6] [7]
+	 *      |.....| |.....| |.....|  |.....|
+	 *         L       M       B        B
+	 *
+	 * where:
+	 * arch_scale_cpu_capacity(L) = 512
+	 * arch_scale_cpu_capacity(M) = 871
+	 * arch_scale_cpu_capacity(B) = 1024
+	 *
+	 * MC topology level will be marked with both SD_ASYM_CPUCAPACITY flags,
+	 * but the relevant masks will be:
+	 *	asym_full_mask = [0-5]
+	 *	asym_mask empty (no other asymmetry apart from
+	 *                       already covered [0-5])
+	 *
+	 * #2
+	 *
+	 * DIE [                                        ]
+	 * MC  [                       ][               ]
+	 *      [0] [1] [2] [3] [4] [5]  [6] [7] [8] [9]
+	 *      |.....| |.....| |.....|  |.....| |.....|
+	 *         L       M       B        L       B
+	 *
+	 * MC topology level will be marked with both SD_ASYM_CPUCAPACITY flags,
+	 * but the relevant masks will be:
+	 *	asym_full_mask = [0-5]
+	 *	asym_mask      = [6-9]
+	 */
+	if (data->asym_mask && cpumask_test_cpu(cpu, data->asym_mask))
+		return SD_ASYM_CPUCAPACITY;
 leave:
-	return flags;
+	return 0;
 }
 
 
 static inline void asym_cpu_capacity_release_data(struct asym_cache_data *data)
 {
+	struct sched_domain_topology_level *tl;
 	struct asym_cache_data *__data = data;
 
 	if (data) {
-		while (data->tl) {
+		for_each_sd_topology(tl) {
 			if (!data->sched_flags)
 				goto next;
 			if (data->sched_flags & SD_ASYM_CPUCAPACITY_FULL)
@@ -2114,7 +2092,7 @@ static inline void asym_cpu_capacity_release_data(struct asym_cache_data *data)
 			kfree(data->asym_mask);
 next:
 			++data;
-		};
+		}
 		kfree(__data);
 	}
 }
@@ -2168,7 +2146,8 @@ static struct asym_cache_data
 	cpumask_var_t cpu_mask;
 	int cpu;
 
-	/* Build-up a list of all CPU capacities, verifying on the way
+	/*
+	 * Build-up a list of all CPU capacities, verifying on the way
 	 * if there is any asymmetry at all
 	 */
 	for_each_cpu(cpu, cpu_map) {
@@ -2201,11 +2180,8 @@ static struct asym_cache_data
 
 	/* Get the number of topology levels */
 	for_each_sd_topology(tl) level_count++;
-	/*
-	 * Allocate an array to store cached data
-	 * per each topology level + sentinel
-	 */
-	scan_data = kcalloc(level_count + 1, sizeof(*scan_data), GFP_KERNEL);
+	/* Allocate an array to store cached data per each topology level */
+	scan_data = kcalloc(level_count, sizeof(*scan_data), GFP_KERNEL);
 	if (!scan_data) {
 		free_cpumask_var(cpu_mask);
 		goto leave;
@@ -2221,19 +2197,16 @@ static struct asym_cache_data
 
 #ifdef CONFIG_NUMA
 		/*
-		 * For NUMA we might end-up in a sched domain
-		 * that spans numa nodes with cpus with
-		 * different capacities which would not be caught
-		 * by the above scan as those will have
-		 * separate cpumasks - subject to numa level
+		 * For NUMA we might end-up in a sched domain that spans numa
+		 * nodes with cpus with different capacities which would not be
+		 * caught by the above scan as those will have separate cpumasks
+		 * - subject to numa level
 		 * @see: sched_domains_curr_level & sd_numa_mask
 		 * Considered to be a no-go
 		 */
 		if (WARN_ON_ONCE(tl->numa_level && !full_asym))
 			goto leave;
 #endif
-		data->tl = tl;
-
 		if (asym_tl) {
 			data->sched_flags = SD_ASYM_CPUCAPACITY |
 					    SD_ASYM_CPUCAPACITY_FULL;
@@ -2247,10 +2220,10 @@ static struct asym_cache_data
 			int i;
 
 			/*
-			 * Tracking each CPU capacity 'scan' id
-			 * to distinguish discovered capacity sets
-			 * between different CPU masks at each topology level:
-			 * capturing unique capacity values at each scan stage
+			 * Tracking each CPU capacity 'scan' id to distinguish
+			 * discovered capacity sets between different CPU masks
+			 * at each topology level: capturing unique capacity
+			 * values at each scan stage
 			 */
 			++scan_id;
 			local_cap_count = 0;
@@ -2261,8 +2234,8 @@ static struct asym_cache_data
 				capacity = arch_scale_cpu_capacity(i);
 
 				list_for_each_entry(entry, &capacity_set, link) {
-					if (entry->capacity == capacity
-					&&  entry->scan_level < scan_id) {
+					if (entry->capacity == capacity &&
+					    entry->scan_level < scan_id) {
 						entry->scan_level = scan_id;
 						++local_cap_count;
 					}
@@ -2334,12 +2307,12 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	for_each_cpu(i, cpu_map) {
 		struct sched_domain_topology_level *tl;
 		int dflags = 0;
+		int tlid = 0;
 
 		sd = NULL;
 		for_each_sd_topology(tl) {
 			if (!(dflags & SD_ASYM_CPUCAPACITY_FULL)) {
-				dflags |= asym_cpu_capacity_verify(asym_scan_data,
-								   tl, i);
+				dflags |= asym_cpu_capacity_verify(&asym_scan_data[tlid], i);
 				has_asym = dflags & SD_ASYM_CPUCAPACITY;
 			}
 
@@ -2354,6 +2327,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 				sd->flags |= SD_OVERLAP;
 			if (cpumask_equal(cpu_map, sched_domain_span(sd)))
 				break;
+
+			tlid++;
 		}
 	}
 
