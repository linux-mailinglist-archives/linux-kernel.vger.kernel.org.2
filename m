Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382F8387B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhEROl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:41:56 -0400
Received: from foss.arm.com ([217.140.110.172]:53698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234201AbhEROl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:41:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6A89ED1;
        Tue, 18 May 2021 07:40:37 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 502693F73B;
        Tue, 18 May 2021 07:40:36 -0700 (PDT)
Date:   Tue, 18 May 2021 15:40:34 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        corbet@lwn.net, rdunlap@infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
Message-ID: <20210518144033.GB3993@e120325.cambridge.arm.com>
References: <1621239831-5870-1-git-send-email-beata.michalska@arm.com>
 <1621239831-5870-3-git-send-email-beata.michalska@arm.com>
 <87mtst1s8m.mognet@arm.com>
 <20210517131816.GA13965@e120325.cambridge.arm.com>
 <87k0nx1jtu.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0nx1jtu.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 04:06:05PM +0100, Valentin Schneider wrote:
> On 17/05/21 14:18, Beata Michalska wrote:
> > On Mon, May 17, 2021 at 01:04:25PM +0100, Valentin Schneider wrote:
> >> On 17/05/21 09:23, Beata Michalska wrote:
> >> > +static void asym_cpu_capacity_scan(const struct cpumask *cpu_map)
> >> > +{
> >> > +	struct asym_cap_data *entry, *next;
> >> > +	int cpu;
> >> >
> >> > -		for_each_sd_topology(tl) {
> >> > -			if (tl_id < asym_level)
> >> > -				goto next_level;
> >> > +	if (!list_empty(&asym_cap_list))
> >> > +		list_for_each_entry(entry, &asym_cap_list, link)
> >> > +			cpumask_clear(entry->cpu_mask);
> >> >
> >>
> >> The topology isn't going to change between domain rebuilds, so why
> >> recompute the masks? The sched_domain spans are already masked by cpu_map,
> >> so no need to do this masking twice. I'm thinking this scan should be done
> >> once against the cpu_possible_mask - kinda like sched_init_numa() done once
> >> against the possible nodes.
> >>
> > This is currently done, as what you have mentioned earlier, the tl->mask
> > may contain CPUs that are not 'available'. So it makes sure that the masks
> > kept on  the list are representing only those CPUs that are online.
> > And it is also needed case all CPUs of given capacity go offline - not to to
> > lose the full asymmetry that might change because of that ( empty masks are
> > being removed from the list).
> >
> > I could change that and use the CPU mask that represents the online CPUs as
> > a checkpoint but then it also means additional tracking which items on the
> > list are actually available at a given point of time.
> > So if the CPUs masks on the list are to be set once (as you are suggesting)
> > than it needs additional logic to count the number of available capacities
> > to decide whether there is a full asymmetry or not.
> >
> 
> That should be doable by counting non-empty intersections between each
> entry->cpumask and the cpu_online_mask in _classify().
> 
> That said I'm afraid cpufreq module loading forces us to dynamically update
> those masks, as you've done. The first domain build could see asymmetry
> without cpufreq loaded, and a later one with cpufreq loaded would need an
> update. Conversely, as much of a fringe case as it is, we'd have to cope
> with the cpufreq module being unloaded later on...
> 
> :(
So it got me thinking that maybe we could actually make it more
'update-on-demand' and use the cpufreq policy notifier to trigger the update.
I could try to draft smth generic enough to make it ... relatively easy to adapt
to different archs case needed.
Any thoughts ?

---
BR
B.
