Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5833133388D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhCJJQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbhCJJQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:16:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1999C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:16:28 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id 7so22448835wrz.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PkG5KhCLzPD+NoLUni1SGXP4hPy8fl2lMbdkLNaDhGw=;
        b=YDSY9EoLtj7bUKgC9G+gi+b8YTKh9E9lDEFvO0Er+tGeD8xKcQlPri3k1uRjbIS1EY
         z2lR2ynWkbKJMIRNj8YGCwkgXEA0fmutbKepBn4GVzd+uvKxNo8JQatydbSyOD/ISmGY
         E1oBB9T4gT24j0o2yK+TWOcIGJ2Ml85+jlbBYVMmgs05TNViVr1ep0PNJTsqVMvjevgT
         UQAlowM84u03T7PlnOH2ELWVpAumPHWucR8FVNTKMiS2g8W0G+8W6ZfvaqiPrmFS/9or
         6x4pxQIjR2Dc7EwEI1wqXRsINSD4WdvPu3sXQ7iWolvM3PfM0/4IxI9fdCIWuEEnYmfP
         T5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PkG5KhCLzPD+NoLUni1SGXP4hPy8fl2lMbdkLNaDhGw=;
        b=Rm/ZkJpEkmSlfoToNoHkB6sF9l/jA5+aowcwj2X22KTKanke1A3QvyjMsiFMaKcjVt
         HxrnqT6zG38+LhvI0dYRfGg5//evH7LnWJQvlVH9phUTXX5e04M0CqLc2KCeYIusIoE7
         cSzc8P6fh8Zl/qk8JTc7q6/R/QxHEgnKhMNkUi5M3WoagzvcF2NKNBX3S+XSHtsGGTSF
         tGnlzojjYq8yknA+omjGXngdFlOI4VHVEwafg6MoBcNmYEbhouLtOxcrQdN2tVEOBlrb
         ngDCmyZl9Gf91laJRSdL1kXtV7xHyi/OpilHNy6J1DUKRPjPFPlvt+YwJvkRfHsYTpW8
         7b4w==
X-Gm-Message-State: AOAM5335DEqp21VSX0YGGkl+/nc3z/l6YFf96EZg9tSuIln+ztEwIUE/
        rZlQ6lmC2ctqxHkCEasUspsirw==
X-Google-Smtp-Source: ABdhPJxR9cMemjYfHKYvXLYhIs0NnnEIp0HfAD4efz2Ym2dj0kft9GotKUJnv1ENopJw2r5QTR7XCg==
X-Received: by 2002:a5d:6a4c:: with SMTP id t12mr2332538wrw.289.1615367787495;
        Wed, 10 Mar 2021 01:16:27 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id u23sm8144903wmn.26.2021.03.10.01.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 01:16:27 -0800 (PST)
Date:   Wed, 10 Mar 2021 09:16:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v3 2/4] mfd: intel-m10-bmc: Simplify the legacy version
 reg definition
Message-ID: <20210310091625.GJ4931@dell>
References: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
 <1614578385-26955-3-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1614578385-26955-3-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2021, Xu Yilun wrote:

> The version register is the only one in the legacy I/O space to be
> accessed, so it is not necessary to define the legacy base & version
> register offset. A direct definition of the legacy version register
> address would be fine.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v3: no change, rebased to 5.12-rc1
> ---
>  drivers/mfd/intel-m10-bmc.c       | 12 +++++-------
>  include/linux/mfd/intel-m10-bmc.h |  2 +-
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> index 06c9775..0d2c03f 100644
> --- a/drivers/mfd/intel-m10-bmc.c
> +++ b/drivers/mfd/intel-m10-bmc.c
> @@ -117,16 +117,14 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
>  
>  	/*
>  	 * This check is to filter out the very old legacy BMC versions,
> -	 * M10BMC_LEGACY_SYS_BASE is the offset to this old block of mmio
> -	 * registers. In the old BMC chips, the BMC version info is stored
> -	 * in this old version register (M10BMC_LEGACY_SYS_BASE +
> -	 * M10BMC_BUILD_VER), so its read out value would have not been
> -	 * LEGACY_INVALID (0xffffffff). But in new BMC chips that the
> +	 * 0x300400 is the offset to this old block of mmio registers. In the

Not sure we want actual addresses in comments.

Please reword this to cover just the latest solution.

> +	 * old BMC chips, the BMC version info is stored in this old version
> +	 * register (0x300400 + 0x68), so its read out value would have not
> +	 * been LEGACY_INVALID (0xffffffff). But in new BMC chips that the
>  	 * driver supports, the value of this register should be
>  	 * LEGACY_INVALID.
>  	 */
> -	ret = m10bmc_raw_read(ddata,
> -			      M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER, &v);
> +	ret = m10bmc_raw_read(ddata, M10BMC_LEGACY_BUILD_VER, &v);
>  	if (ret)
>  		return -ENODEV;
>  
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index 9b54ca1..4f1071f 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -9,7 +9,7 @@
>  
>  #include <linux/regmap.h>
>  
> -#define M10BMC_LEGACY_SYS_BASE		0x300400
> +#define M10BMC_LEGACY_BUILD_VER		0x300468
>  #define M10BMC_SYS_BASE			0x300800
>  #define M10BMC_MEM_END			0x1fffffff
>  

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
