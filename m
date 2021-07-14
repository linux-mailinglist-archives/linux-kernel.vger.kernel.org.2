Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5653C92E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 23:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhGNVR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 17:17:57 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171]:41576 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhGNVR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 17:17:56 -0400
Received: by mail-il1-f171.google.com with SMTP id p3so2993516ilg.8;
        Wed, 14 Jul 2021 14:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=syAXapfi/1thpY4jHBRfGcWzIDr/Y3HxhpyKckHASlE=;
        b=qRbWsreTT+YhXJVzBVo8dv1/IwxXl7KJwCD/s0JluSuRoXY8cQBuYai1CjPs0qMOoR
         T+/RqJL+prlvUU2ltonFrh+GoOkfOTKJ3zqd2iPNk2X+iZTnbwM3DBfn75w7v1j2DoZ+
         yYGU7Iga/yIXfvSRMqaMfzn3nkN93wNab62P/6xsndBjaKjbJ5+kP4Rf1ceO3+QuTxTp
         DWPgEAcAgBlGhZ94YA5hMAdTjHlzGFCUqgYfMiRg1lVUvVBsvGk8A/m9rPzdiRlb3oBc
         swOS6gNDMhizGvwyOuyuxiZZZohLAh81Hu79Bt5E0kEHaGwzytaJUiv+NKnBIdll8knF
         Q67g==
X-Gm-Message-State: AOAM532cHUjCyuBoiTGdJ3WBHP1urjDjkYjMTW837XXUvqcm8yZyXC57
        b+6QviE/tXnef2ADg48V+g==
X-Google-Smtp-Source: ABdhPJyMeqk2FAY7bitNJyippP/0WZgYEXD6g1bDCjmESNtNzj4EVp5q3IV9YBKg+MrxY8yXpakmdw==
X-Received: by 2002:a92:d8c5:: with SMTP id l5mr7989064ilo.79.1626297303292;
        Wed, 14 Jul 2021 14:15:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x9sm1692459iov.45.2021.07.14.14.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 14:14:49 -0700 (PDT)
Received: (nullmailer pid 3536623 invoked by uid 1000);
        Wed, 14 Jul 2021 21:14:44 -0000
Date:   Wed, 14 Jul 2021 15:14:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com
Subject: Re: [PATCH 02/24] dt-bindings: mediatek: mt8195: Add binding for
 infra IOMMU
Message-ID: <20210714211444.GA3531980@robh.at.kernel.org>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
 <20210630023504.18177-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630023504.18177-3-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 10:34:42AM +0800, Yong Wu wrote:
> In mt8195, we have a new IOMMU that is for INFRA IOMMU. its masters
> mainly are PCIe and USB. Different with MM IOMMU, all these masters
> connect with IOMMU directly, there is no mediatek,larbs property for
> infra IOMMU.
> 
> Another thing is about PCIe ports. currently the function
> "of_iommu_configure_dev_id" only support the id number is 1, But our
> PCIe have two ports, one is for reading and the other is for writing.
> see more about the PCIe patch in this patchset. Thus, I only list
> the reading id here and add the other id in our driver.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml         | 14 +++++++++++++-
>  .../dt-bindings/memory/mt8195-memory-port.h    | 18 ++++++++++++++++++
>  include/dt-bindings/memory/mtk-memory-port.h   |  2 ++
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 9b04630158c8..6f3ff631c06b 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -79,6 +79,7 @@ properties:
>            - mediatek,mt8192-m4u  # generation two
>            - mediatek,mt8195-iommu-vdo        # generation two
>            - mediatek,mt8195-iommu-vpp        # generation two
> +          - mediatek,mt8195-iommu-infra      # generation two
>  
>        - description: mt7623 generation one
>          items:
> @@ -129,7 +130,6 @@ required:
>    - compatible
>    - reg
>    - interrupts
> -  - mediatek,larbs
>    - '#iommu-cells'
>  
>  allOf:
> @@ -161,6 +161,18 @@ allOf:
>        required:
>          - power-domains
>  
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            items:
> +              enum:
> +                - mediatek,mt8195-iommu-infra

This is saying all items are 'mediatek,mt8195-iommu-infra'. Other 
schemas prevent that, but really this should be:

compatible:
  contains:
    const: mediatek,mt8195-iommu-infra

> +
> +    then:
> +      required:
> +        - mediatek,larbs
> +
>  additionalProperties: false
>  
>  examples:
> diff --git a/include/dt-bindings/memory/mt8195-memory-port.h b/include/dt-bindings/memory/mt8195-memory-port.h
> index 783bcae8cdea..67afad848725 100644
> --- a/include/dt-bindings/memory/mt8195-memory-port.h
> +++ b/include/dt-bindings/memory/mt8195-memory-port.h
> @@ -387,4 +387,22 @@
>  #define M4U_PORT_L28_CAM_DRZS4NO_R1		MTK_M4U_ID(28, 5)
>  #define M4U_PORT_L28_CAM_TNCSO_R1		MTK_M4U_ID(28, 6)
>  
> +/* infra iommu ports */
> +/* PCIe1: read: BIT16; write BIT17. */
> +#define M4U_PORT_INFRA_PCIE1			MTK_IFAIOMMU_PERI_ID(16)
> +/* PCIe0: read: BIT18; write BIT19. */
> +#define M4U_PORT_INFRA_PCIE0			MTK_IFAIOMMU_PERI_ID(18)
> +#define M4U_PORT_INFRA_SSUSB_P3_R		MTK_IFAIOMMU_PERI_ID(20)
> +#define M4U_PORT_INFRA_SSUSB_P3_W		MTK_IFAIOMMU_PERI_ID(21)
> +#define M4U_PORT_INFRA_SSUSB_P2_R		MTK_IFAIOMMU_PERI_ID(22)
> +#define M4U_PORT_INFRA_SSUSB_P2_W		MTK_IFAIOMMU_PERI_ID(23)
> +#define M4U_PORT_INFRA_SSUSB_P1_1_R		MTK_IFAIOMMU_PERI_ID(24)
> +#define M4U_PORT_INFRA_SSUSB_P1_1_W		MTK_IFAIOMMU_PERI_ID(25)
> +#define M4U_PORT_INFRA_SSUSB_P1_0_R		MTK_IFAIOMMU_PERI_ID(26)
> +#define M4U_PORT_INFRA_SSUSB_P1_0_W		MTK_IFAIOMMU_PERI_ID(27)
> +#define M4U_PORT_INFRA_SSUSB2_R			MTK_IFAIOMMU_PERI_ID(28)
> +#define M4U_PORT_INFRA_SSUSB2_W			MTK_IFAIOMMU_PERI_ID(29)
> +#define M4U_PORT_INFRA_SSUSB_R			MTK_IFAIOMMU_PERI_ID(30)
> +#define M4U_PORT_INFRA_SSUSB_W			MTK_IFAIOMMU_PERI_ID(31)
> +
>  #endif
> diff --git a/include/dt-bindings/memory/mtk-memory-port.h b/include/dt-bindings/memory/mtk-memory-port.h
> index 7d64103209af..2f68a0511a25 100644
> --- a/include/dt-bindings/memory/mtk-memory-port.h
> +++ b/include/dt-bindings/memory/mtk-memory-port.h
> @@ -12,4 +12,6 @@
>  #define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x1f)
>  #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
>  
> +#define MTK_IFAIOMMU_PERI_ID(port)	MTK_M4U_ID(0, port)
> +
>  #endif
> -- 
> 2.18.0
> 
> 
