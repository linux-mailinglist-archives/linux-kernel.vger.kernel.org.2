Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3FD3F5069
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhHWSey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:34:54 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:43714 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhHWSex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:34:53 -0400
Received: by mail-ot1-f53.google.com with SMTP id x10-20020a056830408a00b004f26cead745so38854426ott.10;
        Mon, 23 Aug 2021 11:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4TvCS5H1FNAkng8/8YjZRJGiz+UGB+5faejIY947HJ8=;
        b=FjcbCVP4Iunkl6YriPRrE6bDMB0daFjWIEBPFpaqDfRiM6us2ZR4rGnCZ6NCvhs3YA
         YzRsoksOezLss59PvPQ4MMuK56+tikHTbeUm0LtRF4rCxTsWbMmq/v4uTHcwcBejTmQX
         biTDFYGylOq1qHlrDnvSaHMU7NMtmjZ6ifaaY/FMnh/ivTeQTOTIKp3gn48pkbpr2IYU
         c9pjC9EaDhnpmqXgYzDFyyDG9Ow+BhHuJFW3cgy6I6OSK7IYMf3+fqRLy52WjjBz2iRy
         TDD5ldqLqBADAj6GVuy3OmNuyhirLMXhMp4EOWIoVg93JiMWgWNIJ0Ll50Yt0ffvvCw8
         xXJg==
X-Gm-Message-State: AOAM532SATo7fqx7VKbQyIOz0EF4AvDBWHnWq8rgotvCQNLQraKOuo2C
        PYeuIr3w6QoShbUTcqFIXQ==
X-Google-Smtp-Source: ABdhPJyPtYvsoO4wTHmI2AUT6N2HHnpM6odnregWKtg+VtkHAr5DFTYh7FaAPZ2E27tuY8eW7NsF6g==
X-Received: by 2002:a54:438a:: with SMTP id u10mr13002592oiv.131.1629743649755;
        Mon, 23 Aug 2021 11:34:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p64sm3921067oib.4.2021.08.23.11.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 11:34:09 -0700 (PDT)
Received: (nullmailer pid 2484159 invoked by uid 1000);
        Mon, 23 Aug 2021 18:34:08 -0000
Date:   Mon, 23 Aug 2021 13:34:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, galak@kernel.crashing.org,
        shawnguo@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: imx6: convert the imx pcie
 controller to dtschema
Message-ID: <YSPqIEmngxjCCn+v@robh.at.kernel.org>
References: <20210819071408.3856475-1-hongxing.zhu@nxp.com>
 <20210819071408.3856475-2-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819071408.3856475-2-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 03:14:06PM +0800, Richard Zhu wrote:
> Convert the fsl,imx6q-pcie.txt into a schema.
> - the ranges should be aligned to $ref: /schemas/pci/pci-bus.yaml#
> - only one propert is allowed in the compatible string, remove
>   "snps,dw-pcie".

Didn't I already see a v1?

> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie.txt           | 100 ---------
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 207 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 208 insertions(+), 101 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> deleted file mode 100644
> index d8971ab99274..000000000000
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ /dev/null
> @@ -1,100 +0,0 @@
> -* Freescale i.MX6 PCIe interface
> -
> -This PCIe host controller is based on the Synopsys DesignWare PCIe IP
> -and thus inherits all the common properties defined in designware-pcie.txt.
> -
> -Required properties:
> -- compatible:
> -	- "fsl,imx6q-pcie"
> -	- "fsl,imx6sx-pcie",
> -	- "fsl,imx6qp-pcie"
> -	- "fsl,imx7d-pcie"
> -	- "fsl,imx8mq-pcie"
> -- reg: base address and length of the PCIe controller
> -- interrupts: A list of interrupt outputs of the controller. Must contain an
> -  entry for each entry in the interrupt-names property.
> -- interrupt-names: Must include the following entries:
> -	- "msi": The interrupt that is asserted when an MSI is received
> -- clock-names: Must include the following additional entries:
> -	- "pcie_phy"
> -
> -Optional properties:
> -- fsl,tx-deemph-gen1: Gen1 De-emphasis value. Default: 0
> -- fsl,tx-deemph-gen2-3p5db: Gen2 (3.5db) De-emphasis value. Default: 0
> -- fsl,tx-deemph-gen2-6db: Gen2 (6db) De-emphasis value. Default: 20
> -- fsl,tx-swing-full: Gen2 TX SWING FULL value. Default: 127
> -- fsl,tx-swing-low: TX launch amplitude swing_low value. Default: 127
> -- fsl,max-link-speed: Specify PCI gen for link capability. Must be '2' for
> -  gen2, otherwise will default to gen1. Note that the IMX6 LVDS clock outputs
> -  do not meet gen2 jitter requirements and thus for gen2 capability a gen2
> -  compliant clock generator should be used and configured.
> -- reset-gpio: Should specify the GPIO for controlling the PCI bus device reset
> -  signal. It's not polarity aware and defaults to active-low reset sequence
> -  (L=reset state, H=operation state).
> -- reset-gpio-active-high: If present then the reset sequence using the GPIO
> -  specified in the "reset-gpio" property is reversed (H=reset state,
> -  L=operation state).
> -- vpcie-supply: Should specify the regulator in charge of PCIe port power.
> -  The regulator will be enabled when initializing the PCIe host and
> -  disabled either as part of the init process or when shutting down the
> -  host.
> -- vph-supply: Should specify the regulator in charge of VPH one of the three
> -  PCIe PHY powers. This regulator can be supplied by both 1.8v and 3.3v voltage
> -  supplies.
> -
> -Additional required properties for imx6sx-pcie:
> -- clock names: Must include the following additional entries:
> -	- "pcie_inbound_axi"
> -- power-domains: Must be set to phandles pointing to the DISPLAY and
> -  PCIE_PHY power domains
> -- power-domain-names: Must be "pcie", "pcie_phy"
> -
> -Additional required properties for imx7d-pcie and imx8mq-pcie:
> -- power-domains: Must be set to a phandle pointing to PCIE_PHY power domain
> -- resets: Must contain phandles to PCIe-related reset lines exposed by SRC
> -  IP block
> -- reset-names: Must contain the following entries:
> -	       - "pciephy"
> -	       - "apps"
> -	       - "turnoff"
> -- fsl,imx7d-pcie-phy: A phandle to an fsl,imx7d-pcie-phy node.
> -
> -Additional required properties for imx8mq-pcie:
> -- clock-names: Must include the following additional entries:
> -	- "pcie_aux"
> -
> -Example:
> -
> -	pcie@01000000 {
> -		compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
> -		reg = <0x01ffc000 0x04000>,
> -		      <0x01f00000 0x80000>;
> -		reg-names = "dbi", "config";
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		device_type = "pci";
> -		ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000
> -			  0x81000000 0 0          0x01f80000 0 0x00010000
> -			  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>;
> -		num-lanes = <1>;
> -		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "msi";
> -		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0 0 0 0x7>;
> -		interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> -		                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> -		                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> -		                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&clks 144>, <&clks 206>, <&clks 189>;
> -		clock-names = "pcie", "pcie_bus", "pcie_phy";
> -	};
> -
> -* Freescale i.MX7d PCIe PHY
> -
> -This is the PHY associated with the IMX7d PCIe controller.  It's used by the
> -PCI-e controller via the fsl,imx7d-pcie-phy phandle.
> -
> -Required properties:
> -- compatible:
> -	- "fsl,imx7d-pcie-phy"
> -- reg: base address and length of the PCIe PHY controller
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> new file mode 100644
> index 000000000000..3503ce3de05d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -0,0 +1,207 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX6 PCIe host controller
> +
> +maintainers:
> +  - Lucas Stach <l.stach@pengutronix.de>
> +  - Richard Zhu <hongxing.zhu@nxp.com>
> +
> +description: |+
> +  This PCIe host controller is based on the Synopsys DesignWare PCIe IP
> +  and thus inherits all the common properties defined in snps,dw-pcie.yaml.

Don't need a freeform text reference, but...
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#

...this needs to reference the snps,dw-pcie.yaml DWC schema.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx6q-pcie
> +      - fsl,imx6sx-pcie
> +      - fsl,imx6qp-pcie
> +      - fsl,imx7d-pcie
> +      - fsl,imx8mq-pcie
> +
> +  reg:
> +    items:
> +      - description: Data Bus Interface (DBI) registers.
> +      - description: PCIe configuration space region.
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: config
> +
> +  interrupts:
> +    minItems: 1

Don't need 'minItems: 1' when there's only 1 possible item:

> +    items:
> +      - description: builtin MSI controller.
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: msi
> +
> +  clocks:
> +    minItems: 3
> +    maxItems: 4

Don't need maxItems here.

> +    items:
> +      - description: PCIe bridge clock.
> +      - description: PCIe bus clock.
> +      - description: PCIe PHY clock.
> +      - description: Additional required clock entry for imx6sx-pcie,
> +          imx8mq-pcie.
> +
> +  clock-names:
> +    minItems: 3
> +    maxItems: 4

And here.

> +    items:
> +      - const: pcie
> +      - const: pcie_bus
> +      - const: pcie_phy
> +      - const: pcie_inbound_axi for imx6sx-pcie, pcie_aux for imx8mq-pcie
> +
> +  num-lanes:
> +    const: 1
> +
> +  num-viewport:
> +    const: 4

This is deprecated. The driver detects this now.

> +
> +  fsl,imx7d-pcie-phy:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: A phandle to an fsl,imx7d-pcie-phy node. Additional
> +      required properties for imx7d-pcie and imx8mq-pcie.
> +
> +  power-domains:
> +    maxItems: 2
> +    description: The first phandle pointing to the DISPLAY domain for
> +      imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and imx8mq-pcie.
> +      The second phandle pointing to the PCIE_PHY power domains for imx6sx-pcie.

Split the description:

items:
  - description: ...
  - description: ...

> +
> +  power-domain-names:
> +    maxItems: 2

You have to define the names.

> +
> +  resets:
> +    maxItems: 3
> +    description: Phandles to PCIe-related reset lines exposed by SRC
> +      IP block. Additional required by imx7d-pcie and imx8mq-pcie.
> +
> +  reset-names:
> +    items:
> +      - const: pciephy
> +      - const: apps
> +      - const: turnoff
> +
> +  fsl,tx-deemph-gen1:
> +    description: Gen1 De-emphasis value (optional required).

optional or required? 

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +
> +  fsl,tx-deemph-gen2-3p5db:
> +    description: Gen2 (3.5db) De-emphasis value (optional required).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +
> +  fsl,tx-deemph-gen2-6db:
> +    description: Gen2 (6db) De-emphasis value (optional required).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 20
> +
> +  fsl,tx-swing-full:
> +    description: Gen2 TX SWING FULL value (optional required).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 127
> +
> +  fsl,tx-swing-low:
> +    description: TX launch amplitude swing_low value (optional required).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 127
> +
> +  fsl,max-link-speed:
> +    description: Specify PCI Gen for link capability (optional required).
> +      Note that the IMX6 LVDS clock outputs do not meet gen2 jitter
> +      requirements and thus for gen2 capability a gen2 compliant clock
> +      generator should be used and configured.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3, 4]
> +    default: 1
> +
> +  reset-gpio:

Deprecated.

> +    description: Should specify the GPIO for controlling the PCI bus device
> +      reset signal. It's not polarity aware and defaults to active-low reset
> +      sequence (L=reset state, H=operation state) (optional required).
> +
> +  reset-gpio-active-high:

Deprecated. This should only be used on older compatibles I hope...

> +    description: If present then the reset sequence using the GPIO
> +      specified in the "reset-gpio" property is reversed (H=reset state,
> +      L=operation state) (optional required).
> +
> +  vpcie-supply:
> +    description: Should specify the regulator in charge of PCIe port power.
> +      The regulator will be enabled when initializing the PCIe host and
> +      disabled either as part of the init process or when shutting down
> +      the host (optional required).
> +
> +  vph-supply:
> +    description: Should specify the regulator in charge of VPH one of
> +      the three PCIe PHY powers. This regulator can be supplied by both
> +      1.8v and 3.3v voltage supplies (optional required).
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#address-cells"
> +  - "#size-cells"
> +  - device_type
> +  - bus-range
> +  - ranges
> +  - num-lanes
> +  - num-viewport
> +  - interrupts
> +  - interrupt-names
> +  - "#interrupt-cells"
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx6qdl-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pcie: pcie@1ffc000 {
> +        compatible = "fsl,imx6q-pcie";
> +        reg = <0x01ffc000 0x04000>,
> +              <0x01f00000 0x80000>;
> +        reg-names = "dbi", "config";
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        device_type = "pci";
> +        bus-range = <0x00 0xff>;
> +        ranges = <0x81000000 0 0          0x01f80000 0 0x00010000>,
> +                 <0x82000000 0 0x01000000 0x01000000 0 0x00f00000>;
> +        num-lanes = <1>;
> +        num-viewport = <4>;
> +        interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "msi";
> +        #interrupt-cells = <1>;
> +        interrupt-map-mask = <0 0 0 0x7>;
> +        interrupt-map = <0 0 0 1 &gpc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 2 &gpc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 3 &gpc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 4 &gpc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clks IMX6QDL_CLK_PCIE_AXI>,
> +                <&clks IMX6QDL_CLK_LVDS1_GATE>,
> +                <&clks IMX6QDL_CLK_PCIE_REF_125M>;
> +        clock-names = "pcie", "pcie_bus", "pcie_phy";
> +        status = "disabled";

Why are you disabling your example? 

> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f73fef615702..a1e2cc0be9e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14187,7 +14187,7 @@ M:	Lucas Stach <l.stach@pengutronix.de>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
>  F:	drivers/pci/controller/dwc/*imx6*
>  
>  PCI DRIVER FOR FU740
> -- 
> 2.25.1
> 
> 
