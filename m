Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178B63FCF4C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 23:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbhHaVvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 17:51:24 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:46993 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhHaVvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 17:51:20 -0400
Received: by mail-oi1-f181.google.com with SMTP id o185so1051237oih.13;
        Tue, 31 Aug 2021 14:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z4zGlKAlI6VbY2dCAx/WGVy/9ir/egij02vGyThDzW4=;
        b=nBnVZw+T8obt3S2TzX6a0qQ3zjy7SX5wlqbnnEFmd5bmOt6JFo66IAeNPIrz/vlX7L
         K602WqftoxQ8qzKJIwOMSOO8/N3bbY3oSf1DHYSSncv97siyy1cXLoEQdNcSoUUsx5tF
         pZrD+rYf18C5IIOA29wtNMAWczLcJMoZZdduPWDpubOg32GcOgG63D8flX8nO5df4Ylz
         39648n2Ab4Ygz2HwavY6EhY519e5Tqe1huHhDqupbpqd7azVOiA76ZY+/85JrZlTt8wu
         kzvUGAMjs0ijhIE8bb7sPQDp23J6terLuqJbz6fCtH/NYE4uMQ7dPGgKo/rcnilm8fLw
         oIXg==
X-Gm-Message-State: AOAM5317wbVZtULbealdPs/O1STRQYpNkQMXJcyUz1VkpIAKoNcJfgnZ
        gb9kXdvsCdQL861Ifb2+FQ==
X-Google-Smtp-Source: ABdhPJymrI2LgNkJttvARCCZDVvDEe/pM8dU4KQpr11oFcHkXT9f1G2ElDoRAyoHgIpLjLLkdEy9QA==
X-Received: by 2002:a54:458f:: with SMTP id z15mr4855144oib.42.1630446624054;
        Tue, 31 Aug 2021 14:50:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c7sm4189188otm.27.2021.08.31.14.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 14:50:23 -0700 (PDT)
Received: (nullmailer pid 705164 invoked by uid 1000);
        Tue, 31 Aug 2021 21:50:22 -0000
Date:   Tue, 31 Aug 2021 16:50:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
Message-ID: <YS6kHkeOKCJMOOIf@robh.at.kernel.org>
References: <20210828140205.21973-1-frattaroli.nicolas@gmail.com>
 <20210828140205.21973-3-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828140205.21973-3-frattaroli.nicolas@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 04:02:02PM +0200, Nicolas Frattaroli wrote:
> This adds the YAML bindings for the Rockchip I2S/TDM audio driver.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  .../bindings/sound/rockchip,i2s-tdm.yaml      | 218 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 219 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> new file mode 100644
> index 000000000000..ab8731779805
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> @@ -0,0 +1,218 @@
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
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - rx
> +        - tx
> +
> +  clocks:
> +    minItems: 3
> +    items:
> +      - description: clock for TX
> +      - description: clock for RX
> +      - description: AHB clock driving the interface
> +      - description:
> +          Parent clock for mclk_tx (only required when using mclk-calibrate)
> +      - description:
> +          Parent clock for mclk_rx (only required when using mclk-calibrate)
> +      - description:
> +          Clock for sample rates that are an integer multiple of 8000
> +          (only required when using mclk-calibrate)
> +      - description:
> +          Clock for sample rates that are an integer multiple of 11025
> +          (only required when using mclk-calibrate)
> +
> +  clock-names:
> +    minItems: 3
> +    items:
> +      - const: mclk_tx
> +      - const: mclk_rx
> +      - const: hclk
> +      - const: mclk_tx_src
> +      - const: mclk_rx_src
> +      - const: mclk_root0
> +      - const: mclk_root1
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
> +      Required if neither trcm-sync-tx-only nor trcm-sync-rx-only are specified.
> +
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      The phandle of the syscon node for the GRF register.
> +
> +  rockchip,mclk-calibrate:
> +    description:
> +      Switch between two root clocks depending on the audio sample rate.
> +      For integer multiples of 8000 (e.g. 48000 Hz), mclk_root0 is used.
> +      For integer multiples of 11025 (e.g. 44100 Hz), mclk_root1 is used.
> +    type: boolean
> +
> +  rockchip,trcm-sync-tx-only:
> +    type: boolean
> +    description: Use TX BCLK/LRCK for both TX and RX.
> +
> +  rockchip,trcm-sync-rx-only:
> +    type: boolean
> +    description: Use RX BCLK/LRCK for both TX and RX.
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  rockchip,i2s-rx-route:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Defines the mapping of I2S RX sdis to I2S data bus lines.
> +      By default, they are mapped one-to-one.
> +    items:
> +      - description: which sdi to connect to data line 0
> +      - description: which sdi to connect to data line 1
> +      - description: which sdi to connect to data line 2
> +      - description: which sdi to connect to data line 3

This would be better expressed as:

maxItems: 4
items:
  enum: [ 0, 1, 2, 3 ]

(I'm guessing on the allowed values here)

> +
> +  rockchip,i2s-tx-route:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Defines the mapping of I2S TX sdos to I2S data bus lines.
> +      By default, they are mapped one-to-one.
> +    items:
> +      - description: which sdo to connect to data line 0
> +      - description: which sdo to connect to data line 1
> +      - description: which sdo to connect to data line 2
> +      - description: which sdo to connect to data line 3

Same here.

> +
> +  rockchip,tdm-fsync-half-frame:
> +    description: Whether to use half frame fsync.
> +    type: boolean
> +
> +  rockchip,io-multiplex:
> +    description:
> +      Specify that the GPIO lines on the I2S bus are multiplexed such that
> +      the direction (input/output) needs to be dynamically adjusted.
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
> +
> +allOf:
> +  - if:
> +      properties:
> +        rockchip,trcm-sync-tx-only: false
> +        rockchip,trcm-sync-rx-only: false
> +    then:
> +      required:
> +        - rockchip,cru
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3568-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/pinctrl/rockchip.h>
> +
> +    foo {

bus {

> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        i2s@fe410000 {
> +            compatible = "rockchip,rk3568-i2s-tdm";
> +            reg = <0x0 0xfe410000 0x0 0x1000>;
> +            interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cru MCLK_I2S1_8CH_TX>, <&cru MCLK_I2S1_8CH_RX>,
> +                     <&cru HCLK_I2S1_8CH>;
> +            clock-names = "mclk_tx", "mclk_rx", "hclk";
> +            dmas = <&dmac1 3>, <&dmac1 2>;
> +            dma-names = "rx", "tx";
> +            resets = <&cru SRST_M_I2S1_8CH_TX>, <&cru SRST_M_I2S1_8CH_RX>;
> +            reset-names = "tx-m", "rx-m";
> +            rockchip,trcm-sync-tx-only;
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
> +            status = "okay";

Still needs to be dropped.

> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d459d42672c..d2be16a85009 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16053,6 +16053,7 @@ ROCKCHIP I2S TDM DRIVER
>  M:	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
>  L:	linux-rockchip@lists.infradead.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
>  F:	sound/soc/rockchip/rockchip_i2s_tdm.*
>  
>  ROCKCHIP ISP V1 DRIVER
> -- 
> 2.33.0
> 
> 
