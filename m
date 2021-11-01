Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9114A44155D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhKAIhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231320AbhKAIh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:37:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B27A3610A2
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 08:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635755695;
        bh=obeo4arX2BcSuRDdS9k9PamPIZJFgpOtT0SeoVp8Vtg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UFIwWTzawtcc6PC1NEffH3E+HJQucMTcYfc9JzH6RVIkYZb+rJQkasPbW6qu9m8MJ
         mPLG2n/rxnrgZ+rQdM9GzYRdYMQEOSI22G1i04I6R0KEJDlB9Pzy9kGSv5H8j0y5xi
         zY+/083SME90EYoQQDb5teZHpmWIOQctHoLm3SPochR1kMZIml2NtWepojNHL8gAKl
         9xPNfy4tYedrmP4uwxSnOlzfvHHd6SlMnStCQ1OmnaunVp0juYfsOwzrFaSOXqNgfT
         SUHTYRDclf7O/64NTfRP2Rkb/LI17TTMCzFtqe0uMJ3mOsuMoIpTW/kKoGuWAr4cYD
         b0MVQph+yoprw==
Received: by mail-oi1-f169.google.com with SMTP id bm39so13463426oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 01:34:55 -0700 (PDT)
X-Gm-Message-State: AOAM530GgZ60KY08jCHYHN+CtAgmzaS7DSs+h9YN4+vSEhyvUw3+m2jC
        zqf33yWzSw13ZDShGp21sjb5zN1nP/+LiVCj2HI=
X-Google-Smtp-Source: ABdhPJw9u4sF3GagDkzYyWDjJxayAqxSo5SlRgNq8NAwK5VHTPb+bEN/WnF/aGaG9yS3U1m8w4dyOlys5a7lQf9P8zk=
X-Received: by 2002:aca:3cc1:: with SMTP id j184mr12787185oia.174.1635755694924;
 Mon, 01 Nov 2021 01:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 1 Nov 2021 09:34:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGqOzHM+J30TXR3-uZPkjHBCXB4CMkzZjHbbmptyU5W9w@mail.gmail.com>
Message-ID: <CAMj1kXGqOzHM+J30TXR3-uZPkjHBCXB4CMkzZjHbbmptyU5W9w@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2021 at 04:17, Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> DMA_ATTR_NO_KERNEL_MAPPING is to avoid creating a kernel mapping
> for the allocated buffer, but current implementation is that
> PTE of allocated buffer in kernel page table is valid. So we
> should set invalid for PTE of allocate buffer so that there are
> no kernel mapping for the allocated buffer.
>
> In some cases, we don't hope the allocated buffer to be read
> by cpu or speculative execution, so we use DMA_ATTR_NO_KERNEL_MAPPING
> to get no kernel mapping in order to achieve this goal.
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  kernel/dma/direct.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4c6c5e0635e3..aa10b4c5d762 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -13,6 +13,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
>  #include <linux/slab.h>
> +#include <asm/cacheflush.h>
>  #include "direct.h"
>
>  /*
> @@ -169,6 +170,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>                 if (!PageHighMem(page))
>                         arch_dma_prep_coherent(page, size);
>                 *dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> +               /* remove kernel mapping for pages */
> +               set_memory_valid((unsigned long)phys_to_virt(dma_to_phys(dev, *dma_handle)),
> +                               size >> PAGE_SHIFT, 0);

This only works if the memory is mapped at page granularity in the
linear region, and you cannot rely on that. Many architectures prefer
block mappings for the linear region, and arm64 will only use page
mappings if rodata=full is set (which is set by default but can be
overridden on the kernel command line)


>                 /* return the page pointer as the opaque cookie */
>                 return page;
>         }
> @@ -278,6 +282,10 @@ void dma_direct_free(struct device *dev, size_t size,
>
>         if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>             !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
> +               size = PAGE_ALIGN(size);
> +               /* create kernel mapping for pages */
> +               set_memory_valid((unsigned long)phys_to_virt(dma_to_phys(dev, dma_addr)),
> +                               size >> PAGE_SHIFT, 1);
>                 /* cpu_addr is a struct page cookie, not a kernel address */
>                 dma_free_contiguous(dev, cpu_addr, size);
>                 return;
> --
> 2.18.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
