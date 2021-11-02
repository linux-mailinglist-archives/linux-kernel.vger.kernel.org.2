Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A3144333F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhKBQnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:43:21 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34309 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhKBQnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:43:19 -0400
Received: by mail-ot1-f41.google.com with SMTP id t17-20020a056830083100b00553ced10177so30615281ots.1;
        Tue, 02 Nov 2021 09:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e5GlJ8JHBJ/9O+bLCp/KS0OxnO+d96GJAcEfTy+w1v8=;
        b=6iUiadjxYCyT03HnBKTV/nCKdHN82L/mh98+YbYGJRdG2DquEBs9fZDmcQuEQcsN9/
         Ytey437ldmvJpB3bVNmEylwk9lxQdC8zO9l5rs2Din0CHB/SXsymkCnKiQMLDfZO65wE
         k/qew+nX61T4Yvyl2WmEMveatxSG3B42WkB4h1ImrczUDAm1rNAVp2bC0n7EegcXqWBJ
         YfQ1C5g9NsWEYxJHDYsliX+HJQ/f5CjJLfzosUwM+F+0B4cIhUfqFqBUcFCXyJsRw+Um
         tPWTnjRPbYmbpaQ83pUGvhh9uuUzBZ5X6w1Kyqoxp7bfdudPjvf1ijHE1g3g/XBZHLjU
         2Wig==
X-Gm-Message-State: AOAM532svrKFMLzO1E4ivgkF2ZUNZkCpMUSQGw+o0hP4q0FKYTCSjQcj
        kp4hI1SokdU/IvJOnDJ5MQ==
X-Google-Smtp-Source: ABdhPJzE0adcVTqLogDw/8gNDG3NR3Ik4X8ekV4rjvUQCgy7mvTK9W/vxhu/1hcxpHE33/f8ncxwrQ==
X-Received: by 2002:a9d:847:: with SMTP id 65mr23693262oty.326.1635871244046;
        Tue, 02 Nov 2021 09:40:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bo35sm3941838oib.40.2021.11.02.09.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:40:43 -0700 (PDT)
Received: (nullmailer pid 3033197 invoked by uid 1000);
        Tue, 02 Nov 2021 16:40:42 -0000
Date:   Tue, 2 Nov 2021 11:40:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, kishon@ti.com, vkoul@kernel.org,
        galak@kernel.crashing.org, shawnguo@kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v5 2/8] dt-bindings: phy: Add imx8 pcie phy driver support
Message-ID: <YYFqCptm9m7Onbrv@robh.at.kernel.org>
References: <1635820355-27009-1-git-send-email-hongxing.zhu@nxp.com>
 <1635820355-27009-3-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635820355-27009-3-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 10:32:29AM +0800, Richard Zhu wrote:
> Add dt-binding for the standalone i.MX8 PCIe PHY driver.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> Tested-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  .../bindings/phy/fsl,imx8-pcie-phy.yaml       | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> new file mode 100644
> index 000000000000..b9f89e343b0b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/fsl,imx8-pcie-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8 SoC series PCIe PHY Device Tree Bindings
> +
> +maintainers:
> +  - Richard Zhu <hongxing.zhu@nxp.com>
> +
> +properties:
> +  "#phy-cells":
> +    const: 0
> +
> +  compatible:
> +    enum:
> +      - fsl,imx8mm-pcie-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PHY module clock

The description doesn't really add much. Just 'maxItems: 1'.

> +
> +  clock-names:
> +    items:
> +      - const: ref
> +
> +  resets:
> +    items:
> +      - description: Phandles to PCIe-related reset lines exposed by SRC
> +          IP block.

More than 1 phandle? The schema says only 1. Again, for only 1, you can 
use just 'maxItems: 1'.

> +
> +  reset-names:
> +    items:
> +      - const: pciephy
> +
> +  fsl,refclk-pad-mode:
> +    description: |
> +      Specifies the mode of the refclk pad used. It can be UNUSED(PHY
> +      refclock is derived from SoC internal source), INPUT(PHY refclock
> +      is provided externally via the refclk pad) or OUTPUT(PHY refclock
> +      is derived from SoC internal source and provided on the refclk pad).
> +      Refer include/dt-bindings/phy/phy-imx8-pcie.h for the constants
> +      to be used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1, 2 ]
> +
> +  fsl,tx-deemph-gen1:
> +    description: Gen1 De-emphasis value (optional required).

Optional or required?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +
> +  fsl,tx-deemph-gen2:
> +    description: Gen2 De-emphasis value (optional required).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +
> +  fsl,clkreq-unsupported:
> +    type: boolean
> +    description: A boolean property indicating the CLKREQ# signal is
> +      not supported in the board design (optional)
> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - fsl,refclk-pad-mode
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mm-clock.h>
> +    #include <dt-bindings/phy/phy-imx8-pcie.h>
> +    #include <dt-bindings/reset/imx8mq-reset.h>
> +
> +    pcie_phy: pcie-phy@32f00000 {
> +            compatible = "fsl,imx8mm-pcie-phy";
> +            reg = <0x32f00000 0x10000>;
> +            clocks = <&clk IMX8MM_CLK_PCIE1_PHY>;
> +            clock-names = "ref";
> +            assigned-clocks = <&clk IMX8MM_CLK_PCIE1_PHY>;
> +            assigned-clock-rates = <100000000>;
> +            assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_100M>;
> +            resets = <&src IMX8MQ_RESET_PCIEPHY>;
> +            reset-names = "pciephy";
> +            fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
> +            #phy-cells = <0>;
> +    };
> +...
> -- 
> 2.25.1
> 
> 
