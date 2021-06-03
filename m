Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F64399DB2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhFCJ0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:26:07 -0400
Received: from foss.arm.com ([217.140.110.172]:36356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCJ0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:26:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31D5611FB;
        Thu,  3 Jun 2021 02:24:22 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CB7A3F774;
        Thu,  3 Jun 2021 02:24:19 -0700 (PDT)
Date:   Thu, 3 Jun 2021 10:24:11 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, corbet@lwn.net, rdunlap@infradead.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
Message-ID: <20210603092411.GA4181@e120325.cambridge.arm.com>
References: <98ad8837-b9b8-ff50-5a91-8d5951ee757c@arm.com>
 <20210526121546.GA13262@e120325.cambridge.arm.com>
 <20210526125133.GB13262@e120325.cambridge.arm.com>
 <d4dc6630-041f-bf61-898a-6f402b993fbc@arm.com>
 <20210526214004.GA1712@e120325.cambridge.arm.com>
 <14593ba7-eed9-f035-724c-5cadbb859adc@arm.com>
 <20210527170729.GA20994@e120325.cambridge.arm.com>
 <4f43a9a8-b64e-bb47-b3c1-f51165f40249@arm.com>
 <20210602194805.GA18136@e120325.cambridge.arm.com>
 <32ffee58-5ea9-1e01-c134-9fb90d1b1771@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32ffee58-5ea9-1e01-c134-9fb90d1b1771@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 11:09:48AM +0200, Dietmar Eggemann wrote:
> On 02/06/2021 21:48, Beata Michalska wrote:
> > On Wed, Jun 02, 2021 at 07:17:12PM +0200, Dietmar Eggemann wrote:
> >> On 27/05/2021 19:07, Beata Michalska wrote:
> >>> On Thu, May 27, 2021 at 05:08:42PM +0200, Dietmar Eggemann wrote:
> >>>> On 26/05/2021 23:40, Beata Michalska wrote:
> >>>>> On Wed, May 26, 2021 at 08:17:41PM +0200, Dietmar Eggemann wrote:
> >>>>>> On 26/05/2021 14:51, Beata Michalska wrote:
> >>>>>>> On Wed, May 26, 2021 at 01:15:46PM +0100, Beata Michalska wrote:
> >>>>>>>> On Wed, May 26, 2021 at 11:52:25AM +0200, Dietmar Eggemann wrote:
> >>>>>>>>> On 25/05/2021 12:29, Beata Michalska wrote:
> >>>>>>>>>> On Tue, May 25, 2021 at 10:53:07AM +0100, Valentin Schneider wrote:
> >>>>>>>>>>> On 24/05/21 23:55, Beata Michalska wrote:
> >>>>>>>>>>>> On Mon, May 24, 2021 at 07:01:04PM +0100, Valentin Schneider wrote:
> >>>>>>>>>>>>> On 24/05/21 11:16, Beata Michalska wrote:
> 
> [...]
> 
> > So what I have done is :
> > 
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 77e6f79235ad..ec4ae225687e 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -1324,6 +1324,7 @@ asym_cpu_capacity_classify(struct sched_domain *sd,
> >         if (!asym_cap_miss)
> >                 sd_asym_flags |= SD_ASYM_CPUCAPACITY_FULL;
> >  
> > +       WARN_ONCE(cpu_smt_flags() & sd->flags, "Detected CPU capacity asymmetry on SMT level");
> >  leave:
> >         return sd_asym_flags;
> >  }
> > 
> > Comment can be adjusted.
> > This would sit in the classify function to nicely wrap asymmetry bits in one
> > place. What do you think ?
> 
> ... and you would need to pass in the sched domain pointer ;-)
Yes, as that was for current version.
> 
> Still prefer to check it in sd_init() since there is where we set the flags.
> 
> But you can't do 'cpu_smt_flags() & sd->flags'. MC level would hit too,
> since it has SD_SHARE_PKG_RESOURCES as well.
Yeah, I would need to check:
	cpu_smt_flags() & sd->flags == cpu_smt_flags()
and if I am to move it to sd_init then additionally checking for 
SD_ASYM_CPUCAPACITY ... and #ifdef for SMT .....
so I guess I will go with your proposal using the SD_SHARE_CPUCAPACITY directly.
Will update in the v7.

---
BR
B.
