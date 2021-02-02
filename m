Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB4D30C82E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237817AbhBBRoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbhBBRlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:41:08 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E86C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 09:40:28 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y205so14822968pfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kjFBjgfL0i/X4wLYHJU0qBzIDrE+jxocioJrZPUPQUM=;
        b=u0eZhUJgPo+gWQXaF+Eunac/bRehv7i+udknt1EuNz/O2+ckduiSoiiBKzNzhUPZ/I
         Df6Ah9IP+PsKozok5VYDLxucv4A87bJVjr+s5qwY1Icti4hZbuJfVmF4b17FRxRtrLUE
         4B966gmA8xgtUa9lyRd0++5mU96YDkonVhzW50dCHhyJFyeMCM8TzUVdQE0OlVyIYoZF
         al4zMKu421v+wGYREa7pMze+PQE8UsJL0ZMGrsqBXc3B5uScf34DdewDYNZW4fb+IoRE
         rRuH3QLs+7OG9KdgX5d5h1Y3AeXvxHAk5noSXwiHqJT5Wicz8xhXGSZqy+M8QSPj5B4q
         X2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kjFBjgfL0i/X4wLYHJU0qBzIDrE+jxocioJrZPUPQUM=;
        b=KxeaJQdQdQhA7YU4l8Mkc09v+lJmSdAFGmkIQGNIe04p08LFHNwscdkhOejvgw4pyz
         KhP6eSFVRHy5JPCD1MuAra/ruKNxyyRLreBq1TuGnowwrJFilgAcR6FP64u7hb1q8/o+
         pUaaGWj6tDP4bLEcY5k7sklJDxB8Qye8MaG/Q5mFtRRctltjb0qJ7GSvTUmb/IgYxUTA
         wW4ztwbgoKc/4uUaiIM3FIkgkSeRfYBz85VFtLE25GGDO9UPRIRd4KT6QmwC6PF6AYnS
         xZz68+VEottChGC/7svIujWozBynOgZLSyf6NFqPTB1SY99C90L4KaRh6GSVj3RVhdDo
         8B4g==
X-Gm-Message-State: AOAM532+oEgBw/zJiPyAMoYbYtpcl/fv0zWXkfgc0OxVEUOnNSwEpazW
        ZWImiKtvIyf8TlVk2slweHv7EA==
X-Google-Smtp-Source: ABdhPJxkPiMZzH4w6v/2XHi7bwukljYwKf7dI64Mju7FiubG9gFYS+abhX5eCywMzX8kqerr+gU6uA==
X-Received: by 2002:a63:34c8:: with SMTP id b191mr22568072pga.405.1612287627686;
        Tue, 02 Feb 2021 09:40:27 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id h11sm3250962pjg.46.2021.02.02.09.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 09:40:26 -0800 (PST)
Date:   Tue, 2 Feb 2021 10:40:24 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 03/14] coresight: etm4x: Add support for PE OS lock
Message-ID: <20210202174024.GB1536093@xps15>
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

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

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
