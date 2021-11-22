Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1767D4592F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 17:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbhKVQ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 11:29:42 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:58443 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237615AbhKVQ3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 11:29:41 -0500
Received: from vokac-Latitude-7410.ysoft.local (unknown [10.0.29.92])
        by uho.ysoft.cz (Postfix) with ESMTP id 0A282A8BE7;
        Mon, 22 Nov 2021 17:26:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1637598393;
        bh=h3L3yz0u9AF8xOpPtOAkT6BALAtDnhQo4wc/zCFulFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyLAl4Cy3OHKYmYrdBaslhCtnuzWVs3504lOiioWkCfEH9MlakylvnEEM6BEheRKQ
         tneSb7bjE8M6cB4JaICF7KSTkp+/w+sF0JxRK5FPz5pGhf8BXlVhrnj/sHOva4j9WR
         rv6d/d1+BEKeg632ufMINoMw0rU8Elbir2c21Sxw=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 2/2] ARM: dts: imx6dl-yapp4: Add Y Soft IOTA Crux/Crux+ board
Date:   Mon, 22 Nov 2021 17:25:20 +0100
Message-Id: <20211122162520.90211-2-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211122162520.90211-1-michal.vokac@ysoft.com>
References: <20211122162520.90211-1-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetrees for the new boards in the Y Soft IOTA family.
These boards are based on Orion but use Quad/QuadPlus SoC
instead of DualLite.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/Makefile                   |  2 +
 arch/arm/boot/dts/imx6q-yapp4-crux.dts       | 76 ++++++++++++++++++++
 arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dts | 76 ++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-yapp4-crux.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0de64f237cd8..94c64551a970 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -628,6 +628,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-wandboard.dtb \
 	imx6q-wandboard-revb1.dtb \
 	imx6q-wandboard-revd1.dtb \
+	imx6q-yapp4-crux.dtb \
 	imx6q-zii-rdu2.dtb \
 	imx6qp-nitrogen6_max.dtb \
 	imx6qp-nitrogen6_som2.dtb \
@@ -641,6 +642,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6qp-tx6qp-8137-mb7.dtb \
 	imx6qp-vicutp.dtb \
 	imx6qp-wandboard-revd1.dtb \
+	imx6qp-yapp4-crux-plus.dtb \
 	imx6qp-zii-rdu2.dtb \
 	imx6s-dhcom-drc02.dtb
 dtb-$(CONFIG_SOC_IMX6SL) += \
diff --git a/arch/arm/boot/dts/imx6q-yapp4-crux.dts b/arch/arm/boot/dts/imx6q-yapp4-crux.dts
new file mode 100644
index 000000000000..deb18c57cf18
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-yapp4-crux.dts
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2021 Y Soft Corporation, a.s.
+
+/dts-v1/;
+
+#include "imx6q.dtsi"
+#include "imx6dl-yapp4-common.dtsi"
+
+/ {
+	model = "Y Soft IOTA Crux i.MX6Quad board";
+	compatible = "ysoft,imx6q-yapp4-crux", "fsl,imx6q";
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0xf0000000>;
+	};
+};
+
+&audmux {
+	status = "okay";
+};
+
+&codec {
+	status = "okay";
+};
+
+&gpio_oled {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&leds {
+	status = "okay";
+};
+
+&oled_1305 {
+	status = "okay";
+};
+
+&oled_1309 {
+	status = "okay";
+};
+
+&reg_usb_h1_vbus {
+	status = "okay";
+};
+
+&sound {
+	audio-routing =
+		   "Ext Spk", "LSOUT";
+	status = "okay";
+};
+
+&ssi2 {
+	status = "okay";
+};
+
+&touchkeys {
+	status = "okay";
+};
+
+&uart2 {
+	status = "disabled";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbphy2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dts b/arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dts
new file mode 100644
index 000000000000..a450a77f920f
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dts
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2021 Y Soft Corporation, a.s.
+
+/dts-v1/;
+
+#include "imx6qp.dtsi"
+#include "imx6dl-yapp4-common.dtsi"
+
+/ {
+	model = "Y Soft IOTA Crux+ i.MX6QuadPlus board";
+	compatible = "ysoft,imx6qp-yapp4-crux-plus", "fsl,imx6qp";
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0xf0000000>;
+	};
+};
+
+&audmux {
+	status = "okay";
+};
+
+&codec {
+	status = "okay";
+};
+
+&gpio_oled {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&leds {
+	status = "okay";
+};
+
+&oled_1305 {
+	status = "okay";
+};
+
+&oled_1309 {
+	status = "okay";
+};
+
+&reg_usb_h1_vbus {
+	status = "okay";
+};
+
+&sound {
+	audio-routing =
+		   "Ext Spk", "LSOUT";
+	status = "okay";
+};
+
+&ssi2 {
+	status = "okay";
+};
+
+&touchkeys {
+	status = "okay";
+};
+
+&uart2 {
+	status = "disabled";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbphy2 {
+	status = "okay";
+};
-- 
2.25.1

