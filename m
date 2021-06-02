Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87BF3993D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFBTuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:50:02 -0400
Received: from foss.arm.com ([217.140.110.172]:53076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhFBTuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:50:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B4C01063;
        Wed,  2 Jun 2021 12:48:17 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B707E3F774;
        Wed,  2 Jun 2021 12:48:15 -0700 (PDT)
Date:   Wed, 2 Jun 2021 20:48:06 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, corbet@lwn.net, rdunlap@infradead.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
Message-ID: <20210602194805.GA18136@e120325.cambridge.arm.com>
References: <87a6oj6sxo.mognet@arm.com>
 <20210525102945.GA24210@e120325.cambridge.arm.com>
 <98ad8837-b9b8-ff50-5a91-8d5951ee757c@arm.com>
 <20210526121546.GA13262@e120325.cambridge.arm.com>
 <20210526125133.GB13262@e120325.cambridge.arm.com>
 <d4dc6630-041f-bf61-898a-6f402b993fbc@arm.com>
 <20210526214004.GA1712@e120325.cambridge.arm.com>
 <14593ba7-eed9-f035-724c-5cadbb859adc@arm.com>
 <20210527170729.GA20994@e120325.cambridge.arm.com>
 <4f43a9a8-b64e-bb47-b3c1-f51165f40249@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f43a9a8-b64e-bb47-b3c1-f51165f40249@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 07:17:12PM +0200, Dietmar Eggemann wrote:
> On 27/05/2021 19:07, Beata Michalska wrote:
> > On Thu, May 27, 2021 at 05:08:42PM +0200, Dietmar Eggemann wrote:
> >> On 26/05/2021 23:40, Beata Michalska wrote:
> >>> On Wed, May 26, 2021 at 08:17:41PM +0200, Dietmar Eggemann wrote:
> >>>> On 26/05/2021 14:51, Beata Michalska wrote:
> >>>>> On Wed, May 26, 2021 at 01:15:46PM +0100, Beata Michalska wrote:
> >>>>>> On Wed, May 26, 2021 at 11:52:25AM +0200, Dietmar Eggemann wrote:
> >>>>>>> On 25/05/2021 12:29, Beata Michalska wrote:
> >>>>>>>> On Tue, May 25, 2021 at 10:53:07AM +0100, Valentin Schneider wrote:
> >>>>>>>>> On 24/05/21 23:55, Beata Michalska wrote:
> >>>>>>>>>> On Mon, May 24, 2021 at 07:01:04PM +0100, Valentin Schneider wrote:
> >>>>>>>>>>> On 24/05/21 11:16, Beata Michalska wrote:
> 
> [...]
> 
> >>> We could possibly add a warning (like in EAS) if the asymmetry is detected
> >>> for SMT which would give some indication that there is smth ... wrong ?
> >>
> >> Maybe, in case you find an easy way to detect this.
> >>
> >> But the issue already exists today. Not with the topology mentioned
> >> above but in case we slightly change it to:
> >>
> >>   cpus = { ([446 1024] [871 1024] [446 1024] ) ([1024 1024]) }
> >>                                        ^^^^
> >> so that we have a 1024 CPU in the lowest sd for each CPU, we would get
> >> SD_ASYM_CPUCAPACITY on SMT.
> > The asymmetry capacity flags are being set on a sched domain level, so
> > we could use the SD_SHARE_CPUCAPACITY|SD_SHARE_PKG_RESOURCES (cpu_smt_flags)
> > flags to determine if having asymmetry is valid or not ? If this is enough 
> > this could be handled by the classify function?
> 
> Or maybe something directly in sd_init(), like the WARN_ONCE() which triggers
> if somebody wants to sneak in a ~topology flag via a
> sched_domain_topology_level table? 
> 
> IMHO checking `SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY` will be sufficient
> here.
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 62d412013df8..77b73abbb9a4 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1561,6 +1561,11 @@ sd_init(struct sched_domain_topology_level *tl,
>         sd_id = cpumask_first(sched_domain_span(sd));
>  
>         sd->flags |= asym_cpu_capacity_classify(sd, cpu_map);
> +
> +       WARN_ONCE((sd->flags & (SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY)) ==
> +                 (SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY),
> +                     "CPU capacity asymmetry not supported on SMT\n");
> +
>         /*
>          * Convert topological properties into behaviour.
>          */
> 
> In case we can agree on something simple here I guess you can incorporate it into v7.
So what I have done is :

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 77e6f79235ad..ec4ae225687e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1324,6 +1324,7 @@ asym_cpu_capacity_classify(struct sched_domain *sd,
        if (!asym_cap_miss)
                sd_asym_flags |= SD_ASYM_CPUCAPACITY_FULL;
 
+       WARN_ONCE(cpu_smt_flags() & sd->flags, "Detected CPU capacity asymmetry on SMT level");
 leave:
        return sd_asym_flags;
 }

Comment can be adjusted.
This would sit in the classify function to nicely wrap asymmetry bits in one
place. What do you think ?

---
BR
B.
