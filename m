Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678033451C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhCVV2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhCVV2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:28:09 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A8AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 14:28:09 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id l1so9604699pgb.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AWGwJpJAvysvc0U3nO1D3j0X+nOWBvnOH2yA1Diiz/Y=;
        b=T+stc1IT5e2/e9SMHVhr3gF1TWBjy0QTV6HqA92L7bi2o+4uF0vHHHiQyiK5VHE/aL
         ggov40KtouWOuoB+818dqAiNzGmFdqO8kzytJG22LbMYbRPCJI8eKMqYtXmIQRZxJTm2
         X9OSvkZhYzlnEac+MpS238kJ+Bk4e7r74zfh31sZwaR3at8tqs0UPUQC4q7bkiUs2Xlo
         m78vB+9J3b/kwgCUnxgE2+Io/fs3OMaZOu7bJaUnBA9lhed3aZeJaBx5pUKG+WQPjoDP
         o26idzAva9ewmBY6OQ+6ETj245ONE1dow0g+ewjo+HGE50/u/lvAyCdsqpTP9hMv/bV7
         G2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AWGwJpJAvysvc0U3nO1D3j0X+nOWBvnOH2yA1Diiz/Y=;
        b=biU+dhTvTTrf09uWAEFVQb/gq9Ew8rYsUUTOFpyghW6734g6NeymemNGyA6/zjGYNp
         dh5Gg6jpilsWb5kXNSNRI/LToEJ8PN5zcSDDXkDMeKTpxHnX6968ntSXLZSANTDqn9Vn
         rJBRNDR10nvM2Y0VYLv2MWqs474xbZMJp9ApSbvoq3Mk4up1PREQ2glNLKSPM9mTdErt
         BjJTARN/YC8amPGcoJzpSCtfMAJAd2qBn/tmdGA6OvdrPnOVnYYjqlduVuZOl565WDea
         Nn240R+xX8NP6E4eqwX3vxrnj6Zsu10obqfllpaR/yxlPDepPoJes82INaAFFtslsA36
         8YYQ==
X-Gm-Message-State: AOAM531wy3xfdm6xc9J28EGNzOLshRe1fs3Q8PnEXsPkrCHotMuljhSb
        l9rkVy3quyfTbhSlOVOZXEHwZA==
X-Google-Smtp-Source: ABdhPJyeeUHWPaYQvwZj33UiTDB3/S72LhK4P6TF/pt2pdg3xmn+8xpg0Y/liU6ZdZjqLhJqXL+zBw==
X-Received: by 2002:a65:5cc2:: with SMTP id b2mr1281091pgt.280.1616448488549;
        Mon, 22 Mar 2021 14:28:08 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p10sm2718013pfn.55.2021.03.22.14.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 14:28:07 -0700 (PDT)
Date:   Mon, 22 Mar 2021 15:28:05 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org
Subject: Re: [PATCH v4 09/19] coresight: etm4x: Move ETM to prohibited region
 for disable
Message-ID: <20210322212805.GC1684006@xps15>
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
> ---
>  .../coresight/coresight-etm4x-core.c          | 21 +++++++++++++++++--
>  drivers/hwtracing/coresight/coresight-etm4x.h |  2 ++
>  2 files changed, 21 insertions(+), 2 deletions(-)
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

I am done reviewing this set.

Thanks,
Mathieu
 
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
>  	struct etmv4_config		config;
>  	struct etmv4_save_state		*save_state;
>  	bool				state_needs_restore;
> -- 
> 2.24.1
> 
