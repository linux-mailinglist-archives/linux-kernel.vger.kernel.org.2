Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB9C31C73B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 09:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhBPIRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 03:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhBPIQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 03:16:17 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36C9C061797
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 00:15:10 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bl23so15145004ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 00:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzhTdPHbs48+KQ9HqL9TbcxPy1qXKHCXgtGLrYyU4FA=;
        b=SDYBzdh1dpId2B0EUuMVomU+ozCkhWpfs1MII9Mq81AfCJSc5faOJLTlj6CGDwNpnt
         T9dVAPZB1KagNR6cQdi/Dzj1kgnJrLp40S5cinUkqaayF2B49k70Rc+BiTzPMm8pmkaH
         LGPq1CT/uAiDDKllkdLKDHWgXS5omwWtay4p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzhTdPHbs48+KQ9HqL9TbcxPy1qXKHCXgtGLrYyU4FA=;
        b=SzPzbiWR2rOSkQNnMWwIohBfoyeUacTEOK/5Dn2wwIwiW3pQQd5DRqJPDK9pk4TF1a
         hzmTCywreg6yZqnWjfOqaLohuOh62E96VtzmIEmD9APzpfZQK5IrcP571TzgKy9pGbUU
         WsTz1oUnsHcNy2DcsMZ6IElNVUmPxOjJu1XMCvC14hlVoqTVujBqgB+4So6x1WUR7fof
         MalaCF6xRuLLgNgYPU0g5kjMaaIPCs7fCah1M18pH4lPs6OuTCcrEB+LxeRrS5mvRns3
         wnGcPlQNpHuc+ufvaPQSt5nSnZNzKHEIh3DUIUz5F2jIdGZalayZlkcchfjezEFModxE
         1DNw==
X-Gm-Message-State: AOAM532oqW7ukN/weOPpXt+baE0ZT01PctIwJJiYGz8b21XNqETcEm96
        s5acefalBXx35OZIFtgElUMqhbZbJxPXnvRs
X-Google-Smtp-Source: ABdhPJzTnAgy+lTd1wrl+8i++6pqJFF2yUEiDqXcIkDjRseOPDJVCFNihLOuhAABehEXnqFnReA59w==
X-Received: by 2002:a17:906:2a8b:: with SMTP id l11mr19558883eje.1.1613463309253;
        Tue, 16 Feb 2021 00:15:09 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id p16sm12637862edw.44.2021.02.16.00.15.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 00:15:07 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id v1so11887795wrd.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 00:15:07 -0800 (PST)
X-Received: by 2002:adf:ea48:: with SMTP id j8mr22504831wrn.197.1613463306880;
 Tue, 16 Feb 2021 00:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20210202095110.1215346-1-hch@lst.de> <20210202095110.1215346-7-hch@lst.de>
In-Reply-To: <20210202095110.1215346-7-hch@lst.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 16 Feb 2021 17:14:55 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BXAWeB2h4RvqsF1q8ip-Rhew80c7y1_og22-x3rS8KOQ@mail.gmail.com>
Message-ID: <CAAFQd5BXAWeB2h4RvqsF1q8ip-Rhew80c7y1_og22-x3rS8KOQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] dma-iommu: implement ->alloc_noncontiguous
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sergey Senozhatsky <senozhatsky@google.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph


On Tue, Feb 2, 2021 at 6:51 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Implement support for allocating a non-contiguous DMA region.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/iommu/dma-iommu.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 85cb004d7a44c6..4e0b170d38d57a 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -718,6 +718,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
>                 goto out_free_sg;
>
>         sgt->sgl->dma_address = iova;
> +       sgt->sgl->dma_length = size;
>         return pages;
>
>  out_free_sg:
> @@ -755,6 +756,36 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
>         return NULL;
>  }
>
> +#ifdef CONFIG_DMA_REMAP
> +static struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev,
> +               size_t size, enum dma_data_direction dir, gfp_t gfp)
> +{
> +       struct dma_sgt_handle *sh;
> +
> +       sh = kmalloc(sizeof(*sh), gfp);
> +       if (!sh)
> +               return NULL;
> +
> +       sh->pages = __iommu_dma_alloc_noncontiguous(dev, size, &sh->sgt, gfp,
> +                                                   PAGE_KERNEL, 0);

When working on the videobuf2 integration with Sergey I noticed that
we always pass 0 as DMA attrs here, which removes the ability for
drivers to use DMA_ATTR_ALLOC_SINGLE_PAGES.

It's quite important from a system stability point of view, because by
default the iommu_dma allocator would prefer big order allocations for
TLB locality reasons. For many devices, though, it doesn't really
affect the performance, because of random access patterns, so single
pages are good enough and reduce the risk of allocation failures or
latency due to fragmentation.

Do you think we could add the attrs parameter to the
dma_alloc_noncontiguous() API?

Best regards,
Tomasz
