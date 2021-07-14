Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5CA3C7BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbhGNCZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:25:53 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:45714 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbhGNCZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:25:52 -0400
Received: by mail-il1-f181.google.com with SMTP id b6so40659iln.12;
        Tue, 13 Jul 2021 19:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=12gW3X9OrRKnrBX1nzhlxSiSqMfBp8er0J24VFr4/og=;
        b=iR6A8Mf7rkZfVyZX6jqe1V39DJd/J97W/XilHtFFcZ6NQDIzgpGI3/wAN9eLQJIfTC
         ylVHvDt5TtWY4cJQmoJIjjZrTF3Ljvg/BoUgjh0uMy0xxOnodkHe1xcbbpxNdYdt1mFQ
         wV6E/ifiLao7CNnJklTO/2wLFrddgKDyYKF5FMg+mS8l2MNxQJD8auUxKPDKnNPKA8K7
         X0scXE075ik7d3F3TZSlHT/elLf7LNK10JDSQ3DMA+5IrK1dIyn8oOGo+ByOxMTB/eGn
         CfG+n1boK3TFfiHj1rlNxj6uvsusJ8D1+1M4jTGhh6pQhmTg2dwEGcb3I5RWItPquDEI
         TQ2g==
X-Gm-Message-State: AOAM532WhFc5KsBps6gMmORhtaKMWEMwCwHFcEUzawc0+pTxqbg8of9n
        Q9u66mI5RTlTLvOEXEmmOA==
X-Google-Smtp-Source: ABdhPJz2TkSxBQkzmWQxdvbf6TvEl4d9KgP5yS1/XCJYDi/Q8PCHYjScU07wkIdjmceJH7iegD6dDw==
X-Received: by 2002:a92:cbd0:: with SMTP id s16mr5086798ilq.19.1626229381404;
        Tue, 13 Jul 2021 19:23:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x10sm442883ill.26.2021.07.13.19.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 19:23:00 -0700 (PDT)
Received: (nullmailer pid 1323921 invoked by uid 1000);
        Wed, 14 Jul 2021 02:22:57 -0000
Date:   Tue, 13 Jul 2021 20:22:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 1/8] dt-bindings: phy: Add bindings for HiKey 960 PCIe
 PHY
Message-ID: <20210714022257.GA1320622@robh.at.kernel.org>
References: <cover.1626157454.git.mchehab+huawei@kernel.org>
 <390e7fc0cd6fa4217f5d67c74f12ea101fab3f6d.1626157454.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390e7fc0cd6fa4217f5d67c74f12ea101fab3f6d.1626157454.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 08:28:34AM +0200, Mauro Carvalho Chehab wrote:
> Document the bindings for HiKey 960 (hi3660) PCIe PHY
> interface, supported via the pcie-kirin driver.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../phy/hisilicon,phy-hi3660-pcie.yaml        | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3660-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3660-pcie.yaml b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3660-pcie.yaml
> new file mode 100644
> index 000000000000..81c93e76cef4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3660-pcie.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/hisilicon,phy-hi3660-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon Kirin960 PCIe PHY
> +
> +maintainers:
> +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +
> +description: |+
> +  Bindings for PCIe PHY on HiSilicon Kirin 960.
> +
> +properties:
> +  compatible:
> +    const: hisilicon,hi960-pcie-phy
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +    description: PHY Control registers
> +
> +  reg-names:
> +    const: phy

You don't really need reg-names with only 1.

> +
> +  clocks:
> +    items:
> +      - description: PCIe PHY clock
> +      - description: PCIe AUX clock
> +      - description: PCIe APB PHY clock
> +      - description: PCIe APB SYS clock
> +      - description: PCIe ACLK clock
> +
> +  clock-names:
> +    items:
> +      - const: pcie_phy_ref
> +      - const: pcie_aux
> +      - const: pcie_apb_phy
> +      - const: pcie_apb_sys
> +      - const: pcie_aclk

'pcie_' is redundant. Drop.

> +
> +  reset-gpios:
> +    description: PCI PERST reset GPIO

maxItems: 1

Though this belongs in the PCIE node.

> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - reset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/hi3660-clock.h>
> +
> +    bus {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +      pcie_phy: pcie-phy@f3f2000 {
> +        compatible = "hisilicon,hi960-pcie-phy";
> +        reg = <0x0 0xf3f20000 0x0 0x40000>;
> +        reg-names = "phy";
> +        clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
> +                 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
> +                 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
> +                 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
> +                 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
> +        clock-names = "pcie_phy_ref", "pcie_aux",
> +                 "pcie_apb_phy", "pcie_apb_sys",
> +                 "pcie_aclk";
> +        reset-gpios = <&gpio11 1 0 >;
> +        #phy-cells = <0>;
> +      };
> +    };
> +...
> -- 
> 2.31.1
> 
> 
