Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71243E2C45
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 16:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbhHFOMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 10:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235847AbhHFOMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 10:12:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 740FF611C5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628259104;
        bh=CSbLfRVE2UUWpruHwkg8Uj8Y4BhMu1P18wZvcPO6wpo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NjbxXJRLfzOCZp/OsanZtKa0LYJmDvliEHis1OXyMPWXO5f7DC1LsIedH1xOOTmdq
         LYrLKU1u2fD/w2/tQxOPQ0aVv0hqOfu/h2HynCrM8b7ralpEdpdGMAtgDCAPqTQC30
         d9Ljf/Ffd4LumowMEv886W/09GGFGcNZp2VJ+NkL7EzB5qz/We243LRuMZ+V86PKxE
         uZ7p1GLaaZoOf+4U+YEdwlIpcmbKvho8osS8UzH7wRG0L4aq0FN0szRecGJeKA0r3p
         jC/MPaEhIqnKp9ELYIOkWYt52b7iaeoI3WXeRLL0KcXgnfzqCG9dq8IKieehuJErZg
         gAumwMZcALE3g==
Received: by mail-ej1-f42.google.com with SMTP id qk33so15240472ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 07:11:44 -0700 (PDT)
X-Gm-Message-State: AOAM530gfh4r7n5L5U1Ktvuh4BObFNaSO7EYsmgbdpWg2LNBTrWDFgtS
        1dvMy5FFtdg8Nj14qP8GB4+LNK83N+2IVscCOw==
X-Google-Smtp-Source: ABdhPJz2aB9W+k5EFME8idlFEFePLvrE7JvKCrPX4gmCiv3PpMHVunwV0NzEcLofGEPyHNTiQyH37b4B3lAcTf8hS2o=
X-Received: by 2002:a17:906:d287:: with SMTP id ay7mr9680139ejb.360.1628259102955;
 Fri, 06 Aug 2021 07:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210805094736.902-1-will@kernel.org>
In-Reply-To: <20210805094736.902-1-will@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 6 Aug 2021 08:11:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ7ROWWJX84x2kEex9NQ8G+2=ybRuNOobX+j8bjZzSemQ@mail.gmail.com>
Message-ID: <CAL_JsqJ7ROWWJX84x2kEex9NQ8G+2=ybRuNOobX+j8bjZzSemQ@mail.gmail.com>
Subject: Re: [PATCH] of: restricted dma: Don't fail device probe on rmem init failure
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Claire Chang <tientzu@chromium.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 3:47 AM Will Deacon <will@kernel.org> wrote:
>
> If CONFIG_DMA_RESTRICTED_POOL=n then probing a device with a reference
> to a "restricted-dma-pool" will fail with a reasonably cryptic error:

I'm left wondering why of_dma_set_restricted_buffer() is even enabled
with CONFIG_DMA_RESTRICTED_POOL=n.

of_dma_set_restricted_buffer() should use IS_ENABLED and it should
also be moved to of/device.c. There's no reason for it to be in
of/address.c. It has nothing to do with address parsing.

>   | pci-host-generic: probe of 10000.pci failed with error -22
>
> Print a more helpful message in this case and try to continue probing
> the device as we do if the kernel doesn't have the restricted DMA patches
> applied or either CONFIG_OF_ADDRESS or CONFIG_HAS_DMA =n.

I think you'd have to work pretty hard to hit this code path with
either of the above config options off.

> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/of/address.c    | 8 ++++----
>  drivers/of/device.c     | 2 +-
>  drivers/of/of_private.h | 8 +++-----
>  3 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 973257434398..f6bf4b423c2a 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -997,7 +997,7 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
>         return ret;
>  }
>
> -int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
> +void of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
>  {
>         struct device_node *node, *of_node = dev->of_node;
>         int count, i;
> @@ -1022,11 +1022,11 @@ int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
>                  */
>                 if (of_device_is_compatible(node, "restricted-dma-pool") &&
>                     of_device_is_available(node))
> -                       return of_reserved_mem_device_init_by_idx(dev, of_node,
> -                                                                 i);
> +                       break;
>         }
>
> -       return 0;
> +       if (i != count && of_reserved_mem_device_init_by_idx(dev, of_node, i))
> +               dev_warn(dev, "failed to initialise \"restricted-dma-pool\" memory node\n");
>  }
>  #endif /* CONFIG_HAS_DMA */
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 2defdca418ec..258a2b099410 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -166,7 +166,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>         arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
>
>         if (!iommu)
> -               return of_dma_set_restricted_buffer(dev, np);
> +               of_dma_set_restricted_buffer(dev, np);
>
>         return 0;
>  }
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index f557bd22b0cf..bc883f69496b 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -163,18 +163,16 @@ struct bus_dma_region;
>  #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
>  int of_dma_get_range(struct device_node *np,
>                 const struct bus_dma_region **map);
> -int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np);
> +void of_dma_set_restricted_buffer(struct device *dev, struct device_node *np);
>  #else
>  static inline int of_dma_get_range(struct device_node *np,
>                 const struct bus_dma_region **map)
>  {
>         return -ENODEV;
>  }
> -static inline int of_dma_set_restricted_buffer(struct device *dev,
> -                                              struct device_node *np)
> +static inline void of_dma_set_restricted_buffer(struct device *dev,
> +                                               struct device_node *np)
>  {
> -       /* Do nothing, successfully. */
> -       return 0;
>  }
>  #endif
>
> --
> 2.32.0.605.g8dce9f2422-goog
>
