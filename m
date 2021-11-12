Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDF744ECA6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 19:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhKLSgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 13:36:14 -0500
Received: from finn.gateworks.com ([108.161.129.64]:49814 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230137AbhKLSgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 13:36:13 -0500
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1mlbMP-008C7N-Kc; Fri, 12 Nov 2021 18:33:13 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adam Ford <aford173@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [RFC] arm64: dts: imx8mm: add imx8mm-venice-gw73xx-0x-imx219 overlay
Date:   Fri, 12 Nov 2021 10:33:11 -0800
Message-Id: <20211112183311.9556-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the RaspberryPi Camera v2 module attached to an
imx8mm-venice-gw73xx-0x.

This camera is an IMX219 8MP module:
 - https://datasheets.raspberrypi.com/camera/camera-v2-schematics.pdf
 - has its own on-board 24MHz osc so no clock required from baseboard
 - pin 11 enables 1.8V and 2.8V LDO which is connected to
   GW73xx MIPI_GPIO4 (IMX8MM GPIO1_IO1). The imx219 driver does not
   support powerdown-gpios therefore we use gpio1 via reset-gpios

Support is added via a device-tree overlay.

The IMX219 supports RAW8/RAW10 image formats.

Example usage:
 media-ctl --links "'imx219 2-0010':0->'imx7-mipi-csis.0':0[1]"
 media-ctl -v -V "'imx219 2-0010':0 [fmt:SRGGB8/640x480 field:none]"
 media-ctl -v -V "'csi':0 [fmt:SRGGB8/640x480 field:none]"
 gst-launch-1.0 -v v4l2src num-buffers=1 ! \
       video/x-bayer,format=rggb,width=640,height=480,framerate=30/1 ! \
       bayer2rgb ! jpegenc ! filesink location=test.jpg
 gst-launch-1.0 -v v4l2src num-buffers=300 ! \
       video/x-bayer,format=rggb,width=640,height=480,framerate=30/1 ! \
       bayer2rgb ! jpegenc ! avimux ! filesink location=test.avi

This patch depends on 'arm64: dts: imx8mm: Add CSI nodes' at:
https://lore.kernel.org/all/20211106155427.753197-2-aford173@gmail.com/

This is an RFC as I am not aware of other dt fragments/overlays being
added to the kernel yet. I do get a few warnings but I believe they are
because this is a fragment:

$ make DTC_FLAGS="-@" dtbs W=1
  DTC
arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb
arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts:33.3-16:
Warning (reg_format): /fragment@2/__overlay__/sensor@10:reg: property
has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts:52.10-57.5:
Warning (unit_address_vs_reg): /fragment@3/__overlay__/ports/port@0:
node has a unit name, but no reg or ranges property
arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
Warning (pci_device_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
Warning (simple_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
Warning (spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts:29.20-46.4:
Warning (avoid_default_addr_size): /fragment@2/__overlay__/sensor@10:
Relying on default #address-cells value
arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts:29.20-46.4:
Warning (avoid_default_addr_size): /fragment@2/__overlay__/sensor@10:
Relying on default #size-cells value
arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
Warning (avoid_unnecessary_addr_size): Failed prerequisite
'avoid_default_addr_size'
arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb:
Warning (unique_unit_address): Failed prerequisite
'avoid_default_addr_size'

The intended use of a dt fragement like this is to apply it in boot
firmware before booting the kernel such as:

u-boot=> load mmc 0:1 $fdt_addr_r imx8mm-venice-gw73xx-0x.dtb
u-boot=> fdt addr $fdt_addr_r
u-boot=> fdt resize
u-boot=> load mmc 0:1 $loadaddr imx8mm-venice-gw73xx-0x-imx219.dtb
u-boot=> fdt appply $loadaddr
u-boot=> load mmc 0:1 $kernel_addr_r Image
u-boot=> booti $kernel_addr_r - $fdt_addr_r

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../imx8mm-venice-gw73xx-0x-imx219.dts        | 67 +++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index db9e36ebe932..cc00ac78dbc6 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -42,6 +42,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-imx219.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7901.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7902.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts
new file mode 100644
index 000000000000..6f692ba24a31
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2021 Gateworks Corporation
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "imx8mm-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "gw,imx8mm-gw73xx-0x", "fsl,imx8mm";
+
+	cam24m: cam24m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "cam24m";
+	};
+};
+
+&csi {
+	status = "okay";
+};
+
+&i2c3 {
+	imx219: sensor@10 {
+		compatible = "sony,imx219";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_imx219>;
+		reg = <0x10>;
+		clocks = <&cam24m>;
+		reset-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+
+		port {
+			/* MIPI CSI-2 bus endpoint */
+			imx219_to_mipi_csi2: endpoint {
+				remote-endpoint = <&imx8mm_mipi_csi_in>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+				link-frequencies = /bits/ 64 <456000000>;
+			};
+		};
+	};
+};
+
+&mipi_csi {
+	status = "okay";
+	ports {
+		port@0 {
+			imx8mm_mipi_csi_in: endpoint {
+				remote-endpoint = <&imx219_to_mipi_csi2>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_imx219: imx219grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1	0x41
+		>;
+	};
+};
-- 
2.17.1

