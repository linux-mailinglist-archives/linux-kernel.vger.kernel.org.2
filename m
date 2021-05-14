Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2025C380A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhENNoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbhENNnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:43:52 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:150:448b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF20DC06174A;
        Fri, 14 May 2021 06:42:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 334AC2225A0;
        Fri, 14 May 2021 15:42:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ihl9Ced0Zfqt; Fri, 14 May 2021 15:42:36 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v3 3/7] ARM: dts: sun8i: v3s: add analog codec and frontend to v3s dts
Date:   Fri, 14 May 2021 15:44:01 +0200
Message-Id: <20210514134405.2097464-4-t.schramm@manjaro.org>
In-Reply-To: <20210514134405.2097464-1-t.schramm@manjaro.org>
References: <20210514134405.2097464-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner V3s and V3 SoCs feature an integrated analog audio codec.
Additionally both have an analog frontend with mixers and amplifiers for
the codec.
This commit adds both, the analog codec and its frontend to the V3s dtsi.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 3eaa8703e2ac..236cf45bba91 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -441,6 +441,25 @@ lradc: lradc@1c22800 {
 			status = "disabled";
 		};
 
+		codec: codec@1c22c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-v3s-codec";
+			reg = <0x01c22c00 0x400>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+			clock-names = "apb", "codec";
+			resets = <&ccu RST_BUS_CODEC>;
+			dmas = <&dma 15>, <&dma 15>;
+			dma-names = "rx", "tx";
+			allwinner,codec-analog-controls = <&codec_analog>;
+			status = "disabled";
+		};
+
+		codec_analog: codec-analog@1c23000 {
+			compatible = "allwinner,sun8i-v3s-codec-analog";
+			reg = <0x01c23000 0x4>;
+		};
+
 		uart0: serial@1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.31.1

