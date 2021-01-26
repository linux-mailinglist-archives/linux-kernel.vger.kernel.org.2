Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A7B305815
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhA0KRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:17:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:44416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S314289AbhAZXDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 18:03:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F9EA2065E;
        Tue, 26 Jan 2021 23:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611702191;
        bh=19FsxoKkPI3hC+GmGLglLDAnCCE1nO9FzM/AvjFKYZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A8/tiYkCfUWHAYm7MedPDYLwvu6EjnZUJrUcd+8GIEKIUIqgPp/bzwAO8cMDDSazE
         YhUWZg/yQ2IAmE3I1bS3AnZxocq8CyFID3aazvRqRDRWxhz9b5KZhlZEO9Z5y1BHcr
         /ehxxw3FAh4VGVfvyIoLZ5eQpYfsOB9jL6000nDmk+21Ai/cpdzhHD7eVY/nIsBAXN
         h19/6wvm2UF9oVRoJom44JSh6OEgXrtR1Mf0Sv1Li5tSCl0avY+caqnngDyhm3JhaY
         NlDbKVPLwEXvcENdLgkeSw0ZA1SChsZkZIwm+/AiiZ9UHtFekyVj1iwwS1Q/AL7/pu
         ppy5xK/NO4nUQ==
Date:   Tue, 26 Jan 2021 23:03:06 +0000
From:   Will Deacon <will@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
Message-ID: <20210126230305.GD30941@willie-the-truck>
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com>
 <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
 <CAKfTPtDy3Ynk2nGCTWiXjz9-4vuSHB3pGuafoTUBPFNO1ac3PA@mail.gmail.com>
 <786571e7-b9a2-4cdb-06d5-aa4a4b439b7e@suse.cz>
 <20210123051607.GC2587010@in.ibm.com>
 <CAKfTPtAjyVmS5VYvU6DBxg4-JEo5bdmWbngf-03YsY18cmWv_g@mail.gmail.com>
 <66652406-25e4-a9e7-45a1-8ad14d2e8a36@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66652406-25e4-a9e7-45a1-8ad14d2e8a36@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:20:14PM +0100, Vlastimil Babka wrote:
> On 1/23/21 1:32 PM, Vincent Guittot wrote:
> >> PowerPC PowerNV Host: (160 cpus)
> >> num_online_cpus 1 num_present_cpus 160 num_possible_cpus 160 nr_cpu_ids 160
> >>
> >> PowerPC pseries KVM guest: (-smp 16,maxcpus=160)
> >> num_online_cpus 1 num_present_cpus 16 num_possible_cpus 160 nr_cpu_ids 160
> >>
> >> That's what I see on powerpc, hence I thought num_present_cpus() could
> >> be the correct one to use in slub page order calculation.
> > 
> > num_present_cpus() is set to 1 on arm64 until secondaries cpus boot
> > 
> > arm64 224cpus acpi host:
> > num_online_cpus 1 num_present_cpus 1 num_possible_cpus 224 nr_cpu_ids 224
> > arm64 8cpus DT host:
> > num_online_cpus 1 num_present_cpus 1 num_possible_cpus 8 nr_cpu_ids 8
> > arm64 8cpus qemu-system-aarch64 (-smp 8,maxcpus=256)
> > num_online_cpus 1 num_present_cpus 1 num_possible_cpus 8 nr_cpu_ids 8
> 
> I would have expected num_present_cpus to be 224, 8, 8, respectively.
> 
> > Then present and online increase to num_possible_cpus once all cpus are booted
> > 
> >>
> >> >
> >> > What about heuristic:
> >> > - num_online_cpus() > 1 - we trust that and use it
> >> > - otherwise nr_cpu_ids
> >> > Would that work? Too arbitrary?
> >>
> >> Looking at the following snippet from include/linux/cpumask.h, it
> >> appears that num_present_cpus() should be reasonable compromise
> >> between online and possible/nr_cpus_ids to use here.
> >>
> >> /*
> >>  * The following particular system cpumasks and operations manage
> >>  * possible, present, active and online cpus.
> >>  *
> >>  *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
> >>  *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
> >>  *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
> >>  *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
> >>  *
> >>  *  If !CONFIG_HOTPLUG_CPU, present == possible, and active == online.
> >>  *
> >>  *  The cpu_possible_mask is fixed at boot time, as the set of CPU id's
> >>  *  that it is possible might ever be plugged in at anytime during the
> >>  *  life of that system boot.  The cpu_present_mask is dynamic(*),
> >>  *  representing which CPUs are currently plugged in.  And
> >>  *  cpu_online_mask is the dynamic subset of cpu_present_mask,
> >>  *  indicating those CPUs available for scheduling.
> >>  *
> >>  *  If HOTPLUG is enabled, then cpu_possible_mask is forced to have
> >>  *  all NR_CPUS bits set, otherwise it is just the set of CPUs that
> >>  *  ACPI reports present at boot.
> >>  *
> >>  *  If HOTPLUG is enabled, then cpu_present_mask varies dynamically,
> >>  *  depending on what ACPI reports as currently plugged in, otherwise
> >>  *  cpu_present_mask is just a copy of cpu_possible_mask.
> >>  *
> >>  *  (*) Well, cpu_present_mask is dynamic in the hotplug case.  If not
> >>  *      hotplug, it's a copy of cpu_possible_mask, hence fixed at boot.
> >>  */
> >>
> >> So for host systems, present is (usually) equal to possible and for
> > 
> > But "cpu_present_mask varies dynamically,  depending on what ACPI
> > reports as currently plugged in"
> > 
> > So it should varies when secondaries cpus are booted
> 
> Hm, but booting the secondaries is just a software (kernel) action? They are
> already physically there, so it seems to me as if the cpu_present_mask is not
> populated correctly on arm64, and it's just a mirror of cpu_online_mask?

I think the present_mask retains CPUs if they are hotplugged off, whereas
the online mask does not. We can't really do any better on arm64, as there's
no way of telling that a CPU is present until we've seen it.

Will
