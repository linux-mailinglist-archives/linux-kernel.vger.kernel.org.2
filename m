Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE76344F009
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 00:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhKLXi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 18:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhKLXi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 18:38:26 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79FFC061766;
        Fri, 12 Nov 2021 15:35:34 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x15so43904345edv.1;
        Fri, 12 Nov 2021 15:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KufwM5mCfLvkfHB9L44xSjMiP/J9vtXWW8H7fEHQm8A=;
        b=VeeEX+hb8Q38dXiCudlk+Gtk+dN0Ujc2jObM5z0Zu2SXCSFpjE+MXTtB4Qo0nEDchJ
         hHK17DghW93X+xDr1x9hhXh9EQzkKHAWs7585/CmXjUfQfv0K0gedX1ypz4VGxzRaBju
         MNd78yGv0cRc2wHFw/5rqiKOCypPFU8yw9eCFRt7GSfyC52wN208EwHmvCkrF5S0TjRv
         wc0bGTuEFsXuxZdwEd93CAn35xjfHCxk9Y1I+diNuVlJXdoZIObfpl5PHpU4q7LIKeJN
         DjDwq/rnl44OkJ9wFIBQ6aZLswBKzXnQA4+GFGGH4grVGY0p0xBzZpaYh5FDQotolV0T
         enAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KufwM5mCfLvkfHB9L44xSjMiP/J9vtXWW8H7fEHQm8A=;
        b=kK/XZAeL3HpSpV9yM6mRcAqfOidBoAU38VgNMm5/wEb2FD+3viHOTJMS9vljuBJ3nO
         FHMsj5VPO7mgl3zBOiE/jI6+0KZswtKgqSn/YfrzZrxnDJRbGxavKkkLcSOTvbytzWrs
         tPsNu3Vnue82Kdmm9apOajFa8EfHyj+wu9tVZZO2wn9qI4cb9LQNtnBy3gRt1b5bWUvw
         fFH/vkqHHZgbt4S6llxpON3IIGCHZP0T/2DkdoNPOAWHwMQD/XLSTnY3Ys1PG/3UhwN+
         UGn/m/YtodAn7XIwhwRB3jtnp8gRZErQZL+vBM+BDDW7uWm0EqNnXMFWHOoxkSr3goPx
         eaDw==
X-Gm-Message-State: AOAM532bV026CYIf31Gq77JXm1ecGyjx+U31Kpnw8JhAxRr/J28MfOw+
        B1Dzb1X5ERx6e0xptwHFT0P4jBwjvZ6KioK76lU=
X-Google-Smtp-Source: ABdhPJzTTsMoDpRSN2aarqfhlwtnbIjFTA6/TzvWdZgQNjkCsqJd34bqQjQ3nyaZd+w5tZUbJ2cjv/b3kJ/6Oq/d2I0=
X-Received: by 2002:aa7:d4d4:: with SMTP id t20mr26681856edr.374.1636760132643;
 Fri, 12 Nov 2021 15:35:32 -0800 (PST)
MIME-Version: 1.0
References: <20211104161804.587250-1-aford173@gmail.com> <20211104161804.587250-5-aford173@gmail.com>
 <YY7kg3GC5lnX7TgW@robh.at.kernel.org>
In-Reply-To: <YY7kg3GC5lnX7TgW@robh.at.kernel.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 12 Nov 2021 18:35:20 -0500
Message-ID: <CAHCN7xJHx5eDt3iMH3vtDrL=zgvHq3LtLxe_8XUSjSJR4b1Fug@mail.gmail.com>
Subject: Re: [PATCH V3 4/9] dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
To:     Rob Herring <robh@kernel.org>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        ariel.dalessandro@collabora.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 5:02 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Nov 04, 2021 at 11:17:59AM -0500, Adam Ford wrote:
> > Add the DT binding for the i.MX8MN DISP blk-ctrl.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
> > new file mode 100644
> > index 000000000000..fbeaac399c50
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
> > @@ -0,0 +1,97 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP i.MX8MN DISP blk-ctrl
> > +
> > +maintainers:
> > +  - Lucas Stach <l.stach@pengutronix.de>
> > +
> > +description:
> > +  The i.MX8MN DISP blk-ctrl is a top-level peripheral providing access to
> > +  the NoC and ensuring proper power sequencing of the display and MIPI CSI
> > +  peripherals located in the DISP domain of the SoC.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: fsl,imx8mn-disp-blk-ctrl
> > +      - const: syscon
>
> Are there other functions in this block? If so, what?

This is similar to the i.MX8M Mini.  From what I can tell, there are
some extra clock and reset registers that are not associated with
their respective blocks. The main power domain controller called GPCv2
partially enables the power domains, but there is some ping-pong
between that IP block and this one,

>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#power-domain-cells':
> > +    const: 1
> > +
> > +  power-domains:
> > +    minItems: 5
> > +    maxItems: 5
> > +
> > +  power-domain-names:
> > +    items:
> > +      - const: bus
> > +      - const: isi
> > +      - const: lcdif
> > +      - const: mipi-dsi
> > +      - const: mipi-csi
> > +
> > +  clocks:
> > +    minItems: 11
> > +    maxItems: 11
> > +
> > +  clock-names:
> > +    items:
> > +      - const: disp_axi
> > +      - const: disp_apb
> > +      - const: disp_axi_root
> > +      - const: disp_apb_root
> > +      - const: lcdif-axi
> > +      - const: lcdif-apb
> > +      - const: lcdif-pix
> > +      - const: dsi-pclk
> > +      - const: dsi-ref
> > +      - const: csi-aclk
> > +      - const: csi-pclk
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - power-domains
> > +  - power-domain-names
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/imx8mn-clock.h>
> > +    #include <dt-bindings/power/imx8mn-power.h>
> > +
> > +    disp_blk_ctl: blk_ctrl@32e28000 {
> > +      compatible = "fsl,imx8mn-disp-blk-ctrl", "syscon";
> > +      reg = <0x32e28000 0x100>;
> > +      power-domains = <&pgc_dispmix>, <&pgc_dispmix>,
> > +                      <&pgc_dispmix>, <&pgc_mipi>,
> > +                      <&pgc_mipi>;
> > +      power-domain-names = "bus", "isi", "lcdif", "mipi-dsi",
> > +                           "mipi-csi";
>
> This looks odd. These are the same power domains this node provides.

It is odd, but  I'll try to explain it the best I can.

When this SoC was developed, there were a few additional registers
placed into this IP block that control other IP blocks, and ping-pong
with the main power domain controller to make the various IP blocks
work.

GPCv2, the main power domain controller attempts to enable the domain,
but it has to enable the bus clock and clear the bus reset from this
IP block because neither the reset nor the clock enable were placed
into reset or clock IP blocks.

For example,  when the mipi-csi controller needs to come up, it needs
to request the power domain from disp-blk-ctrl IP block.  The blk-ctrl
block first requests the pgc_mipi power domain.  The GPC ping-pongs
the blk-ctrl which has to set or clear registers so the GPC can finish
its job.  One the GPC has finished its part the blk-ctrl then enables
the clock and reset that controls the csi.  This same is true for
several quasi-related items like DSI, CSI, and LCDIF.

The items listed in the power-domains are from the GPC, and the items
in the power-domain-names are inside the blk-ctrl.  When an item needs
a power domain from the blk-ctrl, the corresponding GPC power domain
must also be referenced.

In order to enable some of the registers, the blk-ctrl IP block also
needs to enable some additional clocks or the system can hang.

Lucas Stach wrote the original driver and might be able to better
explain how it works on the Mini, but the Nano behaves the same way
with different bits in the regisers.


>
> > +      clocks = <&clk IMX8MN_CLK_DISP_AXI>,
> > +               <&clk IMX8MN_CLK_DISP_APB>,
> > +               <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
> > +               <&clk IMX8MN_CLK_DISP_APB_ROOT>,
> > +               <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
> > +               <&clk IMX8MN_CLK_DISP_APB_ROOT>,
> > +               <&clk IMX8MN_CLK_DISP_PIXEL_ROOT>,
> > +               <&clk IMX8MN_CLK_DSI_CORE>,
> > +               <&clk IMX8MN_CLK_DSI_PHY_REF>,
> > +               <&clk IMX8MN_CLK_CSI1_PHY_REF>,
> > +               <&clk IMX8MN_CLK_CAMERA_PIXEL_ROOT>;
> > +       clock-names = "disp_axi", "disp_apb", "disp_axi_root", "disp_apb_root",
> > +                     "lcdif-axi", "lcdif-apb", "lcdif-pix", "dsi-pclk",
> > +                     "dsi-ref", "csi-aclk", "csi-pclk";
> > +       #power-domain-cells = <1>;
> > +    };
> > --
> > 2.32.0
> >
> >
