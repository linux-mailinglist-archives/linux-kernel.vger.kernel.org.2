Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2753DD074
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhHBGXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:23:34 -0400
Received: from smtpbg126.qq.com ([106.55.201.22]:32311 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232241AbhHBGXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:23:32 -0400
X-QQ-mid: bizesmtp41t1627885389t63rejv1
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:23:08 +0800 (CST)
X-QQ-SSF: 01100000002000206000B00A0000000
X-QQ-FEAT: 7eDRq1lSlwvgcusNTK6Z6tWpNC2+lREFRfmYi5e/qAXh+q82nirdNwZp1YVYF
        /7p3YSRxv4Zlfiwy8hotIqcoOaDlhm9KQaQgs2RU29Zt7d+iHJz3emP5r7DMXC0PWl/WL9l
        M7gyTiTfUavnlAKBQtinhDspzsQt3WQK4lLbyC+woV/cTnFCqrdtc3f3Hanz6HZDAjAI4L+
        JLdMI7t4ne1OTjvLAGTCUHYTEhvgkRIVuJC7NbNkVSwddEf0aELvifsqpeaNP2ubojrwSVl
        5jY/IBBK17BeaF/wg9okRThoydv8iiWBKbd0mdkdPaVkDJz9l+gPubht7TuzLHg0l7me0H7
        z6kF2AEB6kDcezi7wOAoLAZghUmCw==
X-QQ-GoodBg: 0
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
Subject: [PATCH 16/17] arm64: allwinner: dts: r329: add DTSI file for Sipeed Maix IIA
Date:   Mon,  2 Aug 2021 14:22:11 +0800
Message-Id: <20210802062212.73220-17-icenowy@sipeed.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802062212.73220-1-icenowy@sipeed.com>
References: <20210802062212.73220-1-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:sipeed.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sipeed Maix IIA is a R329-N4 (AIPU available and 256MiB DRAM) based SoM,
with a Realtek SDIO Wi-Fi module on it.

Add a DTSI file for it.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 .../dts/allwinner/sun50i-r329-maix-iia.dtsi   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-r329-maix-iia.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-r329-maix-iia.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-r329-maix-iia.dtsi
new file mode 100644
index 000000000000..15774f8a5445
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-r329-maix-iia.dtsi
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2021 Sipeed
+
+#include "sun50i-r329.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	reg_vcc3v3: vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 1 0 GPIO_ACTIVE_LOW>; /* PM0 */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_clk_pg0>, <&mmc1_cmd_pg1>, <&mmc1_d0_pg2>,
+		    <&mmc1_d1_pg3>, <&mmc1_d2_pg4>, <&mmc1_d3_pg5>;
+
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
-- 
2.30.2

