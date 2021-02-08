Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388D7312F31
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhBHKjA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Feb 2021 05:39:00 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2829 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhBHK2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:28:31 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DZ2GM73B9z13rm3;
        Mon,  8 Feb 2021 18:25:15 +0800 (CST)
Received: from dggemm751-chm.china.huawei.com (10.1.198.57) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 8 Feb 2021 18:27:27 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemm751-chm.china.huawei.com (10.1.198.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 18:27:27 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Mon, 8 Feb 2021 18:27:27 +0800
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
Subject: RE: [RFC PATCH 2/2] Revert "sched/topology: Warn when NUMA diameter >
 2"
Thread-Topic: [RFC PATCH 2/2] Revert "sched/topology: Warn when NUMA diameter
 > 2"
Thread-Index: AQHW+kT3/IERTgfM8kOk26NOzGLwD6pOEW/Q
Date:   Mon, 8 Feb 2021 10:27:27 +0000
Message-ID: <73c0ed52b665468cb0aa0086f85da60c@hisilicon.com>
References: <20210203155432.10293-1-valentin.schneider@arm.com>
 <20210203155432.10293-3-valentin.schneider@arm.com>
In-Reply-To: <20210203155432.10293-3-valentin.schneider@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.200]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
> Sent: Thursday, February 4, 2021 4:55 AM
> To: linux-kernel@vger.kernel.org
> Cc: vincent.guittot@linaro.org; mgorman@suse.de; mingo@kernel.org;
> peterz@infradead.org; dietmar.eggemann@arm.com; morten.rasmussen@arm.com;
> linuxarm@openeuler.org; xuwei (O) <xuwei5@huawei.com>; Liguozhu (Kenneth)
> <liguozhu@hisilicon.com>; tiantao (H) <tiantao6@hisilicon.com>; wanghuiqiang
> <wanghuiqiang@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Jonathan
> Cameron <jonathan.cameron@huawei.com>; guodong.xu@linaro.org; Song Bao Hua
> (Barry Song) <song.bao.hua@hisilicon.com>; Meelis Roos <mroos@linux.ee>
> Subject: [RFC PATCH 2/2] Revert "sched/topology: Warn when NUMA diameter > 2"
> 
> The scheduler topology code can now figure out what to do with such
> topologies.
> 
> This reverts commit b5b217346de85ed1b03fdecd5c5076b34fbb2f0b.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Yes, this is fine. I actually have seen some other problems we need
to consider.

The current code is probably well consolidated for machines with
2 hops or less. Thus, even after we fix the 3-hops span issue, I
can still see some other issue.

For example, if we change the sd flags and remove the SD_BALANCE
flags for the last hops in sd_init(), we are able to see large
score increase in unixbench.

		if (sched_domains_numa_distance[tl->numa_level] > node_reclaim_distance ||
			is_3rd_hops_domain(...)) {
			sd->flags &= ~(SD_BALANCE_EXEC |
				       SD_BALANCE_FORK |
				       SD_WAKE_AFFINE);
		}

So guess something needs to be tuned for machines with 3 hops or more.

But we need a kernel which has the fix of 3-hops issue before we can
do more work.

> ---
>  kernel/sched/topology.c | 33 ---------------------------------
>  1 file changed, 33 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index a8f69f234258..0fa41aab74e0 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -688,7 +688,6 @@ cpu_attach_domain(struct sched_domain *sd, struct
> root_domain *rd, int cpu)
>  {
>  	struct rq *rq = cpu_rq(cpu);
>  	struct sched_domain *tmp;
> -	int numa_distance = 0;
> 
>  	/* Remove the sched domains which do not contribute to scheduling. */
>  	for (tmp = sd; tmp; ) {
> @@ -720,38 +719,6 @@ cpu_attach_domain(struct sched_domain *sd, struct
> root_domain *rd, int cpu)
>  			sd->child = NULL;
>  	}
> 
> -	for (tmp = sd; tmp; tmp = tmp->parent)
> -		numa_distance += !!(tmp->flags & SD_NUMA);
> -
> -	/*
> -	 * FIXME: Diameter >=3 is misrepresented.
> -	 *
> -	 * Smallest diameter=3 topology is:
> -	 *
> -	 *   node   0   1   2   3
> -	 *     0:  10  20  30  40
> -	 *     1:  20  10  20  30
> -	 *     2:  30  20  10  20
> -	 *     3:  40  30  20  10
> -	 *
> -	 *   0 --- 1 --- 2 --- 3
> -	 *
> -	 * NUMA-3	0-3		N/A		N/A		0-3
> -	 *  groups:	{0-2},{1-3}					{1-3},{0-2}
> -	 *
> -	 * NUMA-2	0-2		0-3		0-3		1-3
> -	 *  groups:	{0-1},{1-3}	{0-2},{2-3}	{1-3},{0-1}	{2-3},{0-2}
> -	 *
> -	 * NUMA-1	0-1		0-2		1-3		2-3
> -	 *  groups:	{0},{1}		{1},{2},{0}	{2},{3},{1}	{3},{2}
> -	 *
> -	 * NUMA-0	0		1		2		3
> -	 *
> -	 * The NUMA-2 groups for nodes 0 and 3 are obviously buggered, as the
> -	 * group span isn't a subset of the domain span.
> -	 */
> -	WARN_ONCE(numa_distance > 2, "Shortest NUMA path spans too many nodes\n");
> -
>  	sched_domain_debug(sd, cpu);
> 
>  	rq_attach_root(rq, rd);
> --
> 2.27.0

Thanks
Barry

