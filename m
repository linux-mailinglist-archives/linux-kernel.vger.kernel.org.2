Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A6633DD8D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhCPTa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbhCPTaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:30:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE753C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:30:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so43975pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=26VQ5R8D+Nv978Dw29EblfP/eaxOCXCI2bftOH+FKyc=;
        b=NLKraj5c80Rza2FJddI2o/SKfGY2EtcGyQHj6Du1+xGxcRK+i0MfKI/wvMUraDTlFI
         TqWDnY0q1+LSop30sJJZLaZzMHMttEcuuAdtaKWwDaoiRkIF63qG1AtWQWUtLESlAhT1
         8fFJI8P4EOlrSXWw8e6zTCmhyJxGTdo3exVLGRJbUDbKkHpEfpqCchyM0H/b4fAy/PMl
         Hva+JH1j6Q7OtSA5A/WJPqvisXeRqVCa9AJwY/D7tIANeWc+iyLv/jrbBYwqkOpzsQRc
         ZXqAs3hm8vgFtCNKWgrz93+TX8pO52SJ3HhvNDDiwrCW5iPRvJG8wHyuCUaRP5vfEgIp
         pkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=26VQ5R8D+Nv978Dw29EblfP/eaxOCXCI2bftOH+FKyc=;
        b=PZpK1GWOgY0GZGRxFt3jQEdmK86SKExD5wG6+LR+VXBJMuGKVwHm8J9PX7qI2jE9V0
         HnlHo+mus+rf7NwqBuYj4kTU1S4O/w9KE+t+YeXOB2DD0R1qdhqYd/tAQ62HGeYcFJAY
         A17ww7kncoz/zGjVlQT6rIzaFZNS1yUnJnCmJnlbFZHSh3PAi7Mfu0AAKhJ55P7qOYdk
         nxi6zSkde413hkz4EcuCTsHJAG/cwE0WmustlujvBGQregD5zfo8OxbCYTlkH4YY0G05
         mmwY2/vL/gZ/LiJ7pmD0Vm0vzAVeuBISjbZSobuZ8UEmavRrzA73wTeFatcQ0O3xUNfi
         LFKw==
X-Gm-Message-State: AOAM5312Wijh0dLnT7N9lAJcKLNSPvL3DaRUVowOrPgkBH+OlVD82kEU
        O9ZChEpc/zDyRQFu1GPO5Uaz4Q==
X-Google-Smtp-Source: ABdhPJwBf3I6ij+ULq029hUbUuZmOD7tr52WJf7LJCXxnaMIoXWPHUkHc2sjiXQ8vxKTH7wBmuZuMw==
X-Received: by 2002:a17:90a:d903:: with SMTP id c3mr590566pjv.27.1615923010233;
        Tue, 16 Mar 2021 12:30:10 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id i10sm19581504pgo.75.2021.03.16.12.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:30:09 -0700 (PDT)
Date:   Tue, 16 Mar 2021 13:30:08 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org
Subject: Re: [PATCH v4 09/19] coresight: etm4x: Move ETM to prohibited region
 for disable
Message-ID: <20210316193008.GD1387186@xps15>
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-10-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225193543.2920532-10-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 07:35:33PM +0000, Suzuki K Poulose wrote:
> If the CPU implements Arm v8.4 Trace filter controls (FEAT_TRF),
> move the ETM to trace prohibited region using TRFCR, while disabling.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> New patch

I would ask you to refrain from introducing new patches.  Otherwise the goal
posts keep on moving with every revision and we'll never get through.  Fixes and
enhancement can come in later patchsets.  

> ---
>  .../coresight/coresight-etm4x-core.c          | 21 +++++++++++++++++--
>  drivers/hwtracing/coresight/coresight-etm4x.h |  2 ++
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 15016f757828..00297906669c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -31,6 +31,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  
> +#include <asm/barrier.h>
>  #include <asm/sections.h>
>  #include <asm/sysreg.h>
>  #include <asm/local.h>
> @@ -654,6 +655,7 @@ static int etm4_enable(struct coresight_device *csdev,
>  static void etm4_disable_hw(void *info)
>  {
>  	u32 control;
> +	u64 trfcr;
>  	struct etmv4_drvdata *drvdata = info;
>  	struct etmv4_config *config = &drvdata->config;
>  	struct coresight_device *csdev = drvdata->csdev;
> @@ -676,6 +678,16 @@ static void etm4_disable_hw(void *info)
>  	/* EN, bit[0] Trace unit enable bit */
>  	control &= ~0x1;
>  
> +	/*
> +	 * If the CPU supports v8.4 Trace filter Control,
> +	 * set the ETM to trace prohibited region.
> +	 */
> +	if (drvdata->trfc) {
> +		trfcr = read_sysreg_s(SYS_TRFCR_EL1);
> +		write_sysreg_s(trfcr & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE),
> +			       SYS_TRFCR_EL1);
> +		isb();
> +	}
>  	/*
>  	 * Make sure everything completes before disabling, as recommended
>  	 * by section 7.3.77 ("TRCVICTLR, ViewInst Main Control Register,
> @@ -683,12 +695,16 @@ static void etm4_disable_hw(void *info)
>  	 */
>  	dsb(sy);
>  	isb();
> +	/* Trace synchronization barrier, is a nop if not supported */
> +	tsb_csync();
>  	etm4x_relaxed_write32(csa, control, TRCPRGCTLR);
>  
>  	/* wait for TRCSTATR.PMSTABLE to go to '1' */
>  	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
>  		dev_err(etm_dev,
>  			"timeout while waiting for PM stable Trace Status\n");
> +	if (drvdata->trfc)
> +		write_sysreg_s(trfcr, SYS_TRFCR_EL1);

drvdata->trfc is invariably set to true in cpu_enable_tracing() and as such
testing for it is not required. 

>  
>  	/* read the status of the single shot comparators */
>  	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
> @@ -873,7 +889,7 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
>  	return false;
>  }
>  
> -static void cpu_enable_tracing(void)
> +static void cpu_enable_tracing(struct etmv4_drvdata *drvdata)
>  {
>  	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
>  	u64 trfcr;
> @@ -881,6 +897,7 @@ static void cpu_enable_tracing(void)
>  	if (!cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_TRACE_FILT_SHIFT))
>  		return;
>  
> +	drvdata->trfc = true;
>  	/*
>  	 * If the CPU supports v8.4 SelfHosted Tracing, enable
>  	 * tracing at the kernel EL and EL0, forcing to use the
> @@ -1082,7 +1099,7 @@ static void etm4_init_arch_data(void *info)
>  	/* NUMCNTR, bits[30:28] number of counters available for tracing */
>  	drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
>  	etm4_cs_lock(drvdata, csa);
> -	cpu_enable_tracing();
> +	cpu_enable_tracing(drvdata);

At least for this patch, the above three hunks aren't needed.

>  }
>  
>  static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 0af60571aa23..f6478ef642bf 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -862,6 +862,7 @@ struct etmv4_save_state {
>   * @nooverflow:	Indicate if overflow prevention is supported.
>   * @atbtrig:	If the implementation can support ATB triggers
>   * @lpoverride:	If the implementation can support low-power state over.
> + * @trfc:	If the implementation supports Arm v8.4 trace filter controls.
>   * @config:	structure holding configuration parameters.
>   * @save_state:	State to be preserved across power loss
>   * @state_needs_restore: True when there is context to restore after PM exit
> @@ -912,6 +913,7 @@ struct etmv4_drvdata {
>  	bool				nooverflow;
>  	bool				atbtrig;
>  	bool				lpoverride;
> +	bool				trfc;

Nor is this one.  

>  	struct etmv4_config		config;
>  	struct etmv4_save_state		*save_state;
>  	bool				state_needs_restore;
> -- 
> 2.24.1
> 
