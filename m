Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294B4382D39
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 15:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbhEQNTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 09:19:44 -0400
Received: from foss.arm.com ([217.140.110.172]:51240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237219AbhEQNTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 09:19:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95F3D12FC;
        Mon, 17 May 2021 06:18:26 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BD0D3F73B;
        Mon, 17 May 2021 06:18:24 -0700 (PDT)
Date:   Mon, 17 May 2021 14:18:16 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        corbet@lwn.net, rdunlap@infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
Message-ID: <20210517131816.GA13965@e120325.cambridge.arm.com>
References: <1621239831-5870-1-git-send-email-beata.michalska@arm.com>
 <1621239831-5870-3-git-send-email-beata.michalska@arm.com>
 <87mtst1s8m.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtst1s8m.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 01:04:25PM +0100, Valentin Schneider wrote:
> On 17/05/21 09:23, Beata Michalska wrote:
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
> > full range of available CPU capacities is visible to all CPUs within given
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
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> 
> That does look quite simpler :-)
> 
> A lesson for me as a reviewer here is to resist biting into the nitty
> gritty code details and spend more time on a first conceptual / high level
> review pass. It's not the first time I'm guilty of it, so I do need to work
> on that.
> 
> > ---
> >  kernel/sched/topology.c | 129 +++++++++++++++++++++++++++++-------------------
> >  1 file changed, 79 insertions(+), 50 deletions(-)
> >
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 55a0a24..81957f7 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -675,7 +675,7 @@ static void update_top_cache_domain(int cpu)
> >       sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
> >       rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
> >
> > -	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
> > +	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY_FULL);
> >       rcu_assign_pointer(per_cpu(sd_asym_cpucapacity, cpu), sd);
> >  }
> >
> > @@ -1989,66 +1989,96 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
> >
> >       return true;
> >  }
> > -
> > +/**
> > + * Asym capacity bits
> 
> Nit: Dietmar would have us phrase this "Asymmetric CPU capacity bits".
> 
> > + */
> > +struct asym_cap_data {
> > +	struct list_head link;
> > +	unsigned long    capacity;
> > +	struct cpumask   *cpu_mask;
> > +};
> 
> > +/*
> > + * Verify whether given CPU at a given topology level belongs to a sched domain
> > + * that does span CPUs with different capacities.
> > + * Provides sd_flags reflecting the asymmetry scope.
> > + */
> > +static inline int
> > +asym_cpu_capacity_classify(struct sched_domain_topology_level *tl, int cpu)
> > +{
> > +	int sd_asym_flags = SD_ASYM_CPUCAPACITY | SD_ASYM_CPUCAPACITY_FULL;
> > +	const struct cpumask *tl_mask = tl->mask(cpu);
> > +	struct asym_cap_data *entry;
> > +	int asym_cap_count = 0;
> > +
> > +	if (list_is_singular(&asym_cap_list))
> > +		goto leave;
> > +
> > +	list_for_each_entry(entry, &asym_cap_list, link) {
> > +		if (cpumask_intersects(tl_mask, entry->cpu_mask))
> > +			++asym_cap_count;
> 
> Ah, this is using tl->mask() which *isn't* masked by the root_domain's
> cpu_map...
> 
> See comment below on the scan; long story short we could issue this *after*
> build_sched_domain() so we can directly use sched_domain_span(sd) which
> *is* masked by the cpu_map. This kind of removes the need for that dflags
> param, but then we're already sidestepping it for SD_OVERLAP.
> 
> EDIT: nope, we have a check against SD_ASYM_CPUCAPACITY in sd_init()... I
> guess we could issue asym_cpu_capacity_classify() in sd_init() itself?
> 
Yeah, sd_init does rely on the SD_ASYM_CPUCAPACITY flag being available,
if needed. The tl->mask isn't masked out but the per-capacity masks are.
Should be enough for the intersection check.
> > +/*
> > + * Build-up/update list of CPUs grouped by their capacities
> > + */
> > +static void asym_cpu_capacity_scan(const struct cpumask *cpu_map)
> > +{
> > +	struct asym_cap_data *entry, *next;
> > +	int cpu;
> >
> > -		for_each_sd_topology(tl) {
> > -			if (tl_id < asym_level)
> > -				goto next_level;
> > +	if (!list_empty(&asym_cap_list))
> > +		list_for_each_entry(entry, &asym_cap_list, link)
> > +			cpumask_clear(entry->cpu_mask);
> >
> 
> The topology isn't going to change between domain rebuilds, so why
> recompute the masks? The sched_domain spans are already masked by cpu_map,
> so no need to do this masking twice. I'm thinking this scan should be done
> once against the cpu_possible_mask - kinda like sched_init_numa() done once
> against the possible nodes.
> 
This is currently done, as what you have mentioned earlier, the tl->mask
may contain CPUs that are not 'available'. So it makes sure that the masks
kept on  the list are representing only those CPUs that are online.
And it is also needed case all CPUs of given capacity go offline - not to to
lose the full asymmetry that might change because of that ( empty masks are
being removed from the list).
I could change that and use the CPU mask that represents the online CPUs as
a checkpoint but then it also means additional tracking which items on the
list are actually available at a given point of time.
So if the CPUs masks on the list are to be set once (as you are suggesting)
than it needs additional logic to count the number of available capacities
to decide whether there is a full asymmetry or not.

> Ideally I'd see this as an __init function, unfortunately we need that to
> happen after cpufreq drivers have been loaded (in case all CPUs have same
> µarch but some can reach higher frequencies, which would yield asymmetry),
> and some of those can be built as modules :/
>
Yeah, this is the tricky bit: and one of the reasons the capacity masks are
being cleared.
> > +		entry = kzalloc(sizeof(*entry) + cpumask_size(), GFP_KERNEL);
> > +		if (entry) {
> > +			entry->capacity = capacity;
> > +			entry->cpu_mask = (struct cpumask *)((char *)entry +
> > +					   sizeof(*entry));
> > +			list_add(&entry->link, &asym_cap_list);
> >               }
> > +		WARN_ONCE(!entry,
> > +		    "Failed to allocate memory for capacity asymmetry detection\n");
> > +next:
> > +		__cpumask_set_cpu(cpu, entry->cpu_mask);
> 
> That looks like a NULL deref if the above WARN is hit.
Nah, indeed!

---
BR
B.
