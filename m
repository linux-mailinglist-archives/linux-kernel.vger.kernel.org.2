Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DB043AF53
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbhJZJq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234962AbhJZJqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:46:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39D7D60FC2;
        Tue, 26 Oct 2021 09:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635241441;
        bh=YhfRDZ8jFzWXlrtoaomkh7QxL2D66rHVotkgkUJ8QXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tn9At/75V3cGEpltTO9f/tMKZI0HfKZhOFguL79zXTt1Q3Pk3Vmf+8c16wtbLn5W9
         +UeBNc5fnL74FRmaB0Uq7AZRmE9u82I8RhOPfyn6yy55kfSbQ0vJNBFV3EaBY0Uwi1
         Rkx/4ot2tNPA/4vm7bnsAYQ7u9WcQvt2aVAIsdwzIKxOniDjD5NLpz3eTjPWujLwEZ
         ATx4nDJ0nvHZdiRRGZYdiuOQYnNvVgMJEdR9wMpPMHhrgZL4QUGHLpeT5D9LdmKQUE
         5b8cxml4TW0XRmlyKKYc4ff+SN1m5vaYMEWUSWL5pBgjO/97UBQWHhB00zDgmpnjkk
         kIivgB3n92b6w==
Date:   Tue, 26 Oct 2021 10:43:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, bbhushan2@marvell.com,
        sgoutham@marvell.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] drivers: perf: Add LLC-TAD perf counter support
Message-ID: <20211026094356.GA21352@willie-the-truck>
References: <20211018153057.23217-1-bbudiredla@marvell.com>
 <20211018153057.23217-2-bbudiredla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018153057.23217-2-bbudiredla@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 09:00:56PM +0530, Bhaskara Budiredla wrote:
> This driver adds support for Last-level cache tag-and-data unit
> (LLC-TAD) PMU that is featured in some of the Marvell's CN10K
> infrastructure silicons.
> 
> The LLC is divided into 2N slices distributed across N Mesh tiles
> in a single-socket configuration. The driver always configures the
> same counter for all of the TADs. The user would end up effectively
> reserving one of eight counters in every TAD to look across all TADs.
> The occurrences of events are aggregated and presented to the user
> at the end of an application run. The driver does not provide a way
> for the user to partition TADs so that different TADs are used for
> different applications.

Is that something you will want to do in the future? If you go with your
current approach of exposing a single "tad" unit to userspace, then you
won't be able to change that.

For the L3 PMUs (including on TX2). we expose per-node PMUs so why shouldn't
we do something similar here and expose each TAD region separately? Even if
userspace drives them all together, it gives you more flexibility in the
future if you _do_ want to be partition them up.

> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 5260b116c7da..2db5418d5b0a 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
>  obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
>  obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
>  obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
> +obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
> new file mode 100644
> index 000000000000..aebb1a0028dc
> --- /dev/null
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
> @@ -0,0 +1,429 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell CN10K LLC-TAD perf driver
> + *
> + * Copyright (C) 2021 Marvell
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt) "tad_pmu: " fmt
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +
> +#define TAD_PFC_OFFSET		0x0
> +#define TAD_PFC(counter)	(TAD_PFC_OFFSET | (counter << 3))
> +#define TAD_PRF_OFFSET		0x100
> +#define TAD_PRF(counter)	(TAD_PRF_OFFSET | (counter << 3))
> +#define TAD_PRF_CNTSEL_MASK	0xFF
> +#define TAD_MAX_COUNTERS	8
> +
> +#define to_tad_pmu(p) (container_of(p, struct tad_pmu, pmu))
> +
> +struct tad_region {
> +	void __iomem	*base;
> +};
> +
> +struct tad_pmu {
> +	struct pmu pmu;
> +	struct tad_region *regions;
> +	u32 region_cnt;
> +	unsigned int cpu;
> +	struct hlist_node node;
> +	struct perf_event *events[TAD_MAX_COUNTERS];
> +	DECLARE_BITMAP(counters_map, TAD_MAX_COUNTERS);
> +};
> +
> +static int tad_pmu_cpuhp_state;
> +
> +static void tad_pmu_event_counter_read(struct perf_event *event)
> +{
> +	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u32 counter_idx = hwc->idx;
> +	u64 delta, prev, new;
> +	int i;
> +
> +	do {
> +		prev = local64_read(&hwc->prev_count);
> +		for (i = 0, new = 0; i < tad_pmu->region_cnt; i++)
> +			new += readq(tad_pmu->regions[i].base +
> +				     TAD_PFC(counter_idx));
> +	} while (local64_cmpxchg(&hwc->prev_count, prev, new) != prev);

If we expose each TAD individually, then this won't matter, but I'd be
inclined to move the counter summation outside of the cmpxchg() loop
given that readq (why not _relaxed?) is probably quite slow.

> +
> +	delta = (new - prev) & GENMASK_ULL(63, 0);

This mask doesn't do anything.

> +	local64_add(delta, &event->count);
> +}
> +
> +static void tad_pmu_event_counter_stop(struct perf_event *event, int flags)
> +{
> +	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u32 counter_idx = hwc->idx;
> +	int i;
> +
> +	/* TAD()_PFC() stop counting on the write
> +	 * which sets TAD()_PRF()[CNTSEL] == 0
> +	 */
> +	for (i = 0; i < tad_pmu->region_cnt; i++)
> +		writeq_relaxed(0, tad_pmu->regions[i].base +
> +			       TAD_PRF(counter_idx));

Please use braces around a multi-line conditional statement.

Will
