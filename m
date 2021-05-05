Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BA7374BB9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 01:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhEEXKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 19:10:03 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:33639 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEEXKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 19:10:01 -0400
Received: by mail-ot1-f54.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso3297908otl.0;
        Wed, 05 May 2021 16:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NJYs480APHZBs1/gMu2DXQ2Z6GydY07ZT9IrG1uPyUA=;
        b=KS8dBzfxFnw5dsnlKSQTi9lRPKpkqLXEJj9DLbM+eYJlSXSOoxr0PR+zy6xHvuwzlc
         3Wf7erpWpJ513fPJqTRCbrS5dCyxmBD7GRWTXXFDD113PHGp599IvILCI9MboK0WquL4
         S7A7lsj4crGsDnSaBShXUD/AdEEW6z207sBRLenHLb1c6/pO7mse7SZ6QzGPYxWIjBCi
         /pboGYzGPlyzQWnj6+G1mgVQou2II+EeBck/OLdLGfc3XSsf5mNJU38AUzao0gjF7MhW
         wJIgd5kjugSOh2SE6X2XrRiWG05xKeN3+ITuznLZHN3MSe0WGV02cy90C4G6dEJ7JEP9
         sSrg==
X-Gm-Message-State: AOAM531d+EdqLiYRrEtaAxTBEcRaGOFZp0bkcUCU8XnIe7a7PuQj57X5
        76GD+TlzGdp6nQEvPwpWI2OENcnszA==
X-Google-Smtp-Source: ABdhPJwZJjad5WMnMT1SK2sXEYfEfLONYmLI8FSf9dy5qsJTmy4KlYTTGYRKUcdUWuwWTsl5/hoi+g==
X-Received: by 2002:a05:6830:2013:: with SMTP id e19mr886154otp.309.1620256142880;
        Wed, 05 May 2021 16:09:02 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r18sm188978otp.74.2021.05.05.16.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 16:09:01 -0700 (PDT)
Received: (nullmailer pid 3014222 invoked by uid 1000);
        Wed, 05 May 2021 23:08:59 -0000
Date:   Wed, 5 May 2021 18:08:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, p.zabel@pengutronix.de,
        l.stach@pengutronix.de, krzk@kernel.org, agx@sigxcpu.org,
        marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 2/4] Documentation: bindings: clk: Add bindings for
 i.MX BLK_CTL
Message-ID: <20210505230859.GA3010875@robh.at.kernel.org>
References: <20210430052746.10815-1-peng.fan@oss.nxp.com>
 <20210430052746.10815-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430052746.10815-3-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 01:27:44PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Document the i.MX BLK_CTL with its devicetree properties.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> new file mode 100644
> index 000000000000..a491b63de50c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/imx/fsl,imx-blk-ctl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX BLK_CTL
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +description:
> +  i.MX BLK_CTL is a conglomerate of different GPRs that are
> +  dedicated to a specific subsystem. It usually contains
> +  clocks and resets amongst other things. Here we take the clocks
> +  and resets as virtual PDs, the reason we could not take it as
> +  clock provider is there is A/B lock issue between power domain
> +  and clock.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,imx8mm-dispmix-blk-ctl
> +          - fsl,imx8mm-vpumix-blk-ctl
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +  power-domains:
> +    minItems: 1
> +    maxItems: 32
> +
> +  power-domain-names:
> +    minItems: 1
> +    maxItems: 32

Please describe why there's a range and we don't enumerate each entry.

> +
> +  '#reset-cells':
> +    const: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 32
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 32
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mm-clock.h>
> +
> +    dispmix_blk_ctl: blk-ctl@32e28000 {
> +      compatible = "fsl,imx8mm-dispmix-blk-ctl", "syscon";
> +      reg = <0x32e28000 0x100>;
> +      #power-domain-cells = <1>;
> +      power-domains = <&pgc_dispmix>, <&pgc_mipi>;
> +      power-domain-names = "dispmix", "mipi";
> +      clocks = <&clk IMX8MM_CLK_DISP_ROOT>, <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
> +               <&clk IMX8MM_CLK_DISP_APB_ROOT>;
> +      clock-names = "disp", "axi", "apb";
> +    };
> -- 
> 2.30.0
> 
