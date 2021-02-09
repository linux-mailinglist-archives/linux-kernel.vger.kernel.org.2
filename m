Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4F93144B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhBIANP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Feb 2021 19:13:15 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3428 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBIANO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:13:14 -0500
Received: from dggeme760-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DZNbH4Jl3z5Q2g;
        Tue,  9 Feb 2021 08:11:07 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme760-chm.china.huawei.com (10.3.19.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 9 Feb 2021 08:12:30 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Tue, 9 Feb 2021 08:12:30 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        Meelis Roos <mroos@linux.ee>
Subject: RE: [RFC PATCH 1/2] sched/topology: Get rid of NUMA overlapping
 groups
Thread-Topic: [RFC PATCH 1/2] sched/topology: Get rid of NUMA overlapping
 groups
Thread-Index: AQHW+kT3/N78LRZazkasMtaKeTFdBqpOCUYA//+chQCAAUaz8A==
Date:   Tue, 9 Feb 2021 00:12:30 +0000
Message-ID: <9619692afa1d4571b59c8a1da5d1076a@hisilicon.com>
References: <20210203155432.10293-1-valentin.schneider@arm.com>
 <20210203155432.10293-2-valentin.schneider@arm.com>
 <26e70a3275b14f248520d7a5e66e5a74@hisilicon.com> <jhjpn1a232z.mognet@arm.com>
In-Reply-To: <jhjpn1a232z.mognet@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.92]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
> Sent: Tuesday, February 9, 2021 12:48 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> linux-kernel@vger.kernel.org
> Cc: vincent.guittot@linaro.org; mgorman@suse.de; mingo@kernel.org;
> peterz@infradead.org; dietmar.eggemann@arm.com; morten.rasmussen@arm.com;
> linuxarm@openeuler.org; xuwei (O) <xuwei5@huawei.com>; Liguozhu (Kenneth)
> <liguozhu@hisilicon.com>; tiantao (H) <tiantao6@hisilicon.com>; wanghuiqiang
> <wanghuiqiang@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Jonathan
> Cameron <jonathan.cameron@huawei.com>; guodong.xu@linaro.org; Meelis Roos
> <mroos@linux.ee>
> Subject: RE: [RFC PATCH 1/2] sched/topology: Get rid of NUMA overlapping groups
> 
> Hi Barry,
> 
> On 08/02/21 10:04, Song Bao Hua (Barry Song) wrote:
> >> -----Original Message-----
> >> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
> 
> >
> > Hi Valentin,
> >
> > While I like your approach, this will require more time
> > to evaluate possible influence as the approach also affects
> > all machines without 3-hops issue. So x86 platforms need to
> > be tested and benchmark is required.
> >
> > What about we firstly finish the review of "grandchild" approach
> > v2 and have a solution for kunpeng920 and Sun Fire X4600-M2
> > while not impacting other machines which haven't 3-hops issues
> > first?
> >
> 
> I figured I'd toss this out while the iron was hot (and I had the topology
> crud paged in), but I ultimately agree that it's better to first go with
> something that fixes the diameter > 2 topologies and leaves the other ones
> untouched, which is exactly what you have.
> 
> > I would appreciate very much if you could comment on v2:
> >
> https://lore.kernel.org/lkml/20210203111201.20720-1-song.bao.hua@hisilicon
> .com/
> >
> 
> See my comment below on domain degeneration; with that taken care of I
> would say it's good to go. Have a look at what patch1+patch3 squashed
> together looks like, passing the right sd to init_overlap_sched_group()
> looks a bit neater IMO.
> 
> >> +static struct sched_domain *find_node_domain(struct sched_domain *sd)
> >> +{
> >> +	struct sched_domain *parent;
> >> +
> >> +	BUG_ON(!(sd->flags & SD_NUMA));
> >> +
> >> +	/* Get to the level above NODE */
> >> +	while (sd && sd->child) {
> >> +		parent = sd;
> >> +		sd = sd->child;
> >> +
> >> +		if (!(sd->flags & SD_NUMA))
> >> +			break;
> >> +	}
> >> +	/*
> >> +	 * We're going to create cross topology level sched_group_capacity
> >> +	 * references. This can only work if the domains resulting from said
> >> +	 * levels won't be degenerated, as we need said sgc to be periodically
> >> +	 * updated: it needs to be attached to the local group of a domain
> >> +	 * that didn't get degenerated.
> >> +	 *
> >> +	 * Of course, groups aren't available yet, so we can't call the usual
> >> +	 * sd_degenerate(). Checking domain spans is the closest we get.
> >> +	 * Start from NODE's parent, and keep going up until we get a domain
> >> +	 * we're sure won't be degenerated.
> >> +	 */
> >> +	while (sd->parent &&
> >> +	       cpumask_equal(sched_domain_span(sd), sched_domain_span(parent)))
> {
> >> +		sd = parent;
> >> +		parent = sd->parent;
> >> +	}
> >
> > So this is because the sched_domain which doesn't contribute to scheduler
> > will be destroyed during cpu_attach_domain() since sd and parent span
> > the seam mask?
> >
> 
> Yes; let's take your topology for instance:
> 
> node   0   1   2   3
>     0:  10  12  20  22
>     1:  12  10  22  24
>     2:  20  22  10  12
>     3:  22  24  12  10
> 
>       2       10      2
>   0 <---> 1 <---> 2 <---> 3

Guess you actually mean
       2       10      2
   1 <---> 0 <---> 2 <---> 3

> 
> 
> Domains for node1 will look like (before any fixes are applied):
> 
> NUMA<=10: span=1   groups=(1)
> NUMA<=12: span=0-1 groups=(1)->(0)
> NUMA<=20: span=0-1 groups=(0,1)
> NUMA<=22: span=0-2 groups=(0,1)->(0,2-3)
> NUMA<=24: span=0-3 groups=(0-2)->(0,2-3)
> 
> As you can see, the domain representing distance <= 20 will be degenerated
> (it has a single group). If we were to e.g. add some more nodes to the left
> of node0, then we would trigger the "grandchildren logic" for node1 and
> would end up creating a reference to node1 NUMA<=20's sgc, which is a
> mistake: that domain will be degenerated, and that sgc will never be
> updated. The right thing to do here would be reference node1 NUMA<=12's
> sgc, which the above snippet does.

Guess I got your point even though the diagram is not correct :-)

If the topology is as below(add a node left to node1 rather than
node0):

    9       2       10      2
A <---> 1 <---> 0 <---> 2 <---> 3

For nodeA,
NUMA<=10: span=A   groups=(A)
NUMA<=12: span= A groups= (A)
NUMA<=19: span=A-1 groups=(A),(1)
NUMA<=20: span=A-1 groups=(A,1)
*1 NUMA<=21: span=A-1-0 groups=(A,1), node1's numa<=20

For node0,
NUMA<=10: span=9   groups=(0)
#3 NUMA<=12: span=0-1 groups=(0)->(1)
#2 NUMA<=19: span=0-1 groups=(0,1)
#1 NUMA<=20: span=0-1-2 groups=(0,1),....

*1 will firstly try #1, and it finds 2 is outside the A-1-0,
then it will try #2. Finally #2 will be degenerated, so we
should actually use #3. Amazing!

> 
> >> +
> >> +	return parent;
> >> +}
> >> +

Thanks
Barry
