Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457203F18CB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 14:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbhHSMJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 08:09:23 -0400
Received: from foss.arm.com ([217.140.110.172]:36964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238105AbhHSMJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 08:09:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44D5A31B;
        Thu, 19 Aug 2021 05:08:43 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC2A13F70D;
        Thu, 19 Aug 2021 05:08:41 -0700 (PDT)
Subject: Re: [PATCH 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210817101119.423853-1-frattaroli.nicolas@gmail.com>
 <20210817101119.423853-3-frattaroli.nicolas@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <deb50900-fcfd-23d0-ab8a-0e64b2abb063@arm.com>
Date:   Thu, 19 Aug 2021 13:08:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817101119.423853-3-frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-17 11:11, Nicolas Frattaroli wrote:
> This adds the YAML bindings for the Rockchip I2S/TDM audio driver.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>   .../bindings/sound/rockchip,i2s-tdm.yaml      | 221 ++++++++++++++++++
>   include/dt-bindings/sound/rockchip,i2s-tdm.h  |   9 +
>   2 files changed, 230 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
>   create mode 100644 include/dt-bindings/sound/rockchip,i2s-tdm.h
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

It seems a bit weird for Rx DMA to be mandatory when other things imply 
that some interfaces may only be used for Tx.

> +
> +  clocks:
> +    items:
> +      - description: clock for TX
> +      - description: clock for RX
> +      - description: clock for I2S bus

Nit: "hclk" normally means the AHB clock driving the bus interface which 
connects to the rest of the SoC (and often doubling up as the core clock 
for the IP block itself) - AIUI the Tx and Rx represent the I2S bus(es).

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

I wonder if that might make sense to have boolean properties to describe 
the latter two cases (which would effectively be mutually-exclusive), 
rather than a magic number? Or possibly even just make the respective 
clocks optional, if this is something which would be done per-SoC rather 
than per-board?

> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  rockchip,no-dmaengine:
> +    description:
> +      If present, driver will not register a pcm dmaengine, only the dai.
> +      If the dai is part of multi-dais, the property should be present.
> +    type: boolean

That sounds a lot more like a policy decision specific to the Linux 
driver implementation, than something which really belongs in DT as a 
description of the platform.

> +
> +  rockchip,playback-only:
> +    description: Specify that the controller only has playback capability.
> +    type: boolean
> +
> +  rockchip,capture-only:
> +    description: Specify that the controller only has capture capability.
> +    type: boolean

Could those be inferred from the compatible string, or are there cases 
where you have multiple instances of the IP block in different 
configurations within the same SoC? (Or if it's merely reflecting 
whether the respective interface is actually wired up externally, could 
that be inferred from the attached codec?)

Robin.

> +  rockchip,i2s-rx-route:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Defines the mapping of I2S RX sdis to I2S data bus lines.
> +      By default, they are mapped one-to-one.
> +    items:
> +      - description: which sdi to connect to data line 0
> +      - description: which sdi to connect to data line 1
> +      - description: which sdi to connect to data line 2
> +      - description: which sdi to connect to data line 3
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
> 
