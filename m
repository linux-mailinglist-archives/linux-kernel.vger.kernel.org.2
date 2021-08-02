Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC133DD3BF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 12:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhHBKeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 06:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233235AbhHBKeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 06:34:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8F3A60F70;
        Mon,  2 Aug 2021 10:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627900446;
        bh=7VhNgp+WOAG4OkaTRNi7bvE0jsdpnh+V+oLCLJAToRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNwVrEE3VKbO0f8Ho0azUlbTMFuq+Qd0zxUZeCbNTIL6cSK4ASw/+19sTY2iwU/2I
         LgDVUuRstAMltYHDSl+pjyP+PG8JR8nworvB7/b3YtLfj9AXDFJGiivefQUu71nd6R
         QUM5dzuF86w3Lh9FbRrRn1hrzMUWuFDwgyfQ1TSo0JtMjmYP0YD15S72t4pC2XMD2S
         /PvCoWjkdKzuhKaT7+9LD8IRSWHzRjbB2dFHDRKXtympB02pV3p8vbgkpbon1u9NCb
         MAxoUz1JByHH1woAxQyyaW3q/sn9A+8Pzp7h1fK93nwMyzsjlnnMv7E1EWyxNDWVWZ
         v+7PQa9qf8v+Q==
Date:   Mon, 2 Aug 2021 11:34:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     mark.rutland@arm.com, sgoutham@marvell.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/1] drivers: perf: Add LLC-TAD perf counter support
Message-ID: <20210802103401.GA27583@willie-the-truck>
References: <20210614135849.6076-1-bbudiredla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614135849.6076-1-bbudiredla@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 07:28:49PM +0530, Bhaskara Budiredla wrote:
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
> 
> The event counters are zeroed to start event counting to avoid any
> rollover issues. TAD perf counters are 64-bit, so it's not currently
> possible to overflow event counters at current mesh and core
> frequencies.

I couldn't spot where you disable sampling events, which rely heavily on
detecting overflow. Probably need PERF_PMU_CAP_NO_INTERRUPT.

> To measure tad pmu events use perf tool stat command. For instance:
> 
> perf stat -e tad_dat_msh_in_dss,tad_req_msh_out_any <application>
> perf stat -e tad_alloc_any,tad_hit_any,tad_tag_rd <application>
> 
> Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
> ---
>  .../bindings/perf/marvell-cn10k-tad-pmu.txt   |  20 +

Adding the DT list for this ^^ as it looks a bit odd to me (also shouldn't
it be in YAML?)

>  drivers/perf/Kconfig                          |   7 +
>  drivers/perf/Makefile                         |   1 +
>  drivers/perf/marvell_cn10k_tad_pmu.c          | 428 ++++++++++++++++++

-ENODOCUMENTATION

>  4 files changed, 456 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-tad-pmu.txt
>  create mode 100644 drivers/perf/marvell_cn10k_tad_pmu.c
> 
> diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-tad-pmu.txt b/Documentation/devicetree/bindings/perf/marvell-cn10k-tad-pmu.txt
> new file mode 100644
> index 000000000000..8b1f753303e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-tad-pmu.txt
> @@ -0,0 +1,20 @@
> +* Marvell CN10K LLC-TAD performace monitor unit
> +
> +Required properties:
> +- compatible: must be:
> +	"marvell,cn10k-tad-pmu"
> +- tad-cnt: number of tad pmu regions
> +- tad-page-size: size of entire tad block
> +- tad-pmu-page-size: size of one tad pmu region
> +- reg: physical address and size
> +
> +Example:
> +
> +/* Actual values updated by firmware at boot time */
> +tad_pmu {
> +	compatible = "marvell,cn10k-tad-pmu";
> +	tad-cnt = <1>;
> +	tad-page-size = <0x1000>;
> +	tad-pmu-page-size = <0x1000>;
> +	reg = <0x87e2 0x80000000 0x0 0x1000>;
> +};
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 77522e5efe11..73dca11f8080 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -137,6 +137,13 @@ config ARM_DMC620_PMU
>  	  Support for PMU events monitoring on the ARM DMC-620 memory
>  	  controller.
>  
> +config MARVELL_CN10K_TAD_PMU
> +	tristate "Marvell CN10K LLC-TAD PMU"
> +	depends on ARM64
> +	help
> +	  Provides support for Last-Level cache Tag-and-data Units (LLC-TAD)
> +	  performance monitors on CN10K family silicons.
> +
>  source "drivers/perf/hisilicon/Kconfig"
>  
>  endmenu
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
> index 000000000000..99878de481f0
> --- /dev/null
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
> @@ -0,0 +1,428 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell CN10K LLC-TAD perf driver
> + *
> + * Copyright (C) 2021 Marvell.
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
> +#include <linux/arm-smccc.h>
> +
> +#define TAD_PFC_OFFSET		0x0800
> +#define TAD_PFC(counter)	(TAD_PFC_OFFSET | (counter << 3))
> +#define TAD_PRF_OFFSET		0x0900
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
> +
> +	delta = (new - prev) & GENMASK_ULL(63, 0);
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
> +		writeq(0, tad_pmu->regions[i].base + TAD_PRF(counter_idx));

writeq_relaxed() should be sufficient for this (and the others in this
driver), no?

> +static ssize_t tad_pmu_event_show(struct device *dev,
> +				struct device_attribute *attr, char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
> +}
> +
> +#define TAD_PMU_EVENT_ATTR(_name, _id)					\
> +	(&((struct perf_pmu_events_attr[]) {				\
> +		{ .attr = __ATTR(_name, 0444, tad_pmu_event_show, NULL),\
> +		  .id = _id, }						\
> +	})[0].attr.attr)

Use PMU_EVENT_ATTR_ID instead?

> +static int tad_pmu_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct tad_region *regions;
> +	struct tad_pmu *tad_pmu;
> +	struct resource *res;
> +	u32 tad_pmu_page_size;
> +	u32 tad_page_size;
> +	u32 tad_cnt;
> +	int i, ret;
> +	char *name;
> +
> +	tad_pmu = devm_kzalloc(&pdev->dev, sizeof(*tad_pmu), GFP_KERNEL);
> +	if (!tad_pmu)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, tad_pmu);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Mem resource not found\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = of_property_read_u32(node, "tad-page-size", &tad_page_size);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't find tad-page-size property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(node, "tad-pmu-page-size",
> +				   &tad_pmu_page_size);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't find tad-pmu-page-size property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(node, "tad-cnt", &tad_cnt);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't find tad-cnt property\n");
> +		return ret;
> +	}
> +
> +	regions = kcalloc(tad_cnt, sizeof(*regions), GFP_KERNEL);

devm_kcalloc() instead?

Will
