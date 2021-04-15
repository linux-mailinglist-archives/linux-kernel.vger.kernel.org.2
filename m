Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5D4360EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhDOPZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:25:34 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:42965 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhDOPZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:25:27 -0400
Received: by mail-oo1-f52.google.com with SMTP id e12-20020a056820060cb02901e94efc049dso533035oow.9;
        Thu, 15 Apr 2021 08:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WqLtDa2Y+Z0BtnNMwL32ANtrJ2QU3EanfS3R24oxCVk=;
        b=fg/PedfINkiVhhtq/vUv1W1ttu7+FwwXJcNNsZUiGyJbYDaiKdz8ASptpmHjOHkJ08
         P6asEsA2C7IPYrQufLqD6MVp/a4A3nN3nto8apUJVsoP+hKKT1KvcuR83BvkaiGdQk7U
         vRKIzu9nASol8LhJMOPXY/fRv7U+UsOFbYw2aquRrNwhITRWv7JXHkehkBYyrGJBNdFN
         Jp80IaPe/42YHAHF64pGppRp/qECQAfNaPUl1AEH3uqd/zTHorzxwmZcE7jFfnqna+BI
         iUeDPWdV/Eh3QqGy0GSwhciBHWJ44tiK1DK8MxXsEZzwCf3e9Zs+eDY5eI1/d3YEOMuF
         rgHg==
X-Gm-Message-State: AOAM531BPTtVGKoU8GgbnMdLJB+OLzqbv3I6bFbJNpEHQiIyycEu5v8z
        7U+nK0hm18kMdREXZg639cZxVCEAvA==
X-Google-Smtp-Source: ABdhPJxCoyKRyGYHhBgzkRX/+OPVCS+l9Tx1bKIAWsB0NIPEPcPYA5s0210m+OawWB6cF2WOrkVoAw==
X-Received: by 2002:a4a:9c46:: with SMTP id c6mr2131118ook.31.1618500303771;
        Thu, 15 Apr 2021 08:25:03 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y13sm726979oti.79.2021.04.15.08.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 08:25:02 -0700 (PDT)
Received: (nullmailer pid 1431769 invoked by uid 1000);
        Thu, 15 Apr 2021 15:25:00 -0000
Date:   Thu, 15 Apr 2021 10:25:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Flora Fu <flora.fu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v2 4/7] dt-bindings: soc: mediatek: apusys: Add new
 document for APU power domain
Message-ID: <20210415152500.GA1424680@robh.at.kernel.org>
References: <1618465960-3013-1-git-send-email-flora.fu@mediatek.com>
 <1618465960-3013-5-git-send-email-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618465960-3013-5-git-send-email-flora.fu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 01:52:37PM +0800, Flora Fu wrote:
> Document the bindings for APU power domain on MediaTek SoC.
> 
> Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> ---
> Note:
> This patch depends on MT8192 clock[1] patches which haven't yet been accepted.
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20210324104110.13383-7-chun-jie.chen@mediatek.com/
> ---
>  .../soc/mediatek/mediatek,apu-pm.yaml         | 145 ++++++++++++++++++
>  1 file changed, 145 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
> new file mode 100644
> index 000000000000..6ff966920917
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
> @@ -0,0 +1,145 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/mediatek/mediatek,apu-pm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek APU Power Domains
> +
> +maintainers:
> +  - Flora Fu <flora.fu@mediatek.com>
> +
> +description: |
> +  Mediatek AI Process Unit (APU) include support for power domains which can be
> +  powered up/down by software.
> +  APU subsys belonging to a power domain should contain a 'power-domains'
> +  property that is a phandle for apuspm node representing the domain.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8192-apu-pm
> +      - const: syscon
> +
> +  reg:
> +    description: Address range of the APU power domain controller.
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  vsram-supply:
> +    description: apu sram regulator supply.
> +
> +  mediatek,scpsys:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      phandle to the device containing the scpsys register range.
> +
> +  mediatek,apu-conn:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      phandle to the device containing the scpsys apu conn register range.
> +
> +  mediatek,apu-conn1:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      phandle to the device containing the scpsys apu conn1 register range.
> +
> +  mediatek,apu-vcore:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      phandle to the device containing the scpsys apu vcore register range.
> +
> +patternProperties:
> +  "^power-domain@[0-9a-f]+$":
> +    type: object
> +    description: |
> +      Represents the power domains within the power controller node as
> +      documented in Documentation/devicetree/bindings/power/power-domain.yaml.
> +
> +    properties:
> +      reg:
> +        description: |
> +          Power domain index. Valid values are defined in:
> +          "include/dt-bindings/power/mt8182-apu-power.h"
> +        maxItems: 1
> +
> +      '#power-domain-cells':
> +        description: |
> +          Must be 0 for nodes representing a single PM domain and 1 for nodes
> +          providing multiple PM.
> +
> +      clocks:
> +        description: |
> +          List of phandles of clocks list. Specify by order according to
> +          power-up sequence.
> +
> +      clock-names:
> +        description: |
> +          List of names of clocks. Specify by order according to power-up
> +          sequence.
> +
> +      assigned-clocks:
> +        maxItems: 2
> +
> +      assigned-clock-parents:
> +        maxItems: 2
> +
> +      domain-supply:
> +        description: domain regulator supply.
> +
> +    required:
> +      - reg
> +      - '#power-domain-cells'
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#power-domain-cells'
> +  - vsram-supply
> +  - mediatek,scpsys
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8192-clk.h>
> +    apuspm: power-domain@190f0000 {
> +        compatible = "mediatek,mt8192-apu-pm", "syscon";
> +        reg = <0x190f0000 0x1000>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #power-domain-cells = <1>;

So you have domains provided by this node and then...

> +        vsram-supply = <&mt6359_vsram_md_ldo_reg>;
> +        mediatek,scpsys = <&scpsys>;
> +        mediatek,apu-conn = <&apu_conn>;
> +        mediatek,apu-vcore = <&apu_vcore>;
> +
> +        apu_top: power-domain@0 {
> +            reg = <0>;
> +            #power-domain-cells = <0>;

...each child node provides a domain. What's the difference?

> +            clocks = <&topckgen CLK_TOP_DSP_SEL>,
> +                     <&topckgen CLK_TOP_IPU_IF_SEL>,
> +                     <&clk26m>,
> +                     <&topckgen CLK_TOP_UNIVPLL_D6_D2>;
> +            clock-names = "clk_top_conn",
> +                          "clk_top_ipu_if",
> +                          "clk_off",
> +                          "clk_on_default";
> +            assigned-clocks = <&topckgen CLK_TOP_DSP_SEL>,
> +                              <&topckgen CLK_TOP_IPU_IF_SEL>;
> +            assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
> +                                     <&topckgen CLK_TOP_UNIVPLL_D6_D2>;
> +            domain-supply = <&mt6359_vproc1_buck_reg>;
> +        };
> +    };
> -- 
> 2.18.0
> 
