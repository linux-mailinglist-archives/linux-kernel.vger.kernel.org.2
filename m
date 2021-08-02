Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0823DD081
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhHBGaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:30:04 -0400
Received: from smtpbg587.qq.com ([113.96.223.105]:34185 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhHBGaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:30:02 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2021 02:30:01 EDT
X-QQ-Spam: true
X-QQ-mid: bizesmtp41t1627885392twhm8kke
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:23:11 +0800 (CST)
X-QQ-SSF: 01100000002000206000B00A0000000
From:   Icenowy Zheng <icenowy@sipeed.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@sipeed.com>
Subject: [PATCH 17/17] arm64: allwinner: dts: r329: add support for Sipeed MaixSense
Date:   Mon,  2 Aug 2021 14:22:12 +0800
Message-Id: <20210802062212.73220-18-icenowy@sipeed.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802062212.73220-1-icenowy@sipeed.com>
References: <20210802062212.73220-1-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:sipeed.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sipeed MaixSense is a R329 devkit based on Maix IIA SoM.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../dts/allwinner/sun50i-r329-maixsense.dts   | 37 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-r329-maixsense.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index a96d9d2d8dd8..80a336d480ac 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -37,3 +37,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-r329-maixsense.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-r329-maixsense.dts b/arch/arm64/boot/dts/allwinner/sun50i-r329-maixsense.dts
new file mode 100644
index 000000000000..1876b9d0b080
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-r329-maixsense.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2021 Sipeed
+
+/dts-v1/;
+
+#include "sun50i-r329-maix-iia.dtsi"
+
+/ {
+	model = "Sipeed MaixSense";
+	compatible = "sipeed,maixsense", "sipeed,maix-iia",
+		     "allwinner,sun50i-r329";
+
+	aliases {
+		serial0 = &uart0;
+		mmc0 = &mmc0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pf_pins>;
+
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
-- 
2.30.2

