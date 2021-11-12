Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB08B44EEFD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 23:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhKLWFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 17:05:38 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:41584 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbhKLWFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 17:05:37 -0500
Received: by mail-oi1-f180.google.com with SMTP id u74so20422008oie.8;
        Fri, 12 Nov 2021 14:02:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t+KAfOjFr4t2mTcUSpON02Xo01xzrWfIkJBe7hcW8jA=;
        b=D8VItZYGfZVj7jhCesdOtT1SPpKaJxRLfxKowxeP39VvbxY+YxcRF6IChmChRFn41q
         L0xyky2fp8155muDwwd+50605zublnCaMlA2vgsZTQVzcELh38mwbFALyTZUPujuvckD
         bC1L7ScPH+cUX29KJkEWwr7mvognH5tQVgbnf15WP8rcRRO33+yd07XQERnDE36uNkY3
         Nu8LujGdnQ2v9fDYm0X/vZ3dlML9shEITLoyKbQq3L/3oFDXaBhLhGqgoacrgJL76I39
         1f6vnsS/rPPTBafemHqy+rEAo2kQwMcvtx1ruAt+qJtgZpBE6uHTRp9r5fCX5eJSGjaG
         XwbA==
X-Gm-Message-State: AOAM530GHyADYBXgA14sQfzJEhAkAwmaK+yfyG2QjCl1r2atcyM32oAH
        5MqSBcaS7Fk8JErLKOfh+A==
X-Google-Smtp-Source: ABdhPJwIsLYv9ns5hwqECj27nFZWXamn7JxO7uKlG8J5zrWyAkJdNcaH05PTDSelKdQDBiZ1WH5yYg==
X-Received: by 2002:aca:3b89:: with SMTP id i131mr15751453oia.102.1636754565780;
        Fri, 12 Nov 2021 14:02:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t12sm1450398oth.21.2021.11.12.14.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:02:44 -0800 (PST)
Received: (nullmailer pid 3452161 invoked by uid 1000);
        Fri, 12 Nov 2021 22:02:43 -0000
Date:   Fri, 12 Nov 2021 16:02:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        ariel.dalessandro@collabora.com, krzk@kernel.org,
        tharvey@gateworks.com, l.stach@pengutronix.de,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/9] dt-bindings: soc: add binding for i.MX8MN DISP
 blk-ctrl
Message-ID: <YY7kg3GC5lnX7TgW@robh.at.kernel.org>
References: <20211104161804.587250-1-aford173@gmail.com>
 <20211104161804.587250-5-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104161804.587250-5-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 11:17:59AM -0500, Adam Ford wrote:
> Add the DT binding for the i.MX8MN DISP blk-ctrl.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
> new file mode 100644
> index 000000000000..fbeaac399c50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8MN DISP blk-ctrl
> +
> +maintainers:
> +  - Lucas Stach <l.stach@pengutronix.de>
> +
> +description:
> +  The i.MX8MN DISP blk-ctrl is a top-level peripheral providing access to
> +  the NoC and ensuring proper power sequencing of the display and MIPI CSI
> +  peripherals located in the DISP domain of the SoC.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: fsl,imx8mn-disp-blk-ctrl
> +      - const: syscon

Are there other functions in this block? If so, what?

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  power-domains:
> +    minItems: 5
> +    maxItems: 5
> +
> +  power-domain-names:
> +    items:
> +      - const: bus
> +      - const: isi
> +      - const: lcdif
> +      - const: mipi-dsi
> +      - const: mipi-csi
> +
> +  clocks:
> +    minItems: 11
> +    maxItems: 11
> +
> +  clock-names:
> +    items:
> +      - const: disp_axi
> +      - const: disp_apb
> +      - const: disp_axi_root
> +      - const: disp_apb_root
> +      - const: lcdif-axi
> +      - const: lcdif-apb
> +      - const: lcdif-pix
> +      - const: dsi-pclk
> +      - const: dsi-ref
> +      - const: csi-aclk
> +      - const: csi-pclk
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - power-domain-names
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mn-clock.h>
> +    #include <dt-bindings/power/imx8mn-power.h>
> +
> +    disp_blk_ctl: blk_ctrl@32e28000 {
> +      compatible = "fsl,imx8mn-disp-blk-ctrl", "syscon";
> +      reg = <0x32e28000 0x100>;
> +      power-domains = <&pgc_dispmix>, <&pgc_dispmix>,
> +                      <&pgc_dispmix>, <&pgc_mipi>,
> +                      <&pgc_mipi>;
> +      power-domain-names = "bus", "isi", "lcdif", "mipi-dsi",
> +                           "mipi-csi";

This looks odd. These are the same power domains this node provides.

> +      clocks = <&clk IMX8MN_CLK_DISP_AXI>,
> +               <&clk IMX8MN_CLK_DISP_APB>,
> +               <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
> +               <&clk IMX8MN_CLK_DISP_APB_ROOT>,
> +               <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
> +               <&clk IMX8MN_CLK_DISP_APB_ROOT>,
> +               <&clk IMX8MN_CLK_DISP_PIXEL_ROOT>,
> +               <&clk IMX8MN_CLK_DSI_CORE>,
> +               <&clk IMX8MN_CLK_DSI_PHY_REF>,
> +               <&clk IMX8MN_CLK_CSI1_PHY_REF>,
> +               <&clk IMX8MN_CLK_CAMERA_PIXEL_ROOT>;
> +       clock-names = "disp_axi", "disp_apb", "disp_axi_root", "disp_apb_root",
> +                     "lcdif-axi", "lcdif-apb", "lcdif-pix", "dsi-pclk",
> +                     "dsi-ref", "csi-aclk", "csi-pclk";
> +       #power-domain-cells = <1>;
> +    };
> -- 
> 2.32.0
> 
> 
