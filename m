Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22507398A31
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFBNFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:05:53 -0400
Received: from foss.arm.com ([217.140.110.172]:44354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhFBNFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:05:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 532A91063;
        Wed,  2 Jun 2021 06:04:06 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D001E3F719;
        Wed,  2 Jun 2021 06:04:03 -0700 (PDT)
Date:   Wed, 2 Jun 2021 14:03:55 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        corbet@lwn.net, rdunlap@infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
Message-ID: <20210602130355.GA19640@e120325.cambridge.arm.com>
References: <20210527153842.17567-1-beata.michalska@arm.com>
 <20210527153842.17567-3-beata.michalska@arm.com>
 <87eedkfn1u.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eedkfn1u.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 01:50:21PM +0100, Valentin Schneider wrote:
> On 27/05/21 16:38, Beata Michalska wrote:
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Suggested-by: Valentin Schneider <valentin.schneider@arm.com>
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> 
> I ran this through the usual series of tests ('exotic' topologies, hotplug
> and exclusive cpusets), it all behaves as expected.
> 
Thanks for that!

> Tested-by: Valentin Schneider <valentin.schneider@arm.com>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> Some tiny cosmetic nits below, which don't warrant a new revision, and a
> comment wrt purely symmetric systems.
> 
> > ---
> >  kernel/sched/topology.c | 194 ++++++++++++++++++++++++----------------
> >  1 file changed, 118 insertions(+), 76 deletions(-)
> >
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 55a0a243e871..77e6f79235ad 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
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
> 
> IMO this is one such place where the 80 chars limit can be omitted.
> 
> > +			++asym_cap_count;
> > +		else if (cpumask_intersects(cpu_capacity_span(entry), cpu_map))
> > +			++asym_cap_miss;
> > +	}
> 
> > +/*
> > + * Build-up/update list of CPUs grouped by their capacities
> > + * An update requires explicit request to rebuild sched domains
> > + * with state indicating CPU topology changes.
> > + */
> > +static void asym_cpu_capacity_scan(void)
> > +{
> > +	struct asym_cap_data *entry, *next;
> > +	int cpu;
> > +
> > +	list_for_each_entry(entry, &asym_cap_list, link)
> > +		cpumask_clear(cpu_capacity_span(entry));
> > +
> > +	for_each_cpu_and(cpu, cpu_possible_mask,
> > +			 housekeeping_cpumask(HK_FLAG_DOMAIN))
> 
> Ditto on keeping this on a single line.
> 
> > +		asym_cpu_capacity_update_data(cpu);
> > +
> > +	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
> > +		if (cpumask_empty(cpu_capacity_span(entry))) {
> > +			list_del(&entry->link);
> > +			kfree(entry);
> > +		}
> > +	}
> > +}
> 
> One "corner case" that comes to mind is systems / architectures which are
> purely symmetric wrt CPU capacity. Our x86 friends might object to us
> reserving a puny 24 bytes + cpumask_size() in a corner of their
> memory.
> 
> Perhaps we could clear the list in the list_is_singular_case(), and since
> the rest of the code only does list iteration, this should 'naturally'
> cover this case:
>
Can do that.
I am also waiting for a reply regarding the asymmetry detected on an SMT level.
Once I get that solved, I will push new version with embedding your suggestions
as well.

Thanks for having a look!

---
BR
B.
> ---
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 62d412013df8..b06d277fa280 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1305,14 +1305,13 @@ asym_cpu_capacity_classify(struct sched_domain *sd,
>  	 * skip those.
>  	 */
>  	list_for_each_entry(entry, &asym_cap_list, link) {
> -		if (cpumask_intersects(sched_domain_span(sd),
> -				       cpu_capacity_span(entry)))
> +		if (cpumask_intersects(sched_domain_span(sd), cpu_capacity_span(entry)))
>  			++asym_cap_count;
>  		else if (cpumask_intersects(cpu_capacity_span(entry), cpu_map))
>  			++asym_cap_miss;
>  	}
>  	/* No asymmetry detected */
> -	if (WARN_ON_ONCE(!asym_cap_count) || asym_cap_count == 1)
> +	if (asym_cap_count < 2)
>  		goto leave;
>  
>  	sd_asym_flags |= SD_ASYM_CPUCAPACITY;
> @@ -1360,8 +1359,7 @@ static void asym_cpu_capacity_scan(void)
>  	list_for_each_entry(entry, &asym_cap_list, link)
>  		cpumask_clear(cpu_capacity_span(entry));
>  
> -	for_each_cpu_and(cpu, cpu_possible_mask,
> -			 housekeeping_cpumask(HK_FLAG_DOMAIN))
> +	for_each_cpu_and(cpu, cpu_possible_mask, housekeeping_cpumask(HK_FLAG_DOMAIN))
>  		asym_cpu_capacity_update_data(cpu);
>  
>  	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
> @@ -1370,6 +1368,16 @@ static void asym_cpu_capacity_scan(void)
>  			kfree(entry);
>  		}
>  	}
> +
> +	/*
> +	 * There's only one capacity value, i.e. this system is symmetric.
> +	 * No need to keep this data around.
> +	 */
> +	if (list_is_singular(&asym_cap_list)) {
> +		entry = list_first_entry(&asym_cap_list, typeof(*entry), link);
> +		list_del(&entry->link);
> +		kfree(entry);
> +	}
>  }
>  
>  /*
