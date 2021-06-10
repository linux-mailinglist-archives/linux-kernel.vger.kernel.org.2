Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF2A3A273F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFJIkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:40:43 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:53132 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhFJIkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:40:42 -0400
Received: by mail-wm1-f53.google.com with SMTP id f17so5654862wmf.2;
        Thu, 10 Jun 2021 01:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vw2rEidNYSZeHFrj7gyKfEnss0oZYJ9I5iUbvOkNzhg=;
        b=ooamT84SYgotXdYQmlxem5mrZzw1HzuUkCjt4aOlyohi6/Rm95UNTFkdQIjLulE2VV
         aozaQKnE6Si75yQpSMmR0ssVEZK0cPJxkXhNKsqeaP3BL8ASpHmfDJaIxXT+/DZ+54iJ
         aQy7NZ9kioLpoWTxSmhbdlRGt/T1Ds4CF+z9PKTf90jHc53Sl6FV3m/eWb+el5brKNMz
         luw6RF0GAQ3/+JRjmJ6Jizh4HK2iWbP8p7zLGlTMpOor1ZXGxLw3MLezHPmcJWwPbbt2
         iQgDCzRYRhk7CbBMhrZC4uoKRzddo7vYB+9pou03oWbTUyOcPE2EoVm5J//xQ92LMs+G
         PdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vw2rEidNYSZeHFrj7gyKfEnss0oZYJ9I5iUbvOkNzhg=;
        b=bolXeZ81BGMdfQAEnym+CH9gcwqe7XawYsot1IzuoMttWcEyYMKNkCNIxO/LH5XB2Z
         RroiMfqyOEPs7SemBdI3PQ03dmWjHaglUYbDhAckvOoi3/51Db3VNIJxaEgUD2NuhkaU
         6zKtLLtsdEqKPZ4LjwiSAqobbVqHAehDNU3mS5xyZw+LUr1tU544C8Dm3Jcx5+vnh6Pt
         dyhjYk7qzYxRAIYFevoCLbjn8NlIAIs1XhTxp+uCaYSV+xaGGB2wVgdxM5kd3b9SaV+c
         b3aNvpzoA/ADssc09FlE1bT9P9Ci63iWcaRHJi5yLqQoCwi+HofwBIDfcjRHuu5IeoY4
         EZyA==
X-Gm-Message-State: AOAM533+PIGcULk+BxhrQvR7xwS4/TlVvTY2je2T6Rz/qFiJKbz4/lsx
        i/TcE5olZ0bGJO3QOx46yyA=
X-Google-Smtp-Source: ABdhPJzcXxE0Z1+qB1Riub+DwCapNG6b60zmCOtH7Z/t9aZnXBURBj3oDjbAhDLMIsLCcajgntaNyA==
X-Received: by 2002:a05:600c:4114:: with SMTP id j20mr14226178wmi.0.1623314265323;
        Thu, 10 Jun 2021 01:37:45 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id o18sm2648988wrx.59.2021.06.10.01.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 01:37:44 -0700 (PDT)
Subject: Re: [PATCH v2] dt-bindings: mediatek: convert mtk jpeg
 decoder/encoder to yaml
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        maoguang.meng@mediatek.com, yong.wu@mediatek.com
References: <20210609180130.693944-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <c324de79-9a07-2f2c-e29a-dcd448da29f8@gmail.com>
Date:   Thu, 10 Jun 2021 10:37:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210609180130.693944-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

On 09/06/2021 20:01, Hsin-Yi Wang wrote:
> Convert mediatek jpeg decoder and encoder bindings to yaml.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v2: fix dt_binding_check errors
> ---
>  .../bindings/media/mediatek-jpeg-decoder.txt  | 38 ----------
>  .../bindings/media/mediatek-jpeg-decoder.yaml | 76 +++++++++++++++++++
>  .../bindings/media/mediatek-jpeg-encoder.txt  | 35 ---------
>  .../bindings/media/mediatek-jpeg-encoder.yaml | 68 +++++++++++++++++
>  4 files changed, 144 insertions(+), 73 deletions(-)
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

We miss the mediatek,larb in the yaml.

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
> index 0000000000000..821e6b480901a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
> @@ -0,0 +1,76 @@
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

Same here.

Regards,
Matthias
