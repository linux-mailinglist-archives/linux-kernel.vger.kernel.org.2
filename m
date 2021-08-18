Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758B23F0976
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhHRQpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:45:40 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:33513 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbhHRQpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:45:35 -0400
Received: by mail-oi1-f174.google.com with SMTP id n27so4284775oij.0;
        Wed, 18 Aug 2021 09:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j4p+QzPcxX1KO6/vzInX+XzVndfnvWYW6jLDLoMv7Jc=;
        b=nwp9mSLgYl6I+wMjlumKuYGPEgXx5aY8mxYrc6G1hsg3SJchp7NOcdCLuUZnIoRX5i
         jyXL+Z9Jk1j3RLMSEeAqydoOyajiAuwzWl99i8ml/TbJIImyUH8OIT5ADEqw/Np4dIyx
         eT6smK2G3W6FZAl24DkR6RCC9YAuT5EuXRB8vZcEtyzFBO63oWsn6nNx40oI4ZoJFkxK
         azFH6ZS+02Cgmkizd+oTiZWfa1gWrzMNYOWwLEPA6rZQ0DKOfbd1oystAN/ab2v1NnBy
         aWY88NwwRA3mvDjSQU5/+9C21XXALM3FJhrnJ8Ly/rR9uOi8VbZIR8p0Q+WRF7PX1hNv
         dbeQ==
X-Gm-Message-State: AOAM531aqMSDeFdIfrcu2mPL+x6p8BUZ2WFiAL+KT9a1Lkf+oz0Nn2rP
        CcQCr2snzGsh9EBjIglt1w==
X-Google-Smtp-Source: ABdhPJyGMOqRAF2+mTS589CkuekxoogzJnDR4EgPb4SQF+GAKHmsmrRL11YaskqHDxMRmr0Id2Y32A==
X-Received: by 2002:aca:2b05:: with SMTP id i5mr7870896oik.55.1629305100437;
        Wed, 18 Aug 2021 09:45:00 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k24sm102593otp.31.2021.08.18.09.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:44:59 -0700 (PDT)
Received: (nullmailer pid 2737924 invoked by uid 1000);
        Wed, 18 Aug 2021 16:44:58 -0000
Date:   Wed, 18 Aug 2021 11:44:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
Message-ID: <YR05Cj5R3cH+rTMx@robh.at.kernel.org>
References: <20210817101119.423853-1-frattaroli.nicolas@gmail.com>
 <20210817101119.423853-3-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817101119.423853-3-frattaroli.nicolas@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 12:11:17PM +0200, Nicolas Frattaroli wrote:
> This adds the YAML bindings for the Rockchip I2S/TDM audio driver.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  .../bindings/sound/rockchip,i2s-tdm.yaml      | 221 ++++++++++++++++++
>  include/dt-bindings/sound/rockchip,i2s-tdm.h  |   9 +
>  2 files changed, 230 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
>  create mode 100644 include/dt-bindings/sound/rockchip,i2s-tdm.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> new file mode 100644
> index 000000000000..c3022620b47f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> @@ -0,0 +1,221 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/rockchip,i2s-tdm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip I2S/TDM Controller
> +
> +description:
> +  The Rockchip I2S/TDM Controller is a Time Division Multiplexed
> +  audio interface found in various Rockchip SoCs, allowing up
> +  to 8 channels of audio over a serial interface.
> +
> +maintainers:
> +  - Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,px30-i2s-tdm
> +      - rockchip,rk1808-i2s-tdm
> +      - rockchip,rk3308-i2s-tdm
> +      - rockchip,rk3568-i2s-tdm
> +      - rockchip,rv1126-i2s-tdm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dmas:
> +    minItems: 1
> +    maxItems: 2
> +
> +  dma-names:
> +    oneOf:
> +      - const: rx
> +      - items:
> +          - const: tx
> +          - const: rx

If 'rx' is always present, then make it first:

minItems: 1
items:
  - const: rx
  - const: tx

> +
> +  clocks:
> +    items:
> +      - description: clock for TX
> +      - description: clock for RX
> +      - description: clock for I2S bus
> +
> +  clock-names:
> +    items:
> +      - const: mclk_tx
> +      - const: mclk_rx
> +      - const: hclk
> +
> +  rockchip,frame-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 64
> +    minimum: 32
> +    maximum: 512
> +    description:
> +      Width of a frame, usually slot width multiplied by number of slots.
> +      Must be even.
> +
> +  resets:
> +    items:
> +      - description: reset for TX
> +      - description: reset for RX
> +
> +  reset-names:
> +    items:
> +      - const: tx-m
> +      - const: rx-m
> +
> +  rockchip,cru:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      The phandle of the cru.
> +      Required if both playback and capture are used, i.e. if rockchip,clk-trcm
> +      is 0.
> +
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      The phandle of the syscon node for the GRF register.
> +
> +  rockchip,mclk-calibrate:
> +    description:
> +      Enable mclk source calibration.
> +    type: boolean
> +
> +  rockchip,trcm-sync:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Which lrck/bclk clocks each direction will sync to. You should use the
> +      constants in <dt-bindings/sound/rockchip,i2s-tdm.h>
> +    oneOf:
> +      - const: 0
> +        description:
> +          RK_TRCM_TXRX. Use both the TX and the RX clock for TX and RX.
> +      - const: 1
> +        description:
> +          RK_TRCM_TX. Use only the TX clock for TX and RX.
> +      - const: 2
> +        description:
> +          RK_TRCM_RX. Use only the RX clock for TX and RX.
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  rockchip,no-dmaengine:
> +    description:
> +      If present, driver will not register a pcm dmaengine, only the dai.
> +      If the dai is part of multi-dais, the property should be present.
> +    type: boolean
> +
> +  rockchip,playback-only:
> +    description: Specify that the controller only has playback capability.
> +    type: boolean
> +
> +  rockchip,capture-only:
> +    description: Specify that the controller only has capture capability.
> +    type: boolean
> +
> +  rockchip,i2s-rx-route:
> +    $ref: /schemas/types.yaml#/definitions/uint32

A single uint32 or

> +    description:
> +      Defines the mapping of I2S RX sdis to I2S data bus lines.
> +      By default, they are mapped one-to-one.
> +    items:
> +      - description: which sdi to connect to data line 0
> +      - description: which sdi to connect to data line 1
> +      - description: which sdi to connect to data line 2
> +      - description: which sdi to connect to data line 3

An array of 4 uint32s?

> +
> +  rockchip,i2s-tx-route:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Defines the mapping of I2S TX sdos to I2S data bus lines.
> +      By default, they are mapped one-to-one.
> +    items:
> +      - description: which sdo to connect to data line 0
> +      - description: which sdo to connect to data line 1
> +      - description: which sdo to connect to data line 2
> +      - description: which sdo to connect to data line 3
> +
> +  rockchip,tdm-fsync-half-frame:
> +    description: Whether to use half frame fsync.
> +    type: boolean
> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - dmas
> +  - dma-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - rockchip,grf
> +  - "#sound-dai-cells"
> +  - rockchip,trcm-sync
> +
> +allOf:
> +  - if:
> +      properties:
> +        rockchip,clk-trcm:

This property doesn't exist.

> +          contains:
> +            enum: [0]
> +    then:
> +      required:
> +        - rockchip,cru
> +
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3568-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/pinctrl/rockchip.h>
> +    #include <dt-bindings/sound/rockchip,i2s-tdm.h>
> +
> +
> +    foo {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        i2s@fe410000 {
> +            compatible = "rockchip,rk3568-i2s-tdm";
> +            reg = <0x0 0xfe410000 0x0 0x1000>;
> +            interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cru MCLK_I2S1_8CH_TX>, <&cru MCLK_I2S1_8CH_RX>,
> +                     <&cru HCLK_I2S1_8CH>;
> +            clock-names = "mclk_tx", "mclk_rx", "hclk";
> +            dmas = <&dmac1 2>, <&dmac1 3>;
> +            dma-names = "tx", "rx";
> +            resets = <&cru SRST_M_I2S1_8CH_TX>, <&cru SRST_M_I2S1_8CH_RX>;
> +            reset-names = "tx-m", "rx-m";
> +            rockchip,trcm-sync = <RK_TRCM_TX>;
> +            rockchip,cru = <&cru>;
> +            rockchip,grf = <&grf>;
> +            #sound-dai-cells = <0>;
> +            pinctrl-names = "default";
> +            pinctrl-0 =
> +                <&i2s1m0_sclktx
> +                &i2s1m0_sclkrx
> +                &i2s1m0_lrcktx
> +                &i2s1m0_lrckrx
> +                &i2s1m0_sdi0
> +                &i2s1m0_sdi1
> +                &i2s1m0_sdi2
> +                &i2s1m0_sdi3
> +                &i2s1m0_sdo0
> +                &i2s1m0_sdo1
> +                &i2s1m0_sdo2
> +                &i2s1m0_sdo3>;
> +            status = "disabled";

Why is the example disabled?

> +        };
> +    };
> diff --git a/include/dt-bindings/sound/rockchip,i2s-tdm.h b/include/dt-bindings/sound/rockchip,i2s-tdm.h
> new file mode 100644
> index 000000000000..32494d64cf33
> --- /dev/null
> +++ b/include/dt-bindings/sound/rockchip,i2s-tdm.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _DT_BINDINGS_ROCKCHIP_I2S_TDM_H
> +#define _DT_BINDINGS_ROCKCHIP_I2S_TDM_H
> +
> +#define RK_TRCM_TXRX 0
> +#define RK_TRCM_TX 1
> +#define RK_TRCM_RX 2
> +
> +#endif /* _DT_BINDINGS_ROCKCHIP_I2S_TDM_H */
> -- 
> 2.32.0
> 
> 
