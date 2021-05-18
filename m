Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3937387B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhERO3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:29:16 -0400
Received: from foss.arm.com ([217.140.110.172]:53410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231792AbhERO3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:29:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90DA0ED1;
        Tue, 18 May 2021 07:27:55 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1425A3F73B;
        Tue, 18 May 2021 07:27:53 -0700 (PDT)
Date:   Tue, 18 May 2021 15:27:46 +0100
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
Message-ID: <20210518142746.GA3993@e120325.cambridge.arm.com>
References: <1621239831-5870-1-git-send-email-beata.michalska@arm.com>
 <1621239831-5870-2-git-send-email-beata.michalska@arm.com>
 <CAKfTPtAPcayjhedNWaL20rsaUQbxXFdEXAF8aqwd9YX5gLVbOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAPcayjhedNWaL20rsaUQbxXFdEXAF8aqwd9YX5gLVbOQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 03:39:27PM +0200, Vincent Guittot wrote:
> On Mon, 17 May 2021 at 10:24, Beata Michalska <beata.michalska@arm.com> wrote:
> >
> > Introducing new, complementary to SD_ASYM_CPUCAPACITY, sched_domain
> > topology flag, to distinguish between shed_domains where any CPU
> > capacity asymmetry is detected (SD_ASYM_CPUCAPACITY) and ones where
> > a full range of CPU capacities is visible to all domain members
> > (SD_ASYM_CPUCAPACITY_FULL).
> 
> I'm not sure about what you want to detect:
> 
> Is it a sched_domain level with a full range of cpu capacity, i.e.
> with at least 1 min capacity and 1 max capacity ?
> or do you want to get at least 1 cpu of each capacity ?
That would be at least one CPU of each available capacity within given domain,
so full -set- of available capacities within a domain.

---
BR
B.
> 
> 
> >
> > With the distinction between full and partial CPU capacity asymmetry,
> > brought in by the newly introduced flag, the scope of the original
> > SD_ASYM_CPUCAPACITY flag gets shifted, still maintaining the existing
> > behaviour when one is detected on a given sched domain, allowing
> > misfit migrations within sched domains that do not observe full range
> > of CPU capacities but still do have members with different capacity
> > values. It loses though it's meaning when it comes to the lowest CPU
> > asymmetry sched_domain level per-cpu pointer, which is to be now
> > denoted by SD_ASYM_CPUCAPACITY_FULL flag.
> >
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> > ---
> >  include/linux/sched/sd_flags.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
> > index 34b21e9..57bde66 100644
> > --- a/include/linux/sched/sd_flags.h
> > +++ b/include/linux/sched/sd_flags.h
> > @@ -91,6 +91,16 @@ SD_FLAG(SD_WAKE_AFFINE, SDF_SHARED_CHILD)
> >  SD_FLAG(SD_ASYM_CPUCAPACITY, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> >
> >  /*
> > + * Domain members have different CPU capacities spanning all unique CPU
> > + * capacity values.
> > + *
> > + * SHARED_PARENT: Set from the topmost domain down to the first domain where
> > + *               all available CPU capacities are visible
> > + * NEEDS_GROUPS: Per-CPU capacity is asymmetric between groups.
> > + */
> > +SD_FLAG(SD_ASYM_CPUCAPACITY_FULL, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> > +
> > +/*
> >   * Domain members share CPU capacity (i.e. SMT)
> >   *
> >   * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
> > --
> > 2.7.4
> >
