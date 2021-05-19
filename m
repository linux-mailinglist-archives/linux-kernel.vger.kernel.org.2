Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5069A3884A2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 04:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhESCDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 22:03:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234117AbhESCDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 22:03:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59C08613AF;
        Wed, 19 May 2021 02:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621389744;
        bh=eSW+Cl/e5KBTkRF2vqSMzB+oYnXIhHnXZ1epqm7AOXA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sj0fwnl/qa9t+tA3iSdZ6uUDjWUESH7TT0/l8YxKOKXvf2jEbOQ5V1K4+LbVUQD7Z
         JUb/rJ6FHwt1S19sy9zSfxmj/esu/ZtaGXuS/L9NVINhjZQuBClzt0C7AU1p5jotwP
         F8vVE21abjTkiEgMNi3Y4PJzsAmY9xVBAuX5UMO3mispq7qiwrBeHMMIIXn0O1N2Z1
         GVPoaus+gWt2WdMgMG+HLC1SMmoe5hx1HoxKHSNBUjnz1wXW1Lpka5WxAXMDaFMMrc
         u+ZlybJmbjsMjgRM5PraR8BAACjWa3rzNrzx7pp1fIFsivxftZ7k0QDaoHBsHuLHOJ
         S5qSxsdOf9Quw==
Received: by mail-ed1-f43.google.com with SMTP id h16so13461299edr.6;
        Tue, 18 May 2021 19:02:24 -0700 (PDT)
X-Gm-Message-State: AOAM533eDyCA7xkYJhLkcA7cQyOcVJafFMcloFzr40DgNlP4zDKNJ4QJ
        sUQg6JNU1J8dGJSEIM0ITxbRdCW8vQE3b9MVrg==
X-Google-Smtp-Source: ABdhPJzv1gE2GvBbkp8kK7JhtqtZFIFNcUAYatbCykH5Qchx71BpP2RwhXApwP8e2nkcie0Kdo6hxR4uYvFdlH2yXpw=
X-Received: by 2002:a50:c446:: with SMTP id w6mr10697786edf.62.1621389742843;
 Tue, 18 May 2021 19:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210518232858.1535403-1-robh@kernel.org> <20210518232858.1535403-6-robh@kernel.org>
 <YKRoqaQaz9QSMVqg@pendragon.ideasonboard.com>
In-Reply-To: <YKRoqaQaz9QSMVqg@pendragon.ideasonboard.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 May 2021 21:02:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJLwC-HLAxX8xJK7DfBeNgPsKDJzreDSem7-1CMA8wAEg@mail.gmail.com>
Message-ID: <CAL_JsqJLwC-HLAxX8xJK7DfBeNgPsKDJzreDSem7-1CMA8wAEg@mail.gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: i2c: i2c-mux-pca954x: Convert to DT schema
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Roger Quadros <rogerq@ti.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 8:23 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Rob,
>
> Thank you for the patch.
>
> On Tue, May 18, 2021 at 06:28:57PM -0500, Rob Herring wrote:
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/i2c/i2c-mux-pca954x.txt          |  74 ------------
> >  .../bindings/i2c/i2c-mux-pca954x.yaml         | 106 ++++++++++++++++++
> >  2 files changed, 106 insertions(+), 74 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> > deleted file mode 100644
> > index 9f3f3eb67e87..000000000000
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> > +++ /dev/null
> > @@ -1,74 +0,0 @@
> > -* NXP PCA954x I2C bus switch
> > -
> > -The driver supports NXP PCA954x and PCA984x I2C mux/switch devices.
> > -
> > -Required Properties:
> > -
> > -  - compatible: Must contain one of the following.
> > -    "nxp,pca9540",
> > -    "nxp,pca9542",
> > -    "nxp,pca9543",
> > -    "nxp,pca9544",
> > -    "nxp,pca9545",
> > -    "nxp,pca9546", "nxp,pca9846",
> > -    "nxp,pca9547", "nxp,pca9847",
> > -    "nxp,pca9548", "nxp,pca9848",
> > -    "nxp,pca9849"
> > -
> > -  - reg: The I2C address of the device.
> > -
> > -  The following required properties are defined externally:
> > -
> > -  - Standard I2C mux properties. See i2c-mux.txt in this directory.
> > -  - I2C child bus nodes. See i2c-mux.txt in this directory.
> > -
> > -Optional Properties:
> > -
> > -  - reset-gpios: Reference to the GPIO connected to the reset input.
> > -  - idle-state: if present, overrides i2c-mux-idle-disconnect,
> > -    Please refer to Documentation/devicetree/bindings/mux/mux-controller.yaml
> > -  - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
> > -    children in idle state. This is necessary for example, if there are several
> > -    multiplexers on the bus and the devices behind them use same I2C addresses.
> > -  - interrupts: Interrupt mapping for IRQ.
> > -  - interrupt-controller: Marks the device node as an interrupt controller.
> > -  - #interrupt-cells : Should be two.
> > -    - first cell is the pin number
> > -    - second cell is used to specify flags.
> > -    See also Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> > -
> > -Example:
> > -
> > -     i2c-switch@74 {
> > -             compatible = "nxp,pca9548";
> > -             #address-cells = <1>;
> > -             #size-cells = <0>;
> > -             reg = <0x74>;
> > -
> > -             interrupt-parent = <&ipic>;
> > -             interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
> > -             interrupt-controller;
> > -             #interrupt-cells = <2>;
> > -
> > -             i2c@2 {
> > -                     #address-cells = <1>;
> > -                     #size-cells = <0>;
> > -                     reg = <2>;
> > -
> > -                     eeprom@54 {
> > -                             compatible = "atmel,24c08";
> > -                             reg = <0x54>;
> > -                     };
> > -             };
> > -
> > -             i2c@4 {
> > -                     #address-cells = <1>;
> > -                     #size-cells = <0>;
> > -                     reg = <4>;
> > -
> > -                     rtc@51 {
> > -                             compatible = "nxp,pcf8563";
> > -                             reg = <0x51>;
> > -                     };
> > -             };
> > -     };
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
> > new file mode 100644
> > index 000000000000..82d9101098c7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
> > @@ -0,0 +1,106 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP PCA954x I2C bus switch
> > +
> > +maintainers:
> > +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > +
> > +description:
> > +  The binding supports NXP PCA954x and PCA984x I2C mux/switch devices.
> > +
> > +allOf:
> > +  - $ref: /schemas/i2c/i2c-mux.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nxp,pca9540
> > +      - nxp,pca9542
> > +      - nxp,pca9543
> > +      - nxp,pca9544
> > +      - nxp,pca9545
> > +      - nxp,pca9546
> > +      - nxp,pca9547
> > +      - nxp,pca9548
> > +      - nxp,pca9849
>
> I'd put this entry last to keep them alphabetically sorted.

Sigh, that was my intent...

> While at it, could you add nxp,pca9646 as the driver supports it ?

Sure.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!
