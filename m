Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA423D425F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhGWVB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 17:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhGWVB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 17:01:28 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60683C061757
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 14:42:01 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id a201so4376382ybg.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 14:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4wRlXm54e3C3fuLfTWWm+AhBVsv03apMT1xPphwuac=;
        b=dB+dx1fxF4JegMhLECUyoU5542K4bedOLBloAj9atRP2r5OkvIja8syfi3HPvdd/g2
         qEbjfmLxW1YZ9GCendFo8POwz8rNKhQnjLbWNBt7Vo1FMgA16fFeVFumICSZ/kIjrPRg
         4m0PJyvKwTmK0lfdRFJDGf4snvmoLoCd+PGQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4wRlXm54e3C3fuLfTWWm+AhBVsv03apMT1xPphwuac=;
        b=Za/gIDzNuxjlf4TmxdKksMzc2XeNqsNKN98ffiVKniSqsWH7HS3gRH35OoXfITCXTj
         LtPvjVCSQSk/69qElPlBcPpIiN3fFmwvCjLWfJ06sW5jUSVA4b9qrf3w8Dp6FTZKYTKG
         PiOHEZVbwOTwtRatIWQi2NgMQXuUskx3/n7nidvi8IQ5cv4EJwsdevWpJ1k006r5wtmY
         WaTmT0coPxANQTH3/CMGhP9JwNqRpvtwXW/06d6gB+Z8xilRvw4GDiTW47qE693+S9RV
         KW29SVZJjGqvhEpEDLIKgMmQd1veGxR9nYWhDBRd7wk0iBU2dbfc03pPQ2aynNfDQF2g
         ww4w==
X-Gm-Message-State: AOAM5328zF3O1t7ILVN/3awSBlN3ZkI0LZUvknlmT+ynxFeZqjyBdbFY
        HcvCGYIUSdWUYPyBwzePNgjTEtZPmxUGBHDkTBMT
X-Google-Smtp-Source: ABdhPJyxNk4dBKh+nVb0yY5onNvD2+GMd5ddJFERs4q+Noxze2O0nDCTkCDvf/IfUkf03HDgO2GXZQt2BunJYA4hhxs=
X-Received: by 2002:a25:d015:: with SMTP id h21mr8642248ybg.202.1627076520639;
 Fri, 23 Jul 2021 14:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210712061704.4162464-1-hch@lst.de> <20210712061704.4162464-7-hch@lst.de>
In-Reply-To: <20210712061704.4162464-7-hch@lst.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 23 Jul 2021 14:41:50 -0700
Message-ID: <CAOnJCUJyBCwCzCAjpO2Kn4+eNx+FAGbbxotW4UqEnFVJN69GXQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] dma-mapping: make the global coherent pool conditional
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2021 at 11:25 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Only build the code to support the global coherent pool if support for
> it is enabled.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Dillon Min <dillon.minfei@gmail.com>
> ---
>  include/linux/dma-map-ops.h | 18 +++++++-------
>  kernel/dma/coherent.c       | 47 ++++++++++++++++++++-----------------
>  2 files changed, 35 insertions(+), 30 deletions(-)
>
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 7e49bb86a0c0..9b79aa4dd300 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -170,13 +170,6 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
>  int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
>  int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
>                 void *cpu_addr, size_t size, int *ret);
> -
> -void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
> -               dma_addr_t *dma_handle);
> -int dma_release_from_global_coherent(int order, void *vaddr);
> -int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
> -               size_t size, int *ret);
> -int dma_init_global_coherent(phys_addr_t phys_addr, size_t size);
>  #else
>  static inline int dma_declare_coherent_memory(struct device *dev,
>                 phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
> @@ -186,7 +179,16 @@ static inline int dma_declare_coherent_memory(struct device *dev,
>  #define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
>  #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
>  #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
> +#endif /* CONFIG_DMA_DECLARE_COHERENT */
>
> +#ifdef CONFIG_DMA_GLOBAL_POOL
> +void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
> +               dma_addr_t *dma_handle);
> +int dma_release_from_global_coherent(int order, void *vaddr);
> +int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
> +               size_t size, int *ret);
> +int dma_init_global_coherent(phys_addr_t phys_addr, size_t size);
> +#else
>  static inline void *dma_alloc_from_global_coherent(struct device *dev,
>                 ssize_t size, dma_addr_t *dma_handle)
>  {
> @@ -201,7 +203,7 @@ static inline int dma_mmap_from_global_coherent(struct vm_area_struct *vma,
>  {
>         return 0;
>  }
> -#endif /* CONFIG_DMA_DECLARE_COHERENT */
> +#endif /* CONFIG_DMA_GLOBAL_POOL */
>
>  /*
>   * This is the actual return value from the ->alloc_noncontiguous method.
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index 160d4e246ecb..c05408902a68 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -20,8 +20,6 @@ struct dma_coherent_mem {
>         bool            use_dev_dma_pfn_offset;
>  };
>
> -static struct dma_coherent_mem *dma_coherent_default_memory __ro_after_init;
> -
>  static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *dev)
>  {
>         if (dev && dev->dma_mem)
> @@ -191,16 +189,6 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
>         return 1;
>  }
>
> -void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
> -                                    dma_addr_t *dma_handle)
> -{
> -       if (!dma_coherent_default_memory)
> -               return NULL;
> -
> -       return __dma_alloc_from_coherent(dev, dma_coherent_default_memory, size,
> -                                        dma_handle);
> -}
> -
>  static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
>                                        int order, void *vaddr)
>  {
> @@ -236,15 +224,6 @@ int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
>         return __dma_release_from_coherent(mem, order, vaddr);
>  }
>
> -int dma_release_from_global_coherent(int order, void *vaddr)
> -{
> -       if (!dma_coherent_default_memory)
> -               return 0;
> -
> -       return __dma_release_from_coherent(dma_coherent_default_memory, order,
> -                       vaddr);
> -}
> -
>  static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
>                 struct vm_area_struct *vma, void *vaddr, size_t size, int *ret)
>  {
> @@ -290,6 +269,28 @@ int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
>         return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
>  }
>
> +#ifdef CONFIG_DMA_GLOBAL_POOL
> +static struct dma_coherent_mem *dma_coherent_default_memory __ro_after_init;
> +
> +void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
> +                                    dma_addr_t *dma_handle)
> +{
> +       if (!dma_coherent_default_memory)
> +               return NULL;
> +
> +       return __dma_alloc_from_coherent(dev, dma_coherent_default_memory, size,
> +                                        dma_handle);
> +}
> +
> +int dma_release_from_global_coherent(int order, void *vaddr)
> +{
> +       if (!dma_coherent_default_memory)
> +               return 0;
> +
> +       return __dma_release_from_coherent(dma_coherent_default_memory, order,
> +                       vaddr);
> +}
> +
>  int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *vaddr,
>                                    size_t size, int *ret)
>  {
> @@ -311,6 +312,7 @@ int dma_init_global_coherent(phys_addr_t phys_addr, size_t size)
>         pr_info("DMA: default coherent area is set\n");
>         return 0;
>  }
> +#endif /* CONFIG_DMA_GLOBAL_POOL */
>
>  /*
>   * Support for reserved memory regions defined in device tree
> @@ -377,6 +379,7 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
>         return 0;
>  }
>
> +#ifdef CONFIG_DMA_GLOBAL_POOL
>  static int __init dma_init_reserved_memory(void)
>  {
>         if (!dma_reserved_default_memory)
> @@ -384,8 +387,8 @@ static int __init dma_init_reserved_memory(void)
>         return dma_init_global_coherent(dma_reserved_default_memory->base,
>                                         dma_reserved_default_memory->size);

dma_reserved_default_memory also needs to be moved inside
CONFIG_DMA_GLOBAL_POOL because
all the usages are already part of that config.


>  }
> -
>  core_initcall(dma_init_reserved_memory);
> +#endif /* CONFIG_DMA_GLOBAL_POOL */
>
>  RESERVEDMEM_OF_DECLARE(dma, "shared-dma-pool", rmem_dma_setup);
>  #endif
> --
> 2.30.2
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



--
Regards,
Atish
