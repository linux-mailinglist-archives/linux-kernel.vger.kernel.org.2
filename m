Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9203DB5F5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbhG3Jcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbhG3Jc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:32:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E63C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:32:24 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id h9so224142ejs.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jXZmAj10YMwUuMQVsNud4Tjz/SN+TYKnCKl9JrvXlTs=;
        b=Ge8bGdXL7p43tS8UZ/M9cht7Pac8eSIv1YeU9Cgs/fe734gtfYaD+dzzM+tGKTwAXD
         2vEt9rFv+3hFvIfILimXdyVg0X7rAZLwSV0aXVXeeq7Iy83xcvqJst5FM2VrpDvc+TTy
         bCjaQldsrKFyLFE5qwLU/qebZwG3N22cnNm9Cbvt+8xMNKxqvWMXvzhG1Q8qXzozTJKQ
         6eNGHWJceAy0/9uMPenRhxWE8JalloYsKTHdoMF1jxOKZzwXljncjt+IVbDniWcPGe+4
         s8QPV3p5Aim4ntUteJGR9nfFeyWC0Kkvv8zRC/rHSkmk6UuKQjeOTp5ChYVNLeY0X0l4
         3TXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jXZmAj10YMwUuMQVsNud4Tjz/SN+TYKnCKl9JrvXlTs=;
        b=MKvWSuaBJ2WyKFaPf3oWbgZkzBiGZm6r9vff+mLyeAI4anfP/+wQiRB4//MLdZf5rO
         NEAKgtJ5nGrQcy5lgQsAr4up1yqi2POCpK5gCdvmHfKUCpTVTdcOr5pRx6gMy7ldVlpG
         VUf6MYXpx3958y5xQKc8QWW62zvDTmqtyxUVaEVfIrV4/yKPHGRxK2FuZkNe2yR8PtKX
         NR8hVbhgd/jVQ0h0d1IspFQloKgaGBvl6M/x0BTSGl1mZ2vX9DZbbyDnxUcNXa5lfd8E
         op+tYLsu8f46uL3z/RIsUkrSQ+e7ISbyBQF0NaIoPct+EHZUm7b0LRv1Rlmkfe0qlrQC
         F7ig==
X-Gm-Message-State: AOAM530y/EtgBdRtg5SpqptFJP8uyriHyVlN8x1X4uTHde3kL6k3OXXX
        foi9OW2Q8/aVSZHaubtDS3EEow==
X-Google-Smtp-Source: ABdhPJz2wmY/H4t/1qZqsTeLCI1roKsM30OsGoE5ghmW5W6XCOsgW22Tu/F3Y6tz5gBO8MV5MCIa+w==
X-Received: by 2002:a17:906:1685:: with SMTP id s5mr1667118ejd.370.1627637543289;
        Fri, 30 Jul 2021 02:32:23 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id j22sm365079ejt.11.2021.07.30.02.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:32:22 -0700 (PDT)
Date:   Fri, 30 Jul 2021 11:32:02 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        dianders@chromium.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/24] iommu: Pull IOVA cookie management into the core
Message-ID: <YQPHEpWLN3lZ92fp@myrica>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <fcd58f6e0265b5339091cbabdea88151d437ad40.1627468309.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcd58f6e0265b5339091cbabdea88151d437ad40.1627468309.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 04:58:22PM +0100, Robin Murphy wrote:
> Now that everyone has converged on iommu-dma for IOMMU_DOMAIN_DMA
> support, we can abandon the notion of drivers being responsible for the
> cookie type, and consolidate all the management into the core code.
> 
> CC: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> CC: Geert Uytterhoeven <geert+renesas@glider.be>
> CC: Yong Wu <yong.wu@mediatek.com>
> CC: Heiko Stuebner <heiko@sntech.de>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> CC: Maxime Ripard <mripard@kernel.org>
> CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/iommu.c | 7 +++++++
>  include/linux/iommu.h | 3 ++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f2cda9950bd5..ea5a9ea8d431 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -7,6 +7,7 @@
>  #define pr_fmt(fmt)    "iommu: " fmt
>  
>  #include <linux/device.h>
> +#include <linux/dma-iommu.h>
>  #include <linux/kernel.h>
>  #include <linux/bits.h>
>  #include <linux/bug.h>
> @@ -1946,6 +1947,11 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>  	/* Assume all sizes by default; the driver may override this later */
>  	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>  
> +	/* Temporarily ignore -EEXIST while drivers still get their own cookies */
> +	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(domain) == -ENOMEM) {
> +		iommu_domain_free(domain);
> +		domain = NULL;
> +	}
>  	return domain;
>  }
>  
> @@ -1957,6 +1963,7 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>  
>  void iommu_domain_free(struct iommu_domain *domain)
>  {
> +	iommu_put_dma_cookie(domain);
>  	domain->ops->domain_free(domain);
>  }
>  EXPORT_SYMBOL_GPL(iommu_domain_free);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 4997c78e2670..141779d76035 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -40,6 +40,7 @@ struct iommu_domain;
>  struct notifier_block;
>  struct iommu_sva;
>  struct iommu_fault_event;
> +struct iommu_dma_cookie;
>  
>  /* iommu fault flags */
>  #define IOMMU_FAULT_READ	0x0
> @@ -86,7 +87,7 @@ struct iommu_domain {
>  	iommu_fault_handler_t handler;
>  	void *handler_token;
>  	struct iommu_domain_geometry geometry;
> -	void *iova_cookie;
> +	struct iommu_dma_cookie *iova_cookie;
>  };
>  
>  enum iommu_cap {
> -- 
> 2.25.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
