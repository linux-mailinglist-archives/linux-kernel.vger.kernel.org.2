Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869EF38FDE3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhEYJcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:32:21 -0400
Received: from foss.arm.com ([217.140.110.172]:53812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232603AbhEYJcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:32:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C6B76D;
        Tue, 25 May 2021 02:30:49 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 935FE3F73D;
        Tue, 25 May 2021 02:30:47 -0700 (PDT)
Date:   Tue, 25 May 2021 10:30:39 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        corbet@lwn.net, rdunlap@infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
Message-ID: <20210525093039.GA31871@e120325.cambridge.arm.com>
References: <20210524101617.8965-1-beata.michalska@arm.com>
 <20210524101617.8965-3-beata.michalska@arm.com>
 <cdb4e3a4-569f-1dc2-be22-c0128250996a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdb4e3a4-569f-1dc2-be22-c0128250996a@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 10:25:36AM +0200, Dietmar Eggemann wrote:
> On 24/05/2021 12:16, Beata Michalska wrote:
> 
> [...]
> 
> > Rework the way the capacity asymmetry levels are being detected,
> > allowing to point to the lowest topology level (for a given CPU), where
> > full set of available CPU capacities is visible to all CPUs within given
> > domain. As a result, the per-cpu sd_asym_cpucapacity might differ across
> > the domains. This will have an impact on EAS wake-up placement in a way
> > that it might see different rage of CPUs to be considered, depending on
> 
> s/rage/range ;-)
Right ..... :)
> 
> [...]
> 
> > @@ -1266,6 +1266,112 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
> >  	update_group_capacity(sd, cpu);
> >  }
> >  
> > +/**
> > + * Asymmetric CPU capacity bits
> > + */
> > +struct asym_cap_data {
> > +	struct list_head link;
> > +	unsigned long    capacity;
> > +	struct cpumask   *cpu_mask;
> 
> Not sure if this has been discussed already but shouldn't the flexible
> array members` approach known from struct sched_group, struct
> sched_domain or struct em_perf_domain be used here?
> IIRC the last time this has been discussed in this thread:
> https://lkml.kernel.org/r/20200910054203.525420-2-aubrey.li@intel.com
> 
If I got right the discussion you have pointed to, it was about using
cpumask_var_t which is not the case here. I do not mind moving the code
to use the array but I am not sure if this changes much. Looking at the
code changes to support that (to_cpumask namely) it was introduced for
cases where cpumask_var_t was not appropriate, which again isn't the case
here.

---
BR
B.
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 0de6eef91bc8..03e492e91bd7 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1271,8 +1271,8 @@ static void init_sched_groups_capacity(int cpu,
> struct sched_domain *sd)
>   */
>  struct asym_cap_data {
>         struct list_head link;
> -       unsigned long    capacity;
> -       struct cpumask   *cpu_mask;
> +       unsigned long capacity;
> +       unsigned long cpumask[];
>  };
> 
>  /*
> @@ -1299,14 +1299,14 @@ asym_cpu_capacity_classify(struct sched_domain *sd,
>                 goto leave;
> 
>         list_for_each_entry(entry, &asym_cap_list, link) {
> -               if (cpumask_intersects(sched_domain_span(sd),
> entry->cpu_mask)) {
> +               if (cpumask_intersects(sched_domain_span(sd),
> to_cpumask(entry->cpumask))) {
>                         ++asym_cap_count;
>                 } else {
>                         /*
>                          * CPUs with given capacity might be offline
>                          * so make sure this is not the case
>                          */
> -                       if (cpumask_intersects(entry->cpu_mask, cpu_map)) {
> +                       if
> (cpumask_intersects(to_cpumask(entry->cpumask), cpu_map)) {
>                                 sd_asym_flags &= ~SD_ASYM_CPUCAPACITY_FULL;
>                                 if (asym_cap_count > 1)
>                                         break;
> @@ -1332,7 +1332,6 @@ asym_cpu_capacity_get_data(unsigned long capacity)
>         if (WARN_ONCE(!entry, "Failed to allocate memory for asymmetry
> data\n"))
>                 goto done;
>         entry->capacity = capacity;
> -       entry->cpu_mask = (struct cpumask *)((char *)entry +
> sizeof(*entry));
>         list_add(&entry->link, &asym_cap_list);
>  done:
>         return entry;
> @@ -1349,7 +1348,7 @@ static void asym_cpu_capacity_scan(void)
>         int cpu;
> 
>         list_for_each_entry(entry, &asym_cap_list, link)
> -               cpumask_clear(entry->cpu_mask);
> +               cpumask_clear(to_cpumask(entry->cpumask));
> 
>         entry = list_first_entry_or_null(&asym_cap_list,
>                                          struct asym_cap_data, link);
> @@ -1361,11 +1360,11 @@ static void asym_cpu_capacity_scan(void)
>                 if (!entry || capacity != entry->capacity)
>                         entry = asym_cpu_capacity_get_data(capacity);
>                 if (entry)
> -                       __cpumask_set_cpu(cpu, entry->cpu_mask);
> +                       __cpumask_set_cpu(cpu, to_cpumask(entry->cpumask));
>         }
> 
>         list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
> -               if (cpumask_empty(entry->cpu_mask)) {
> +               if (cpumask_empty(to_cpumask(entry->cpumask))) {
>                         list_del(&entry->link);
>                         kfree(entry);
>                 }
> 
> [...]
