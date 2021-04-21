Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6E93664FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 07:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhDUFpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 01:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhDUFpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 01:45:30 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07603C06174A;
        Tue, 20 Apr 2021 22:44:57 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id k25so41369254oic.4;
        Tue, 20 Apr 2021 22:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U7V0MlLQiJe5sshBFw+/s4JiO4Nt98J/TU5pdZXAe00=;
        b=R/N6y1bEgi/d7JlhxRhAcZ8KPKbypTLeHLworeIlhnFmrqNIZbjHmok1c0Pwmjpoo4
         Vpe2mM94dBtm4YgnF25/n5JYhaoCEYcuRGwa2LEyRoRUZ4Ht91QZmOu2UbRH7AU27qs0
         ZyO4891HEsvXW9LiMPGmUnjFVPceZbeiBDhWAk1E6hrQS370OwmF2UQM+sRJpxgd27YF
         IvpjnvYF6KrLL3o35BMYJwwjEjywqVhYT9tLAgq7T+2hYtotm01/tawpR2minoxzqMCB
         /SRbyDe8kqAzekEc+mWTlnsG8dANeKJNbBHGMjSIBgxKCHp1Y+cV/pfxdY33AjnuCts5
         b+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U7V0MlLQiJe5sshBFw+/s4JiO4Nt98J/TU5pdZXAe00=;
        b=AJKOfyvK/O/PVW1uRPbSWCT1mYpQeQgZ8n4L7I5GRdc9NzI7lvUvKrLDKtTuOD8tpk
         yqC2sGQoonRmA1j1DZpuW2iPeaoqGeEv68+NBVFWxvO50Nc1rliAPE80knpD1/VhyLx3
         Rz2iKJ0i0h7FDXKqJV3TnQROMvG6nKuh4WSgrzoVvG8IZlqr1T7g4ISeulQ9WSBcUUXO
         vjaITNHClxWVjhXjCkez3M3lyuQgQEIR7dkDlGNIwGGWgFLUSyhGJsAqPGgKIUHvJL2v
         IjTks9jsFpjPe0uw1VZ/SsgRybSvzN9LldHBa2fQeeDrKJF3v7PN+bno97B6XTI5mcZ4
         BTFw==
X-Gm-Message-State: AOAM531T9yIg7urSC8GEzDTO+jeIQD9pdBRQ/esJ5FFLHaxMQnfs+iYW
        RGcCjuQDw0M+Mo/n3fakGxEWKw267Y/Zq9vhcY/frQjtx3uPVw==
X-Google-Smtp-Source: ABdhPJxT/svrkD7zGz8HB7KxMh2+pkpFs+0Rzt5aZeyoCxEE6Yvr3yptvBTDiaWpBVFkyHpKq4rlqx6R2RDje52D1xI=
X-Received: by 2002:aca:2813:: with SMTP id 19mr5828893oix.23.1618983896388;
 Tue, 20 Apr 2021 22:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210411081818.26926-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20210411081818.26926-1-sergio.paracuellos@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 21 Apr 2021 07:44:45 +0200
Message-ID: <CAMhs-H8+CjWFB8NB2ZJgC0Bf5s1CAaeGzoOUKML_BPbRb5a=ug@mail.gmail.com>
Subject: Re: [PATCH] staging: mt7621-pci: dt-bindings: update bindings to yaml format
To:     linux-staging@lists.linux.dev
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Sun, Apr 11, 2021 at 10:18 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Update bindings for this pci controller according to the current
> device tree and driver code and prepare them to be mainlined
> porting it to the YAML format.
>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>
> Hi Rob,
>
> Some concerns here. I was not be able to found any case similar to
> this binding where sub-nodes describing each pcie port interface
> are needed. I added them to the 'examples' directly without saying
> nothing about properties in any other place since its properties
> seems to be covered in 'pci-bus.yaml' schema definition. I don't
> know if this is the way, I have copied them to its correct future
> place in Documentation folder and check against schema and I noticed
> I am forced to add 'device_type' property in each subnode because
> schema checker complains that this is mandatory. So I have added
> it and schema is properly being validated:
>
> Before add the 'device_type' in each subnode:
> /home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@0,0: 'device_type' is a required property
> From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
> /home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@1,0: 'device_type' is a required property
> From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
> /home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@2,0: 'device_type' is a required property
> From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
>
> After adding it:
> CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> DTEX    Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dts
> DTC     Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml
> CHECK   Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml
>
> Looks a bit redundant and maybe I am doing somethng wrong...
>
> Thanks in advance for clarification.
>
> Best regards,
>     Sergio Paracuellos

Any comments on this?? I don't know if with this subject not starting
with dt-bindings, patches end up in your review list...

Thanks in advance for your time and sorry for bothering you.

Best regards,
    Sergio Paracuellos
>
>
>  .../mt7621-pci/mediatek,mt7621-pci.txt        | 104 -------------
>  .../mt7621-pci/mediatek,mt7621-pci.yaml       | 144 ++++++++++++++++++
>  2 files changed, 144 insertions(+), 104 deletions(-)
>  delete mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
>  create mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.yaml
>
> diff --git a/drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt b/drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
> deleted file mode 100644
> index 327a68267309..000000000000
> --- a/drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
> +++ /dev/null
> @@ -1,104 +0,0 @@
> -MediaTek MT7621 PCIe controller
> -
> -Required properties:
> -- compatible: "mediatek,mt7621-pci"
> -- device_type: Must be "pci"
> -- reg: Base addresses and lengths of the PCIe subsys and root ports.
> -- bus-range: Range of bus numbers associated with this controller.
> -- #address-cells: Address representation for root ports (must be 3)
> -- pinctrl-names : The pin control state names.
> -- pinctrl-0: The "default" pinctrl state.
> -- #size-cells: Size representation for root ports (must be 2)
> -- ranges: Ranges for the PCI memory and I/O regions.
> -- #interrupt-cells: Must be 1
> -- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties.
> -  Please refer to the standard PCI bus binding document for a more detailed
> -  explanation.
> -- status: either "disabled" or "okay".
> -- resets: Must contain an entry for each entry in reset-names.
> -  See ../reset/reset.txt for details.
> -- reset-names: Must be "pcie0", "pcie1", "pcieN"... based on the number of
> -  root ports.
> -- clocks: Must contain an entry for each entry in clock-names.
> -  See ../clocks/clock-bindings.txt for details.
> -- clock-names: Must be "pcie0", "pcie1", "pcieN"... based on the number of
> -  root ports.
> -- reset-gpios: GPIO specs for the reset pins.
> -
> -In addition, the device tree node must have sub-nodes describing each PCIe port
> -interface, having the following mandatory properties:
> -
> -Required properties:
> -- reg: Only the first four bytes are used to refer to the correct bus number
> -      and device number.
> -- #address-cells: Must be 3
> -- #size-cells: Must be 2
> -- ranges: Sub-ranges distributed from the PCIe controller node. An empty
> -  property is sufficient.
> -- bus-range: Range of bus numbers associated with this port.
> -
> -Example for MT7621:
> -
> -       pcie: pcie@1e140000 {
> -               compatible = "mediatek,mt7621-pci";
> -        reg = <0x1e140000 0x100    /* host-pci bridge registers */
> -               0x1e142000 0x100    /* pcie port 0 RC control registers */
> -               0x1e143000 0x100    /* pcie port 1 RC control registers */
> -               0x1e144000 0x100>;  /* pcie port 2 RC control registers */
> -
> -               #address-cells = <3>;
> -               #size-cells = <2>;
> -
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pcie_pins>;
> -
> -               device_type = "pci";
> -
> -               bus-range = <0 255>;
> -               ranges = <
> -                       0x02000000 0 0x00000000 0x60000000 0 0x10000000 /* pci memory */
> -                       0x01000000 0 0x00000000 0x1e160000 0 0x00010000 /* io space */
> -               >;
> -
> -               #interrupt-cells = <1>;
> -               interrupt-map-mask = <0xF0000 0 0 1>;
> -               interrupt-map = <0x10000 0 0 1 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>,
> -                               <0x20000 0 0 1 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
> -                               <0x30000 0 0 1 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
> -
> -               status = "disabled";
> -
> -               resets = <&rstctrl 24 &rstctrl 25 &rstctrl 26>;
> -               reset-names = "pcie0", "pcie1", "pcie2";
> -               clocks = <&clkctrl 24 &clkctrl 25 &clkctrl 26>;
> -               clock-names = "pcie0", "pcie1", "pcie2";
> -
> -               reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>,
> -                               <&gpio 8 GPIO_ACTIVE_LOW>,
> -                               <&gpio 7 GPIO_ACTIVE_LOW>;
> -
> -               pcie@0,0 {
> -                       reg = <0x0000 0 0 0 0>;
> -                       #address-cells = <3>;
> -                       #size-cells = <2>;
> -                       ranges;
> -                       bus-range = <0x00 0xff>;
> -               };
> -
> -               pcie@1,0 {
> -                       reg = <0x0800 0 0 0 0>;
> -                       #address-cells = <3>;
> -                       #size-cells = <2>;
> -                       ranges;
> -                       bus-range = <0x00 0xff>;
> -               };
> -
> -               pcie@2,0 {
> -                       reg = <0x1000 0 0 0 0>;
> -                       #address-cells = <3>;
> -                       #size-cells = <2>;
> -                       ranges;
> -                       bus-range = <0x00 0xff>;
> -               };
> -       };
> -
> diff --git a/drivers/staging/mt7621-pci/mediatek,mt7621-pci.yaml b/drivers/staging/mt7621-pci/mediatek,mt7621-pci.yaml
> new file mode 100644
> index 000000000000..9c1d05d929a2
> --- /dev/null
> +++ b/drivers/staging/mt7621-pci/mediatek,mt7621-pci.yaml
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
> +
> +  ranges:
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 3
> +
> +  resets:
> +    items:
> +      - description: pcie port 0 reset.
> +      - description: pcie port 1 reset.
> +      - description: pcie port 2 reset.
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
> --
> 2.25.1
>
