Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F77387DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350779AbhERQfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:35:39 -0400
Received: from foss.arm.com ([217.140.110.172]:56570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235080AbhERQfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:35:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A0CB6D;
        Tue, 18 May 2021 09:34:19 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F6463F73B;
        Tue, 18 May 2021 09:34:16 -0700 (PDT)
Date:   Tue, 18 May 2021 17:34:14 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] sched/core: Introduce SD_ASYM_CPUCAPACITY_FULL
 sched_domain flag
Message-ID: <20210518163413.GE3993@e120325.cambridge.arm.com>
References: <1621239831-5870-1-git-send-email-beata.michalska@arm.com>
 <1621239831-5870-2-git-send-email-beata.michalska@arm.com>
 <CAKfTPtAPcayjhedNWaL20rsaUQbxXFdEXAF8aqwd9YX5gLVbOQ@mail.gmail.com>
 <20210518142746.GA3993@e120325.cambridge.arm.com>
 <CAKfTPtAk8pQfpN7FrBqdOiSz2Ncby4ozXOgQvT_QZMX67-FRKA@mail.gmail.com>
 <20210518150947.GC3993@e120325.cambridge.arm.com>
 <CAKfTPtAYjzMfj3Uh=xjAeiOZtkb5iyPA72+ow+RXYtQq0mGNDA@mail.gmail.com>
 <20210518154756.GD3993@e120325.cambridge.arm.com>
 <CAKfTPtBw3bxT=Zaig0qT17AM=yP47KM8TTKVAE+=RtRVPAK_LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBw3bxT=Zaig0qT17AM=yP47KM8TTKVAE+=RtRVPAK_LQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 05:56:20PM +0200, Vincent Guittot wrote:
> On Tue, 18 May 2021 at 17:48, Beata Michalska <beata.michalska@arm.com> wrote:
> >
> > On Tue, May 18, 2021 at 05:28:11PM +0200, Vincent Guittot wrote:
> > > On Tue, 18 May 2021 at 17:09, Beata Michalska <beata.michalska@arm.com> wrote:
> > > >
> > > > On Tue, May 18, 2021 at 04:53:09PM +0200, Vincent Guittot wrote:
> > > > > On Tue, 18 May 2021 at 16:27, Beata Michalska <beata.michalska@arm.com> wrote:
> > > > > >
> > > > > > On Tue, May 18, 2021 at 03:39:27PM +0200, Vincent Guittot wrote:
> > > > > > > On Mon, 17 May 2021 at 10:24, Beata Michalska <beata.michalska@arm.com> wrote:
> > > > > > > >
> > > > > > > > Introducing new, complementary to SD_ASYM_CPUCAPACITY, sched_domain
> > > > > > > > topology flag, to distinguish between shed_domains where any CPU
> > > > > > > > capacity asymmetry is detected (SD_ASYM_CPUCAPACITY) and ones where
> > > > > > > > a full range of CPU capacities is visible to all domain members
> > > > > > > > (SD_ASYM_CPUCAPACITY_FULL).
> > > > > > >
> > > > > > > I'm not sure about what you want to detect:
> > > > > > >
> > > > > > > Is it a sched_domain level with a full range of cpu capacity, i.e.
> > > > > > > with at least 1 min capacity and 1 max capacity ?
> > > > > > > or do you want to get at least 1 cpu of each capacity ?
> > > > > > That would be at least one CPU of each available capacity within given domain,
> > > > > > so full -set- of available capacities within a domain.
> > > > >
> > > > > Would be good to add the precision.
> > > > Will do.
> > > > >
> > > > > Although I'm not sure if that's the best policy compared to only
> > > > > getting the range which would be far simpler to implement.
> > > > > Do you have some topology example ?
> > > >
> > > > An example from second patch from the series:
> > > >
> > > > DIE      [                                ]
> > > > MC       [                       ][       ]
> > > >
> > > > CPU       [0] [1] [2] [3] [4] [5]  [6] [7]
> > > > Capacity  |.....| |.....| |.....|  |.....|
> > > >              L       M       B        B
> > >
> > > The one above , which is described in your patchset, works with the range policy
> > Yeap, but that is just a variation of all the possibilities....
> > >
> > > >
> > > > Where:
> > > >  arch_scale_cpu_capacity(L) = 512
> > > >  arch_scale_cpu_capacity(M) = 871
> > > >  arch_scale_cpu_capacity(B) = 1024
> > > >
> > > > which could also look like:
> > > >
> > > > DIE      [                                        ]
> > > > MC       [                       ][               ]
> > > >
> > > > CPU       [0] [1] [2] [3] [4] [5]  [6] [7] [8] [9]
> > > > Capacity  |.....| |.....| |.....|  |.....| |.....|
> > > >              L       M       B        L       B
> > >
> > > I know that that HW guys can come with crazy idea but they would
> > > probably add M  instead of L with B in the 2nd cluster as a boost of
> > > performance at the cost of powering up another "cluster" in which case
> > > the range policy works as well
> > >
> > > >
> > > > Considering only range would mean loosing the 2 (M) CPUs out of sight
> > > > for feec in some cases.
> > >
> > > Is it realistic ? Considering all the code and complexity added by
> > > patch 2, will we really use it at the end ?
> > >
> > I do completely agree that the first approach was slightly .... blown out of
> > proportions, but with Peter's idea, the complexity has dropped significantly.
> > With the range being considered we are back to per domain tracking of available
> > capacities (min/max), plus additional cycles on comparing capacities.
> > Unless I fail to see the simplicity of that approach ?
> 
> With the range, you just have to keep track of one cpumask for min
> capacity and 1 for max capacity (considering that the absolute max
> capacity/1024 might not be in the cpumap) instead of tracking all
> capacity and manipulating/updating a dynamic link list. Then as soon
> as you have 1 cpu of both masks then you are done. As a 1st glance
> this seems to be simpler to do.
>
You would still have to go through all the capacities to find min/max:
so it's either going through all available CPUs twice, or tracking capacities
during the single go-through run. Those masks would also have to be updated to
cover hotplug events when one of the two  might become obsolete.
There is an option being considered to drop updating the list upon every
rebuild of sched domains and that would simplify things even further.
I do not see any big gain with changing the approach, especially that current
one covers all of the cases.
The idea though is a good one so thank you for that.


---
BR
B.

> >
> > ---
> > BR
> > B.
> > > Regards,
> > > Vincent
> > > >
> > > > ---
> > > > BR.
> > > > B
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > > ---
> > > > > > BR
> > > > > > B.
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > With the distinction between full and partial CPU capacity asymmetry,
> > > > > > > > brought in by the newly introduced flag, the scope of the original
> > > > > > > > SD_ASYM_CPUCAPACITY flag gets shifted, still maintaining the existing
> > > > > > > > behaviour when one is detected on a given sched domain, allowing
> > > > > > > > misfit migrations within sched domains that do not observe full range
> > > > > > > > of CPU capacities but still do have members with different capacity
> > > > > > > > values. It loses though it's meaning when it comes to the lowest CPU
> > > > > > > > asymmetry sched_domain level per-cpu pointer, which is to be now
> > > > > > > > denoted by SD_ASYM_CPUCAPACITY_FULL flag.
> > > > > > > >
> > > > > > > > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > > > > > > > Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> > > > > > > > ---
> > > > > > > >  include/linux/sched/sd_flags.h | 10 ++++++++++
> > > > > > > >  1 file changed, 10 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
> > > > > > > > index 34b21e9..57bde66 100644
> > > > > > > > --- a/include/linux/sched/sd_flags.h
> > > > > > > > +++ b/include/linux/sched/sd_flags.h
> > > > > > > > @@ -91,6 +91,16 @@ SD_FLAG(SD_WAKE_AFFINE, SDF_SHARED_CHILD)
> > > > > > > >  SD_FLAG(SD_ASYM_CPUCAPACITY, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> > > > > > > >
> > > > > > > >  /*
> > > > > > > > + * Domain members have different CPU capacities spanning all unique CPU
> > > > > > > > + * capacity values.
> > > > > > > > + *
> > > > > > > > + * SHARED_PARENT: Set from the topmost domain down to the first domain where
> > > > > > > > + *               all available CPU capacities are visible
> > > > > > > > + * NEEDS_GROUPS: Per-CPU capacity is asymmetric between groups.
> > > > > > > > + */
> > > > > > > > +SD_FLAG(SD_ASYM_CPUCAPACITY_FULL, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> > > > > > > > +
> > > > > > > > +/*
> > > > > > > >   * Domain members share CPU capacity (i.e. SMT)
> > > > > > > >   *
> > > > > > > >   * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
> > > > > > > > --
> > > > > > > > 2.7.4
> > > > > > > >
