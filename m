Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766F3451BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346536AbhKPAJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:09:31 -0500
Received: from finn.gateworks.com ([108.161.129.64]:51700 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1350912AbhKOU1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 15:27:38 -0500
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1mmiWi-008GBo-En; Mon, 15 Nov 2021 20:24:28 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tim Harvey <tharvey@gateworks.com>
Subject: [RFC] arm64: dts: imx8mm-venice-gw73xx-0x: add DT overlays for serial modes
Date:   Mon, 15 Nov 2021 12:24:26 -0800
Message-Id: <20211115202426.16114-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx8mm-venice-gw73xx-0x som+baseboard combination has a multi-protocol
RS-232/RS-485/RS-422 transceiver to an off-board connector which
can be configured in a number of ways via UART and GPIO configuration.

The default configuration per the imx8mm-venice-gw73xx-0x DT is for
UART2 TX/RX and UART4 TX/RX to be available as RS-232:
 J15.1 UART2 TX out
 J15.2 UART2 RX in
 J15.3 UART4 TX out
 J15.4 UART4 RX in
 J15.5 GND

Add dt overlays to allow additional the modes of operation:

rs232-rts (UART2 RS-232 with RTS/CTS hardware flow control)
 J15.1 TX out
 J15.2 RX in
 J15.3 RTS out
 J15.4 CTS in
 J15.5 GND

rs485 (UART2 RS-485 half duplex)
 J15.1 TXRX-
 J15.2 N/C
 J15.3 TXRX+
 J15.4 N/C
 J15.5 GND

rs422 (UART2 RS-422 full duplex)
 J15.1 TX-
 J15.2 RX+
 J15.3 TX+
 J15.4 RX-
 J15.5 GND

This is an RFC as I am not aware of other dt fragments/overlays being
added to the kernel yet.

I prefer to have this as an overlay vs creating a full dts including this
capability because there are other optional add-on boards for this board
including:
- imx219 camera
- rpidsi touchscreen display

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |  3 ++
 .../imx8mm-venice-gw73xx-0x-rs232-rts.dts     | 42 +++++++++++++++++
 .../imx8mm-venice-gw73xx-0x-rs422.dts         | 45 +++++++++++++++++++
 .../imx8mm-venice-gw73xx-0x-rs485.dts         | 45 +++++++++++++++++++
 4 files changed, 135 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index db9e36ebe932..bcc3c2dcb30b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -42,6 +42,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs232-rts.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs422.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs485.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7901.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7902.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts
new file mode 100644
index 000000000000..18053997efe5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts
@@ -0,0 +1,42 @@
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
+	compatible = "gw,imx8mm-gw73xx-0x";
+};
+
+/* For RS232 with CTS_RTS:
+ *  - UART4_TX becomes RTS
+ *  - UART4_RX becomes CTS
+ */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	rts-gpios = <&gpio5 29 GPIO_ACTIVE_LOW>;
+	cts-gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&uart4 {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX     0x140
+			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX     0x140
+			MX8MM_IOMUXC_UART4_TXD_GPIO5_IO29	0x140
+			MX8MM_IOMUXC_UART4_RXD_GPIO5_IO28	0x140
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts
new file mode 100644
index 000000000000..d23b56ba22e5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts
@@ -0,0 +1,45 @@
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
+	compatible = "gw,imx8mm-gw73xx-0x";
+};
+
+/* For RS485 FD:
+ *  - UART4_TX is DE for RS485 transmitter
+ *  - RS485_EN needs to be pulled high
+ *  - RS485_HALF needs to be low
+ */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	rts-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
+	rs485-term-gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&uart4 {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX     0x140
+			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX     0x140
+			MX8MM_IOMUXC_UART4_TXD_GPIO5_IO29	0x140
+			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0       0x40000104 /* RS485_TERM */
+			MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0        0x40000144 /* RS485_EN */
+			MX8MM_IOMUXC_SAI1_RXD0_GPIO4_IO2        0x40000104 /* RS485_HALF */
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts
new file mode 100644
index 000000000000..f0416af10165
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts
@@ -0,0 +1,45 @@
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
+	compatible = "gw,imx8mm-gw73xx-0x";
+};
+
+/* For RS485 HD:
+ *  - UART4_TX is DE for RS485 transmitter
+ *  - RS485_EN needs to be pulled high
+ *  - RS485_HALF needs to be pulled high
+ */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	rts-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
+	rs485-term-gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&uart4 {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX     0x140
+			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX     0x140
+			MX8MM_IOMUXC_UART4_TXD_GPIO5_IO29	0x140
+			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0       0x40000104 /* RS485_TERM */
+			MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0        0x40000144 /* RS485_EN */
+			MX8MM_IOMUXC_SAI1_RXD0_GPIO4_IO2        0x40000144 /* RS485_HALF */
+		>;
+	};
+};
-- 
2.17.1

