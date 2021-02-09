Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1071E314E4E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhBILaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:30:55 -0500
Received: from foss.arm.com ([217.140.110.172]:50054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhBIL3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:29:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C722E1042;
        Tue,  9 Feb 2021 03:28:58 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 955393F774;
        Tue,  9 Feb 2021 03:28:56 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Barry Song <song.bao.hua@hisilicon.com>,
        vincent.guittot@linaro.org, mgorman@suse.de, mingo@kernel.org,
        peterz@infradead.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, linux-kernel@vger.kernel.org
Cc:     linuxarm@openeuler.org, xuwei5@huawei.com, liguozhu@hisilicon.com,
        tiantao6@hisilicon.com, wanghuiqiang@huawei.com,
        prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
        guodong.xu@linaro.org, Barry Song <song.bao.hua@hisilicon.com>,
        Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH v3] sched/topology: fix the issue groups don't span domain->span for NUMA diameter > 2
In-Reply-To: <20210209082125.22176-1-song.bao.hua@hisilicon.com>
References: <20210209082125.22176-1-song.bao.hua@hisilicon.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 09 Feb 2021 11:28:54 +0000
Message-ID: <jhj35y5v5s9.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/21 21:21, Barry Song wrote:
> Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> Tested-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Tested on a bunch of NUMA topologies via QEMU (AMD Epyc, D06, Sunfire) and
the results look sane.

Small comment nits below, but regardless:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> ---
>  -v3:
>  Mainly updated according to Valentin's comments. While the approach was
>  started by me, Valentin contributed the most useful edit and comments.
>  Thanks, Valentin!
>

Happy to help, thanks for fixing this!

>  * fixed a potential issue that re-used sgc might be located in
>  a sched_domain which will be degenrated;
>  * code cleanup to make it more readable
>
>  While Valentin started another approach which completely removed overlapped
>  sched_group, we both agree that it is better to have a solution which won't
>  touch machines without 3-hops issue first:
>  https://lore.kernel.org/lkml/jhjpn1a232z.mognet@arm.com/
>

I think this doesn't scale properly so I doubt it's ever going to see the
light of day, but I had to write it to convince myself of it :/

>  kernel/sched/topology.c | 91 +++++++++++++++++++++++++++--------------
>  1 file changed, 61 insertions(+), 30 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 5d3675c7a76b..ab5ebf17f30a 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -982,6 +953,31 @@ static void init_overlap_sched_group(struct sched_domain *sd,
>       sg->sgc->max_capacity = SCHED_CAPACITY_SCALE;
>  }
>
> +static struct sched_domain *
> +find_descended_sibling(struct sched_domain *sd, struct sched_domain *sibling)
> +{
> +	/*
> +	 * The proper descendant would be the one whose child won't span out
> +	 * of sd
> +	 */
> +	while (sibling->child &&
> +	       !cpumask_subset(sched_domain_span(sibling->child),
> +			       sched_domain_span(sd)))
> +		sibling = sibling->child;
> +
> +	/*
> +	 * As we are referencing sgc across different topology level, we need
> +	 * to go down to skip those sched_domains which don't contribute to
> +	 * scheduling because they will be degenerated in cpu_attach_domain

 +	 * This is important because we must make sure we point to an sgc that
 +	 * will be updated via update_group_capacity().

> +	 */
> +	while (sibling->child &&
> +	       cpumask_equal(sched_domain_span(sibling->child),
> +			     sched_domain_span(sibling)))
> +		sibling = sibling->child;
> +
> +	return sibling;
> +}
> +
>  static int
>  build_overlap_sched_groups(struct sched_domain *sd, int cpu)
>  {
> @@ -1015,6 +1011,41 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
>               if (!cpumask_test_cpu(i, sched_domain_span(sibling)))
>                       continue;
>
> +		/*
> +		 * Usually we build sched_group by sibling's child sched_domain
> +		 * But for machines whose NUMA diameter are 3 or above, we move
> +		 * to build sched_group by sibling's proper descendant's child
> +		 * domain because sibling's child sched_domain will span out of
> +		 * the sched_domain being built as below.
> +		 *
> +		 * Smallest diameter=3 topology is:
> +		 *
> +		 *   node   0   1   2   3
> +		 *     0:  10  20  30  40
> +		 *     1:  20  10  20  30
> +		 *     2:  30  20  10  20
> +		 *     3:  40  30  20  10
> +		 *
> +		 *   0 --- 1 --- 2 --- 3
> +		 *
> +		 * NUMA-3       0-3             N/A             N/A             0-3
> +		 *  groups:     {0-2},{1-3}                                     {1-3},{0-2}
> +		 *
> +		 * NUMA-2       0-2             0-3             0-3             1-3
> +		 *  groups:     {0-1},{1-3}     {0-2},{2-3}     {1-3},{0-1}     {2-3},{0-2}
> +		 *
> +		 * NUMA-1       0-1             0-2             1-3             2-3
> +		 *  groups:     {0},{1}         {1},{2},{0}     {2},{3},{1}     {3},{2}
> +		 *
> +		 * NUMA-0       0               1               2               3
> +		 *
> +		 * The NUMA-2 groups for nodes 0 and 3 are obviously buggered, as the
                                                       ^^^
s/are/would be/

> +		 * group span isn't a subset of the domain span.
                              ^^^^^
s/isn't/wouldn't be/

> +		 */
> +		if (sibling->child &&
> +		    !cpumask_subset(sched_domain_span(sibling->child), span))
> +			sibling = find_descended_sibling(sd, sibling);
> +
>               sg = build_group_from_child_sched_domain(sibling, cpu);
>               if (!sg)
>                       goto fail;
> @@ -1022,7 +1053,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
>               sg_span = sched_group_span(sg);
>               cpumask_or(covered, covered, sg_span);
>
> -		init_overlap_sched_group(sd, sg);
> +		init_overlap_sched_group(sibling, sg);
>
>               if (!first)
>                       first = sg;
> --
> 2.25.1
