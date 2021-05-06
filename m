Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E46B375664
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbhEFPTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:19:41 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:39759 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhEFPTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:19:40 -0400
Received: by mail-oi1-f178.google.com with SMTP id i81so5816897oif.6;
        Thu, 06 May 2021 08:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G8NEvPOrDT6+Pw7E4JBz+Asc/i7s7xwCTqt4dFpDTf8=;
        b=DfqIAAH86fnHlW3rLAk6Bn/aknubS2qNwTIpkbC6x6aGdtboUXbhVMjOWb0tdr9Nx2
         Udo9hgdeWcAg/8P0/Vlls5GFk7xItAkTqAnjAv0O2JpSMLtSnqbemhM8OuS9sTgzYe14
         68y2WCtApX7pIOqpG+y3aKK1iCtXKaqqsCW0GJadcT1cMy7uke7gt9XKxVBFpgIfOvLn
         MxEhRjy8oNFspXaXeKmusIeRGdOHm7eiU027TbfESlCbyV2RbpbP0iJNozb+GXcH92cW
         hV9biEOTwPgUBVn5WfjuT4VQZl0x1msRzxlBI/hEmk99ztGv15rgyXsbFwysWzckZKdK
         C4Bg==
X-Gm-Message-State: AOAM532DPj+vXUchO8aveQy/qJNBCmdF9ihlegXz1ZgiYxHnMziyYQfs
        tEJcdxF/lsvWM8/Ml1U0W8j02MfQwg==
X-Google-Smtp-Source: ABdhPJw8TU5WtN1FKAJbma13bBGVi4QMT4s2r0u1oqiA/2XEoUhRqwbJPWl0n7B9VTqsCjNKWGzRFA==
X-Received: by 2002:aca:2316:: with SMTP id e22mr11528857oie.53.1620314321724;
        Thu, 06 May 2021 08:18:41 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f13sm637603ote.46.2021.05.06.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:18:40 -0700 (PDT)
Received: (nullmailer pid 344905 invoked by uid 1000);
        Thu, 06 May 2021 15:18:39 -0000
Date:   Thu, 6 May 2021 10:18:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: staging: mt7621-pci: PCIe binding
 documentation for MT76721 SoCs
Message-ID: <20210506151839.GA322729@robh.at.kernel.org>
References: <20210501133647.14350-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210501133647.14350-1-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2021 at 03:36:46PM +0200, Sergio Paracuellos wrote:
> Add device tree binding documentation for PCIe in MT7621 SoCs.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
> 
> Hi Rob,
> 
> Some concerns here. I was not be able to found any case similar to
> this binding where sub-nodes describing each pcie port interface
> are needed. I added them to the 'examples' directly without saying
> anything about properties in any other place since its properties
> seems to be covered in 'pci-bus.yaml' schema definition. I don't
> know if this is the way, I have checked against schema and I noticed
> I am forced to add 'device_type' property in each subnode because
> schema checker complains that this is mandatory. So I have added
> it and schema is properly being validated:
> 
> Before add the 'device_type' in each subnode:
> /home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@0,0: 'device_type' is a required property
> >From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
> /home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@1,0: 'device_type' is a required property
> >From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
> /home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@2,0: 'device_type' is a required property
> >From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml

Each port is a PCI bridge, right? If so, then 'pcie' for the node name 
and 'device_type = "pci";' are correct.

> 
> After adding it:
> CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json

Validates all the schema

> SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json

Preprocesses all the schema

> DTEX    Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dts

Extracts the example to dts file

> DTC     Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml

Converts the example to yaml

> CHECK   Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml

Runs the checks.

> 
> Looks a bit redundant and maybe I am doing something wrong...
> 
> Thanks in advance for clarification.
> 
> Best regards,
>     Sergio Paracuellos
> 
> 
>  .../bindings/pci/mediatek,mt7621-pci.yaml     | 144 ++++++++++++++++++
>  .../mt7621-pci/mediatek,mt7621-pci.txt        | 104 -------------
>  2 files changed, 144 insertions(+), 104 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
>  delete mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> new file mode 100644
> index 000000000000..9c1d05d929a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> @@ -0,0 +1,144 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/mediatek,mt7621-pci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT7621 PCIe controller
> +
> +maintainers:
> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +
> +description: |+
> +  MediaTek MT7621 PCIe subsys supports single Root complex (RC)
> +  with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt7621-pci
> +
> +  reg:
> +    items:
> +      - description: host-pci bridge registers
> +      - description: pcie port 0 RC control registers
> +      - description: pcie port 1 RC control registers
> +      - description: pcie port 2 RC control registers

Are these config space registers or MT7621 specific?

> +
> +  ranges:
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 3

What are the 3 interrupts?

> +
> +  resets:
> +    items:
> +      - description: pcie port 0 reset.
> +      - description: pcie port 1 reset.
> +      - description: pcie port 2 reset.

This and clocks should perhaps be in each child node.

> +
> +  reset-names:
> +    items:
> +      - const: pcie0
> +      - const: pcie1
> +      - const: pcie2
> +
> +  clocks:
> +    items:
> +      - description: pcie port 0 clock.
> +      - description: pcie port 1 clock.
> +      - description: pcie port 2 clock.
> +
> +  clock-names:
> +    items:
> +      - const: pcie0
> +      - const: pcie1
> +      - const: pcie2
> +
> +  phys:
> +    items:
> +      - description: Dual-ported phy for pcie port 0 and 1.
> +      - description: Phy for pcie port 2.
> +
> +  phy-names:
> +    items:
> +      - const: pcie-phy0
> +      - const: pcie-phy2
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - interrupts
> +  - resets
> +  - reset-names
> +  - clocks
> +  - clock-names
> +  - phys
> +  - phy-names
> +  - reset-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/mips-gic.h>
> +
> +    pcie: pcie@1e140000 {
> +        compatible = "mediatek,mt7621-pci";
> +        reg = <0x1e140000 0x100>,
> +              <0x1e142000 0x100>,
> +              <0x1e143000 0x100>,
> +              <0x1e144000 0x100>;
> +
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pcie_pins>;
> +        device_type = "pci";
> +        bus-range = <0 255>;

That's the default, so not needed.

> +        ranges = <0x02000000 0 0x00000000 0x60000000 0 0x10000000>,  /* pci memory */
> +                 <0x01000000 0 0x00000000 0x1e160000 0 0x00010000>;  /* io space */
> +        interrupt-parent = <&gic>;
> +        interrupts = <GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
> +        resets = <&rstctrl 24>, <&rstctrl 25>, <&rstctrl 26>;
> +        reset-names = "pcie0", "pcie1", "pcie2";
> +        clocks = <&clkctrl 24>, <&clkctrl 25>, <&clkctrl 26>;
> +        clock-names = "pcie0", "pcie1", "pcie2";
> +        phys = <&pcie0_phy 1>, <&pcie2_phy 0>;
> +        phy-names = "pcie-phy0", "pcie-phy2";
> +        reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>;
> +
> +        pcie@0,0 {
> +            reg = <0x0000 0 0 0 0>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            device_type = "pci";
> +            ranges;
> +            bus-range = <0x00 0xff>;

Besides being the default, I don't think this makes sense here as it 
belongs in the parent unless you had some subset of bus numbers allowed 
by the parent.

> +        };
> +
> +        pcie@1,0 {
> +            reg = <0x0800 0 0 0 0>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            device_type = "pci";
> +            ranges;
> +            bus-range = <0x00 0xff>;
> +        };
> +
> +        pcie@2,0 {
> +            reg = <0x1000 0 0 0 0>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            device_type = "pci";
> +            ranges;
> +            bus-range = <0x00 0xff>;
> +        };
> +    };
> +...
