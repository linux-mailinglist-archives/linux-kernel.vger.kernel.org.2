Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD27C3DB5E9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbhG3JaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbhG3JaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:30:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC02C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:30:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id da26so12288678edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yTXTqt76E4GEU0UK9YFMo0iaEiN8YMEQ//FwGWJRdeg=;
        b=C7Xuhg0pbaQmCiRVNt5VksbzD8WVUhyFEf6KeaNTEN+U3PyTN3dpnBfFK3jLX8ZwJp
         ZL2zwsy7erQuGwXn/6N1MZoJlSY9SCfrfMfGfYjKeexYeWWG9lc+kojub516EvyABeEP
         sxB3l+l8nxURaym6t6Bjv2rMHMMrTHZIZLhk34zbBH7kUCe+zp5u0niVEF1OYU7cdoXW
         1rTx1UikZmr81qzeHaNZAA9jgtZWF0/tR7+DuDX8uNx/o48ahUKv8rv0mHhIqcG7iZj9
         6lwDTNRMB5mxbWW997/PixT6YuEqw2SE/sM4iPN29nLO5vsCkj2gpRZb+73tcMLxY3My
         iU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yTXTqt76E4GEU0UK9YFMo0iaEiN8YMEQ//FwGWJRdeg=;
        b=baTpip+fI4k/0O1rwb99cYtOqOjq2t4Lx6x/7yFKv4lywl2IE0uQXiqciqsrCsC18R
         Wq6yxXvPYDbuGcsXjlg/tlk9qfI1NVOTRYlTiO2mrmuoUtirJxzqTwtQbkCgXEHiGIPu
         G/YNeHAnV3AlddYqlLThM/nj486zcciZMkxw3PlABs+WGiI1ae8alc9P7ufJ1Y1PrNQk
         FrTYljk+gDdzfzSEmVeOoHoDgmT3vucDwNmubrS/C4+0Rwvix8ecq2QSiixcf8FlDCcm
         y9NXYXJEdKf4KWk0degny04aD+7vZ4NoLuKU/zpe+6ele4ETY3DLrEfyGkPdEI1qVZRP
         L3qg==
X-Gm-Message-State: AOAM531ye3HGZaDfSYhVM0ygdIFH1NSKLOLa5tgYeVkGR5e0ncfmsPLV
        loqcaGTYYhu3MnFPzjomJjHUxrJ2sHysQA==
X-Google-Smtp-Source: ABdhPJzR7h7K0UB04ngaRLs+lx+K56tBTUTPTr94qqq9WbBrSm9ijUbX3qk7TivlvyjJfwpw5LhteQ==
X-Received: by 2002:a50:cf8c:: with SMTP id h12mr1827098edk.360.1627637398976;
        Fri, 30 Jul 2021 02:29:58 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id c13sm422187edv.93.2021.07.30.02.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:29:58 -0700 (PDT)
Date:   Fri, 30 Jul 2021 11:29:38 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 20/24] iommu: Merge strictness and domain type configs
Message-ID: <YQPGgjT5nGdbTYDN@myrica>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <992b2952f0b173411c7b6f221dce82e8e082c0b8.1627468310.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <992b2952f0b173411c7b6f221dce82e8e082c0b8.1627468310.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 04:58:41PM +0100, Robin Murphy wrote:
> To parallel the sysfs behaviour, merge the new build-time option
> for DMA domain strictness into the default domain type choice.
> 
> Suggested-by: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

kernel-parameters.txt still refers to the old config options

Otherwise
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/Kconfig | 80 +++++++++++++++++++++----------------------
>  drivers/iommu/iommu.c |  2 +-
>  2 files changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c84da8205be7..6e06f876d75a 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -79,55 +79,55 @@ config IOMMU_DEBUGFS
>  	  debug/iommu directory, and then populate a subdirectory with
>  	  entries as required.
>  
> -config IOMMU_DEFAULT_PASSTHROUGH
> -	bool "IOMMU passthrough by default"
> -	depends on IOMMU_API
> -	help
> -	  Enable passthrough by default, removing the need to pass in
> -	  iommu.passthrough=on or iommu=pt through command line. If this
> -	  is enabled, you can still disable with iommu.passthrough=off
> -	  or iommu=nopt depending on the architecture.
> -
> -	  If unsure, say N here.
> -
>  choice
> -	prompt "IOMMU default DMA IOTLB invalidation mode"
> -	depends on IOMMU_DMA
> -
> -	default IOMMU_DEFAULT_LAZY if (AMD_IOMMU || INTEL_IOMMU)
> -	default IOMMU_DEFAULT_STRICT
> +	prompt "IOMMU default domain type"
> +	depends on IOMMU_API
> +	default IOMMU_DEFAULT_DMA_LAZY if AMD_IOMMU || INTEL_IOMMU
> +	default IOMMU_DEFAULT_DMA_STRICT
>  	help
> -	  This option allows an IOMMU DMA IOTLB invalidation mode to be
> -	  chosen at build time, to override the default mode of each ARCH,
> -	  removing the need to pass in kernel parameters through command line.
> -	  It is still possible to provide common boot params to override this
> -	  config.
> +	  Choose the type of IOMMU domain used to manage DMA API usage by
> +	  device drivers. The options here typically represent different
> +	  levels of tradeoff between robustness/security and performance,
> +	  depending on the IOMMU driver. Not all IOMMUs support all options.
> +	  This choice can be overridden at boot via the command line, and for
> +	  some devices also at runtime via sysfs.
>  
>  	  If unsure, keep the default.
>  
> -config IOMMU_DEFAULT_STRICT
> -	bool "strict"
> +config IOMMU_DEFAULT_DMA_STRICT
> +	bool "Translated - Strict"
>  	help
> -	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
> -	  the free operation of IOVA are guaranteed to be done in the unmap
> -	  function.
> +	  Trusted devices use translation to restrict their access to only
> +	  DMA-mapped pages, with strict TLB invalidation on unmap. Equivalent
> +	  to passing "iommu.passthrough=0 iommu.strict=1" on the command line.
>  
> -config IOMMU_DEFAULT_LAZY
> -	bool "lazy"
> +	  Untrusted devices always use this mode, with an additional layer of
> +	  bounce-buffering such that they cannot gain access to any unrelated
> +	  data within a mapped page.
> +
> +config IOMMU_DEFAULT_DMA_LAZY
> +	bool "Translated - Lazy"
>  	help
> -	  Support lazy mode, where for every IOMMU DMA unmap operation, the
> -	  flush operation of IOTLB and the free operation of IOVA are deferred.
> -	  They are only guaranteed to be done before the related IOVA will be
> -	  reused.
> +	  Trusted devices use translation to restrict their access to only
> +	  DMA-mapped pages, but with "lazy" batched TLB invalidation. This
> +	  mode allows higher performance with some IOMMUs due to reduced TLB
> +	  flushing, but at the cost of reduced isolation since devices may be
> +	  able to access memory for some time after it has been unmapped.
> +	  Equivalent to passing "iommu.passthrough=0 iommu.strict=0" on the
> +	  command line.
>  
> -	  The isolation provided in this mode is not as secure as STRICT mode,
> -	  such that a vulnerable time window may be created between the DMA
> -	  unmap and the mappings cached in the IOMMU IOTLB or device TLB
> -	  finally being invalidated, where the device could still access the
> -	  memory which has already been unmapped by the device driver.
> -	  However this mode may provide better performance in high throughput
> -	  scenarios, and is still considerably more secure than passthrough
> -	  mode or no IOMMU.
> +	  If this mode is not supported by the IOMMU driver, the effective
> +	  runtime default will fall back to IOMMU_DEFAULT_DMA_STRICT.
> +
> +config IOMMU_DEFAULT_PASSTHROUGH
> +	bool "Passthrough"
> +	help
> +	  Trusted devices are identity-mapped, giving them unrestricted access
> +	  to memory with minimal performance overhead. Equivalent to passing
> +	  "iommu.passthrough=1" (historically "iommu=pt") on the command line.
> +
> +	  If this mode is not supported by the IOMMU driver, the effective
> +	  runtime default will fall back to IOMMU_DEFAULT_DMA_STRICT.
>  
>  endchoice
>  
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5a08e0806cbb..25c1adc1ec67 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -31,7 +31,7 @@ static struct kset *iommu_group_kset;
>  static DEFINE_IDA(iommu_group_ida);
>  
>  static unsigned int iommu_def_domain_type __read_mostly;
> -static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);
> +static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
>  static u32 iommu_cmd_line __read_mostly;
>  
>  struct iommu_group {
> -- 
> 2.25.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
