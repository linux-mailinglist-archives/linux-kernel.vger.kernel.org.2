Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E5837F91D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhEMNtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:49:52 -0400
Received: from foss.arm.com ([217.140.110.172]:35862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234047AbhEMNtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:49:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1F86169E;
        Thu, 13 May 2021 06:48:36 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6916F3F73B;
        Thu, 13 May 2021 06:48:35 -0700 (PDT)
Date:   Thu, 13 May 2021 14:48:32 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        corbet@lwn.net, rdunlap@infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
Message-ID: <20210513134832.GB15289@e120325.cambridge.arm.com>
References: <1620664258-11045-1-git-send-email-beata.michalska@arm.com>
 <1620664258-11045-3-git-send-email-beata.michalska@arm.com>
 <YJ0H5+P4uHJVh5qF@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ0H5+P4uHJVh5qF@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for having a look at that.

On Thu, May 13, 2021 at 01:05:11PM +0200, Peter Zijlstra wrote:
> On Mon, May 10, 2021 at 05:30:57PM +0100, Beata Michalska wrote:
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
> > 	     L	     M       B        B
> > 
> > Where:
> >  arch_scale_cpu_capacity(L) = 512
> >  arch_scale_cpu_capacity(M) = 871
> >  arch_scale_cpu_capacity(B) = 1024
> 
> Low, High
> Small, Big
> 
> But you appear to have picked: Low and Big, which just doesn't make any
> sense. (Worse, L can also be Large :-)
>
(L)ittle, (M)edium, (B)ig
I can re-arrange the abbreviations used here.

> > In this particular case, the asymmetric topology level will point
> > at MC, as all possible CPU  masks for that level do cover the CPU
> > with the highest capacity. It will work just fine for the first
> > cluster, not so much for the second one though (consider the
> > find_energy_efficient_cpu which might end up attempting the energy
> > aware wake-up for a domain that does not see any asymmetry at all)
> > 
> > Rework the way the capacity asymmetry levels are being detected,
> > to point to the lowest topology level( for a given CPU), where full
> > range of available CPU capacities is visible to all CPUs within given
> > domain. As a result, the per-cpu sd_asym_cpucapacity might differ
> > across the domains. This will have an impact on EAS wake-up placement
> > in a way that it might see different rage of CPUs to be considered,
> > depending on the given current and target CPUs.
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
> 
> My head hurts trying to untangle this.
> 
> Would it not be much easier to have a cpumask for each type and then
> have something like:
> 
> 
> enum asym_type {
> 	full,
> 	asym,
> 	none,
> };
> 
> static struct cpumask *asym_masks[];
> static int asym_nr;
> 
> enum asym_type classify_asym_domain(struct sched_domain *sd)
> {
> 	int i, n = 0;
> 
> 	for (i = 0; i < asym_nr; i++) {
> 		if (cpumask_intersects(sched_domain_span(sd), asym_mask[i]))
> 			n++;
> 	}
> 
> 	WARN_ON_ONCE(!n);
> 
> 	if (n == 1)
> 		return none;
> 	if (n == asym_nr)
> 		return full;
> 	return asym;
> }
> 
> Or am I missing the point?
Your suggestion should work - thanks for that!
Guess that's just an example of overthinking.
Will change the implementation and see how that plays, but the idea looks good.
Thanks again.

---
BR
B.
