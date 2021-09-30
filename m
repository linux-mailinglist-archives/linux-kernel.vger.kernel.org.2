Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3FF41DA46
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351128AbhI3MyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351051AbhI3MyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:54:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECA8C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:52:30 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mVvXz-00049S-CL; Thu, 30 Sep 2021 14:52:23 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mVvXy-0007sL-Hp; Thu, 30 Sep 2021 14:52:22 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1] ARM: dts: imx6: skov: provide panel support for lt2 variants
Date:   Thu, 30 Sep 2021 14:52:21 +0200
Message-Id: <20210930125221.30127-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Logic Technologies LTTD800x480 L2RT 7" 800x480 TFT
Resistive Touch Module.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-skov-revc-lt2.dts   |  1 +
 arch/arm/boot/dts/imx6q-skov-revc-lt2.dts    |  1 +
 arch/arm/boot/dts/imx6qdl-skov-revc-lt2.dtsi | 99 ++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6qdl-skov-revc-lt2.dtsi

diff --git a/arch/arm/boot/dts/imx6dl-skov-revc-lt2.dts b/arch/arm/boot/dts/imx6dl-skov-revc-lt2.dts
index 667b8faa1807..b12b5aabe70a 100644
--- a/arch/arm/boot/dts/imx6dl-skov-revc-lt2.dts
+++ b/arch/arm/boot/dts/imx6dl-skov-revc-lt2.dts
@@ -6,6 +6,7 @@
 #include "imx6dl.dtsi"
 #include "imx6qdl-skov-cpu.dtsi"
 #include "imx6qdl-skov-cpu-revc.dtsi"
+#include "imx6qdl-skov-revc-lt2.dtsi"
 
 / {
 	model = "SKOV IMX6 CPU SoloCore";
diff --git a/arch/arm/boot/dts/imx6q-skov-revc-lt2.dts b/arch/arm/boot/dts/imx6q-skov-revc-lt2.dts
index f00add7b3048..ff97d22eb09f 100644
--- a/arch/arm/boot/dts/imx6q-skov-revc-lt2.dts
+++ b/arch/arm/boot/dts/imx6q-skov-revc-lt2.dts
@@ -6,6 +6,7 @@
 #include "imx6q.dtsi"
 #include "imx6qdl-skov-cpu.dtsi"
 #include "imx6qdl-skov-cpu-revc.dtsi"
+#include "imx6qdl-skov-revc-lt2.dtsi"
 
 / {
 	model = "SKOV IMX6 CPU QuadCore";
diff --git a/arch/arm/boot/dts/imx6qdl-skov-revc-lt2.dtsi b/arch/arm/boot/dts/imx6qdl-skov-revc-lt2.dtsi
new file mode 100644
index 000000000000..48c9ce051f47
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-skov-revc-lt2.dtsi
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright (C) 2021 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
+
+/ {
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_backlight>;
+		enable-gpios = <&gpio6 23 GPIO_ACTIVE_LOW>;
+		pwms = <&pwm2 0 20000 0>;
+		brightness-levels = <0 255>;
+		num-interpolated-steps = <17>;
+		default-brightness-level = <8>;
+		power-supply = <&reg_24v0>;
+	};
+
+	display {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		compatible = "fsl,imx-parallel-display";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1>;
+
+		port@0 {
+			reg = <0>;
+
+			display0_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp0>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			display0_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+
+	panel {
+		compatible = "logictechno,lttd800480070-l2rt";
+		backlight = <&backlight>;
+		power-supply = <&reg_3v3>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display0_out>;
+			};
+		};
+	};
+};
+
+&ipu1_di0_disp0 {
+	remote-endpoint = <&display0_in>;
+};
+
+&iomuxc {
+	pinctrl_backlight: backlightgrp {
+		fsl,pins = <
+			MX6QDL_PAD_RGMII_TD3__GPIO6_IO23		0x58
+		>;
+	};
+
+	pinctrl_ipu1: ipu1grp {
+		fsl,pins = <
+			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x10
+			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15		0x10
+			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x10
+			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x10
+			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x10
+			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x10
+			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x10
+			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x10
+			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x10
+			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x10
+			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x10
+			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x10
+			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x10
+			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x10
+			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x10
+			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x10
+			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x10
+			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x10
+			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x10
+			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x10
+			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x10
+			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x10
+			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18	0x10
+			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19	0x10
+			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20	0x10
+			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21	0x10
+			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22	0x10
+			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23	0x10
+		>;
+	};
+};
-- 
2.30.2

