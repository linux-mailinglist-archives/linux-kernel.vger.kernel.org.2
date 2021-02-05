Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF07311B3A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 06:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhBFE7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:59:43 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:39350 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhBFDfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:35:48 -0500
Received: by mail-ua1-f43.google.com with SMTP id t15so2815293ual.6;
        Fri, 05 Feb 2021 19:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h67k2LCgLLyuT0KAHJEqShKOh80gdx1RxrPR6qsQQUs=;
        b=neXHMiv17Oi7OpskFWBzwr16NTwZEVnU+Bs8Lt6IDhrzn+5v5V54TAByqObUoAIjET
         L7RaX0spO/LjMotQu8dmz5fDJyuHcJLcaYTQcmxBBw9zGKgW1Y7m1KcotV3/RyaroTw+
         fk1tPsMZKRTbOUC7NuMhlX2xPXj/DExUSJ4MrzGDamfKQHT9z4xntwWjK2Q1cgHPK0X5
         CmUEnt91nsuUmbmEn3WUCg5YYFhwnUkvW8IiGcELkFlRozqvLAq7lRgn5coBVrkkd52R
         fRyPCRHkY27Pj0cUeddD0c+XhnalqN8/BxerA6IoZ9K9OpUgLbg0IYDmSKDT2Ms60JWP
         gF7A==
X-Gm-Message-State: AOAM532A7yyHNWYJFGtbPyavkr0kSmqyhQ16OikgVXdPAcncFykonDuS
        t1z8KrRi66I4CuJZx22RzkfLqCuyLQ==
X-Google-Smtp-Source: ABdhPJzNt1N5iC6rEdfBFptrxE+q7qbqWAfZnrcFhVtG/g2E/+rv2wMIB1fKhaOhfYwbEOCXVRwbsg==
X-Received: by 2002:a9d:3462:: with SMTP id v89mr4755037otb.51.1612562646149;
        Fri, 05 Feb 2021 14:04:06 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 62sm468431oii.23.2021.02.05.14.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 14:04:04 -0800 (PST)
Received: (nullmailer pid 3832610 invoked by uid 1000);
        Fri, 05 Feb 2021 22:04:02 -0000
Date:   Fri, 5 Feb 2021 16:04:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nick Fan <Nick.Fan@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: Add DT schema for Arm Mali Valhall
 GPU
Message-ID: <20210205220402.GA3824042@robh.at.kernel.org>
References: <20210128022342.6445-1-Nick.Fan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128022342.6445-1-Nick.Fan@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:23:41AM +0800, Nick Fan wrote:
> Add devicetree schema for Arm Mali Valhall GPU
> 
> Define a compatible string for the Mali Valhall GPU
> for Mediatek's SoC platform.
> 
> Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>
> ---
>  .../bindings/gpu/arm,mali-valhall.yaml        | 217 ++++++++++++++++++
>  1 file changed, 217 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-valhall.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall.yaml
> new file mode 100644
> index 000000000000..275c14ad173a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall.yaml
> @@ -0,0 +1,217 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2020 MediaTek Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpu/arm,mali-valhall.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM Mali Valhall GPU
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +
> +properties:
> +  $nodename:
> +    pattern: '^gpu@[a-f0-9]+$'
> +
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8192-mali
> +      - const: arm,mali-valhall
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: GPU interrupt
> +      - description: MMU interrupt
> +      - description: Job interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: gpu
> +      - const: mmu
> +      - const: job

Please use the same order as midgard and bifrost.

> +
> +  clocks:
> +    minItems: 1
> +
> +  power-domains:
> +    minItems: 1
> +    maxItems: 5
> +
> +  mali-supply: true
> +  sram-supply: true
> +
> +  operating-points-v2: true
> +  opp_table: true

opp-table

> +
> +  "#cooling-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8192-mali
> +    then:
> +      properties:
> +        power-domains:
> +          minItems: 5
> +          maxItems: 5
> +
> +        power-domain-names:
> +          items:
> +            - const: core0
> +            - const: core1
> +            - const: core2
> +            - const: core3
> +            - const: core4
> +
> +      required:
> +        - sram-supply
> +        - power-domains
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    gpu@13000000 {
> +           compatible = "mediatek,mt8192-mali", "arm,mali-valhall";

Do 4 space indent.

> +           reg = <0x13000000 0x4000>;
> +           interrupts =
> +                   <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>,
> +                   <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
> +                   <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>;
> +           interrupt-names =
> +                   "gpu",
> +                   "mmu",
> +                   "job";
> +
> +           clocks = <&mfgcfg 0>;
> +
> +           power-domains =
> +                   <&spm 4>,
> +                   <&spm 5>,
> +                   <&spm 6>,
> +                   <&spm 7>,
> +                   <&spm 8>;
> +
> +           operating-points-v2 = <&gpu_opp_table>;
> +           mali-supply = <&mt6315_7_vbuck1>;
> +           sram-supply = <&mt6359_vsram_others_ldo_reg>;
> +           gpu_opp_table: opp_table {
> +             compatible = "operating-points-v2";

And then the same here.

> +             opp-shared;
> +
> +             opp-358000000 {
> +                   opp-hz = /bits/ 64 <358000000>;
> +                   opp-microvolt = <606250>,
> +                                   <750000>;

Isn't this supposed to be either a single value or <min max nominal>?

> +             };
> +
> +             opp-399000000 {
> +                   opp-hz = /bits/ 64 <399000000>;
> +                   opp-microvolt = <618750>,
> +                                   <750000>;
> +             };
> +
> +             opp-440000000 {
> +                   opp-hz = /bits/ 64 <440000000>;
> +                   opp-microvolt = <631250>,
> +                                   <750000>;
> +             };
> +
> +             opp-482000000 {
> +                   opp-hz = /bits/ 64 <482000000>;
> +                   opp-microvolt = <643750>,
> +                                   <750000>;
> +             };
> +
> +             opp-523000000 {
> +                   opp-hz = /bits/ 64 <523000000>;
> +                   opp-microvolt = <656250>,
> +                                   <750000>;
> +             };
> +
> +             opp-564000000 {
> +                   opp-hz = /bits/ 64 <564000000>;
> +                   opp-microvolt = <668750>,
> +                                   <750000>;
> +             };
> +
> +             opp-605000000 {
> +                   opp-hz = /bits/ 64 <605000000>;
> +                   opp-microvolt = <681250>,
> +                                   <750000>;
> +             };
> +
> +             opp-647000000 {
> +                   opp-hz = /bits/ 64 <647000000>;
> +                   opp-microvolt = <693750>,
> +                                   <750000>;
> +             };
> +
> +             opp-688000000 {
> +                   opp-hz = /bits/ 64 <688000000>;
> +                   opp-microvolt = <706250>,
> +                                   <750000>;
> +             };
> +
> +             opp-724000000 {
> +                   opp-hz = /bits/ 64 <724000000>;
> +                   opp-microvolt = <725000>,
> +                                   <750000>;
> +             };
> +
> +             opp-760000000 {
> +                   opp-hz = /bits/ 64 <760000000>;
> +                   opp-microvolt = <743750>,
> +                                   <750000>;
> +             };
> +
> +             opp-795000000 {
> +                   opp-hz = /bits/ 64 <795000000>;
> +                   opp-microvolt = <762500>,
> +                                   <762500>;
> +             };
> +
> +             opp-831000000 {
> +                   opp-hz = /bits/ 64 <831000000>;
> +                   opp-microvolt = <781250>,
> +                                   <781250>;
> +             };
> +
> +             opp-855000000 {
> +                   opp-hz = /bits/ 64 <855000000>;
> +                   opp-microvolt = <793750>,
> +                                   <793750>;
> +             };
> +
> +             opp-902000000 {
> +                   opp-hz = /bits/ 64 <902000000>;
> +                   opp-microvolt = <818750>,
> +                                   <818750>;
> +             };
> +
> +             opp-950000000 {
> +                   opp-hz = /bits/ 64 <950000000>;
> +                   opp-microvolt = <843750>,
> +                                   <843750>;
> +             };
> +          };
> +    };
> +...
> -- 
> 2.18.0
> 
