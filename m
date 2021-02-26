Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A55E326150
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhBZKce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:32:34 -0500
Received: from mail.manjaro.org ([176.9.38.148]:51474 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230444AbhBZKbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:31:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 8E1293DC0E31;
        Fri, 26 Feb 2021 11:30:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CGEMCot-z218; Fri, 26 Feb 2021 11:30:28 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 3/3] ARM: dts: sun8i: V3/S3: add i2s peripheral
Date:   Fri, 26 Feb 2021 11:30:28 +0100
Message-Id: <20210226103028.729172-4-t.schramm@manjaro.org>
In-Reply-To: <20210226103028.729172-1-t.schramm@manjaro.org>
References: <20210226103028.729172-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The V3 and S3 SoCs feature an i2s peripheral identical to that of the H3.
Add it to the dts.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 arch/arm/boot/dts/sun8i-v3.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3.dtsi b/arch/arm/boot/dts/sun8i-v3.dtsi
index c279e13583ba..17ea6b8f091f 100644
--- a/arch/arm/boot/dts/sun8i-v3.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3.dtsi
@@ -30,3 +30,18 @@ uart1_pg_pins: uart1-pg-pins {
 		function = "uart1";
 	};
 };
+
+&soc {
+		i2s0: i2s@1c22000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22000 0x400>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S0>, <&ccu CLK_I2S0>;
+			clock-names = "apb", "mod";
+			dmas = <&dma 3>, <&dma 3>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_I2S0>;
+			status = "disabled";
+		};
+};
-- 
2.30.1

