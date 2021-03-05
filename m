Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE6D32F499
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 21:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCEU0X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Mar 2021 15:26:23 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2915 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhCEU0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 15:26:03 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DsfMP5kfwz5YF0;
        Sat,  6 Mar 2021 04:23:45 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sat, 6 Mar 2021 04:25:56 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sat, 6 Mar 2021 04:25:55 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Sat, 6 Mar 2021 04:25:55 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [PATCH] sched/topology: remove redundant cpumask_and in
 init_overlap_sched_group
Thread-Topic: [PATCH] sched/topology: remove redundant cpumask_and in
 init_overlap_sched_group
Thread-Index: AQHXEUbFwdk9gqF8eUOp23ZOsJR2kap0wmWAgAETGfA=
Date:   Fri, 5 Mar 2021 20:25:55 +0000
Message-ID: <27e60cb105e040deb16af774399db15e@hisilicon.com>
References: <20210304222944.32504-1-song.bao.hua@hisilicon.com>
 <jhjeegt7rdg.mognet@arm.com>
In-Reply-To: <jhjeegt7rdg.mognet@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.103]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
> Sent: Saturday, March 6, 2021 12:49 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> vincent.guittot@linaro.org; mingo@redhat.com; peterz@infradead.org;
> juri.lelli@redhat.com; dietmar.eggemann@arm.com; rostedt@goodmis.org;
> bsegall@google.com; mgorman@suse.de
> Cc: linux-kernel@vger.kernel.org; linuxarm@openeuler.org; Song Bao Hua (Barry
> Song) <song.bao.hua@hisilicon.com>
> Subject: Re: [PATCH] sched/topology: remove redundant cpumask_and in
> init_overlap_sched_group
> 
> On 05/03/21 11:29, Barry Song wrote:
> > mask is built in build_balance_mask() by for_each_cpu(i, sg_span), so
> > it must be a subset of sched_group_span(sg).
> 
> So we should indeed have
> 
>   cpumask_subset(sched_group_span(sg), mask)
> 
> but that doesn't imply
> 
>   cpumask_first(sched_group_span(sg)) == cpumask_first(mask)
> 
> does it? I'm thinking if in your topology of N CPUs, CPUs 0 and N-1 are the
> furthest away, you will most likely hit

It is true:
cpumask_first(sched_group_span(sg)) != cpumask_first(mask)

but 

cpumask_first_and(sched_group_span(sg), mask) = cpumask_first(mask)

since mask is always subset of sched_group_span(sg).

/**
 * cpumask_first_and - return the first cpu from *srcp1 & *srcp2
 * @src1p: the first input
 * @src2p: the second input
 *
 * Returns >= nr_cpu_ids if no cpus set in both.  See also cpumask_next_and().
 */

*srcp2 is subset of *srcp1, so  *srcp1 & *srcp2 = *srcp2

> 
>   !cpumask_equal(sg_pan, sched_domain_span(sibling->child))
>                  ^^^^^^                    ^^^^^^^^^^^^^
>                  CPUN-1                        CPU0
> 
> which should be the case on your Kunpeng920 system.
> 
> > Though cpumask_first_and
> > doesn't lead to a wrong result of balance cpu, it is pointless to do
> > cpumask_and again.
> >
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >  kernel/sched/topology.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 12f8058..45f3db2 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -934,7 +934,7 @@ static void init_overlap_sched_group(struct sched_domain
> *sd,
> >  	int cpu;
> >
> >  	build_balance_mask(sd, sg, mask);
> > -	cpu = cpumask_first_and(sched_group_span(sg), mask);
> > +	cpu = cpumask_first(mask);
> >
> >  	sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
> >  	if (atomic_inc_return(&sg->sgc->ref) == 1)
> > --
> > 1.8.3.1

Thanks
Barry

