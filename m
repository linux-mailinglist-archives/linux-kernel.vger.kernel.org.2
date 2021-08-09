Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138A33E4CA7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 21:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhHITGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 15:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbhHITGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 15:06:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76921C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 12:06:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e19so4042543pla.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=caHh4K3GG0Tg0ei0p+fQ0LOeKdeT+FalwTqxBa+LBRE=;
        b=PLtOLsH9SDCeD60uPC/eAHmMv4J9tYqXrL0GGDcdYOWSwDcHfR0RHL0ZqR3uT9U3D9
         86bhjXtEtn0w/6QUL1B/VbOvdxiPp4vbcdm3Z7kIDrvpaPCCgmQr0dmW2oe+0+TVgJJS
         qt5fn98bOcSAAnbSJQJFCpngfP0zR2hTJh5mUk/l0J9W8qYExl2GnHKwcU7Lbfq9Qvs4
         4cb/sEs8k0g960J9eoqGvk4ecDtPaIVT9Ndj+Clld8hLpD8Wl1u/aEd79q3+aOUpAVpv
         S1Fgr0j1JzOItQJ4gnjxEiAL2Jis7FuPj1OP96QZnBVjxa4ETx6m4YCDBjoWpHVqOfV6
         FnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=caHh4K3GG0Tg0ei0p+fQ0LOeKdeT+FalwTqxBa+LBRE=;
        b=bfJTrusXmfUnhfCxXStXYA9q9X2AUbbjkVkegruX4byhzTkBkMnwAxUfDwFvxdyB3U
         pQmuV5VsFQb+nyNh2VkAWn/QsrHP5l8QdJ7uBLDEYXf+VA2y10W5Zgte1Gx9olya2E/5
         qZwOXjZwo4HYPjYuGqdWNx9cYqeOQ3Uq0wPhEGtNEH8Ag7iMgp6UyNvREIMkvEjYqlUu
         OD3zbKhjaGq2Nh7pd3VruN564sjiGmeizKGiqHZtbAYxX5uBsVTzxdruQBdvf7FsVB8d
         W053xhyqU44LmcD9rtXS6TnbA2BL5xNaX19hpKT2/sBk3eP/mPPlZdZt84UKyMbox1+6
         o5ug==
X-Gm-Message-State: AOAM5318+5uQhyA+FpQUwDxaBdzCBvFnlYXtQ8ME2xofgXG3s/cefoTD
        w34hWaGXX5eAM+jLh95deQEhax4qc/SH0J9oNG4I7A==
X-Google-Smtp-Source: ABdhPJx+Udtd8mj0DtGSlKZTvrmyjG18QmaVRtyeRrpitO2gTq7zjK3NP0/NNGDwGognWiN7/ZARJfaM+lIVAcP5n30=
X-Received: by 2002:a63:4f43:: with SMTP id p3mr290889pgl.435.1628535959700;
 Mon, 09 Aug 2021 12:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628094600.git.robin.murphy@arm.com> <3b5284ee394f267ba966839173f874fc9a996bb2.1628094601.git.robin.murphy@arm.com>
In-Reply-To: <3b5284ee394f267ba966839173f874fc9a996bb2.1628094601.git.robin.murphy@arm.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 9 Aug 2021 12:05:23 -0700
Message-ID: <CACK8Z6HSM678q=BZ3FY7spN2S3ZkhdJ3ecnMCbKWrqB5dNWaMA@mail.gmail.com>
Subject: Re: [PATCH v3 24/25] iommu/dma: Factor out flush queue init
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org,
        chenxiang66@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 10:16 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Factor out flush queue setup from the initial domain init so that we
> can potentially trigger it from sysfs later on in a domain's lifetime.
>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 30 ++++++++++++++++++++----------
>  include/linux/dma-iommu.h |  9 ++++++---
>  2 files changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2e19505dddf9..f51b8dc99ac6 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -310,6 +310,25 @@ static bool dev_is_untrusted(struct device *dev)
>         return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
>  }
>
> +int iommu_dma_init_fq(struct iommu_domain *domain)
> +{
> +       struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +
> +       if (domain->type != IOMMU_DOMAIN_DMA_FQ)
> +               return -EINVAL;
> +       if (cookie->fq_domain)
> +               return 0;
> +
> +       if (init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all,
> +                                 iommu_dma_entry_dtor)) {
> +               pr_warn("iova flush queue initialization failed\n");
> +               domain->type = IOMMU_DOMAIN_DMA;
> +               return -ENODEV;
> +       }
> +       cookie->fq_domain = domain;
> +       return 0;
> +}
> +
>  /**
>   * iommu_dma_init_domain - Initialise a DMA mapping domain
>   * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
> @@ -362,16 +381,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>         }
>
>         init_iova_domain(iovad, 1UL << order, base_pfn);
> -
> -       if (domain->type == IOMMU_DOMAIN_DMA_FQ && !cookie->fq_domain) {
> -               if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
> -                                         iommu_dma_entry_dtor)) {
> -                       pr_warn("iova flush queue initialization failed\n");
> -                       domain->type = IOMMU_DOMAIN_DMA;
> -               } else {
> -                       cookie->fq_domain = domain;
> -               }
> -       }
> +       iommu_dma_init_fq(domain);
>
>         return iova_reserve_iommu_regions(dev, domain);
>  }
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 758ca4694257..81ab647f1618 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -20,6 +20,7 @@ void iommu_put_dma_cookie(struct iommu_domain *domain);
>
>  /* Setup call for arch DMA mapping code */
>  void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
> +int iommu_dma_init_fq(struct iommu_domain *domain);
>
>  /* The DMA API isn't _quite_ the whole story, though... */
>  /*
> @@ -37,9 +38,6 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>
>  void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>
> -void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
> -               struct iommu_domain *domain);
> -

This looks like an unrelated code cleanup. Should this be a separate patch?

Thanks,

Rajat


>  extern bool iommu_dma_forcedac;
>
>  #else /* CONFIG_IOMMU_DMA */
> @@ -54,6 +52,11 @@ static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
>  {
>  }
>
> +static inline int iommu_dma_init_fq(struct iommu_domain *domain)
> +{
> +       return -EINVAL;
> +}
> +
>  static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
>  {
>         return -ENODEV;
> --
> 2.25.1
>
