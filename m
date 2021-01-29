Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB0230838A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 03:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhA2CDo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Jan 2021 21:03:44 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2884 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhA2CDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 21:03:42 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DRgYd4PL2z5JYV;
        Fri, 29 Jan 2021 10:01:25 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 10:02:58 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 29 Jan 2021 10:02:58 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Fri, 29 Jan 2021 10:02:58 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "mgorman@suse.de" <mgorman@suse.de>
Subject: RE: [PATCH 1/1] sched/topology: Make sched_init_numa() use a set for
 the deduplicating sort
Thread-Topic: [PATCH 1/1] sched/topology: Make sched_init_numa() use a set for
 the deduplicating sort
Thread-Index: AQHW8LvLAz5G3mjdME+poUenwzVodao3mZgg///3IYCAAHq7gIAA0qKAgAPDTYCAATz5wA==
Date:   Fri, 29 Jan 2021 02:02:58 +0000
Message-ID: <e12ec4f50c6c41db84f601038d3ee39c@hisilicon.com>
References: <20210122123943.1217-1-valentin.schneider@arm.com>
 <20210122123943.1217-2-valentin.schneider@arm.com>
 <bfb703294b234e1e926a68fcb73dbee3@hisilicon.com> <jhj1re92wqm.mognet@arm.com>
 <jhjtur50xu2.mognet@arm.com> <ff1e47829eac4278a3489c46c39873c8@hisilicon.com>
 <jhjo8h915l2.mognet@arm.com>
In-Reply-To: <jhjo8h915l2.mognet@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.74]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
> Sent: Friday, January 29, 2021 3:47 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> linux-kernel@vger.kernel.org
> Cc: mingo@kernel.org; peterz@infradead.org; vincent.guittot@linaro.org;
> dietmar.eggemann@arm.com; morten.rasmussen@arm.com; mgorman@suse.de
> Subject: RE: [PATCH 1/1] sched/topology: Make sched_init_numa() use a set
> for the deduplicating sort
> 
> On 25/01/21 21:35, Song Bao Hua (Barry Song) wrote:
> > I was using 5.11-rc1. One thing I'd like to mention is that:
> >
> > For the below topology:
> > +-------+          +-----+
> > | node1 |  20      |node2|
> > |       +----------+     |
> > +---+---+          +-----+
> >     |                  |12
> > 12  |                  |
> > +---+---+          +---+-+
> > |       |          |node3|
> > | node0 |          |     |
> > +-------+          +-----+
> >
> > with node0-node2 as 22, node0-node3 as 24, node1-node3 as 22.
> >
> > I will get the below sched_domains_numa_distance[]:
> > 10, 12, 22, 24
> > As you can see there is *no* 20. So the node1 and node2 will
> > only get two-level numa sched_domain:
> >
> 
> 
> So that's
> 
>     -numa node,cpus=0-1,nodeid=0 -numa node,cpus=2-3,nodeid=1, \
>     -numa node,cpus=4-5,nodeid=2, -numa node,cpus=6-7,nodeid=3, \
>     -numa dist,src=0,dst=1,val=12, \
>     -numa dist,src=0,dst=2,val=22, \
>     -numa dist,src=0,dst=3,val=24, \
>     -numa dist,src=1,dst=2,val=20, \
>     -numa dist,src=1,dst=3,val=22, \
>     -numa dist,src=2,dst=3,val=12
> 
> but running this still doesn't get me a splat. Debugging
> sched_domains_numa_distance[] still gives me
> {10, 12, 20, 22, 24}
> 
> >
> > But for the below topology:
> > +-------+          +-----+
> > | node0 |  20      |node2|
> > |       +----------+     |
> > +---+---+          +-----+
> >     |                  |12
> > 12  |                  |
> > +---+---+          +---+-+
> > |       |          |node3|
> > | node1 |          |     |
> > +-------+          +-----+
> >
> > with node1-node2 as 22, node1-node3 as 24,node0-node3 as 22.
> >
> > I will get the below sched_domains_numa_distance[]:
> > 10, 12, 20, 22, 24
> >
> > What I have seen is the performance will be better if we
> > drop the 20 as we will get a sched_domain hierarchy with less
> > levels, and two intermediate nodes won't have the group span
> > issue.
> >
> 
> That is another thing that's worth considering. Morten was arguing that if
> the distance between two nodes is so tiny, it might not be worth
> representing it at all in the scheduler topology.

Yes. I agree it is a different thing. Anyway, I saw your patch has been
in sched tree. One side effect your patch is the one more sched_domain
level is imported for this topology:

                            24
                      X X XXX X X  X X X X XXX
             XX XX X                          XXXXX
         XXX                                        X
       XX                                             XXX
     XX                                 22              XXX
     X                           XXXXXXX                   XX
    X                        XXXXX      XXXXXXXXX           XXXX
   XX                      XXX                    XX X XX X    XX
+--------+           +---------+          +---------+      XX+---------+
| 0      |   12      | 1       | 20       | 2       |   12   |3        |
|        +-----------+         +----------+         +--------+         |
+---X----+           +---------+          +--X------+        +---------+
    X                                        X
    XX                                      X
     X                                     XX
      XX                                  XX
       XX                                X
        X XXX                         XXX
             X XXXXXX XX XX X X X XXXX
                       22
Without the patch, Linux will use 10,12,22,24 to build sched_domain;
With your patch, Linux will use 10,12,20,22,24 to build sched_domain.

So one more layer is added. What I have seen is that:

For node0 sched_domain <=12 and sched_domain <=20 span the same range
(node0, node1). So one of them is redundant. then in cpu_attach_domain,
the redundant one is dropped due to "remove the sched domains which
do not contribute to scheduling".

For node1&2, the origin code had no "20", thus built one less sched_domain
level.

What is really interesting is that removing 20 actually gives better
benchmark in speccpu :-)


> 
> > Thanks
> > Barry

Thanks
Barry

