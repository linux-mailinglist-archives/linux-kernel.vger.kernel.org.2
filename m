Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6C33C7BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbhGNC3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:29:47 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:36476 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbhGNC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:29:45 -0400
Received: by mail-il1-f180.google.com with SMTP id j5so81325ilk.3;
        Tue, 13 Jul 2021 19:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=voA9smuMk/g18L5B9OeTv9tT41v85LP2kwVfB4rVqRY=;
        b=WIm9ZnZNoTsgxNdPLJvEXO/bMuDG+X3UecmZeJog4WihgJsPOfuqyCpp76Ax8Jen1n
         8NDGzFAyIAmsveaGYGEPc4lsASC/y0Sfc1JF3Uy25t+rlWDj0wJQE99m8BuR3WabopL8
         4ckMui20xYNiHftoXV+uhwxJX9hm4C9Wv4PkhrU9I22XpDVy/BR5E5rvyNlYjTlqjJ/1
         pyipPuNXnjM0J4GP06SLER8hpB9dRD2Oo0DXFKrjFh3Y42A/dyCT2cVrOpRAeiJzZTHq
         c/hY2gi1qsLQjE1uROWuWWIGGX8C2gcVjx0GMBd+CilLJ/bM4INOBHNpJhD1fEjY0qzT
         Xf0g==
X-Gm-Message-State: AOAM530cG/0AUSOyHO/u2gxcimPVPFtplakEzyrqVAumBFq4zW2fNJ/A
        r7k0vzNNod9tKOlVqNPSOQ==
X-Google-Smtp-Source: ABdhPJwEw8/nE86XRTkOiB+A8+CrZbl8V1CVobuOJdb5rgOsCbFHOb6A5SmlBn9fd3pjIWOnMX6wlw==
X-Received: by 2002:a92:b308:: with SMTP id p8mr5045602ilh.296.1626229613897;
        Tue, 13 Jul 2021 19:26:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d14sm443440iln.48.2021.07.13.19.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 19:26:53 -0700 (PDT)
Received: (nullmailer pid 1329963 invoked by uid 1000);
        Wed, 14 Jul 2021 02:26:49 -0000
Date:   Tue, 13 Jul 2021 20:26:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 2/8] dt-bindings: phy: Add bindings for HiKey 970 PCIe
 PHY
Message-ID: <20210714022649.GA1324196@robh.at.kernel.org>
References: <cover.1626157454.git.mchehab+huawei@kernel.org>
 <baa7e71e13953b28a11fffdcef35195099feb7fd.1626157454.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa7e71e13953b28a11fffdcef35195099feb7fd.1626157454.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 08:28:35AM +0200, Mauro Carvalho Chehab wrote:
> Document the bindings for HiKey 970 (hi3670) PCIe PHY
> interface, supported via the pcie-kirin driver.

Same comments on this one.

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../phy/hisilicon,phy-hi3670-pcie.yaml        | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> new file mode 100644
> index 000000000000..976ab6fe7b0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/hisilicon,phy-hi3670-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon Kirin970 PCIe PHY
> +
> +maintainers:
> +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +
> +description: |+
> +  Bindings for PCIe PHY on HiSilicon Kirin 970.
> +
> +properties:
> +  compatible:
> +    const: hisilicon,hi970-pcie-phy
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
> +
> +  phy-supply:
> +    description: The PCIe PHY power supply
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
> +
> +  reset-gpios:
> +    description: PCI PERST reset GPIOs
> +    maxItems: 4

Hiding the 4 ports in the phy?

> +
> +  clkreq-gpios:
> +    description: Clock request GPIOs
> +    maxItems: 3
> +
> +  hisilicon,eye-diagram-param:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: Eye diagram for phy.

Is there a size to this array?

> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - reset-gpios
> +  - clkreq-gpios
> +  - hisilicon,eye-diagram-param
> +  - phy-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/hi3670-clock.h>
> +
> +    bus {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +      pcie_phy: pcie-phy@fc000000 {
> +        compatible = "hisilicon,hi970-pcie-phy";
> +        reg = <0x0 0xfc000000 0x0 0x80000>;
> +        reg-names = "phy";
> +        #phy-cells = <0>;
> +        phy-supply = <&ldo33>;
> +        clocks = <&crg_ctrl HI3670_CLK_GATE_PCIEPHY_REF>,
> +                 <&crg_ctrl HI3670_CLK_GATE_PCIEAUX>,
> +                 <&crg_ctrl HI3670_PCLK_GATE_PCIE_PHY>,
> +                 <&crg_ctrl HI3670_PCLK_GATE_PCIE_SYS>,
> +                 <&crg_ctrl HI3670_ACLK_GATE_PCIE>;
> +        clock-names = "pcie_phy_ref", "pcie_aux",
> +                      "pcie_apb_phy", "pcie_apb_sys", "pcie_aclk";
> +        reset-gpios = <&gpio7 0 0 >, <&gpio25 2 0 >,
> +                      <&gpio3 1 0 >, <&gpio27 4 0 >;
> +        clkreq-gpios = <&gpio20 6 0 >, <&gpio27 3 0 >, <&gpio17 0 0 >;
> +        hisilicon,eye-diagram-param = <0xFFFFFFFF 0xFFFFFFFF
> +                                       0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF>;
> +      };
> +    };
> +...
> -- 
> 2.31.1
> 
> 
