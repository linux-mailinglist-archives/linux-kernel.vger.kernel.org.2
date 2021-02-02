Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E444030C8FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhBBSGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbhBBSDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:03:51 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2D6C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:03:11 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id a20so2769360pjs.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lkhZZvNSdphBEgxNtEjm9c1xFLre72fLRjQrKOIVspA=;
        b=K5RVz3i7fl0XZEDJsRd7Ki/q8AQ2Sq2FdIM67rEOfp6MPElxA+i29Elr7SkEGFenGY
         l+YzVYqx486SffkW2svqEEiNcRBFe16bv4wNxrdY7fNkl7CfvecpzdPxFBEtE8oulkms
         V3gCfgaCjC3ds3v7t19w9yTN1bB288TQrf50gBECx+FelXA+9CyQLAYNkNuL2OYRJ7zn
         UOpLPeSv0hAGdAaNhsWmXDnA6ErBGJfnlDYIf5QJZni2nGevKmgbGhVOuakpYRlRsLa3
         m0m769ekdmqgeS5qaKZSDYhoQXielMT0N1vhhW/hxMYG9wMnPTgCNF5gDH12jg0Pq960
         Hnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lkhZZvNSdphBEgxNtEjm9c1xFLre72fLRjQrKOIVspA=;
        b=mQ73mA6l0PiQAdt82Oposg2cv3ozuULdGeMgLOZw9ywJVl1b7R/ymnomShTy04WF1A
         Bl/w9gf7z1l96jHf90dFAQ+76Xltyvqoum5SaBKcW2QPKkQopqjBx4nMn/pZDt/F/upH
         19ize1SR9N6tszOW2oYEiqORQKU6svzQp4ywtXR4GQDNXzkmdSAcjWLpdWfBA/owcY/H
         nytpDIwvlGUBJNclCIOHa55sY3hkhnJpAEFafFVn3UOGCfodnXmd1LAQ38HA+5EN6epg
         35c9apQlYJ93GKs2P8Wb4u6KlWm/R1dBls6KpANmyPOufJKNvd1fvEassNB+Bk0qXH4B
         BQtw==
X-Gm-Message-State: AOAM531PXyGUyaNDCWogOHweaxFChWovTVi+OIu9BabIs2llML6h+jPO
        cCLA+O8VJCYSvBmI0cE3mD4gqA==
X-Google-Smtp-Source: ABdhPJy0aGGFdNwQYktKyVZktX6sYlcHstzKJg8MqmMvsk+5l7qRHHU34pKa4q5eHKoyJXrn95GXAg==
X-Received: by 2002:a17:90b:11c9:: with SMTP id gv9mr671158pjb.196.1612288990722;
        Tue, 02 Feb 2021 10:03:10 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id w21sm22046360pff.220.2021.02.02.10.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:03:10 -0800 (PST)
Date:   Tue, 2 Feb 2021 11:03:08 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 03/14] coresight: etm4x: Add support for PE OS lock
Message-ID: <20210202180308.GD1536093@xps15>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-4-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611737738-1493-4-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 02:25:27PM +0530, Anshuman Khandual wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> ETE may not implement the OS lock and instead could rely on
> the PE OS Lock for the trace unit access. This is indicated
> by the TRCOLSR.OSM == 0b100. Add support for handling the
> PE OS lock
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 50 ++++++++++++++++++----
>  drivers/hwtracing/coresight/coresight-etm4x.h      | 15 +++++++
>  2 files changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 473ab74..9edf8be 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -114,30 +114,59 @@ void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
>  	}
>  }
>  
> -static void etm4_os_unlock_csa(struct etmv4_drvdata *drvdata, struct csdev_access *csa)
> +static void etm_detect_os_lock(struct etmv4_drvdata *drvdata,
> +			       struct csdev_access *csa)
>  {
> -	/* Writing 0 to TRCOSLAR unlocks the trace registers */
> -	etm4x_relaxed_write32(csa, 0x0, TRCOSLAR);
> -	drvdata->os_unlock = true;
> +	u32 oslsr = etm4x_relaxed_read32(csa, TRCOSLSR);
> +
> +	drvdata->os_lock_model = ETM_OSLSR_OSLM(oslsr);
> +}
> +
> +static void etm_write_os_lock(struct etmv4_drvdata *drvdata,
> +			      struct csdev_access *csa, u32 val)
> +{
> +	val = !!val;
> +
> +	switch (drvdata->os_lock_model) {
> +	case ETM_OSLOCK_PRESENT:
> +		etm4x_relaxed_write32(csa, val, TRCOSLAR);
> +		break;
> +	case ETM_OSLOCK_PE:
> +		write_sysreg_s(val, SYS_OSLAR_EL1);
> +		break;
> +	default:
> +		pr_warn_once("CPU%d: Unsupported Trace OSLock model: %x\n",
> +			     smp_processor_id(), drvdata->os_lock_model);
> +		fallthrough;
> +	case ETM_OSLOCK_NI:
> +		return;
> +	}
>  	isb();
>  }
>  
> +static inline void etm4_os_unlock_csa(struct etmv4_drvdata *drvdata,
> +				      struct csdev_access *csa)
> +{
> +	WARN_ON(drvdata->cpu != smp_processor_id());
> +
> +	/* Writing 0 to OS Lock unlocks the trace unit registers */
> +	etm_write_os_lock(drvdata, csa, 0x0);
> +	drvdata->os_unlock = true;
> +}
> +
>  static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
>  {
>  	if (!WARN_ON(!drvdata->csdev))
>  		etm4_os_unlock_csa(drvdata, &drvdata->csdev->access);
> -
>  }
>  
>  static void etm4_os_lock(struct etmv4_drvdata *drvdata)
>  {
>  	if (WARN_ON(!drvdata->csdev))
>  		return;
> -
> -	/* Writing 0x1 to TRCOSLAR locks the trace registers */
> -	etm4x_relaxed_write32(&drvdata->csdev->access, 0x1, TRCOSLAR);
> +	/* Writing 0x1 to OS Lock locks the trace registers */
> +	etm_write_os_lock(drvdata, &drvdata->csdev->access, 0x1);
>  	drvdata->os_unlock = false;
> -	isb();
>  }
>  
>  static void etm4_cs_lock(struct etmv4_drvdata *drvdata,
> @@ -906,6 +935,9 @@ static void etm4_init_arch_data(void *info)
>  	if (!etm4_init_csdev_access(drvdata, csa))
>  		return;
>  
> +	/* Detect the support for OS Lock before we actuall use it */

s/actuall/actually

> +	etm_detect_os_lock(drvdata, csa);
> +
>  	/* Make sure all registers are accessible */
>  	etm4_os_unlock_csa(drvdata, csa);
>  	etm4_cs_unlock(drvdata, csa);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 0af6057..0e86eba 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -506,6 +506,20 @@
>  					 ETM_MODE_EXCL_USER)
>  
>  /*
> + * TRCOSLSR.OSLM advertises the OS Lock model.
> + * OSLM[2:0] = TRCOSLSR[4:3,0]
> + *
> + *	0b000 - Trace OS Lock is not implemented.
> + *	0b010 - Trace OS Lock is implemented.
> + *	0b100 - Trace OS Lock is not implemented, unit is controlled by PE OS Lock.
> + */
> +#define ETM_OSLOCK_NI		0b000
> +#define ETM_OSLOCK_PRESENT	0b010
> +#define ETM_OSLOCK_PE		0b100
> +
> +#define ETM_OSLSR_OSLM(oslsr)	((((oslsr) & GENMASK(4, 3)) >> 2) | (oslsr & 0x1))
> +
> +/*
>   * TRCDEVARCH Bit field definitions
>   * Bits[31:21]	- ARCHITECT = Always Arm Ltd.
>   *                * Bits[31:28] = 0x4
> @@ -897,6 +911,7 @@ struct etmv4_drvdata {
>  	u8				s_ex_level;
>  	u8				ns_ex_level;
>  	u8				q_support;
> +	u8				os_lock_model;
>  	bool				sticky_enable;
>  	bool				boot_enable;
>  	bool				os_unlock;
> -- 
> 2.7.4
> 
