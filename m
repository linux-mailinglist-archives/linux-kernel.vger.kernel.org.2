Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B4643900B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhJYHKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230059AbhJYHKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:10:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 907BC60F9C;
        Mon, 25 Oct 2021 07:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635145674;
        bh=jAvb0Th54ggrdiHBLJ1eMnNsymTI/uXr/s7gfpm+Yw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVHSSsU7xk/RWpeonZOIzDd3tH1iEuL0K57WNjrMw8HIdaEFQapbSy7GyinXZcRMC
         QMAQbGyIin6yXie79hHZglXuktnTLHvb1VdBInU8jDuxbhOAAV1ESvBRsXv6PsIODh
         yqjA7Ww8N6rexXAoab2MKkZLaBJvVpyC/o9KIpa9SzvNx+enVFiryjeFqvayjwxAfJ
         XcdYTCKzJykG0SQDcs84oFGhaW723n5nIrZ9EXP90bpVTrypundJhCAsezfm6MSBiA
         u4IfnbBRaQNjtFd3L/1kBFuhszzFjuBoB28RCkL7st+wmZqTW+82qEQj5mudUut4T5
         atMbJ/y7Aun+g==
Date:   Mon, 25 Oct 2021 12:37:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        michael.riesch@wolfvision.net, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: rockchip: Add Naneng combo PHY
 bindings
Message-ID: <YXZXxl8rc7b+i5J8@matsya>
References: <20211013101938.28061-1-yifeng.zhao@rock-chips.com>
 <20211013101938.28061-2-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013101938.28061-2-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-10-21, 18:19, Yifeng Zhao wrote:
> Add the compatible strings for the Naneng combo PHY found on rockchip SoC.

Pls cc rob & DT list here!

> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> Changes in v2:
> - Fix dtschema/dtc warnings/errors
> 
>  .../phy/phy-rockchip-naneng-combphy.yaml      | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> new file mode 100644
> index 000000000000..55ad33d902ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/phy-rockchip-naneng-combphy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip SoC Naneng Combo Phy Device Tree Bindings
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3568-naneng-combphy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: reference clock
> +      - description: apb clock
> +      - description: pipe clock
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: ref
> +      - const: apb
> +      - const: pipe
> +
> +  '#phy-cells':
> +    const: 1
> +
> +  resets:
> +    minItems: 1
> +    items:
> +      - description: exclusive apb reset line
> +      - description: exclusive PHY reset line
> +
> +  reset-names:
> +    minItems: 1
> +    items:
> +      - const: combphy-apb
> +      - const: combphy
> +
> +  rockchip,pipe-grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Some additional phy settings are access through GRF regs.
> +
> +  rockchip,pipe-phy-grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Some additional pipe settings are access through GRF regs.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#phy-cells'
> +  - resets
> +  - reset-names
> +  - rockchip,pipe-grf
> +  - rockchip,pipe-phy-grf
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    #include <dt-bindings/clock/rk3568-cru.h>
> +
> +    pipegrf: syscon@fdc50000 {
> +      reg = <0xfdc50000 0x1000>;
> +    };
> +
> +    pipe_phy_grf0: syscon@fdc70000 {
> +      reg = <0xfdc70000 0x1000>;
> +    };
> +
> +    combphy0_us: phy@fe820000 {
> +      compatible = "rockchip,rk3568-naneng-combphy";
> +      reg = <0xfe820000 0x100>;
> +      #phy-cells = <1>;
> +      clocks = <&pmucru CLK_PCIEPHY0_REF>, <&cru PCLK_PIPEPHY0>,
> +        <&cru PCLK_PIPE>;
> +      clock-names = "ref", "apb", "pipe";
> +      assigned-clocks = <&pmucru CLK_PCIEPHY0_REF>;
> +      assigned-clock-rates = <100000000>;
> +      resets = <&cru SRST_P_PIPEPHY0>, <&cru SRST_PIPEPHY0>;
> +      reset-names = "combphy-apb", "combphy";
> +      rockchip,pipe-grf = <&pipegrf>;
> +      rockchip,pipe-phy-grf = <&pipe_phy_grf0>;
> +    };
> -- 
> 2.17.1
> 
> 

-- 
~Vinod
