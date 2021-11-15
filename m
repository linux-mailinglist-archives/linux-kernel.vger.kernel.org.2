Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626824501A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhKOJtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhKOJtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:49:39 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74E9C061202;
        Mon, 15 Nov 2021 01:46:42 -0800 (PST)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 07BB59CA;
        Mon, 15 Nov 2021 10:46:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1636969601;
        bh=J1KDFRR5Nw0fD54zBrNi/tGxyOwYSiGKhE1xRU8vM3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+zXJBB1Eg266yEUk90TY25PzhDSxcEWk+ONkgG9hsSm9iwS24D1F5O/zquTAe2m/
         E+yKfjuGXogkQhlM/HU5MSioxGS9jymNuJ7DwcUp+IrHKaBJzrS2qyQ7WnIEnWYmkW
         jiNASeiF2eeiTsGspBM8pVct22bbOhkRtotVgn+s=
Date:   Mon, 15 Nov 2021 11:46:19 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adam Ford <aford173@gmail.com>
Subject: Re: [RFC] arm64: dts: imx8mm: add imx8mm-venice-gw73xx-0x-imx219
 overlay
Message-ID: <YZIsa6F0ijVRDvAV@pendragon.ideasonboard.com>
References: <20211112183311.9556-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211112183311.9556-1-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

Thank you for the patch.

On Fri, Nov 12, 2021 at 10:33:11AM -0800, Tim Harvey wrote:
> Add support for the RaspberryPi Camera v2 module attached to an
> imx8mm-venice-gw73xx-0x.
> 
> This camera is an IMX219 8MP module:
>  - https://datasheets.raspberrypi.com/camera/camera-v2-schematics.pdf
>  - has its own on-board 24MHz osc so no clock required from baseboard
>  - pin 11 enables 1.8V and 2.8V LDO which is connected to
>    GW73xx MIPI_GPIO4 (IMX8MM GPIO1_IO1). The imx219 driver does not
>    support powerdown-gpios therefore we use gpio1 via reset-gpios

How about modeling this with a GPIO-controlled regulator, and connecting
it to the IMX219 through the *-supply properties ?

> Support is added via a device-tree overlay.
> 
> The IMX219 supports RAW8/RAW10 image formats.
> 
> Example usage:
>  media-ctl --links "'imx219 2-0010':0->'imx7-mipi-csis.0':0[1]"
>  media-ctl -v -V "'imx219 2-0010':0 [fmt:SRGGB8/640x480 field:none]"
>  media-ctl -v -V "'csi':0 [fmt:SRGGB8/640x480 field:none]"
>  gst-launch-1.0 -v v4l2src num-buffers=1 ! \
>        video/x-bayer,format=rggb,width=640,height=480,framerate=30/1 ! \
>        bayer2rgb ! jpegenc ! filesink location=test.jpg
>  gst-launch-1.0 -v v4l2src num-buffers=300 ! \
>        video/x-bayer,format=rggb,width=640,height=480,framerate=30/1 ! \
>        bayer2rgb ! jpegenc ! avimux ! filesink location=test.avi
> 
> This patch depends on 'arm64: dts: imx8mm: Add CSI nodes' at:
> https://lore.kernel.org/all/20211106155427.753197-2-aford173@gmail.com/
> 
> This is an RFC as I am not aware of other dt fragments/overlays being
> added to the kernel yet. I do get a few warnings but I believe they are
> because this is a fragment:

I like the idea of centralizing DT overlays. I'm not sure where to best
store them, and I don't know if this has been discussed already, but the
kernel supports compilation of DT overlays, so I assume it's meant to be
used. Rob may have an opinion on this.

What we're really missing is a way to parametrize DT overlays, so that a
single overlay file could be used with different hosts. Discussions
about DT connectors have died out as far as I know, but they were aiming
at overlays being applied at runtime. I'm not aware of a similar effort
to standardize connectors when applying overlays in the boot loader. The
Raspberry Pi boot loader has a proprietary implementation of this
feature, which is very handy.

> $ make DTC_FLAGS="-@" dtbs W=1
>   DTC
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts:33.3-16:
> Warning (reg_format): /fragment@2/__overlay__/sensor@10:reg: property
> has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts:52.10-57.5:
> Warning (unit_address_vs_reg): /fragment@3/__overlay__/ports/port@0:
> node has a unit name, but no reg or ranges property
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
> Warning (pci_device_reg): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
> Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
> Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
> Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
> Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts:29.20-46.4:
> Warning (avoid_default_addr_size): /fragment@2/__overlay__/sensor@10:
> Relying on default #address-cells value
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts:29.20-46.4:
> Warning (avoid_default_addr_size): /fragment@2/__overlay__/sensor@10:
> Relying on default #size-cells value
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
> Warning (avoid_unnecessary_addr_size): Failed prerequisite
> 'avoid_default_addr_size'
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
> Warning (unique_unit_address): Failed prerequisite
> 'avoid_default_addr_size'
> 
> The intended use of a dt fragement like this is to apply it in boot
> firmware before booting the kernel such as:
> 
> u-boot=> load mmc 0:1 $fdt_addr_r imx8mm-venice-gw73xx-0x.dtb
> u-boot=> fdt addr $fdt_addr_r
> u-boot=> fdt resize
> u-boot=> load mmc 0:1 $loadaddr imx8mm-venice-gw73xx-0x-imx219.dtb
> u-boot=> fdt appply $loadaddr
> u-boot=> load mmc 0:1 $kernel_addr_r Image
> u-boot=> booti $kernel_addr_r - $fdt_addr_r
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../imx8mm-venice-gw73xx-0x-imx219.dts        | 67 +++++++++++++++++++
>  2 files changed, 68 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index db9e36ebe932..cc00ac78dbc6 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -42,6 +42,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-imx219.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7901.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7902.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts
> new file mode 100644
> index 000000000000..6f692ba24a31
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2021 Gateworks Corporation
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +#include "imx8mm-pinfunc.h"
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {
> +	compatible = "gw,imx8mm-gw73xx-0x", "fsl,imx8mm";
> +
> +	cam24m: cam24m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24000000>;
> +		clock-output-names = "cam24m";
> +	};
> +};
> +
> +&csi {
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	imx219: sensor@10 {
> +		compatible = "sony,imx219";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_imx219>;
> +		reg = <0x10>;
> +		clocks = <&cam24m>;
> +		reset-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> +
> +		port {
> +			/* MIPI CSI-2 bus endpoint */
> +			imx219_to_mipi_csi2: endpoint {
> +				remote-endpoint = <&imx8mm_mipi_csi_in>;
> +				clock-lanes = <0>;
> +				data-lanes = <1 2>;
> +				link-frequencies = /bits/ 64 <456000000>;
> +			};
> +		};
> +	};
> +};
> +
> +&mipi_csi {
> +	status = "okay";
> +	ports {
> +		port@0 {
> +			imx8mm_mipi_csi_in: endpoint {
> +				remote-endpoint = <&imx219_to_mipi_csi2>;
> +				data-lanes = <1 2>;
> +			};
> +		};
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_imx219: imx219grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1	0x41
> +		>;
> +	};
> +};

-- 
Regards,

Laurent Pinchart
