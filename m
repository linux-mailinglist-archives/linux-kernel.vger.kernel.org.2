Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F6B30CCD6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbhBBUKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:10:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240352AbhBBUHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:07:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B75064F87;
        Tue,  2 Feb 2021 20:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612296417;
        bh=177W24pGzoFswqH9nTZaROa3v08ehN0O15ITVWWoTA8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X3YnornFgmRRBVzILwDg1N8sB8wXFA7S1v9nsp83crJauh6vb6xxteVp6Kqq+qEy4
         FmirK5uSR3NToqSrNRpy3xuEdzdCMvGt7WUdHNTGgaHIjaXO5+fG63FlcryheTPTXH
         Wb5P79FDuM65nY31V5WUdrVoshCLONQACZtl81vZjJcA2n81tY4stjhTpl9MQYDqH7
         i5dRRNzbZy1L9RkQHU+vBI/qzpM/VOuD0pW/maAN0dxFO3IOUXay4aa5Us1Kl0/9L8
         nkytDB/iSk7QBOohxDGoA09zisdqbkw24MyrlYwQdlqtADCJ/b4JgiKN+PYvLo1gFX
         Sn3YmjyvNCWBQ==
Received: by mail-ej1-f43.google.com with SMTP id rv9so31875196ejb.13;
        Tue, 02 Feb 2021 12:06:57 -0800 (PST)
X-Gm-Message-State: AOAM532Z5YfYmF4Sft2uwp2l3VKAycknZ53QMbkEYnPeH0Aq0O+S/FEX
        GnGJMM5/DU8nkUkS2JvF3wO96iWRCrJp6ZjYoA==
X-Google-Smtp-Source: ABdhPJy+Ssy3SHqDPADh0XT4vUCeL4af4/u7PEu8tQ8UODl2UpPpxxaQvEaUlpa6MrTAVJMm3ZaMnyQ921p4Sq6+l5k=
X-Received: by 2002:a17:906:25c4:: with SMTP id n4mr24229292ejb.359.1612296415627;
 Tue, 02 Feb 2021 12:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20210201194105.32673-1-jbx6244@gmail.com> <d4626d79-06ae-6abc-6ab4-6425fc344180@gmail.com>
In-Reply-To: <d4626d79-06ae-6abc-6ab4-6425fc344180@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 2 Feb 2021 14:06:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLb65dM1QvOCVqztc_x9YQMkbwR_eNdnzyCoBJv0DA0Tw@mail.gmail.com>
Message-ID: <CAL_JsqLb65dM1QvOCVqztc_x9YQMkbwR_eNdnzyCoBJv0DA0Tw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: usb: convert rockchip,dwc3.txt to yaml
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     "heiko@sntech.de" <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 2:46 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Hi Rob,
>
> See questions below.
>
> Kind regards,
>
> Johan Jonker
>
> On 2/1/21 8:41 PM, Johan Jonker wrote:
> > In the past Rockchip dwc3 usb nodes were manually checked.
> > With the conversion of snps,dwc3.yaml as common document
> > we now can convert rockchip,dwc3.txt to yaml as well.
> >
> > Added properties for rk3399 are:
> >   resets
> >   reset-names
> >
> > Generic properties that are now also filtered:
> >   "#address-cells"
> >   "#size-cells"
> >   ranges
> >
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> >  .../devicetree/bindings/usb/rockchip,dwc3.txt      |  56 -----------
> >  .../devicetree/bindings/usb/rockchip,dwc3.yaml     | 107 +++++++++++++++++++++
> >  2 files changed, 107 insertions(+), 56 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
> >  create mode 100644 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
> > deleted file mode 100644
> > index 945204932..000000000
> > --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
> > +++ /dev/null
> > @@ -1,56 +0,0 @@
> > -Rockchip SuperSpeed DWC3 USB SoC controller
> > -
> > -Required properties:
> > -- compatible:        should contain "rockchip,rk3399-dwc3" for rk3399 SoC
> > -- clocks:    A list of phandle + clock-specifier pairs for the
> > -             clocks listed in clock-names
> > -- clock-names:       Should contain the following:
> > -  "ref_clk"  Controller reference clk, have to be 24 MHz
> > -  "suspend_clk"      Controller suspend clk, have to be 24 MHz or 32 KHz
> > -  "bus_clk"  Master/Core clock, have to be >= 62.5 MHz for SS
> > -             operation and >= 30MHz for HS operation
> > -  "grf_clk"  Controller grf clk
> > -
> > -Required child node:
> > -A child node must exist to represent the core DWC3 IP block. The name of
> > -the node is not important. The content of the node is defined in dwc3.txt.
> > -
> > -Phy documentation is provided in the following places:
> > -Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml - USB2.0 PHY
> > -Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt     - Type-C PHY
> > -
> > -Example device nodes:
> > -
> > -     usbdrd3_0: usb@fe800000 {
> > -             compatible = "rockchip,rk3399-dwc3";
> > -             clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
> > -                      <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_GRF>;
> > -             clock-names = "ref_clk", "suspend_clk",
> > -                           "bus_clk", "grf_clk";
> > -             #address-cells = <2>;
> > -             #size-cells = <2>;
> > -             ranges;
> > -             usbdrd_dwc3_0: dwc3@fe800000 {
> > -                     compatible = "snps,dwc3";
> > -                     reg = <0x0 0xfe800000 0x0 0x100000>;
> > -                     interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> > -                     dr_mode = "otg";
> > -             };
> > -     };
> > -
> > -     usbdrd3_1: usb@fe900000 {
> > -             compatible = "rockchip,rk3399-dwc3";
> > -             clocks = <&cru SCLK_USB3OTG1_REF>, <&cru SCLK_USB3OTG1_SUSPEND>,
> > -                      <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_GRF>;
> > -             clock-names = "ref_clk", "suspend_clk",
> > -                           "bus_clk", "grf_clk";
> > -             #address-cells = <2>;
> > -             #size-cells = <2>;
> > -             ranges;
> > -             usbdrd_dwc3_1: dwc3@fe900000 {
> > -                     compatible = "snps,dwc3";
> > -                     reg = <0x0 0xfe900000 0x0 0x100000>;
> > -                     interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> > -                     dr_mode = "otg";
> > -             };
> > -     };
> > diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> > new file mode 100644
> > index 000000000..681086fa6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> > @@ -0,0 +1,107 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/rockchip,dwc3.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip SuperSpeed DWC3 USB SoC controller
> > +
> > +maintainers:
> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - rockchip,rk3399-dwc3
> > +
> > +  clocks:
> > +    items:
> > +      - description:
> > +          Controller reference clock, must to be 24 MHz
> > +      - description:
> > +          Controller suspend clock, must to be 24 MHz or 32 KHz
> > +      - description:
> > +          Master/Core clock, must to be >= 62.5 MHz for SS
> > +          operation and >= 30MHz for HS operation
> > +      - description:
> > +          Controller aclk_usb3_rksoc_axi_perf clock
> > +      - description:
> > +          Controller aclk_usb3 clock
> > +      - description:
> > +          Controller grf clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: ref_clk
> > +      - const: suspend_clk
> > +      - const: bus_clk
>
> > +      - const: aclk_usb3_rksoc_axi_perf
> > +      - const: aclk_usb3
>
> This was not in the original document, but is needed to compile.

Okay, fine to add it. That's common.

> > +      - const: grf_clk
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  reset-names:
> > +    const: usb3-otg
> > +
> > +  "#address-cells":
> > +    const: 2
> > +
> > +  "#size-cells":
> > +    const: 2
> > +
> > +  ranges: true
> > +
> > +patternProperties:
> > +  "^usb@[a-f0-9]+$":
> > +    type: object
> > +
> > +    $ref: "snps,dwc3.yaml"
> > +
> > +    description:
> > +      A child node must exist to represent the core DWC3 IP block.
> > +      The content of the node is defined in snps,dwc3.yaml.
> > +
> > +      Phy documentation is provided in the following places.
> > +
> > +      USB2.0 PHY
> > +      Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> > +
> > +      Type-C PHY
> > +      Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> > +
> > +    unevaluatedProperties: false
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - clocks
> > +  - clock-names
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - ranges
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/rk3399-cru.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>
> > +    usbdrd3_0: usb@fe800000 {
>
> The rk3399 has 2 dwc3 usb nodes. When we remove @fe800000 and @fe900000
> in the rk3399.dtsi it complains about 2 identical usb root nodenames.
> For this example to pass change to:
>
> usbdrd3_0: usb ??
>
> What to do with it in the dtsi??

The correct thing is really that there shouldn't have been 2 nodes in
the first place. I think the first DWC3 user had some wrapper
registers where separate nodes kind of make sense. But just for
clocks, not really needed.

> > +      compatible = "rockchip,rk3399-dwc3";
> > +      clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
> > +               <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
> > +               <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
> > +      clock-names = "ref_clk", "suspend_clk",
> > +                    "bus_clk", "aclk_usb3_rksoc_axi_perf",
> > +                    "aclk_usb3", "grf_clk";
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
>
> > +      ranges;
>
> Ranges generates notifications. Could you advise if that is needed in
> this dwc3 usb context and rk3399.dtsi or should it be removed?

A non-empty ranges will solve all your problems:

ranges = <0 0xfe800000 0 0xfe800000 0 0x100000>;

>
> > +      usbdrd_dwc3_0: usb@fe800000 {
> > +        compatible = "snps,dwc3";
> > +        reg = <0x0 0xfe800000 0x0 0x100000>;
> > +        interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> > +        dr_mode = "otg";
> > +      };
> > +    };
> >
>
