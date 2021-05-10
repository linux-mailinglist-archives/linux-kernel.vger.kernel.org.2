Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564BD3793EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhEJQfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:35:07 -0400
Received: from foss.arm.com ([217.140.110.172]:34076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231696AbhEJQep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:34:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BC10168F;
        Mon, 10 May 2021 09:33:40 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C655B3F73B;
        Mon, 10 May 2021 09:33:37 -0700 (PDT)
Date:   Mon, 10 May 2021 17:33:29 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/3] sched/doc: Update the CPU capacity asymmetry
 bits
Message-ID: <20210510163329.GA8567@e120325.cambridge.arm.com>
References: <1619602363-1305-1-git-send-email-beata.michalska@arm.com>
 <1619602363-1305-4-git-send-email-beata.michalska@arm.com>
 <79223641-6b3e-6b48-50df-3a9c73c003cd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79223641-6b3e-6b48-50df-3a9c73c003cd@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 10:19:10AM -0700, Randy Dunlap wrote:
> On 4/28/21 2:32 AM, Beata Michalska wrote:
> > Update the documentation bits referring to capacity aware scheduling
> > with regards to newly introduced SD_ASYM_CPUCAPACITY_FULL shed_domain
> 
>                                                             sched_domain
> I guess.
> 
> > flag.
> > 
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > ---
> >  Documentation/scheduler/sched-capacity.rst | 6 ++++--
> >  Documentation/scheduler/sched-energy.rst   | 2 +-
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/scheduler/sched-capacity.rst
> > index 9b7cbe4..92d16e7 100644
> > --- a/Documentation/scheduler/sched-capacity.rst
> > +++ b/Documentation/scheduler/sched-capacity.rst
> > @@ -284,8 +284,10 @@ whether the system exhibits asymmetric CPU capacities. Should that be the
> >  case:
> >  
> >  - The sched_asym_cpucapacity static key will be enabled.
> > -- The SD_ASYM_CPUCAPACITY flag will be set at the lowest sched_domain level that
> > -  spans all unique CPU capacity values.
> > +- The SD_ASYM_CPUCAPACITY_FULL flag will be set at the lowest sched_domain
> > +  level that spans all unique CPU capacity values.
> > +- The SD_ASYM_CPUCAPACITY flag will be set for any sched_domain that spans
> > +  cpus with any range of asymmetry.
> 
>      CPUs
> please.
> 
> >  
> >  The sched_asym_cpucapacity static key is intended to guard sections of code that
> >  cater to asymmetric CPU capacity systems. Do note however that said key is
> > diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
> > index afe02d3..8fbce5e 100644
> > --- a/Documentation/scheduler/sched-energy.rst
> > +++ b/Documentation/scheduler/sched-energy.rst
> > @@ -328,7 +328,7 @@ section lists these dependencies and provides hints as to how they can be met.
> >  
> >  As mentioned in the introduction, EAS is only supported on platforms with
> >  asymmetric CPU topologies for now. This requirement is checked at run-time by
> > -looking for the presence of the SD_ASYM_CPUCAPACITY flag when the scheduling
> > +looking for the presence of the SD_ASYM_CPUCAPACITY_FULL flag when the scheduling
> >  domains are built.
> >  
> >  See Documentation/scheduler/sched-capacity.rst for requirements to be met for this
> > 
>

Thank you for having a look!
Fixes applied to v3.

---
BR
B.

> thanks.
> -- 
> ~Randy
> 
