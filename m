Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03083A483C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhFKSBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:01:14 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:34387 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhFKSBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:01:13 -0400
Received: by mail-il1-f180.google.com with SMTP id w14so5976903ilv.1;
        Fri, 11 Jun 2021 10:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rYvfAaQyYTuzM/snNVZd9sqNdmZO2pqv3w7ixGw7bvE=;
        b=VKM+5DugD/rv4iO1vUP9JgUZL87bp/IQvxaqw/m+umSUwGgaHq5WueMMY2ac3TLLD/
         Y4wFr/m5iVlPlLZEPIwO8pxW7ah1MGAj7/5PDkKht0fgWnIwAjolxtqfGPd6ycAooZhE
         +13sZ9yY/d69pLsQsoF2MHUXiA2FPlnVW7f/ExliqcBdhZyfBT1YE3rrOnFhjzJwQWb9
         qlBcsgP+nW/H5fkZyNGmpCSLYZ1JozDgvSpE7PuYeR713DAGfqWNrItieXy4pUUg4KfO
         6VlW08wfcNYveNlBRVkpC3X7TJfPtGwh40+gkthXU+0dTyz2hEH8m1cmZchbRfhbGnWk
         T+eQ==
X-Gm-Message-State: AOAM532Ofbm8wwWK6fehjeuv5sR1FF7vZPSXSPEtOafC0BCeMXgoGXPn
        3Tvm5av9YPG4J8rQyfIDbA==
X-Google-Smtp-Source: ABdhPJxQLqYzHpUd+zV0YDemJpqEe/O1KTR5IFFZR473Y+/HkjBZpRk76P0K905Sl3kMpqyOGAse5Q==
X-Received: by 2002:a05:6e02:1a4f:: with SMTP id u15mr4164029ilv.147.1623434355310;
        Fri, 11 Jun 2021 10:59:15 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h6sm3574012iop.40.2021.06.11.10.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 10:59:14 -0700 (PDT)
Received: (nullmailer pid 1214653 invoked by uid 1000);
        Fri, 11 Jun 2021 17:59:12 -0000
Date:   Fri, 11 Jun 2021 11:59:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        maoguang.meng@mediatek.com, yong.wu@mediatek.com
Subject: Re: [PATCH v4 1/3] dt-bindings: mediatek: convert mtk jpeg
 decoder/encoder to yaml
Message-ID: <20210611175912.GA1211865@robh.at.kernel.org>
References: <20210611112009.2955944-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611112009.2955944-1-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 07:20:07PM +0800, Hsin-Yi Wang wrote:
> Convert mediatek jpeg decoder and encoder bindings to yaml.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v3->v4: split adding mt8183 into another patch
> ---
>  .../bindings/media/mediatek-jpeg-decoder.txt  | 38 ---------
>  .../bindings/media/mediatek-jpeg-decoder.yaml | 85 +++++++++++++++++++
>  .../bindings/media/mediatek-jpeg-encoder.txt  | 35 --------
>  .../bindings/media/mediatek-jpeg-encoder.yaml | 76 +++++++++++++++++
>  4 files changed, 161 insertions(+), 73 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
>  delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
> deleted file mode 100644
> index 39c1028b2dfb4..0000000000000
> --- a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -* Mediatek JPEG Decoder
> -
> -Mediatek JPEG Decoder is the JPEG decode hardware present in Mediatek SoCs
> -
> -Required properties:
> -- compatible : must be one of the following string:
> -	"mediatek,mt8173-jpgdec"
> -	"mediatek,mt7623-jpgdec", "mediatek,mt2701-jpgdec"
> -	"mediatek,mt2701-jpgdec"
> -- reg : physical base address of the jpeg decoder registers and length of
> -  memory mapped region.
> -- interrupts : interrupt number to the interrupt controller.
> -- clocks: device clocks, see
> -  Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
> -- clock-names: must contain "jpgdec-smi" and "jpgdec".
> -- power-domains: a phandle to the power domain, see
> -  Documentation/devicetree/bindings/power/power_domain.txt for details.
> -- mediatek,larb: must contain the local arbiters in the current Socs, see
> -  Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> -  for details.
> -- iommus: should point to the respective IOMMU block with master port as
> -  argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> -  for details.
> -
> -Example:
> -	jpegdec: jpegdec@15004000 {
> -		compatible = "mediatek,mt2701-jpgdec";
> -		reg = <0 0x15004000 0 0x1000>;
> -		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
> -		clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
> -			  <&imgsys CLK_IMG_JPGDEC>;
> -		clock-names = "jpgdec-smi",
> -			      "jpgdec";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> -		mediatek,larb = <&larb2>;
> -		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
> -			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
> -	};
> diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
> new file mode 100644
> index 0000000000000..43a611c17ed59
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek JPEG Decoder Device Tree Bindings
> +
> +maintainers:
> +  - Xia Jiang <xia.jiang@mediatek.com>
> +
> +description: |-
> +  Mediatek JPEG Decoder is the JPEG decode hardware present in Mediatek SoCs
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: mediatek,mt8173-jpgdec
> +      - items:
> +          - const: mediatek,mt2701-jpgdec

These 2 entries can be an 'enum'.

> +      - items:
> +          - enum:
> +              - mediatek,mt7623-jpgdec
> +          - const: mediatek,mt2701-jpgdec
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +    minItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: jpgdec-smi
> +      - const: jpgdec
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  mediatek,larb:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description: |
> +      Must contain the local arbiters in the current Socs, see
> +      Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> +      for details.
> +
> +  iommus:
> +    maxItems: 2

Please explain what the 2 are.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - mediatek,larb
> +  - iommus
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt2701-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/memory/mt2701-larb-port.h>
> +    #include <dt-bindings/power/mt2701-power.h>
> +    jpegdec: jpegdec@15004000 {
> +      compatible = "mediatek,mt2701-jpgdec";
> +      reg = <0x15004000 0x1000>;
> +      interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
> +      clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
> +                <&imgsys CLK_IMG_JPGDEC>;
> +      clock-names = "jpgdec-smi",
> +                    "jpgdec";
> +      power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> +      mediatek,larb = <&larb2>;
> +      iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
> +               <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
> +    };
> diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
> deleted file mode 100644
> index 5e53c6ab52d01..0000000000000
> --- a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -* MediaTek JPEG Encoder
> -
> -MediaTek JPEG Encoder is the JPEG encode hardware present in MediaTek SoCs
> -
> -Required properties:
> -- compatible : "mediatek,mt2701-jpgenc"
> -  followed by "mediatek,mtk-jpgenc"
> -- reg : physical base address of the JPEG encoder registers and length of
> -  memory mapped region.
> -- interrupts : interrupt number to the interrupt controller.
> -- clocks: device clocks, see
> -  Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
> -- clock-names: must contain "jpgenc". It is the clock of JPEG encoder.
> -- power-domains: a phandle to the power domain, see
> -  Documentation/devicetree/bindings/power/power_domain.txt for details.
> -- mediatek,larb: must contain the local arbiters in the current SoCs, see
> -  Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> -  for details.
> -- iommus: should point to the respective IOMMU block with master port as
> -  argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> -  for details.
> -
> -Example:
> -	jpegenc: jpegenc@1500a000 {
> -		compatible = "mediatek,mt2701-jpgenc",
> -			     "mediatek,mtk-jpgenc";
> -		reg = <0 0x1500a000 0 0x1000>;
> -		interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_LOW>;
> -		clocks =  <&imgsys CLK_IMG_VENC>;
> -		clock-names = "jpgenc";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> -		mediatek,larb = <&larb2>;
> -		iommus = <&iommu MT2701_M4U_PORT_JPGENC_RDMA>,
> -			 <&iommu MT2701_M4U_PORT_JPGENC_BSDMA>;
> -	};
> diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> new file mode 100644
> index 0000000000000..28f26e79fcb3a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek-jpeg-encoder.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek JPEG Encoder Device Tree Bindings
> +
> +maintainers:
> +  - Xia Jiang <xia.jiang@mediatek.com>
> +
> +description: |-
> +  MediaTek JPEG Encoder is the JPEG encode hardware present in MediaTek SoCs
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt2701-jpgenc
> +      - const: mediatek,mtk-jpgenc
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: jpgenc
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  mediatek,larb:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description: |
> +      Must contain the local arbiters in the current Socs, see
> +      Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> +      for details.
> +
> +  iommus:
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - mediatek,larb
> +  - iommus
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt2701-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/memory/mt2701-larb-port.h>
> +    #include <dt-bindings/power/mt2701-power.h>
> +    jpegenc: jpegenc@1500a000 {
> +      compatible = "mediatek,mt2701-jpgenc",
> +                   "mediatek,mtk-jpgenc";
> +      reg = <0x1500a000 0x1000>;
> +      interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_LOW>;
> +      clocks =  <&imgsys CLK_IMG_VENC>;
> +      clock-names = "jpgenc";
> +      power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> +      mediatek,larb = <&larb2>;
> +      iommus = <&iommu MT2701_M4U_PORT_JPGENC_RDMA>,
> +               <&iommu MT2701_M4U_PORT_JPGENC_BSDMA>;
> +    };
> -- 
> 2.32.0.272.g935e593368-goog
