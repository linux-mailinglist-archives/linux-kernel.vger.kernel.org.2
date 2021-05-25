Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559ED38FE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhEYJzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:55:01 -0400
Received: from foss.arm.com ([217.140.110.172]:54042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232723AbhEYJyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:54:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D22E8D6E;
        Tue, 25 May 2021 02:53:14 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DFDC3F719;
        Tue, 25 May 2021 02:53:13 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        corbet@lwn.net, rdunlap@infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/3] sched/topology: Rework CPU capacity asymmetry detection
In-Reply-To: <20210524225508.GA14880@e120325.cambridge.arm.com>
References: <20210524101617.8965-1-beata.michalska@arm.com> <20210524101617.8965-3-beata.michalska@arm.com> <87fsyc6mfz.mognet@arm.com> <20210524225508.GA14880@e120325.cambridge.arm.com>
Date:   Tue, 25 May 2021 10:53:07 +0100
Message-ID: <87a6oj6sxo.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/21 23:55, Beata Michalska wrote:
> On Mon, May 24, 2021 at 07:01:04PM +0100, Valentin Schneider wrote:
>> On 24/05/21 11:16, Beata Michalska wrote:
>> > This patch also removes the additional -dflags- parameter used when
>>   ^^^^^^^^^^^^^^^^^^^^^^^
>> s/^/Also remove/
> I would kind of ... disagree.
> All the commit msg is constructed using passive structure, the suggestion
> would actually break that. And it does 'sound' bit imperative but I guess
> that is subjective. I'd rather stay with impersonal structure (which is
> applied through out the whole patchset).

It's mainly about the 'This patch' formulation, some take exception to that :-)

>>
>> > building sched domains as the asymmetry flags are now being set
>> > directly in sd_init.
>> >
>>
>> Few nits below, but beyond that:
>>
>> Tested-by: Valentin Schneider <valentin.schneider@arm.com>
>> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>>
> Thanks a lot for the review and testing!
>
>> > +static inline int
>> > +asym_cpu_capacity_classify(struct sched_domain *sd,
>> > +			   const struct cpumask *cpu_map)
>> > +{
>> > +	int sd_asym_flags = SD_ASYM_CPUCAPACITY | SD_ASYM_CPUCAPACITY_FULL;
>> > +	struct asym_cap_data *entry;
>> > +	int asym_cap_count = 0;
>> > +
>> > +	if (list_is_singular(&asym_cap_list))
>> > +		goto leave;
>> > +
>> > +	list_for_each_entry(entry, &asym_cap_list, link) {
>> > +		if (cpumask_intersects(sched_domain_span(sd), entry->cpu_mask)) {
>> > +			++asym_cap_count;
>> > +		} else {
>> > +			/*
>> > +			 * CPUs with given capacity might be offline
>> > +			 * so make sure this is not the case
>> > +			 */
>> > +			if (cpumask_intersects(entry->cpu_mask, cpu_map)) {
>> > +				sd_asym_flags &= ~SD_ASYM_CPUCAPACITY_FULL;
>> > +				if (asym_cap_count > 1)
>> > +					break;
>> > +			}
>>
>> Readability nit: That could be made into an else if ().
> It could but then this way the -comment- gets more exposed.
> But that might be my personal perception so I can change that.

As always those are quite subjective! Methink something like this would
still draw attention to the offline case:

               /*
                * Count how many unique capacities this domain covers. If a
                * capacity isn't covered, we need to check if any CPU with
                * that capacity is actually online, otherwise it can be
                * ignored.
                */
                if (cpumask_intersects(sched_domain_span(sd), entry->cpu_mask)) {
                        ++asym_cap_count;
                } else if (cpumask_intersects(entry->cpu_mask, cpu_map)) {
                        sd_asym_flags &= ~SD_ASYM_CPUCAPACITY_FULL;
                        if (asym_cap_count > 1)
                                break;
                }
