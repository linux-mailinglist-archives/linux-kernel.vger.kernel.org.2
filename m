Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82E6414220
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 08:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhIVGsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 02:48:12 -0400
Received: from foss.arm.com ([217.140.110.172]:43794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232710AbhIVGsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 02:48:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2B1B113E;
        Tue, 21 Sep 2021 23:46:41 -0700 (PDT)
Received: from [10.163.73.113] (unknown [10.163.73.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 732593F40C;
        Tue, 21 Sep 2021 23:46:37 -0700 (PDT)
Subject: Re: [PATCH v2 02/17] coresight: trbe: Add infrastructure for Errata
 handling
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        leo.yan@linaro.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-3-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7384656b-2777-d5d5-0c5a-d30ee6dde20a@arm.com>
Date:   Wed, 22 Sep 2021 12:17:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210921134121.2423546-3-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/21 7:11 PM, Suzuki K Poulose wrote:
> Add a minimal infrastructure to keep track of the errata
> affecting the given TRBE instance. Given that we have
> heterogeneous CPUs, we have to manage the list per-TRBE
> instance to be able to apply the work around as needed.
> 
> We rely on the arm64 errata framework for the actual
> description and the discovery of a given erratum, to
> keep the Erratum work around at a central place and
> benefit from the code and the advertisement from the
> kernel. We use a local mapping of the erratum to
> avoid bloating up the individual TRBE structures.
> i.e, each arm64 TRBE erratum bit is assigned a new number
> within the driver to track. Each trbe instance updates
> the list of affected erratum at probe time on the CPU.
> This makes sure that we can easily access the list of
> errata on a given TRBE instance without much overhead.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v1:
>   - Flip the order of args for trbe_has_erratum()
>   - Move erratum detection further down in the sequence
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 49 ++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index e3d73751d568..63f7edd5fd1f 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -16,6 +16,8 @@
>  #define pr_fmt(fmt) DRVNAME ": " fmt
>  
>  #include <asm/barrier.h>
> +#include <asm/cputype.h>
> +
>  #include "coresight-self-hosted-trace.h"
>  #include "coresight-trbe.h"
>  
> @@ -65,6 +67,35 @@ struct trbe_buf {
>  	struct trbe_cpudata *cpudata;
>  };
>  
> +/*
> + * TRBE erratum list
> + *
> + * We rely on the corresponding cpucaps to be defined for a given
> + * TRBE erratum. We map the given cpucap into a TRBE internal number
> + * to make the tracking of the errata lean.
> + *
> + * This helps in :
> + *   - Not duplicating the detection logic
> + *   - Streamlined detection of erratum across the system
> + *
> + * Since the erratum work arounds could be applied individually
> + * per TRBE instance, we keep track of the list of errata that
> + * affects the given instance of the TRBE.
> + */
> +#define TRBE_ERRATA_MAX			0
> +
> +static unsigned long trbe_errata_cpucaps[TRBE_ERRATA_MAX] = {
> +};

Hence TRBE_ERRATA_MAX needs to be updated manually here when new
TRBE specific erratums get added to the cpucap list. Hence lets
add a comment indicating that the TRBE_ERRATA_MAX needs explicit
syncing with changes to cpucap list.

> +
> +/*
> + * struct trbe_cpudata: TRBE instance specific data
> + * @trbe_flag		- TRBE dirty/access flag support
> + * @tbre_align		- Actual TRBE alignment required for TRBPTR_EL1.
> + * @cpu			- CPU this TRBE belongs to.
> + * @mode		- Mode of current operation. (perf/disabled)
> + * @drvdata		- TRBE specific drvdata
> + * @errata		- Bit map for the errata on this TRBE.
> + */
>  struct trbe_cpudata {
>  	bool trbe_flag;
>  	u64 trbe_align;
> @@ -72,6 +103,7 @@ struct trbe_cpudata {
>  	enum cs_mode mode;
>  	struct trbe_buf *buf;
>  	struct trbe_drvdata *drvdata;
> +	DECLARE_BITMAP(errata, TRBE_ERRATA_MAX);
>  };
>  
>  struct trbe_drvdata {
> @@ -84,6 +116,21 @@ struct trbe_drvdata {
>  	struct platform_device *pdev;
>  };
>  
> +static void trbe_check_errata(struct trbe_cpudata *cpudata)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(trbe_errata_cpucaps); i++) {
> +		if (this_cpu_has_cap(trbe_errata_cpucaps[i]))
> +			set_bit(i, cpudata->errata);
> +	}
> +}
> +
> +static inline bool trbe_has_erratum(struct trbe_cpudata *cpudata, int i)
> +{
> +	return (i < TRBE_ERRATA_MAX) && test_bit(i, cpudata->errata);
> +}
> +
>  static int trbe_alloc_node(struct perf_event *event)
>  {
>  	if (event->cpu == -1)
> @@ -926,6 +973,8 @@ static void arm_trbe_probe_cpu(void *info)
>  		pr_err("Unsupported alignment on cpu %d\n", cpu);
>  		goto cpu_clear;
>  	}
> +
> +	trbe_check_errata(cpudata);

This could be moved further down just before the 'return' statement.
Lets not interrupt cpudata init sequence, rather run all the errata
detection right at the end.

>  	cpudata->trbe_flag = get_trbe_flag_update(trbidr);
>  	cpudata->cpu = cpu;
>  	cpudata->drvdata = drvdata;
> 
