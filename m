Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F96E3064BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 21:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhA0UDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:03:18 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:35854 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhA0UBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:01:30 -0500
Received: by mail-oi1-f170.google.com with SMTP id d18so3523380oic.3;
        Wed, 27 Jan 2021 12:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rvRcBguN/96Hnzr6bI5Ag8OoiWzcrVtrxH3mL5ZfZ1o=;
        b=tVmyxrE93w8bvPxNtz9EUy+98rnwQ79FsIxgTNw4pmXe9LTMTlGMZG2C/gf86tlZiv
         d/m+kB9gtrtU4zcc2t6pJacvRSyQnuaOiSDrGoTL5MWA06ftPFhtEerZgSb7wJGn5+vx
         pLokbIu9nrCb6bf/oDelS/lA0ehfAbpuRMLXaXxQ9McuGD/30xGydMK9hKTmdsIIYoOc
         Xsbv6tBEtHH/Gsnml9MZbBf7NL1N9BiRjf5eDFLN8LJ++VI9n+rjMhgI7+zS/GMaI0fj
         Ke0MNWSGkaO2I3aaPSaZTvjmBBYhUml83HpbXTxDxtbNA62+opwhqGykGCsFcpAl8XRc
         b1LA==
X-Gm-Message-State: AOAM533/pQoMZzt+sB3YzBREQvHrd0duvP1kNmRRnumswyXYShv/AVfz
        7yNIlOxrSVTGFMWE72jAlp3iMl6GQA==
X-Google-Smtp-Source: ABdhPJwMBL6J6h0Mdgp/mb0/qiCzzg22X3N+4Non2UUG6xKNUgZwnVj+ExesrC+lIcTiArkT8riPBA==
X-Received: by 2002:aca:fcc5:: with SMTP id a188mr4342745oii.169.1611777649178;
        Wed, 27 Jan 2021 12:00:49 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z4sm625941ooz.5.2021.01.27.12.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 12:00:47 -0800 (PST)
Received: (nullmailer pid 2143114 invoked by uid 1000);
        Wed, 27 Jan 2021 20:00:46 -0000
Date:   Wed, 27 Jan 2021 14:00:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomasz Figa <tfiga@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>, srv_heupstream@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] of/device: Update dma_range_map only when dev has
 valid dma-ranges
Message-ID: <20210127200046.GA2142347@robh.at.kernel.org>
References: <20210119105203.15530-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119105203.15530-1-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021 18:52:03 +0800, Yong Wu wrote:
> The commit e0d072782c73 ("dma-mapping: introduce DMA range map,
> supplanting dma_pfn_offset") always update dma_range_map even though it was
> already set, like in the sunxi_mbus driver. the issue is reported at [1].
> This patch avoid this(Updating it only when dev has valid dma-ranges).
> 
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

Applied, thanks!
