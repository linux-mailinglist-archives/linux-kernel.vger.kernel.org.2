Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4479B31C0F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhBORrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:47:45 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:45605 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbhBORd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 12:33:28 -0500
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 0C6B3100002;
        Mon, 15 Feb 2021 17:32:32 +0000 (UTC)
Date:   Mon, 15 Feb 2021 18:32:32 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: reset: microchip sparx5 reset driver
 bindings
Message-ID: <20210215173232.GM6798@piout.net>
References: <20210210091952.2013027-1-steen.hegelund@microchip.com>
 <20210210091952.2013027-2-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210091952.2013027-2-steen.hegelund@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2021 10:19:50+0100, Steen Hegelund wrote:
> Document the Sparx5 reset device driver bindings
> 
> The driver uses two IO ranges on sparx5 for access to
> the reset control and the reset status.
> 
> Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> ---
>  .../bindings/reset/microchip,rst.yaml         | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/microchip,rst.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> new file mode 100644
> index 000000000000..80046172c9f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/reset/microchip,rst.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Microchip Sparx5 Switch Reset Controller
> +
> +maintainers:
> +  - Steen Hegelund <steen.hegelund@microchip.com>
> +  - Lars Povlsen <lars.povlsen@microchip.com>
> +
> +description: |
> +  The Microchip Sparx5 Switch provides reset control and implements the following
> +  functions
> +    - One Time Switch Core Reset (Soft Reset)
> +
> +properties:
> +  $nodename:
> +    pattern: "^reset-controller@[0-9a-f]+$"
> +
> +  compatible:
> +    const: microchip,sparx5-switch-reset
> +
> +  reg:
> +    items:
> +      - description: cpu block registers
> +      - description: global control block registers
> +
> +  reg-names:
> +    items:
> +      - const: cpu
> +      - const: gcb
> +

I still think this is not right because then you will be mapping the
same set of register using multiple drivers without any form of
synchronisation which will work because you are mapping the region
without requesting it. But this may lead to issues later.

At least, you should make cpu start at 0x80 and of size 4. Else, you
won't be able to define and use the GPRs that are in front of
CPU_REGS:RESET.

I would still keep DEVCPU_GCB:CHIP_REGS as a syscon, especially since
you are mapping the whole set of registers.


> +  "#reset-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    reset: reset-controller@0 {
> +        compatible = "microchip,sparx5-switch-reset";
> +        #reset-cells = <1>;
> +        reg = <0x0 0xd0>,
> +              <0x11010000 0x10000>;
> +        reg-names = "cpu", "gcb";
> +    };
> +
> -- 
> 2.30.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
