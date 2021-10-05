Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1DD422E48
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbhJEQsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbhJEQsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:48:35 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FF7C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 09:46:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 187so20683pfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CMKgmK3mlTyeDt2/ePAWiFedhbRGkxDpDQljZm9d13s=;
        b=IVjUvqOy0HV1zpBCIBHKVLlL3pWPcf2jyz3qZclFd4LzLlBUfF2pw0QpDUXVCTmM0+
         tfrtTjpwmkJG9Ptgsawzv8V3qKMEJvRLlzTUu0AIjyt04G73CCcr9PLJStbkcU6XKvtx
         bUXZQYTywIlwQxHYR7dRjqZYav3K/cKC45u+T0zbBpcRYtuqcMWGockpizstmlLBy+UH
         95bFn5UCOmt/MqK3G0r9Kr5QE+k+4EUkYjW9B4so7vjCZjijnxEF9UN/Aei35Plyiwzb
         X2EoScsEFrBYkfQ+WwvYda5s5S1L9rfhfjVihyqx4mLsjYJGluubYlo61AQhcoUoV6iE
         7HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CMKgmK3mlTyeDt2/ePAWiFedhbRGkxDpDQljZm9d13s=;
        b=6yXnfKCB5gi/swHy5ke8STPV3+pjISV9A+m6S32QV6zvBW6csfniqHGZNs+OWT2nhf
         8HduUnSJkFX2tP24Xqxl4/qImgDPjlgXTPVeA51Vx0ol2IAS7kCD/oP/NV1p+ZqWfL+h
         uEVoSZlfz/ht2JjRxbdq5yMq39GLld6BZH45/i6uF4tWPDPso9fcbqlTl0PYkmwEhpp+
         0dE+nHlyvXocCqs7ZksqBUIVDc7metooWg9rtME9EiY+AXeFrssD4+cSR4JMR2VHP4gM
         fN13Vh2wVObFZrYxs8NFVClRbPSYMcZmy6nhojxbKo0ztWVomzPJ667Lzn6xUp08TYLR
         QVBw==
X-Gm-Message-State: AOAM5322o3w/Jd7XesI2cFVpMHgS9Dnydm1qJx5JUAwjA7LPjazWCMLD
        LDvDFrNtcU7goeqXUw4ltuNbbw==
X-Google-Smtp-Source: ABdhPJwK/PYb+B+6yxnpsL3UyIdlGb08TId/QCoP3QG4kDkc+ttnBPLsAem9Pqu2DiYdHnBzXfBcwA==
X-Received: by 2002:a05:6a00:887:b0:44b:dee9:b7b1 with SMTP id q7-20020a056a00088700b0044bdee9b7b1mr33242887pfj.84.1633452404430;
        Tue, 05 Oct 2021 09:46:44 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q21sm2756352pjg.55.2021.10.05.09.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 09:46:43 -0700 (PDT)
Date:   Tue, 5 Oct 2021 10:46:41 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        james.morse@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
Subject: Re: [PATCH v2 02/17] coresight: trbe: Add infrastructure for Errata
 handling
Message-ID: <20211005164641.GA3311227@p14s>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-3-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921134121.2423546-3-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 02:41:06PM +0100, Suzuki K Poulose wrote:
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

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

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
>  	cpudata->trbe_flag = get_trbe_flag_update(trbidr);
>  	cpudata->cpu = cpu;
>  	cpudata->drvdata = drvdata;
> -- 
> 2.24.1
> 
