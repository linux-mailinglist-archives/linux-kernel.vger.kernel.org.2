Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794613C92DA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 23:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbhGNVPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 17:15:00 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:38488 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhGNVO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 17:14:59 -0400
Received: by mail-io1-f51.google.com with SMTP id k11so3871320ioa.5;
        Wed, 14 Jul 2021 14:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u0T8yxk3ADHwBjHH2WxpSHI7hYdlroWexCd530t9WFM=;
        b=rH6uHuI2pyKcQA/h4Id22nXayLZVCCkS9I8JUbfmm4MoEuxswSCbh7VbQGk0RnEcIZ
         tRZ+Ckb/eGrForELzXGf9dc7s28QkCxpVnuPFTenVGl3nLKEQ3TLIfNABRLXDcXVuqcp
         i8h0CihazEnOgIfCskh+7nAFdq6ULgRg55UB+187FSXiNKP77uRfy38NmU5ZkQt6A/Wz
         k2qD2CqyVvPfsOSh9EOt0TdbDrgrb1gyaSO4H6mQA17R3GX7m4qrXA4pQxmrmqKV1fmU
         Lr3Hx0J5JZkcLNV8e1hRgmrP1Txs8KWfx4JcL1WLec7qepOaUinJGwJjOhYpMLANx+x/
         tpHA==
X-Gm-Message-State: AOAM53172UEkjRwT6cd2Qq0JlfEvr5kEG9k2l7zpx7B+i0Bs7Zy0o1Gz
        4QDe1jq2sWoW40BxhIecVw==
X-Google-Smtp-Source: ABdhPJwZWyyb2dpNruY5IFtlfTSV040Z1vLqwIxyzwYdK/m+mJL5npLfz6lMrc/RXg+/pntDInkeoQ==
X-Received: by 2002:a05:6638:218:: with SMTP id e24mr227669jaq.38.1626297126510;
        Wed, 14 Jul 2021 14:12:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w8sm1732316ill.50.2021.07.14.14.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 14:11:44 -0700 (PDT)
Received: (nullmailer pid 3531794 invoked by uid 1000);
        Wed, 14 Jul 2021 21:11:38 -0000
Date:   Wed, 14 Jul 2021 15:11:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Robin Murphy <robin.murphy@arm.com>,
        Evan Green <evgreen@chromium.org>,
        linux-mediatek@lists.infradead.org, anan.sun@mediatek.com,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, youlin.pei@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Will Deacon <will@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>, chao.hao@mediatek.com,
        Tomasz Figa <tfiga@google.com>
Subject: Re: [PATCH 01/24] dt-bindings: mediatek: mt8195: Add binding for MM
 IOMMU
Message-ID: <20210714211138.GA3531732@robh.at.kernel.org>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
 <20210630023504.18177-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630023504.18177-2-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2021 10:34:41 +0800, Yong Wu wrote:
> This patch adds descriptions for mt8195 IOMMU which also use ARM
> Short-Descriptor translation table format.
> 
> In mt8195, there are two smi-common HW and IOMMU, one is for vdo(video
> output), the other is for vpp(video processing pipe). They connects
> with different smi-larbs, then some setting(larbid_remap) is different.
> Differentiate them with the compatible string.
> 
> Something like this:
> 
>     IOMMU(VDO)          IOMMU(VPP)
>        |                   |
>   SMI_COMMON_VDO      SMI_COMMON_VPP
>   ---------------     ----------------
>   |      |   ...      |      |     ...
> larb0 larb2  ...    larb1 larb3    ...
> 
> Another change is that we have a new IOMMU that is for infra master like
> PCIe and USB. The infra master don't have the larb and ports, thus we
> rename the port header file to mt8195-memory-port.h rather than
> mt8195-larb-port.h.
> 
> Also, the IOMMU is not only for MM, thus, we don't call it "m4u" which
> means "MultiMedia Memory Management UNIT". thus, use the "iommu" as the
> compatiable string.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |   7 +
>  .../dt-bindings/memory/mt8195-memory-port.h   | 390 ++++++++++++++++++
>  2 files changed, 397 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt8195-memory-port.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
