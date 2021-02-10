Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E72D3166B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhBJMaP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 Feb 2021 07:30:15 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4625 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhBJM2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:28:09 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DbJrt209qzY7Sq;
        Wed, 10 Feb 2021 20:26:06 +0800 (CST)
Received: from dggemm752-chm.china.huawei.com (10.1.198.58) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 10 Feb 2021 20:27:22 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemm752-chm.china.huawei.com (10.1.198.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Wed, 10 Feb 2021 20:27:22 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Wed, 10 Feb 2021 20:27:22 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        Meelis Roos <mroos@linux.ee>
Subject: RE: [PATCH v2] sched/topology: fix the issue groups don't span
 domain->span for NUMA diameter > 2
Thread-Topic: [PATCH v2] sched/topology: fix the issue groups don't span
 domain->span for NUMA diameter > 2
Thread-Index: AQHW+h42U7QNiWetGE+PWD4uLCFytKpPS20AgAEC7uCAAHUfAIAAkj9w
Date:   Wed, 10 Feb 2021 12:27:22 +0000
Message-ID: <09e6f2addd3f4c7eb6fb22209c4896c3@hisilicon.com>
References: <20210203111201.20720-1-song.bao.hua@hisilicon.com>
 <YCKGVBnXzRsE6/Er@hirez.programming.kicks-ass.net>
 <4bdaa3e1a54f445fa8e629ea392e7bce@hisilicon.com>
 <YCPByAdQ+rZFzYWp@hirez.programming.kicks-ass.net>
In-Reply-To: <YCPByAdQ+rZFzYWp@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.187]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Peter Zijlstra [mailto:peterz@infradead.org]
> Sent: Thursday, February 11, 2021 12:22 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: valentin.schneider@arm.com; vincent.guittot@linaro.org; mgorman@suse.de;
> mingo@kernel.org; dietmar.eggemann@arm.com; morten.rasmussen@arm.com;
> linux-kernel@vger.kernel.org; linuxarm@openeuler.org; xuwei (O)
> <xuwei5@huawei.com>; Liguozhu (Kenneth) <liguozhu@hisilicon.com>; tiantao (H)
> <tiantao6@hisilicon.com>; wanghuiqiang <wanghuiqiang@huawei.com>; Zengtao (B)
> <prime.zeng@hisilicon.com>; Jonathan Cameron <jonathan.cameron@huawei.com>;
> guodong.xu@linaro.org; Meelis Roos <mroos@linux.ee>
> Subject: Re: [PATCH v2] sched/topology: fix the issue groups don't span
> domain->span for NUMA diameter > 2
> 
> On Tue, Feb 09, 2021 at 08:58:15PM +0000, Song Bao Hua (Barry Song) wrote:
> 
> > > I've finally had a moment to think about this, would it make sense to
> > > also break up group: node0+1, such that we then end up with 3 groups of
> > > equal size?
> >
> 
> > Since the sched_domain[n-1] of a part of node[m]'s siblings are able
> > to cover the whole span of sched_domain[n] of node[m], there is no
> > necessity to scan over all siblings of node[m], once sched_domain[n]
> > of node[m] has been covered, we can stop making more sched_groups. So
> > the number of sched_groups is small.
> >
> > So historically, the code has never tried to make sched_groups result
> > in equal size. And it permits the overlapping of local group and remote
> > groups.
> 
> Histrorically groups have (typically) always been the same size though.

This is probably true for other platforms. But unfortunately it has never
been true in my platform :-)

node   0   1   2   3 
  0:  10  12  20  22 
  1:  12  10  22  24 
  2:  20  22  10  12 
  3:  22  24  12  10

In case we have only two cpus in one numa. 

CPU0's domain-3 has no overflowed sched_group, but its first group
covers 0-5(node0-node2), the second group covers 4-7
(node2-node3):

[    0.802139] CPU0 attaching sched-domain(s):
[    0.802193]  domain-0: span=0-1 level=MC
[    0.802443]   groups: 0:{ span=0 cap=1013 }, 1:{ span=1 cap=979 }
[    0.802693]   domain-1: span=0-3 level=NUMA
[    0.802731]    groups: 0:{ span=0-1 cap=1992 }, 2:{ span=2-3 cap=1943 }
[    0.802811]    domain-2: span=0-5 level=NUMA
[    0.802829]     groups: 0:{ span=0-3 cap=3935 }, 4:{ span=4-7 cap=3937 }
[    0.802881] ERROR: groups don't span domain->span
[    0.803058]     domain-3: span=0-7 level=NUMA
[    0.803080]      groups: 0:{ span=0-5 mask=0-1 cap=5843 }, 6:{ span=4-7 mask=6-7 cap=4077 }


> 
> The reason I did ask is because when you get one large and a bunch of
> smaller groups, the load-balancing 'pull' is relatively smaller to the
> large groups.
> 
> That is, IIRC should_we_balance() ensures only 1 CPU out of the group
> continues the load-balancing pass. So if, for example, we have one group
> of 4 CPUs and one group of 2 CPUs, then the group of 2 CPUs will pull
> 1/2 times, while the group of 4 CPUs will pull 1/4 times.
> 
> By making sure all groups are of the same level, and thus of equal size,
> this doesn't happen.

As you can see, even if we give all groups of domain2 equal size
by breaking up both local_group and remote_groups,  we will get to
the same problem in domain-3. And what's more tricky is that
domain-3 has no problem of "groups don't span domain->span".

It seems we need to change both domain2 and domain3 then though
domain3 has no issue of "groups don't span domain->span".

Thanks
Barry

