Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EC23800E3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 01:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhEMXaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 19:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbhEMXaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 19:30:12 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:150:448b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B509C06174A;
        Thu, 13 May 2021 16:29:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id B82DC2210AD;
        Fri, 14 May 2021 01:29:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ywCVWN8o1e2m; Fri, 14 May 2021 01:28:58 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v2 7/7] ARM: dts: sun8i: V3: add I2S interface to V3 dts
Date:   Fri, 14 May 2021 01:30:24 +0200
Message-Id: <20210513233024.2076725-8-t.schramm@manjaro.org>
In-Reply-To: <20210513233024.2076725-1-t.schramm@manjaro.org>
References: <20210513233024.2076725-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner V3 SoC features an I2S interface. The I2S peripheral is
identical to that in the Allwinner H3 SoC.
This commit adds it to the Allwinner V3 dts.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 arch/arm/boot/dts/sun8i-v3.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3.dtsi b/arch/arm/boot/dts/sun8i-v3.dtsi
index 8af790d286b9..3698e024d604 100644
--- a/arch/arm/boot/dts/sun8i-v3.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3.dtsi
@@ -1,10 +1,31 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2019 Icenowy Zheng <icenowy@aosc.io>
+ * Copyright (C) 2021 Tobias Schramm <t.schramm@manjaro.org>
  */
 
 #include "sun8i-v3s.dtsi"
 
+/ {
+	soc {
+			i2s0: i2s@1c22000 {
+				#sound-dai-cells = <0>;
+				compatible = "allwinner,sun8i-v3-i2s",
+					     "allwinner,sun8i-h3-i2s";
+				reg = <0x01c22000 0x400>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ccu CLK_BUS_I2S0>, <&ccu CLK_I2S0>;
+				clock-names = "apb", "mod";
+				dmas = <&dma 3>, <&dma 3>;
+				dma-names = "rx", "tx";
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2s0_pins>;
+				resets = <&ccu RST_BUS_I2S0>;
+				status = "disabled";
+			};
+	};
+};
+
 &ccu {
 	compatible = "allwinner,sun8i-v3-ccu";
 };
@@ -30,6 +51,11 @@ external_mdio: mdio@2 {
 &pio {
 	compatible = "allwinner,sun8i-v3-pinctrl";
 
+	i2s0_pins: i2s0-pins {
+		pins = "PG10", "PG11", "PG12", "PG13";
+		function = "i2s";
+	};
+
 	uart1_pg_pins: uart1-pg-pins {
 		pins = "PG6", "PG7";
 		function = "uart1";
-- 
2.31.1

