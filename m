Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A2F3063BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbhA0TH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:07:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344084AbhA0THz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:07:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FB1464D9D;
        Wed, 27 Jan 2021 19:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611774435;
        bh=+2fq9fqcnJYIGiasm2Y78NeRv8I7YIdMcOI8TxM795s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YhRvfHT6RV1BMZil1zdzFYbHrjCJm7nZH8PN85tJkCvVMFjd6eDbEasUTop/t+LPD
         +og8JbTEYZzAi04vEHfuIFInmDsmd231LW3n5RVJFYyM6vY3hmYrtWNfd8A82XdX6m
         DjpPaS8pSa/DuHZYs6mKcfXHpOXTTFE56zyLkjQntGO4C+hsC0Ykvmz47tpeTx/84l
         zXaW1LY6a8F7/TYczF+XBpza56l2dKK/8HzbEQZeM6w1bYXSP9+Xt5hPZiwG5xTEFf
         wAw/S9OAFRpNo71WJjOFETco8uFIl0z2ETgQOd81ch+lFz7xSSy2QicZgzOBZ8Zlq9
         XFs7hqikGgclQ==
Received: by mail-ej1-f50.google.com with SMTP id a10so4179320ejg.10;
        Wed, 27 Jan 2021 11:07:14 -0800 (PST)
X-Gm-Message-State: AOAM532d+vzWmtu6C/Vd27Ep0mHE1prshOu1/I7LVcuMMITDgn7/M9f8
        KgByfyq7GQmIT6pmTqJtqtmZSVWYJjBzEc6AhA==
X-Google-Smtp-Source: ABdhPJwZ642wt52ernlRSW6Ok++wbRCAdfK+zZt0YWbSRLkd8I/BHIp2pHEsvorc0aidjP5dLvbM2BPXjvTf/vQ2vrY=
X-Received: by 2002:a17:906:c9d8:: with SMTP id hk24mr8285418ejb.468.1611774433585;
 Wed, 27 Jan 2021 11:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20210119105203.15530-1-yong.wu@mediatek.com>
In-Reply-To: <20210119105203.15530-1-yong.wu@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 27 Jan 2021 13:07:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJB=MMeMobznBiAUihJLBt5aeiiL+AtDWh6tajePu=Now@mail.gmail.com>
Message-ID: <CAL_JsqJB=MMeMobznBiAUihJLBt5aeiiL+AtDWh6tajePu=Now@mail.gmail.com>
Subject: Re: [PATCH v2] of/device: Update dma_range_map only when dev has
 valid dma-ranges
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomasz Figa <tfiga@google.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 4:52 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The commit e0d072782c73 ("dma-mapping: introduce DMA range map,
> supplanting dma_pfn_offset") always update dma_range_map even though it was
> already set, like in the sunxi_mbus driver. the issue is reported at [1].
> This patch avoid this(Updating it only when dev has valid dma-ranges).

only when dev *doesn't* have valid dma-ranges?

> Meanwhile, dma_range_map contains the devices' dma_ranges information,
> This patch moves dma_range_map before of_iommu_configure. The iommu
> driver may need to know the dma_address requirements of its iommu
> consumer devices.
>
> [1] https://lore.kernel.org/linux-arm-kernel/5c7946f3-b56e-da00-a750-be097c7ceb32@arm.com/
>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Frank Rowand <frowand.list@gmail.com>
> Fixes: e0d072782c73 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset"),
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/device.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index aedfaaafd3e7..1122daa8e273 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -162,9 +162,11 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>         mask = DMA_BIT_MASK(ilog2(end) + 1);
>         dev->coherent_dma_mask &= mask;
>         *dev->dma_mask &= mask;
> -       /* ...but only set bus limit if we found valid dma-ranges earlier */
> -       if (!ret)
> +       /* ...but only set bus limit and range map if we found valid dma-ranges earlier */
> +       if (!ret) {
>                 dev->bus_dma_limit = end;
> +               dev->dma_range_map = map;
> +       }
>
>         coherent = of_dma_is_coherent(np);
>         dev_dbg(dev, "device is%sdma coherent\n",
> @@ -172,6 +174,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>
>         iommu = of_iommu_configure(dev, np, id);
>         if (PTR_ERR(iommu) == -EPROBE_DEFER) {
> +               /* Don't touch range map if it wasn't set from a valid dma-ranges */
> +               if (!ret)
> +                       dev->dma_range_map = NULL;
>                 kfree(map);
>                 return -EPROBE_DEFER;
>         }
> @@ -181,7 +186,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>
>         arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
>
> -       dev->dma_range_map = map;
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_configure_id);
> --
> 2.18.0
>
