Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C193A4BC8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 02:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFLAr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 20:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFLAr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 20:47:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABDCF61181;
        Sat, 12 Jun 2021 00:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623458758;
        bh=aHVcBRVTirFXBTQGZ1D/qDt/hppo1Wzxf97VHIll9Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BhxsTnmV2Px0kthvruh05x5UvppRkVnkutAyByqdZm+Er/rJbXp1bmloL2heXbX5W
         MZ+OOsvTgHbFsW9h9SYUXjHbEPTGDqIw/rKAi5gLUtl+W3wcHDD/6gUjOCTYRhC7Wr
         fY/NdncBSYLdClok0mSkgtH0Fie2p6HGqKI2jo5ttQtVM3x93BSyBXJRkUveaugYiD
         1B437+FpcT6Rlaq74rA4KnrYv/mbob1PAddI2yl7xgDguvHXjZ6yMmd7LYPIuAjwFC
         qnXws4TmsM8vO62fWsh1rq1eGUPMUXAOJI3Gt0rAFMMx4BePUtTu1u5FTh8I4o6ms6
         Wz9gmL+L5AkPg==
Date:   Sat, 12 Jun 2021 08:45:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, p.zabel@pengutronix.de,
        l.stach@pengutronix.de, krzk@kernel.org, agx@sigxcpu.org,
        marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V6 2/4] Documentation: bindings: clk: Add bindings for
 i.MX BLK_CTL
Message-ID: <20210612004550.GC29138@dragon>
References: <20210522134249.15322-1-peng.fan@oss.nxp.com>
 <20210522134249.15322-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522134249.15322-3-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 09:42:47PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Document the i.MX BLK_CTL with its devicetree properties.
> 
> Each BLK CTL have different power domain inputs and they have different
> names, so we are not able to list all the power domain names for each
> BLK CTL here.
> 
> For example:
> i.MX8MM dispmix BLK CTL, it has
> 	power-domains = <&pgc_dispmix>, <&pgc_mipi>;
> 	power-domain-names = "dispmix", "mipi";
> 
> vpumix BLK CTL, it has
> 	power-domains = <&vpumix_pd>, <&vpu_g1_pd>, <&vpu_g2_pd>,
> 			<&vpu_h1_pd>;
> 	power-domain-names = "vpumix", "g1", "g2", "h1";
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Can we be consistent in using 'dt-bindings: ...' as prefix?

Shawn

> ---
>  .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> new file mode 100644
> index 000000000000..a66f11acc6b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> @@ -0,0 +1,66 @@
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
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 32
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - power-domain-names
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
> +    };
> -- 
> 2.30.0
> 
