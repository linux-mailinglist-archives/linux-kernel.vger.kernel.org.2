Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6E451997
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 00:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353873AbhKOXY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 18:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244910AbhKOTSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:18:14 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D168DC0432EB
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:06:19 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id o4so15674146pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XcuIbwHU9nz+0j0x+IpAIYzZkfvXihnimoqaJ+7v6sU=;
        b=OvKgRgRyY/jrIz5QmoPBA80Ta7/77c/FUmt9OMLEe3NwljZ9zM7SwtUESrDdYnm2RT
         facPJxLC1cN5gceWVBulTApuJM/5QZq23Ex8+F9bVXn8E1pKvQLFbpRleupqrerNig2/
         IhvlHmUu46fTsviE2X9MgYvoLmN9BvYGXkX9AbkvuUEyKrWXEU3/bIo8/M0DKC9SquVv
         GuXMeQoeJ1OmFsxA3awbOhIN7Rn+U6LATAlM2d2EZ30oXMIPXWTBfQq0YBg+L9KkI6i1
         6wfOEYA+IsVub3H/I8GQ8Wo2dudShEhzuCXccmwCSvleuKK7JbJfUHLLelHmLdpI4dsz
         n3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XcuIbwHU9nz+0j0x+IpAIYzZkfvXihnimoqaJ+7v6sU=;
        b=a1EsNJfWP4basAGFCdF64IKEUnv2Vcb/l8y6C8GbAzjiZHx53cemFCMVUDx1jOjp9R
         HXABwlrGvwH1LgxVOQWIBYpY6g9jqdYgS2yu3OXKJLHBZEPZp/scWIca/64+nHx2+A1O
         rs4o9UxmWHXEpLJb3XW44g7iq4RUSNBbaSZhFJdZ7QupT5ciaVPgxLrAx6h8DmjrjRHT
         O6Ef9UxBeoiLbdFyfAeiRrlROUcq5IzFacnLrSWa79vkJO6AZUOqywLU5ZciVvTaD0Sz
         VRYB0/qOBWfSww4ZDma+NyQpe/5wiU8OgFbdNyNEH88ObgmxpI/Wwx+e+8bvgLLpUjHq
         HR9A==
X-Gm-Message-State: AOAM531pE6uUYDOXNkro81e36zJXApUBUNR6R3EOLJzAfb6CaHoY5rEc
        EPkPtxgm+loZ1nPz1OlzNuM079rDyuL+CJuHtj6uIg==
X-Google-Smtp-Source: ABdhPJzA6dxW70QSrys6sNDGFF4HIa714y6DO3oaBRIh5ejhllvNEK7cKHonADvkvKxsjVye1+yeKSSBqDeO7Wgtp4U=
X-Received: by 2002:a63:5f56:: with SMTP id t83mr523178pgb.432.1636999577749;
 Mon, 15 Nov 2021 10:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20211112183311.9556-1-tharvey@gateworks.com> <YZIsa6F0ijVRDvAV@pendragon.ideasonboard.com>
In-Reply-To: <YZIsa6F0ijVRDvAV@pendragon.ideasonboard.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 15 Nov 2021 10:06:06 -0800
Message-ID: <CAJ+vNU1d2REruejA2nX=PQmm1Leps6NX5csjmLwZe2y1ST7Kng@mail.gmail.com>
Subject: Re: [RFC] arm64: dts: imx8mm: add imx8mm-venice-gw73xx-0x-imx219 overlay
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Adam Ford <aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 1:46 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Tim,
>
> Thank you for the patch.

Laurent,

Thanks for the review.

>
> On Fri, Nov 12, 2021 at 10:33:11AM -0800, Tim Harvey wrote:
> > Add support for the RaspberryPi Camera v2 module attached to an
> > imx8mm-venice-gw73xx-0x.
> >
> > This camera is an IMX219 8MP module:
> >  - https://datasheets.raspberrypi.com/camera/camera-v2-schematics.pdf
> >  - has its own on-board 24MHz osc so no clock required from baseboard
> >  - pin 11 enables 1.8V and 2.8V LDO which is connected to
> >    GW73xx MIPI_GPIO4 (IMX8MM GPIO1_IO1). The imx219 driver does not
> >    support powerdown-gpios therefore we use gpio1 via reset-gpios
>
> How about modeling this with a GPIO-controlled regulator, and connecting
> it to the IMX219 through the *-supply properties ?

Sure... that is probably more appropriate.

>
> > Support is added via a device-tree overlay.
> >
> > The IMX219 supports RAW8/RAW10 image formats.
> >
> > Example usage:
> >  media-ctl --links "'imx219 2-0010':0->'imx7-mipi-csis.0':0[1]"
> >  media-ctl -v -V "'imx219 2-0010':0 [fmt:SRGGB8/640x480 field:none]"
> >  media-ctl -v -V "'csi':0 [fmt:SRGGB8/640x480 field:none]"
> >  gst-launch-1.0 -v v4l2src num-buffers=1 ! \
> >        video/x-bayer,format=rggb,width=640,height=480,framerate=30/1 ! \
> >        bayer2rgb ! jpegenc ! filesink location=test.jpg
> >  gst-launch-1.0 -v v4l2src num-buffers=300 ! \
> >        video/x-bayer,format=rggb,width=640,height=480,framerate=30/1 ! \
> >        bayer2rgb ! jpegenc ! avimux ! filesink location=test.avi
> >
> > This patch depends on 'arm64: dts: imx8mm: Add CSI nodes' at:
> > https://lore.kernel.org/all/20211106155427.753197-2-aford173@gmail.com/
> >
> > This is an RFC as I am not aware of other dt fragments/overlays being
> > added to the kernel yet. I do get a few warnings but I believe they are
> > because this is a fragment:
>
> I like the idea of centralizing DT overlays. I'm not sure where to best
> store them, and I don't know if this has been discussed already, but the
> kernel supports compilation of DT overlays, so I assume it's meant to be
> used. Rob may have an opinion on this.

My understanding is that DT overlays are typically .dtbo vs .dtb but I
noticed the kernel Makefiles did not have support for this. I do feel
the DT overlays should be in the kernel tree as they apply to the DT's
there as well.

>
> What we're really missing is a way to parametrize DT overlays, so that a
> single overlay file could be used with different hosts. Discussions
> about DT connectors have died out as far as I know, but they were aiming
> at overlays being applied at runtime. I'm not aware of a similar effort
> to standardize connectors when applying overlays in the boot loader. The
> Raspberry Pi boot loader has a proprietary implementation of this
> feature, which is very handy.
>

I like the idea as this particular overlay would also apply to
imx8mm-venice-gw72xx-0x and I would otherwise have to have a duplicate
of it for that board.

The other reason I want to solve this with a DT overlay is that both
'imx8mm-venice-gw73xx-0x' and 'imx8mm-venice-gw72xx-0x' have the
following DT overlays that I'm working on:
- rs232-rts (not sure the best name for this but the default is to
have UART2/UART4 TX/RX RS232 only and this DT overlay would drop UART4
and make UART2 have RTS/CTS hardware flow control instead)
- rs485 (would drop UART4 and make UART2 rs485 half duplex)
- rs422 (would drop UART4 and make UART2 rs422 full duplex)
- rpidsi (not sure the best name for this; would add support for
RaspberryPi 5in and 7in DSI touchscreen displays)
- imx219 (this patch; not sure the best name for this; would add
support for RaspberryPi v2.0 camera sensor)

All of the above overlays would be available for both boards which
would create a lot of combinations if I were to create upper level non
overlay dts files for them.

Best regards,

Tim

> > $ make DTC_FLAGS="-@" dtbs W=1
> >   DTC
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts:33.3-16:
> > Warning (reg_format): /fragment@2/__overlay__/sensor@10:reg: property
> > has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts:52.10-57.5:
> > Warning (unit_address_vs_reg): /fragment@3/__overlay__/ports/port@0:
> > node has a unit name, but no reg or ranges property
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
> > Warning (pci_device_reg): Failed prerequisite 'reg_format'
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
> > Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
> > Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
> > Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
> > Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts:29.20-46.4:
> > Warning (avoid_default_addr_size): /fragment@2/__overlay__/sensor@10:
> > Relying on default #address-cells value
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts:29.20-46.4:
> > Warning (avoid_default_addr_size): /fragment@2/__overlay__/sensor@10:
> > Relying on default #size-cells value
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
> > Warning (avoid_unnecessary_addr_size): Failed prerequisite
> > 'avoid_default_addr_size'
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
> > Warning (unique_unit_address): Failed prerequisite
> > 'avoid_default_addr_size'
> >
> > The intended use of a dt fragement like this is to apply it in boot
> > firmware before booting the kernel such as:
> >
> > u-boot=> load mmc 0:1 $fdt_addr_r imx8mm-venice-gw73xx-0x.dtb
> > u-boot=> fdt addr $fdt_addr_r
> > u-boot=> fdt resize
> > u-boot=> load mmc 0:1 $loadaddr imx8mm-venice-gw73xx-0x-imx219.dtb
> > u-boot=> fdt appply $loadaddr
> > u-boot=> load mmc 0:1 $kernel_addr_r Image
> > u-boot=> booti $kernel_addr_r - $fdt_addr_r
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile        |  1 +
> >  .../imx8mm-venice-gw73xx-0x-imx219.dts        | 67 +++++++++++++++++++
> >  2 files changed, 68 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > index db9e36ebe932..cc00ac78dbc6 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -42,6 +42,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
> > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-imx219.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7901.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7902.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts
> > new file mode 100644
> > index 000000000000..6f692ba24a31
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts
> > @@ -0,0 +1,67 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2021 Gateworks Corporation
> > + */
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +
> > +#include "imx8mm-pinfunc.h"
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +&{/} {
> > +     compatible = "gw,imx8mm-gw73xx-0x", "fsl,imx8mm";
> > +
> > +     cam24m: cam24m {
> > +             compatible = "fixed-clock";
> > +             #clock-cells = <0>;
> > +             clock-frequency = <24000000>;
> > +             clock-output-names = "cam24m";
> > +     };
> > +};
> > +
> > +&csi {
> > +     status = "okay";
> > +};
> > +
> > +&i2c3 {
> > +     imx219: sensor@10 {
> > +             compatible = "sony,imx219";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_imx219>;
> > +             reg = <0x10>;
> > +             clocks = <&cam24m>;
> > +             reset-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> > +
> > +             port {
> > +                     /* MIPI CSI-2 bus endpoint */
> > +                     imx219_to_mipi_csi2: endpoint {
> > +                             remote-endpoint = <&imx8mm_mipi_csi_in>;
> > +                             clock-lanes = <0>;
> > +                             data-lanes = <1 2>;
> > +                             link-frequencies = /bits/ 64 <456000000>;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&mipi_csi {
> > +     status = "okay";
> > +     ports {
> > +             port@0 {
> > +                     imx8mm_mipi_csi_in: endpoint {
> > +                             remote-endpoint = <&imx219_to_mipi_csi2>;
> > +                             data-lanes = <1 2>;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&iomuxc {
> > +     pinctrl_imx219: imx219grp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1       0x41
> > +             >;
> > +     };
> > +};
>
> --
> Regards,
>
> Laurent Pinchart
