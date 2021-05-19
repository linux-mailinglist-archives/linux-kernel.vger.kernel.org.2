Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5CD3896F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhESTtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:49:42 -0400
Received: from foss.arm.com ([217.140.110.172]:54274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232171AbhESTtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:49:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E062311D4;
        Wed, 19 May 2021 12:48:20 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 810B73F73D;
        Wed, 19 May 2021 12:48:18 -0700 (PDT)
Date:   Wed, 19 May 2021 20:48:09 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        corbet@lwn.net, rdunlap@infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
Message-ID: <20210519194808.GA15842@e120325.cambridge.arm.com>
References: <1621239831-5870-1-git-send-email-beata.michalska@arm.com>
 <1621239831-5870-3-git-send-email-beata.michalska@arm.com>
 <YKT2vbluMgcu94M6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKT2vbluMgcu94M6@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 01:30:05PM +0200, Peter Zijlstra wrote:
> 
> Mostly style nits, since I read you're already looking at reworking this
> due to other feedback, do with it what you like.
>
Will apply your remarks on whatever ends up in the new version, which should be
most of it. To be out soon.

Thank You

---
BR
B.
> On Mon, May 17, 2021 at 09:23:50AM +0100, Beata Michalska wrote:
> > @@ -1989,66 +1989,96 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
> >  
> >  	return true;
> >  }
> 
> + whitespace
> 
> > +/**
> > + * Asym capacity bits
> > + */
> > +struct asym_cap_data {
> > +	struct list_head link;
> > +	unsigned long    capacity;
> > +	struct cpumask   *cpu_mask;
> > +};
> 
> + whitespace
> 
> >  /*
> > + * Set of available CPUs grouped by their corresponding capacities
> > + * Each list entry contains a CPU mask reflecting CPUs that share the same
> > + * capacity.
> > + * The lifespan of data is unlimited.
> >   */
> > +static LIST_HEAD(asym_cap_list);
> >  
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
> > +		else
> > +			sd_asym_flags &= ~SD_ASYM_CPUCAPACITY_FULL;
> >  	}
> > +	WARN_ON_ONCE(!asym_cap_count);
> > +leave:
> > +	return asym_cap_count > 1 ? sd_asym_flags : 0;
> > +}
> >  
> >  
> 
> - whitespace
> 
> > +/*
> > + * Build-up/update list of CPUs grouped by their capacities
> > + */
> > +static void asym_cpu_capacity_scan(const struct cpumask *cpu_map)
> > +{
> > +	struct asym_cap_data *entry, *next;
> > +	int cpu;
> >  
> > +	if (!list_empty(&asym_cap_list))
> > +		list_for_each_entry(entry, &asym_cap_list, link)
> > +			cpumask_clear(entry->cpu_mask);
> 
> two nits:
> 
>  - the if() needs { } because while what follows is strictly a single
>    statement, it is multi-line, so coding style requires { }.
> 
>  - the if() is strictly superfluous, if the list is empty the
>    list_for_each_entry() iteration already doesn't do anything.
> 
> >  
> > +	entry = list_first_entry_or_null(&asym_cap_list,
> > +			struct asym_cap_data, link);
> 
> Please align line-breaks at the most nested (, vim can help you do this
> with: set cino=(0:0, if you're using that other editor, I'm sure you can
> convince it to align properly too :-)
> 
> >  
> > +	for_each_cpu(cpu, cpu_map) {
> > +		unsigned long capacity = arch_scale_cpu_capacity(cpu);
> >  
> > +		if (entry && capacity == entry->capacity)
> > +			goto next;
> >  
> > +		list_for_each_entry(entry, &asym_cap_list, link)
> > +			if (capacity == entry->capacity)
> > +				goto next;
> 
> { } again
> 
> > +
> > +		entry = kzalloc(sizeof(*entry) + cpumask_size(), GFP_KERNEL);
> > +		if (entry) {
> > +			entry->capacity = capacity;
> > +			entry->cpu_mask = (struct cpumask *)((char *)entry +
> > +					   sizeof(*entry));
> 
> alignment again
> 
> > +			list_add(&entry->link, &asym_cap_list);
> >  		}
> > +		WARN_ONCE(!entry,
> > +		    "Failed to allocate memory for capacity asymmetry detection\n");
> 
> alignment again
> 
> (also, eeew, if this lives, perhaps a find_asym_data(capacity) helper
> might make it better:
> 
> 		if (!entry || entry->capacity != capacity)
> 			entry = find_asym_data(capacity);
> )
> 
> > +next:
> > +		__cpumask_set_cpu(cpu, entry->cpu_mask);
> >  	}
> >  
> > +	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
> > +		if (cpumask_empty(entry->cpu_mask)) {
> > +			list_del(&entry->link);
> > +			kfree(entry);
> > +		}
> > +	}
> 
> See, this has { }
> 
> >  }
