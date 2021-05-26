Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF9539180B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhEZMzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:55:24 -0400
Received: from foss.arm.com ([217.140.110.172]:44228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234950AbhEZMxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:53:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E52821516;
        Wed, 26 May 2021 05:51:38 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 880FD3F73D;
        Wed, 26 May 2021 05:51:36 -0700 (PDT)
Date:   Wed, 26 May 2021 13:51:34 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, corbet@lwn.net, rdunlap@infradead.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
Message-ID: <20210526125133.GB13262@e120325.cambridge.arm.com>
References: <20210524101617.8965-1-beata.michalska@arm.com>
 <20210524101617.8965-3-beata.michalska@arm.com>
 <87fsyc6mfz.mognet@arm.com>
 <20210524225508.GA14880@e120325.cambridge.arm.com>
 <87a6oj6sxo.mognet@arm.com>
 <20210525102945.GA24210@e120325.cambridge.arm.com>
 <98ad8837-b9b8-ff50-5a91-8d5951ee757c@arm.com>
 <20210526121546.GA13262@e120325.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526121546.GA13262@e120325.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 01:15:46PM +0100, Beata Michalska wrote:
> On Wed, May 26, 2021 at 11:52:25AM +0200, Dietmar Eggemann wrote:
> > On 25/05/2021 12:29, Beata Michalska wrote:
> > > On Tue, May 25, 2021 at 10:53:07AM +0100, Valentin Schneider wrote:
> > >> On 24/05/21 23:55, Beata Michalska wrote:
> > >>> On Mon, May 24, 2021 at 07:01:04PM +0100, Valentin Schneider wrote:
> > >>>> On 24/05/21 11:16, Beata Michalska wrote:
> > 
> > [...]
> > 
> > >>>>> +static inline int
> > >>>>> +asym_cpu_capacity_classify(struct sched_domain *sd,
> > >>>>> +			   const struct cpumask *cpu_map)
> > >>>>> +{
> > >>>>> +	int sd_asym_flags = SD_ASYM_CPUCAPACITY | SD_ASYM_CPUCAPACITY_FULL;
> > >>>>> +	struct asym_cap_data *entry;
> > >>>>> +	int asym_cap_count = 0;
> > >>>>> +
> > >>>>> +	if (list_is_singular(&asym_cap_list))
> > >>>>> +		goto leave;
> > >>>>> +
> > >>>>> +	list_for_each_entry(entry, &asym_cap_list, link) {
> > >>>>> +		if (cpumask_intersects(sched_domain_span(sd), entry->cpu_mask)) {
> > >>>>> +			++asym_cap_count;
> > >>>>> +		} else {
> > >>>>> +			/*
> > >>>>> +			 * CPUs with given capacity might be offline
> > >>>>> +			 * so make sure this is not the case
> > >>>>> +			 */
> > >>>>> +			if (cpumask_intersects(entry->cpu_mask, cpu_map)) {
> > >>>>> +				sd_asym_flags &= ~SD_ASYM_CPUCAPACITY_FULL;
> > >>>>> +				if (asym_cap_count > 1)
> > >>>>> +					break;
> > >>>>> +			}
> > >>>>
> > >>>> Readability nit: That could be made into an else if ().
> > >>> It could but then this way the -comment- gets more exposed.
> > >>> But that might be my personal perception so I can change that.
> > >>
> > >> As always those are quite subjective! Methink something like this would
> > >> still draw attention to the offline case:
> > >>
> > >>                /*
> > >>                 * Count how many unique capacities this domain covers. If a
> > >>                 * capacity isn't covered, we need to check if any CPU with
> > >>                 * that capacity is actually online, otherwise it can be
> > >>                 * ignored.
> > >>                 */
> > >>                 if (cpumask_intersects(sched_domain_span(sd), entry->cpu_mask)) {
> > >>                         ++asym_cap_count;
> > >>                 } else if (cpumask_intersects(entry->cpu_mask, cpu_map)) {
> > >>                         sd_asym_flags &= ~SD_ASYM_CPUCAPACITY_FULL;
> > >>                         if (asym_cap_count > 1)
> > >>                                 break;
> > >>                 }
> > > Noted.
> > > Will wait for some more comments before sending out 'polished' version.
> > 
> > For me asym_cpu_capacity_classify() is pretty hard to digest ;-) But I
> > wasn't able to break it. It also performs correctly on (non-existing SMT)
> > layer (with sd span eq. single CPU).
> > 
> > Something like this (separating asym_cap_list iteration and flags
> > construction would be easier for me. But like already said here,
> > it's subjective.
> > I left the two optimizations (list_is_singular(), break on asym_cap_count
> > > 1) out for now. asym_cap_list shouldn't have > 4 entries (;-)).
> > 
> > static inline int
> > asym_cpu_capacity_classify(struct sched_domain *sd, 
> >                            const struct cpumask *cpu_map)
> > {
> >         int sd_span_match = 0, cpu_map_match = 0, flags = 0; 
> >         struct asym_cap_data *entry;
> > 
> >         list_for_each_entry(entry, &asym_cap_list, link) {
> >                 if (cpumask_intersects(sched_domain_span(sd), entry->cpu_mask))
> >                         ++sd_span_match;
> >                 else if (cpumask_intersects(cpu_map, entry->cpu_mask))
> >                         ++cpu_map_match;
> >         }
> > 
> >         WARN_ON_ONCE(!sd_span_match);
> > 
> >         if (sd_span_match > 1) { 
> >                 flags |= SD_ASYM_CPUCAPACITY;
> >                 if (!cpu_map_match)
> >                         flags |= SD_ASYM_CPUCAPACITY_FULL;
> >         }
> > 
> >         return flags;
> > }
> So I planned to drop the list_is_singular check as it is needless really.
> Otherwise, I am not really convinced by the suggestion. I could add comments
> around current version to make it more ..... 'digestible' but I'd rather
> stay with it as it seems more compact to me (subjective).
> 
> > 
> > BTW, how would this mechanism behave on a system with SMT and asymmetric CPU
> > capacity? Something EAS wouldn't allow but I guess asym_cap_list will be
> > constructed and the SD_ASYM_CPUCAPACITY_XXX flags will be set?
> Yes, the list would get created and flags set. I do not think there is
> a difference with current approach (?). So EAS would be disabled (it only cares
> about SD_ASYM_CPUCAPACITY_FULL flag) but the misift might still kick in.
>
That depends on the arch_scale_cpu_capacity. I would imagine it would
return SCHED_CAPACITY_SCALE for those, which means no asymmetry will
be detected ?

> ---
> BR
> B.
