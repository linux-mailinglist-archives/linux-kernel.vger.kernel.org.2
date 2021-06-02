Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED6F399404
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhFBT4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:56:25 -0400
Received: from foss.arm.com ([217.140.110.172]:53224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhFBT4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:56:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A924A1063;
        Wed,  2 Jun 2021 12:54:39 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F1333F774;
        Wed,  2 Jun 2021 12:54:38 -0700 (PDT)
Date:   Wed, 2 Jun 2021 20:54:35 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        corbet@lwn.net, rdunlap@infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
Message-ID: <20210602195435.GB18136@e120325.cambridge.arm.com>
References: <20210527153842.17567-1-beata.michalska@arm.com>
 <20210527153842.17567-3-beata.michalska@arm.com>
 <8ea4cfc2-514b-6b5c-7269-7720a54dbb39@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ea4cfc2-514b-6b5c-7269-7720a54dbb39@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 09:09:54PM +0200, Dietmar Eggemann wrote:
> On 27/05/2021 17:38, Beata Michalska wrote:
> 
> [...]
> 
> > +/*
> > + * Verify whether there is any CPU capacity asymmetry in a given sched domain.
> > + * Provides sd_flags reflecting the asymmetry scope.
> > + */
> > +static inline int
> > +asym_cpu_capacity_classify(struct sched_domain *sd,
> > +			   const struct cpumask *cpu_map)
> > +{
> > +	struct asym_cap_data *entry;
> > +	int sd_asym_flags = 0;
> > +	int asym_cap_count = 0;
> > +	int asym_cap_miss = 0;
> > +
> > +	/*
> > +	 * Count how many unique CPU capacities this domain spans across
> > +	 * (compare sched_domain CPUs mask with ones representing  available
> > +	 * CPUs capacities). Take into account CPUs that might be offline:
> > +	 * skip those.
> > +	 */
> > +	list_for_each_entry(entry, &asym_cap_list, link) {
> > +		if (cpumask_intersects(sched_domain_span(sd),
> > +				       cpu_capacity_span(entry)))
> > +			++asym_cap_count;
> > +		else if (cpumask_intersects(cpu_capacity_span(entry), cpu_map))
> 
> nit: `sd span, entry span` but `entry span, cpu_map`. Why not `cpu_map, entry span`?
>
Cannot recall any reason for that.

> > +			++asym_cap_miss;
> > +	}
> > +	/* No asymmetry detected */
> > +	if (WARN_ON_ONCE(!asym_cap_count) || asym_cap_count == 1)
> > +		goto leave;
> > +
> > +	sd_asym_flags |= SD_ASYM_CPUCAPACITY;
> > +
> > +	/*
> > +	 * All the available capacities have been found within given sched
> > +	 * domain: no misses reported.
> > +	 */
> > +	if (!asym_cap_miss)
> > +		sd_asym_flags |= SD_ASYM_CPUCAPACITY_FULL;
> > +
> > +leave:
> > +	return sd_asym_flags;
> > +}
> 
> Everything looks good except that I like this more compact version better, proposed in:  
> 
> https://lkml.kernel.org/r/YK9ESqNEo+uacyMD@hirez.programming.kicks-ass.net
> 
> And passing `const struct cpumask *sd_span` instead of `struct
> sched_domain *sd` into the function.
>
I do understand the parameter argument, but honestly don't see much difference
in naming and switching single return for asymmetric topologies vs two return
statement, but if that is more preferred/readable version I do not mind changing
that as well.

Thanks for the review.

---
BR
B.

> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 77b73abbb9a4..0de8eebded9f 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1290,13 +1290,11 @@ static LIST_HEAD(asym_cap_list);
>   * Provides sd_flags reflecting the asymmetry scope.
>   */  
>  static inline int 
> -asym_cpu_capacity_classify(struct sched_domain *sd,
> +asym_cpu_capacity_classify(const struct cpumask *sd_span,
>                            const struct cpumask *cpu_map)
>  {
>         struct asym_cap_data *entry;
> -       int sd_asym_flags = 0;
> -       int asym_cap_count = 0;
> -       int asym_cap_miss = 0;
> +       int count = 0, miss = 0;
>  
>         /*
>          * Count how many unique CPU capacities this domain spans across
> @@ -1305,27 +1303,20 @@ asym_cpu_capacity_classify(struct sched_domain *sd,
>          * skip those.
>          */
>         list_for_each_entry(entry, &asym_cap_list, link) {
> -               if (cpumask_intersects(sched_domain_span(sd),
> -                                      cpu_capacity_span(entry)))
> -                       ++asym_cap_count;
> -               else if (cpumask_intersects(cpu_capacity_span(entry), cpu_map))
> -                       ++asym_cap_miss;
> +               if (cpumask_intersects(sd_span, cpu_capacity_span(entry)))
> +                       ++count;
> +               else if (cpumask_intersects(cpu_map, cpu_capacity_span(entry)))
> +                       ++miss;
>         }
> -       /* No asymmetry detected */
> -       if (WARN_ON_ONCE(!asym_cap_count) || asym_cap_count == 1)
> -               goto leave;
>  
> -       sd_asym_flags |= SD_ASYM_CPUCAPACITY;
> +       if (WARN_ON_ONCE(!count) || count == 1) /* No asymmetry */
> +               return 0;
>  
> -       /*
> -        * All the available capacities have been found within given sched
> -        * domain: no misses reported.
> -        */
> -       if (!asym_cap_miss)
> -               sd_asym_flags |= SD_ASYM_CPUCAPACITY_FULL;
> +       if (miss) /* Partial asymmetry */
> +               return SD_ASYM_CPUCAPACITY;
>  
> -leave:
> -       return sd_asym_flags;
> +       /* Full asymmetry */
> +       return SD_ASYM_CPUCAPACITY | SD_ASYM_CPUCAPACITY_FULL;
>  }
>  
>  static inline void asym_cpu_capacity_update_data(int cpu)
> @@ -1510,6 +1501,7 @@ sd_init(struct sched_domain_topology_level *tl,
>         struct sd_data *sdd = &tl->data;
>         struct sched_domain *sd = *per_cpu_ptr(sdd->sd, cpu);
>         int sd_id, sd_weight, sd_flags = 0;
> +       struct cpumask *sd_span;
>  
>  #ifdef CONFIG_NUMA
>         /*
> @@ -1557,10 +1549,11 @@ sd_init(struct sched_domain_topology_level *tl,
>  #endif
>         };
>  
> -       cpumask_and(sched_domain_span(sd), cpu_map, tl->mask(cpu));
> -       sd_id = cpumask_first(sched_domain_span(sd));
> +       sd_span = sched_domain_span(sd);
> +       cpumask_and(sd_span, cpu_map, tl->mask(cpu));
> +       sd_id = cpumask_first(sd_span);
>  
> -       sd->flags |= asym_cpu_capacity_classify(sd, cpu_map);
> +       sd->flags |= asym_cpu_capacity_classify(sd_span, cpu_map);
>  
>         WARN_ONCE((sd->flags & (SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY)) ==
>                   (SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY),
> -- 
> 2.25.1
