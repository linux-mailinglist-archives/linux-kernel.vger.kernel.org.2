Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FCB315B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhBJAjQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Feb 2021 19:39:16 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4620 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbhBIU7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:59:22 -0500
Received: from dggeme706-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DZwDr0NhGzY6nK;
        Wed, 10 Feb 2021 04:57:00 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme706-chm.china.huawei.com (10.1.199.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 10 Feb 2021 04:58:15 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Wed, 10 Feb 2021 04:58:15 +0800
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
Thread-Index: AQHW+h42U7QNiWetGE+PWD4uLCFytKpPS20AgAEC7uA=
Date:   Tue, 9 Feb 2021 20:58:15 +0000
Message-ID: <4bdaa3e1a54f445fa8e629ea392e7bce@hisilicon.com>
References: <20210203111201.20720-1-song.bao.hua@hisilicon.com>
 <YCKGVBnXzRsE6/Er@hirez.programming.kicks-ass.net>
In-Reply-To: <YCKGVBnXzRsE6/Er@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.77]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Peter Zijlstra [mailto:peterz@infradead.org]
> Sent: Wednesday, February 10, 2021 1:56 AM
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
> On Thu, Feb 04, 2021 at 12:12:01AM +1300, Barry Song wrote:
> > As long as NUMA diameter > 2, building sched_domain by sibling's child
> > domain will definitely create a sched_domain with sched_group which will
> > span out of the sched_domain:
> >
> >                +------+         +------+        +-------+       +------+
> >                | node |  12     |node  | 20     | node  |  12   |node  |
> >                |  0   +---------+1     +--------+ 2     +-------+3     |
> >                +------+         +------+        +-------+       +------+
> >
> > domain0        node0            node1            node2          node3
> >
> > domain1        node0+1          node0+1          node2+3        node2+3
> >                                                  +
> > domain2        node0+1+2                         |
> >              group: node0+1                      |
> >                group:node2+3 <-------------------+
> >
> > when node2 is added into the domain2 of node0, kernel is using the child
> > domain of node2's domain2, which is domain1(node2+3). Node 3 is outside
> > the span of the domain including node0+1+2.
> >
> > This will make load_balance() run based on screwed avg_load and group_type
> > in the sched_group spanning out of the sched_domain, and it also makes
> > select_task_rq_fair() pick an idle CPU out of the sched_domain.
> >
> > Real servers which suffer from this problem include Kunpeng920 and 8-node
> > Sun Fire X4600-M2, at least.
> >
> > Here we move to use the *child* domain of the *child* domain of node2's
> > domain2 as the new added sched_group. At the same time, we re-use the
> > lower level sgc directly.
> >
> >                +------+         +------+        +-------+       +------+
> >                | node |  12     |node  | 20     | node  |  12   |node  |
> >                |  0   +---------+1     +--------+ 2     +-------+3     |
> >                +------+         +------+        +-------+       +------+
> >
> > domain0        node0            node1          +- node2          node3
> >                                                |
> > domain1        node0+1          node0+1        | node2+3        node2+3
> >                                                |
> > domain2        node0+1+2                       |
> >              group: node0+1                    |
> >                group:node2 <-------------------+
> >
> 
> I've finally had a moment to think about this, would it make sense to
> also break up group: node0+1, such that we then end up with 3 groups of
> equal size?

We used to create the sched_groups of sched_domain[n] of node[m] by
1. local group: sched_domain[n-1] of node[m]
2. remote group: sched_domain[n-1] of node[m]'s siblings
in the same level. 
Since the sched_domain[n-1] of a part of node[m]'s siblings are able
to cover the whole span of sched_domain[n] of node[m], there is no
necessity to scan over all siblings of node[m], once sched_domain[n]
of node[m] has been covered, we can stop making more sched_groups. So
the number of sched_groups is small.

So historically, the code has never tried to make sched_groups result
in equal size. And it permits the overlapping of local group and remote
groups.

One issue we are facing in original code is that once the topology
gets to 3-hops NUMA, sched_domain[n-1] of node[m]'s siblings might
span out of the range of sched_domain[n] of node[m]. Here my approach
is trying to find a descanted sibling to build remote groups and fix
this issue for those machines with this problem. So it keeps those
machines without 3-hops issues untouched. 

Valentin sent another RFC to break up all remote groups to include
the remote node only instead of using sched_domain[n-1] of siblings,
this will eliminate the problem from the first beginning. One side
effect is that it changes all machines including those machines w/o
3-hops issue by creating much more remote sched_groups. So we both
agree we can get started from descanted sibling(grandchild) approach
first.

What you are advising seems to be breaking up local sched_group,
it will create much more local groups. It sounds like a huge change
even beyond the scope of the original issue we are trying to fix :-)

> 
> > w/ patch, we don't get "groups don't span domain->span" any more:
> > [    1.486271] CPU0 attaching sched-domain(s):
> > [    1.486820]  domain-0: span=0-1 level=MC
> > [    1.500924]   groups: 0:{ span=0 cap=980 }, 1:{ span=1 cap=994 }
> > [    1.515717]   domain-1: span=0-3 level=NUMA
> > [    1.515903]    groups: 0:{ span=0-1 cap=1974 }, 2:{ span=2-3 cap=1989 }
> > [    1.516989]    domain-2: span=0-5 level=NUMA
> > [    1.517124]     groups: 0:{ span=0-3 cap=3963 }, 4:{ span=4-5 cap=1949 }
> 
> 		     groups: 0:{ span=0-1 cap=1974 }, 2:{ span=2-3, cap=1989 },
> 4:{ span=4-5, cap=1949 }
> 
> > [    1.517369]     domain-3: span=0-7 level=NUMA
> > [    1.517423]      groups: 0:{ span=0-5 mask=0-1 cap=5912 }, 6:{ span=4-7
> mask=6-7 cap=4054 }
> 
> Let me continue to think about this... it's been a while :/

Sure, thanks!

Barry

