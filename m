Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109B538F5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhEXW4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:56:50 -0400
Received: from foss.arm.com ([217.140.110.172]:48784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229568AbhEXW4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:56:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AF266D;
        Mon, 24 May 2021 15:55:20 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FC2F3F73D;
        Mon, 24 May 2021 15:55:18 -0700 (PDT)
Date:   Mon, 24 May 2021 23:55:09 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        corbet@lwn.net, rdunlap@infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
Message-ID: <20210524225508.GA14880@e120325.cambridge.arm.com>
References: <20210524101617.8965-1-beata.michalska@arm.com>
 <20210524101617.8965-3-beata.michalska@arm.com>
 <87fsyc6mfz.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fsyc6mfz.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 07:01:04PM +0100, Valentin Schneider wrote:
> Hi Beata,
> 
> On 24/05/21 11:16, Beata Michalska wrote:
> > Currently the CPU capacity asymmetry detection, performed through
> > asym_cpu_capacity_level, tries to identify the lowest topology level
> > at which the highest CPU capacity is being observed, not necessarily
> > finding the level at which all possible capacity values are visible
> > to all CPUs, which might be bit problematic for some possible/valid
> > asymmetric topologies i.e.:
> >
> > DIE      [                                ]
> > MC       [                       ][       ]
> >
> > CPU       [0] [1] [2] [3] [4] [5]  [6] [7]
> > Capacity  |.....| |.....| |.....|  |.....|
> >            L	     M       B        B
> >
> > Where:
> >  arch_scale_cpu_capacity(L) = 512
> >  arch_scale_cpu_capacity(M) = 871
> >  arch_scale_cpu_capacity(B) = 1024
> >
> > In this particular case, the asymmetric topology level will point
> > at MC, as all possible CPU masks for that level do cover the CPU
> > with the highest capacity. It will work just fine for the first
> > cluster, not so much for the second one though (consider the
> > find_energy_efficient_cpu which might end up attempting the energy
> > aware wake-up for a domain that does not see any asymmetry at all)
> >
> > Rework the way the capacity asymmetry levels are being detected,
> > allowing to point to the lowest topology level (for a given CPU), where
> > full set of available CPU capacities is visible to all CPUs within given
> > domain. As a result, the per-cpu sd_asym_cpucapacity might differ across
> > the domains. This will have an impact on EAS wake-up placement in a way
> > that it might see different rage of CPUs to be considered, depending on
> > the given current and target CPUs.
> >
> > Additionally, those levels, where any range of asymmetry (not
> > necessarily full) is being detected will get identified as well.
> > The selected asymmetric topology level will be denoted by
> > SD_ASYM_CPUCAPACITY_FULL sched domain flag whereas the 'sub-levels'
> > would receive the already used SD_ASYM_CPUCAPACITY flag. This allows
> > maintaining the current behaviour for asymmetric topologies, with
> > misfit migration operating correctly on lower levels, if applicable,
> > as any asymmetry is enough to trigger the misfit migration.
> > The logic there relies on the SD_ASYM_CPUCAPACITY flag and does not
> > relate to the full asymmetry level denoted by the sd_asym_cpucapacity
> > pointer.
> >
> > Detecting the CPU capacity asymmetry is being based on a set of
> > available CPU capacities for all possible CPUs. This data is being
> > generated upon init and updated once CPU topology changes are being
> > detected (through arch_update_cpu_topology). As such, any changes
> > to identified CPU capacities (like initializing cpufreq) need to be
> > explicitly advertised by corresponding archs to trigger rebuilding
> > the data.
> >
> > This patch also removes the additional -dflags- parameter used when
>   ^^^^^^^^^^^^^^^^^^^^^^^
> s/^/Also remove/
I would kind of ... disagree.
All the commit msg is constructed using passive structure, the suggestion
would actually break that. And it does 'sound' bit imperative but I guess
that is subjective. I'd rather stay with impersonal structure (which is
applied through out the whole patchset).
> 
> > building sched domains as the asymmetry flags are now being set
> > directly in sd_init.
> >
> 
> Few nits below, but beyond that:
> 
> Tested-by: Valentin Schneider <valentin.schneider@arm.com>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 
Thanks a lot for the review and testing!

> > +static inline int
> > +asym_cpu_capacity_classify(struct sched_domain *sd,
> > +			   const struct cpumask *cpu_map)
> > +{
> > +	int sd_asym_flags = SD_ASYM_CPUCAPACITY | SD_ASYM_CPUCAPACITY_FULL;
> > +	struct asym_cap_data *entry;
> > +	int asym_cap_count = 0;
> > +
> > +	if (list_is_singular(&asym_cap_list))
> > +		goto leave;
> > +
> > +	list_for_each_entry(entry, &asym_cap_list, link) {
> > +		if (cpumask_intersects(sched_domain_span(sd), entry->cpu_mask)) {
> > +			++asym_cap_count;
> > +		} else {
> > +			/*
> > +			 * CPUs with given capacity might be offline
> > +			 * so make sure this is not the case
> > +			 */
> > +			if (cpumask_intersects(entry->cpu_mask, cpu_map)) {
> > +				sd_asym_flags &= ~SD_ASYM_CPUCAPACITY_FULL;
> > +				if (asym_cap_count > 1)
> > +					break;
> > +			}
> 
> Readability nit: That could be made into an else if ().
It could but then this way the -comment- gets more exposed.
But that might be my personal perception so I can change that.
> 
> 
> > +		}
> > +	}
> > +	WARN_ON_ONCE(!asym_cap_count);
> > +leave:
> > +	return asym_cap_count > 1 ? sd_asym_flags : 0;
> > +}
> > +
> 
> > +static void asym_cpu_capacity_scan(void)
> > +{
> > +	struct asym_cap_data *entry, *next;
> > +	int cpu;
> > +
> > +	list_for_each_entry(entry, &asym_cap_list, link)
> > +		cpumask_clear(entry->cpu_mask);
> > +
> > +	entry = list_first_entry_or_null(&asym_cap_list,
> > +					 struct asym_cap_data, link);
> > +
> > +	for_each_cpu_and(cpu, cpu_possible_mask,
> > +			 housekeeping_cpumask(HK_FLAG_DOMAIN)) {
> > +		unsigned long capacity = arch_scale_cpu_capacity(cpu);
> > +
> > +		if (!entry || capacity != entry->capacity)
> > +			entry = asym_cpu_capacity_get_data(capacity);
> > +		if (entry)
> > +			__cpumask_set_cpu(cpu, entry->cpu_mask);
> 
> That 'if' is only there in case the alloc within the helper failed, which
> is a bit of a shame.
> 
> You could pass the CPU to that helper function and have it set the right
> bit, or you could even forgo the capacity != entry->capacity check here and
> let the helper function do it all.
> 
> Yes, that means more asym_cap_list iterations, but that's
> O(nr_cpus * nr_caps); a topology rebuild is along the lines of
> O(nr_cpus² * nr_topology_levels), so not such a big deal comparatively.
> 
I could drop that check and make the helper function update the CPUs mask
(along with dropping the initial grabbing of the first entry)
+
switching to list_for_each_entry_reverse which would result in less
iterations for most (if not all) of the use cases.


---
BR
B
> > +	}
> > +
> > +	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
> > +		if (cpumask_empty(entry->cpu_mask)) {
> > +			list_del(&entry->link);
> > +			kfree(entry);
> > +		}
> > +	}
> > +}
> > +
