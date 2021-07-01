Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66743B9720
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 22:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhGAUVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 16:21:24 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:35748 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhGAUVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 16:21:23 -0400
Received: by mail-il1-f181.google.com with SMTP id a11so7665347ilf.2;
        Thu, 01 Jul 2021 13:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jkKNz83v8bTKAmVdHO7nGUak++aeSsOWlXuVgcISOl0=;
        b=Upels+RW/G8dqi33Nuz8lHusjGDW7ton7n6GAFiUX18hM1gB+kA6+CuEi0QsTrNG1t
         rcREUJdOMm9rVJVjGxXTjI2NBql/s59IMYyA2pI8/w61sZhF14lTe0yf4xVJJfzP//BX
         J9koxzJvetZGZnxvxmWMJ7CEOHH83ajcbtRWWwyjPVrtQRo5Q1+2XgTamAdTkwfLWaM7
         sQ6KeIW4cz0WdIBZPOLyCXwEaC0AF4/VqqzYp7QDWqTQi2A9e5llgcg51ertw/7SiMl1
         UWoDF7IcpWXCGkZiDKwEQGOMxLm0pBllIJUEwHLbu4DtRKgA7qp0y70pdlISAEMWqMJH
         B+YQ==
X-Gm-Message-State: AOAM532T7WOvDlm95YF3VZpRBbgHhGxp33/E0P6dqC8kUv/5Y/WTNztg
        /16EZrX0g+K/Nrqt/QkWvQ==
X-Google-Smtp-Source: ABdhPJxtxgEA4kNkOytbyFpCO9NEcYOLLKLdFA7tA79AD7cIrlqW3i8z2e3RRRGjRSL7hT+sxY+b4g==
X-Received: by 2002:a05:6e02:1292:: with SMTP id y18mr896855ilq.30.1625170732037;
        Thu, 01 Jul 2021 13:18:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u16sm419388iob.41.2021.07.01.13.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 13:18:51 -0700 (PDT)
Received: (nullmailer pid 2858275 invoked by uid 1000);
        Thu, 01 Jul 2021 20:18:46 -0000
Date:   Thu, 1 Jul 2021 14:18:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, bicycle.tsai@mediatek.com,
        jiaxin.yu@mediatek.com, cychiang@google.com, aaronyu@google.com
Subject: Re: [PATCH v2 6/8] dt-bindings: mediatek: mt8195: add audio afe
 document
Message-ID: <20210701201846.GA2783836@robh.at.kernel.org>
References: <20210629014736.31153-1-trevor.wu@mediatek.com>
 <20210629014736.31153-7-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629014736.31153-7-trevor.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 09:47:34AM +0800, Trevor Wu wrote:
> This patch adds mt8195 audio afe document.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
> This patch depends on the following series that have not been accepted.
> 
> [1] Mediatek MT8195 clock support
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=501923
> (dt-bindings/clock/mt8195-clk.h is included)
> 
> [2] Mediatek MT8195 power domain support
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=500709
> (dt-bindings/power/mt8195-power.h is included)
> ---
>  .../bindings/sound/mt8195-afe-pcm.yaml        | 136 ++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml
> new file mode 100644
> index 000000000000..a4fb5c7dd022
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mt8195-afe-pcm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek AFE PCM controller for mt8195
> +
> +maintainers:
> +  - Trevor Wu <trevor.wu@mediatek.com>
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8195-audio
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  mediatek,topckgen:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    description: The phandle of the mediatek topckgen controller
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: audio 26M clock
> +      - description: AFE clock
> +      - description: audio infra sys clock
> +      - description: audio infra 26M clock
> +
> +  clock-names:
> +    items:
> +      - const: clk26m
> +      - const: aud_afe
> +      - const: infra_ao_audio
> +      - const: infra_ao_audio_26m_b
> +
> +  etdm-in1-chn-disabled:

Needs a vendor prefix.

> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    maxItems: 24
> +    description: Specify which input channel should be disabled.
> +
> +  etdm-in2-chn-disabled:

Needs a vendor prefix.

> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    maxItems: 16
> +    description: Specify which input channel should be disabled.
> +
> +patternProperties:
> +  "^etdm-in[1-2]-mclk-source$":

And all these need a vendor prefix.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Specify etdm in mclk source clock.
> +    enum:
> +      - 0 # xtal_26m_ck
> +      - 1 # apll1_ck
> +      - 2 # apll2_ck
> +      - 3 # apll3_ck
> +      - 4 # apll4_ck
> +      - 5 # apll5_ck
> +      - 6 # hdmirx_apll_ck
> +
> +  "^etdm-out[1-3]-mclk-source$":
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Specify etdm out mclk source clock.
> +
> +  "^etdm-in[1-2]-mclk-alwasys-on-rate$":
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Specify etdm in mclk output rate for always on case.

Hz? If so, '-hz' unit suffix and drop the type ref.

> +
> +  "^etdm-out[1-3]-mclk-alwasys-on-rate$":

typo: alwasys

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Specify etdm out mclk output rate for always on case.

Hz?

> +
> +  "^etdm-in[1-2]-data-mode$":
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Specify etdm in data mode.
> +    enum:
> +      - 0 # one pin (TDM)
> +      - 1 # multi pin (I2S)

Can be boolean?

> +
> +  "^etdm-out[1-3]-data-mode$":
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Specify etdm out data mode.

Constraints on values?

> +
> +  "^etdm-in[1-2]-cowork-source$":
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      etdm modules can share the same external clock pin. Specify
> +      which etdm clock source is required by this etdm in moudule.
> +    enum:
> +      - 0 # etdm1_in
> +      - 1 # etdm2_in
> +      - 2 # etdm1_out
> +      - 3 # etdm2_out
> +      - 4 # etdm3_out
> +
> +  "^etdm-out[1-3]-cowork-source$":
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      etdm modules can share the same external clock pin. Specify
> +      which etdm clock source is required by this etdm out moudule.

Constraints?

> +
> +required:
> +  - compatible
> +  - interrupts
> +  - mediatek,topckgen
> +  - power-domains
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +
> +    afe: mt8195-afe-pcm {
> +        compatible = "mediatek,mt8195-audio";
> +        interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH 0>;
> +        mediatek,topckgen = <&topckgen>;
> +        power-domains = <&spm MT8195_POWER_DOMAIN_AUDIO>;
> +        clocks = <&clk26m>,
> +                 <&audsys CLK_AUD_AFE>,
> +                 <&infracfg_ao CLK_INFRA_AO_AUDIO>,
> +                 <&infracfg_ao CLK_INFRA_AO_AUDIO_26M_B>;
> +        clock-names = "clk26m",
> +                      "aud_afe",
> +                      "infra_ao_audio",
> +                      "infra_ao_audio_26m_b";
> +    };
> +
> +...
> -- 
> 2.18.0
> 
> 
