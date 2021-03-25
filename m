Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2650C3487DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 05:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCYET4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 00:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhCYETz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 00:19:55 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551E6C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 21:19:55 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l76so528842pga.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 21:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kAbtn2DjFJGIlk06pF99jYb6+39s2WPW/A5+kygysFI=;
        b=PdAU+7+2QIu0P+GsRXt70GBA/sODxCHbE6cmETYpIAbEFMq4cfLrTzrx+vozxAp96B
         Uy6RzCzOoRhAooPdCk8opLtGBzq4q/bq0auNiO4q+UMQBP6kVpntoslyVxWtvn4o4O4x
         jnc03RUeKQE1sjN5tRZQVsMUvXcO0MeVQMHs68tuZ9R1WgGYep14WMU07QRW4JZ8bRTi
         FlV+hhvMO1Qc3eZNQ1L9lE1hV3cKGx6GG7xcBRWDFt0xZRfCm5uOnNdaRwVCuAFLPLCj
         aIv50ziGob+KrjMTsOJ1+TgeVtBu77SeL3q9rzN828FMcvPUurCX3jxiCGPfwZ88AXhz
         hvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kAbtn2DjFJGIlk06pF99jYb6+39s2WPW/A5+kygysFI=;
        b=k5I3VwL7dppWR2kdb3FAi48IZ/u2Gl+fuOWgEWKYeVPEsFxGFzfDNSBhT+pirlo2jh
         /jNQ3l9oLxqdp+zZ+WJVOVHQv0cs8K/zCia5JpUq94M4IxoQpxeJPEPsSmKXnCxC2j2b
         hMoOVs1nbWiYq7CHnpmePD9nhaFN7fm2Jvx5+rRXjVhTatJbOItO+lukAmzqRxU4VrJ6
         qR3swiYsAN/Gm7ICt4myYoqa3XupIFjUIfx3JHkN7YdqUFn1Iw5e5BMG0vpWokCKJQDA
         cYl9VrTqPKpZWzQqCs2ftHmgkSxrD6T/t2U6FOFVTRxY+fUuGHc5aFKK2VlqBEQ8STgg
         2yqQ==
X-Gm-Message-State: AOAM531NKjQzNMpYCXj3LJrsfMtRsNUzbQFz3R2X2Jx5JZgsIC/lnHJF
        deEQIG4yr3vJ7GTTvSGvyavAQw==
X-Google-Smtp-Source: ABdhPJy/VknUGACX59FTdqJZR5MOezNiKJwEJLQTDR5H+Q7oxlhLtjXZmw8Mf2uE/oHFqB46vf3yiA==
X-Received: by 2002:a62:7ac3:0:b029:1f1:5d13:5ec6 with SMTP id v186-20020a627ac30000b02901f15d135ec6mr6413342pfc.14.1616645994292;
        Wed, 24 Mar 2021 21:19:54 -0700 (PDT)
Received: from localhost ([122.172.6.13])
        by smtp.gmail.com with ESMTPSA id gt22sm3905384pjb.35.2021.03.24.21.19.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 21:19:53 -0700 (PDT)
Date:   Thu, 25 Mar 2021 09:49:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/1] dmaengine: dw: Make it dependent to HAS_IOMEM
Message-ID: <20210325041948.qykcnbqh7vqywvsz@vireshk-i7>
References: <20210324141757.24710-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324141757.24710-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-03-21, 16:17, Andy Shevchenko wrote:
> Some architectures do not provide devm_*() APIs. Hence make the driver
> dependent on HAVE_IOMEM.
> 
> Fixes: dbde5c2934d1 ("dw_dmac: use devm_* functions to simplify code")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: used proper option (Serge)
>  drivers/dma/dw/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/dw/Kconfig b/drivers/dma/dw/Kconfig
> index e5162690de8f..db25f9b7778c 100644
> --- a/drivers/dma/dw/Kconfig
> +++ b/drivers/dma/dw/Kconfig
> @@ -10,6 +10,7 @@ config DW_DMAC_CORE
>  
>  config DW_DMAC
>  	tristate "Synopsys DesignWare AHB DMA platform driver"
> +	depends on HAS_IOMEM
>  	select DW_DMAC_CORE
>  	help
>  	  Support the Synopsys DesignWare AHB DMA controller. This
> @@ -18,6 +19,7 @@ config DW_DMAC
>  config DW_DMAC_PCI
>  	tristate "Synopsys DesignWare AHB DMA PCI driver"
>  	depends on PCI
> +	depends on HAS_IOMEM
>  	select DW_DMAC_CORE
>  	help
>  	  Support the Synopsys DesignWare AHB DMA controller on the

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
