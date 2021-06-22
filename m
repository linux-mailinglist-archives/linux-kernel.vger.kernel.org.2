Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942643B0AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhFVQ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:59:09 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:41942 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFVQ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:59:08 -0400
Received: by mail-il1-f182.google.com with SMTP id k5so5442622ilv.8;
        Tue, 22 Jun 2021 09:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XXD64DW43MkEPz+dTKES9lCjXNn8ZHTv2qhDOUEKvHY=;
        b=MGbTcs4qpFCCYfdQReFASE2+nECYV9NbDZ6qTr5dvX/NekTFQVaNVjbvbQU54Hv4MD
         4mw2At6A1wKroaXB0lnxxC/D+UyhiftH1p7vhyOI2s3wsMnjUWTh6ot3BFf7wMZNvqfz
         5T56CKCZploMpo6Ksqzuk8Y6OgiUZ6zuffoUXNkMpKCl1yBkW8kOatSh2Uo60futdbzD
         0H0/Dkd1irrpg1+Ep1xhXOGDJIwJikg0pOO1hr7M4szfFZeUcsdcCvRtkhWqgeznKzxZ
         22WRYoFNvnFAJXHVTNj4jvQFor8Abw09CR4K5EMjMe4pEK7BQs1aBYvvn2GVwCFvq3K2
         0HoA==
X-Gm-Message-State: AOAM532bNCHEQittQNvFRXhXdOvRE20Q2Xd0D2Iwcmu5Is7EiOv/jZac
        vk5OjDYmhyGKoAgVgZjUOw==
X-Google-Smtp-Source: ABdhPJypIwlNsW2XYlIq0IjRsoUGyvqG8oeTVi3ETiXk+6aO7i069nPHEq/tw4RVzMKG/Qxmyv4cuQ==
X-Received: by 2002:a92:280a:: with SMTP id l10mr2702990ilf.265.1624381011704;
        Tue, 22 Jun 2021 09:56:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l11sm11055629ios.8.2021.06.22.09.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 09:56:49 -0700 (PDT)
Received: (nullmailer pid 3840158 invoked by uid 1000);
        Tue, 22 Jun 2021 16:56:46 -0000
Date:   Tue, 22 Jun 2021 10:56:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tomasz Figa <t.figa@samsung.com>,
        Fancy Fang <chen.fang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Anthony Brandon <anthony@amarulasolutions.com>,
        Francis Laniel <francis.laniel@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Milco Pratesi <milco.pratesi@engicam.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [RFC PATCH 3/9] dt-bindings: phy: Add SEC DSIM DPHY bindings
Message-ID: <20210622165646.GA3838180@robh.at.kernel.org>
References: <20210621072424.111733-1-jagan@amarulasolutions.com>
 <20210621072424.111733-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621072424.111733-4-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 12:54:18PM +0530, Jagan Teki wrote:
> Samsung SEC MIPI DSIM DPHY controller is part of registers
> available in SEC MIPI DSIM bridge for NXP's i.MX8M Mini and
> Nano Processors.
> 
> Add dt-bingings for it.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../bindings/phy/samsung,sec-dsim-dphy.yaml   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/samsung,sec-dsim-dphy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/samsung,sec-dsim-dphy.yaml b/Documentation/devicetree/bindings/phy/samsung,sec-dsim-dphy.yaml
> new file mode 100644
> index 000000000000..c5770c8035e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/samsung,sec-dsim-dphy.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/samsung,sec-dsim-dphy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung SEC MIPI DSIM DPHY controller on i.MX8M Mini and Nano SoCs
> +
> +maintainers:
> +  - Jagan Teki <jagan@amarulasolutions.com>
> +
> +properties:
> +  "#phy-cells":
> +    const: 0
> +
> +  compatible:
> +    enum:
> +      - fsl,imx8mm-sec-dsim-dphy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Phy Ref Clock
> +
> +  clock-names:
> +    items:
> +      - const: phy_ref

'ref' is sufficient.

> +
> +  power-domains:
> +    maxItems: 1
> +    description: phandle to the associated power domain
> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mm-clock.h>
> +    #include <dt-bindings/power/imx8mm-power.h>
> +
> +    dphy: dphy@32e100a4 {

phy@...

> +      compatible = "fsl,imx8mm-sec-dsim-dphy";
> +      reg = <0x32e100a4 0xbc>;
> +      clocks = <&clk IMX8MM_CLK_DSI_PHY_REF>;
> +      clock-names = "phy_ref";
> +      power-domains = <&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DPHY>;
> +      #phy-cells = <0>;
> +    };
> -- 
> 2.25.1
> 
> 
