Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE6437F65C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhEMLHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbhEMLGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:06:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65B8C06138E;
        Thu, 13 May 2021 04:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BoBJ4XmGvGv9Rh+akhyS1h6qYWC0leGzYa19oQ06nOY=; b=bQ96GKI8ZS6JHqs7pqvVfm4NkF
        cIwSiL9/2rDXKfDMn2NmmQlR6c1HpY0FZApxg2HBj5FCIGnBApMaStFnC3Jayh2LPqN+xfWaDhmu3
        L2SIO5Sh/1l0IHVm+xhhaQQDjT8JcgWeZx5xCaIoUa9D0Bf6U6S8WiuX+MTenkSFjse9P+QeuREhz
        eewkXb4NiNnyHjtpN7JIoFnE+YTrZFMjZuhsagUdpYFBRVQKZ1btr0hscHXgHwDl0aBpP0me5O1Zc
        cwtqHTPqfK2Sl/rHtZg4dm7wQUrCHQQ3MQvD5mknNgy4qTTbWxh826BUrkHXOPufpuQppw/Vy+tvU
        Dzz+zmLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lh99U-005O7T-VU; Thu, 13 May 2021 11:05:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 86F3E30019C;
        Thu, 13 May 2021 13:05:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 70DF02D3BB1B6; Thu, 13 May 2021 13:05:11 +0200 (CEST)
Date:   Thu, 13 May 2021 13:05:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        corbet@lwn.net, rdunlap@infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
Message-ID: <YJ0H5+P4uHJVh5qF@hirez.programming.kicks-ass.net>
References: <1620664258-11045-1-git-send-email-beata.michalska@arm.com>
 <1620664258-11045-3-git-send-email-beata.michalska@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620664258-11045-3-git-send-email-beata.michalska@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 05:30:57PM +0100, Beata Michalska wrote:
> Currently the CPU capacity asymmetry detection, performed through
> asym_cpu_capacity_level, tries to identify the lowest topology level
> at which the highest CPU capacity is being observed, not necessarily
> finding the level at which all possible capacity values are visible
> to all CPUs, which might be bit problematic for some possible/valid
> asymmetric topologies i.e.:
> 
> DIE      [                                ]
> MC       [                       ][       ]
> 
> CPU       [0] [1] [2] [3] [4] [5]  [6] [7]
> Capacity  |.....| |.....| |.....|  |.....|
> 	     L	     M       B        B
> 
> Where:
>  arch_scale_cpu_capacity(L) = 512
>  arch_scale_cpu_capacity(M) = 871
>  arch_scale_cpu_capacity(B) = 1024

Low, High
Small, Big

But you appear to have picked: Low and Big, which just doesn't make any
sense. (Worse, L can also be Large :-)

> In this particular case, the asymmetric topology level will point
> at MC, as all possible CPU  masks for that level do cover the CPU
> with the highest capacity. It will work just fine for the first
> cluster, not so much for the second one though (consider the
> find_energy_efficient_cpu which might end up attempting the energy
> aware wake-up for a domain that does not see any asymmetry at all)
> 
> Rework the way the capacity asymmetry levels are being detected,
> to point to the lowest topology level( for a given CPU), where full
> range of available CPU capacities is visible to all CPUs within given
> domain. As a result, the per-cpu sd_asym_cpucapacity might differ
> across the domains. This will have an impact on EAS wake-up placement
> in a way that it might see different rage of CPUs to be considered,
> depending on the given current and target CPUs.
> 
> Additionally, those levels, where any range of asymmetry (not
> necessarily full) is being detected will get identified as well.
> The selected asymmetric topology level will be denoted by
> SD_ASYM_CPUCAPACITY_FULL sched domain flag whereas the 'sub-levels'
> would receive the already used SD_ASYM_CPUCAPACITY flag. This allows
> maintaining the current behaviour for asymmetric topologies, with
> misfit migration operating correctly on lower levels, if applicable,
> as any asymmetry is enough to trigger the misfit migration.
> The logic there relies on the SD_ASYM_CPUCAPACITY flag and does not
> relate to the full asymmetry level denoted by the sd_asym_cpucapacity
> pointer.

My head hurts trying to untangle this.

Would it not be much easier to have a cpumask for each type and then
have something like:


enum asym_type {
	full,
	asym,
	none,
};

static struct cpumask *asym_masks[];
static int asym_nr;

enum asym_type classify_asym_domain(struct sched_domain *sd)
{
	int i, n = 0;

	for (i = 0; i < asym_nr; i++) {
		if (cpumask_intersects(sched_domain_span(sd), asym_mask[i]))
			n++;
	}

	WARN_ON_ONCE(!n);

	if (n == 1)
		return none;
	if (n == asym_nr)
		return full;
	return asym;
}

Or am I missing the point?
