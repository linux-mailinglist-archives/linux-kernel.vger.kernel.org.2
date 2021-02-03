Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A7730D783
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhBCK2l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Feb 2021 05:28:41 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2822 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbhBCK2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:28:24 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DVyW13F6zz13pt8;
        Wed,  3 Feb 2021 18:25:33 +0800 (CST)
Received: from dggemm751-chm.china.huawei.com (10.1.198.57) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 3 Feb 2021 18:27:40 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemm751-chm.china.huawei.com (10.1.198.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 18:27:40 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Wed, 3 Feb 2021 18:27:40 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        Meelis Roos <mroos@linux.ee>
Subject: RE: [PATCH] sched/topology: fix the issue groups don't span
 domain->span for NUMA diameter > 2
Thread-Topic: [PATCH] sched/topology: fix the issue groups don't span
 domain->span for NUMA diameter > 2
Thread-Index: AQHW+EyH3+RsPKpAu0uyCnuQYKixoapEdkSAgAG/1ZCAAAXIsA==
Date:   Wed, 3 Feb 2021 10:27:40 +0000
Message-ID: <8b46e28d26d84b6da69354bf906ce6aa@hisilicon.com>
References: <20210201033830.15040-1-song.bao.hua@hisilicon.com>
 <jhj4kiu4hz8.mognet@arm.com> 
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.254]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Song Bao Hua (Barry Song)
> Sent: Wednesday, February 3, 2021 11:18 PM
> To: 'Valentin Schneider' <valentin.schneider@arm.com>;
> vincent.guittot@linaro.org; mgorman@suse.de; mingo@kernel.org;
> peterz@infradead.org; dietmar.eggemann@arm.com; morten.rasmussen@arm.com;
> linux-kernel@vger.kernel.org
> Cc: linuxarm@openeuler.org; xuwei (O) <xuwei5@huawei.com>; Liguozhu (Kenneth)
> <liguozhu@hisilicon.com>; tiantao (H) <tiantao6@hisilicon.com>; wanghuiqiang
> <wanghuiqiang@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Jonathan
> Cameron <jonathan.cameron@huawei.com>; guodong.xu@linaro.org; Meelis Roos
> <mroos@linux.ee>
> Subject: RE: [PATCH] sched/topology: fix the issue groups don't span
> domain->span for NUMA diameter > 2
> 
> 
> 
> > -----Original Message-----
> > From: Valentin Schneider [mailto:valentin.schneider@arm.com]
> > Sent: Wednesday, February 3, 2021 4:17 AM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> > vincent.guittot@linaro.org; mgorman@suse.de; mingo@kernel.org;
> > peterz@infradead.org; dietmar.eggemann@arm.com; morten.rasmussen@arm.com;
> > linux-kernel@vger.kernel.org
> > Cc: linuxarm@openeuler.org; xuwei (O) <xuwei5@huawei.com>; Liguozhu
> (Kenneth)
> > <liguozhu@hisilicon.com>; tiantao (H) <tiantao6@hisilicon.com>;
> wanghuiqiang
> > <wanghuiqiang@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Jonathan
> > Cameron <jonathan.cameron@huawei.com>; guodong.xu@linaro.org; Song Bao Hua
> > (Barry Song) <song.bao.hua@hisilicon.com>; Meelis Roos <mroos@linux.ee>
> > Subject: Re: [PATCH] sched/topology: fix the issue groups don't span
> > domain->span for NUMA diameter > 2
> >
> > On 01/02/21 16:38, Barry Song wrote:
> > > @@ -964,6 +941,12 @@ static void init_overlap_sched_group(struct
> sched_domain
> > *sd,
> > >
> > >       build_balance_mask(sd, sg, mask);
> > >       cpu = cpumask_first_and(sched_group_span(sg), mask);
> > > +	/*
> > > +	 * for the group generated by grandchild, use the sgc of 2nd cpu
> > > +	 * because the 1st cpu might be used by another sched_group
> > > +	 */
> > > +	if (from_grandchild && cpumask_weight(mask) > 1)
> > > +		cpu = cpumask_next_and(cpu, sched_group_span(sg), mask);
> > >
> > >       sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
> >
> > So you are getting a (hopefully) unique ID for this group span at this
> > given topology level (i.e. sd->private) but as I had stated in that list of
> > issues, this creates an sgc that isn't attached to the local group of any
> > sched_domain, and thus won't get its capacity values updated.
> >
> > This can actually be seen via the capacity values you're getting at build
> > time:
> >
> > > [    0.868907] CPU0 attaching sched-domain(s):
> > ...
> > > [    0.869542]    domain-2: span=0-5 level=NUMA
> > > [    0.869559]     groups: 0:{ span=0-3 cap=4002 }, 5:{ span=4-5 cap=2048 }
> >                                                           ^^^^^^^^^^^^^^^^
> > > [    0.871177] CPU4 attaching sched-domain(s):
> > ...
> > > [    0.871200]   groups: 4:{ span=4 cap=977 }, 5:{ span=5 cap=1001 }
> > > [    0.871243]   domain-1: span=4-7 level=NUMA
> > > [    0.871257]    groups: 4:{ span=4-5 cap=1978 }, 6:{ span=6-7 cap=1968 }
> >                                 ^^^^^^^^^^^^^^^^
> >
> 
> Yes. I could see this issue.  We could hack update_group_capacity to let
> it scan both local_group  and sched_group generated by grandchild, but it
> seems your edit is much better.
> 
> > IMO what we want to do here is to hook this CPU0-domain-2-group5 to the sgc
> > of CPU4-domain1-group4. I've done that in the below diff - this gives us
> > groups with sgc's owned at lower topology levels, but this will only ever
> > be true for non-local groups. This has the added benefit of working with
> > single-CPU nodes. Briefly tested on your topology and the sunfire's (via
> > QEMU), and I didn't get screamed at.
> >
> > Before the fun police comes and impounds my keyboard, I'd like to point out
> > that we could leverage this cross-level sgc referencing hack to further
> > change the NUMA domains and pretty much get rid of overlapping groups
> > (that's what I was fumbling with in [1]).
> >
> > [1]: http://lore.kernel.org/r/jhjwnw11ak2.mognet@arm.com
> >
> > That is, rather than building overlapping groups and fixing them whenever
> > that breaks (distance > 2), we could have:
> > - the local group being the child domain's span (as always)
> > - all non-local NUMA groups spanning a single node each, with the right sgc
> >   cross-referencing.
> >
> > Thoughts?
> 
> I guess the original purpose of overlapping groups is creating as few groups
> as possible. If we totally remove overlapping groups, it seems we will create
> much more groups?
> For example, while node0 begins to build sched_domain for distance 20, it will
> add node2, since the distance between node2 and node3 is 15, so while node2
> is
> added, node3 is also added as node2's lower domain has covered node3. So we
> need
> two groups only for node0's sched_domain of distance level 20.
> +-------+                  +--------+
>  |       |      15          |        |
>  |  node0+----------------+ | node1  |
>  |       |                  |        |
>  +----+--+                XXX--------+
>       |                 XXX
>       |                XX
> 20    |         15   XX
>       |            XXX
>       |       X XXX
>  +----+----XXX               +-------+
>  |         |     15          |  node3|
>  | node2   +-----------------+       |
>  |         |                 +-------+
>  +---------+
> 

Sorry for missing a line:

node0-node3: 20

                             20
                 X XX X  X X  X  X  X
             XXXX                       X   X  X XX
           XX                                     XXX
         XX                                          X
       XX                                              XX
 +-----X-+                  +--------+                  XX
 |       |      15          |        |                   X
 |  node0+----------------+ | node1  |                   X
 |       |                  |        |                   X
 +----+--+                XXX--------+                   X
      |                 XXX                             XX
      |                XX                              XX
20    |         15   XX                             XXXX
      |            XXX                         XXXX
      |       X XXX                        XXXX
 +----+----XXX               +-------+ XXXX
 |         |     15          |  node3|XX
 | node2   +-----------------+       |
 |         |                 +-------+
 +---------+

> If we remove overlapping group, we will add a group for node2, another
> group for node3. Then we get three groups.
> 
> I am not sure if it is always positive for performance.
> 
> >
> > --->8---
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index b748999c9e11..ef43abb6b1fb 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -932,21 +932,15 @@ build_group_from_child_sched_domain(struct
> sched_domain
> > *sd, int cpu)
> >
> >  static void init_overlap_sched_group(struct sched_domain *sd,
> >  				     struct sched_group *sg,
> > -				     int from_grandchild)
> > +				     struct sched_domain *grandchild)
> >  {
> >  	struct cpumask *mask = sched_domains_tmpmask2;
> > -	struct sd_data *sdd = sd->private;
> > +	struct sd_data *sdd = grandchild ? grandchild->private : sd->private;
> >  	struct cpumask *sg_span;
> >  	int cpu;
> >
> >  	build_balance_mask(sd, sg, mask);
> >  	cpu = cpumask_first_and(sched_group_span(sg), mask);
> > -	/*
> > -	 * for the group generated by grandchild, use the sgc of 2nd cpu
> > -	 * because the 1st cpu might be used by another sched_group
> > -	 */
> > -	if (from_grandchild && cpumask_weight(mask) > 1)
> > -		cpu = cpumask_next_and(cpu, sched_group_span(sg), mask);
> >
> >  	sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
> >  	if (atomic_inc_return(&sg->sgc->ref) == 1)
> > @@ -979,7 +973,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int
> > cpu)
> >
> >  	for_each_cpu_wrap(i, span, cpu) {
> >  		struct cpumask *sg_span;
> > -		int from_grandchild = 0;
> > +		bool from_grandchild = false;
> >
> >  		if (cpumask_test_cpu(i, covered))
> >  			continue;
> > @@ -1033,7 +1027,7 @@ build_overlap_sched_groups(struct sched_domain *sd,
> int
> > cpu)
> >  		       !cpumask_subset(sched_domain_span(sibling->child),
> >  				       span)) {
> >  			sibling = sibling->child;
> > -			from_grandchild = 1;
> > +			from_grandchild = true;
> >  		}
> >
> >  		sg = build_group_from_child_sched_domain(sibling, cpu);
> > @@ -1043,7 +1037,7 @@ build_overlap_sched_groups(struct sched_domain *sd,
> int
> > cpu)
> >  		sg_span = sched_group_span(sg);
> >  		cpumask_or(covered, covered, sg_span);
> >
> > -		init_overlap_sched_group(sd, sg, from_grandchild);
> > +		init_overlap_sched_group(sd, sg, from_grandchild ? sibling : NULL);
> >
> Nice edit!
> Will merge your edit into v1 and send v2.
> 
> >  		if (!first)
> >  			first = sg;
> 
Thanks
Barry
