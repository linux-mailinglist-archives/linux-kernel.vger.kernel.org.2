Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDDC3F8794
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbhHZMg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:36:28 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:55379 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbhHZMg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:36:27 -0400
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 714DB22173;
        Thu, 26 Aug 2021 14:35:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1629981339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y7OzeEt1IsRaZo5c2zdI/3wRNmRi6itnyDWYa9jDWws=;
        b=QtLZ6+MLQ6agvz1ZZ8UDSyKHOXW5WkQvSnGGo8MldPFBRuOzPTy202sE3n2B0/tfyXkTfV
        fL86JcoTb0519+PWYbw1h9lOCKOJEOTayLfhwdMvWRYU0wuqiDmOSDaYoEbKH8ZjpvTluK
        4TvRd3qHNg0gJUi/g7iX9PRdPRGunWc=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] arm64: dts: freescale: fix arm,sp805 compatible string
Date:   Thu, 26 Aug 2021 14:35:28 +0200
Message-Id: <20210826123529.737398-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
the compatible is:
  compatible = "arm,sp805", "arm,primecell";

The current compatible string doesn't exist at all. Fix it.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 16 ++++++++--------
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index f85e437f80b7..605072317243 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -847,7 +847,7 @@ pcs7_3: ethernet-phy@3 {
 		};
 
 		cluster1_core0_watchdog: wdt@c000000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>,
@@ -857,7 +857,7 @@ QORIQ_CLK_PLL_DIV(16)>,
 		};
 
 		cluster1_core1_watchdog: wdt@c010000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc010000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>,
@@ -867,7 +867,7 @@ QORIQ_CLK_PLL_DIV(16)>,
 		};
 
 		cluster1_core2_watchdog: wdt@c020000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc020000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>,
@@ -877,7 +877,7 @@ QORIQ_CLK_PLL_DIV(16)>,
 		};
 
 		cluster1_core3_watchdog: wdt@c030000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc030000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>,
@@ -887,7 +887,7 @@ QORIQ_CLK_PLL_DIV(16)>,
 		};
 
 		cluster2_core0_watchdog: wdt@c100000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc100000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>,
@@ -897,7 +897,7 @@ QORIQ_CLK_PLL_DIV(16)>,
 		};
 
 		cluster2_core1_watchdog: wdt@c110000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc110000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>,
@@ -907,7 +907,7 @@ QORIQ_CLK_PLL_DIV(16)>,
 		};
 
 		cluster2_core2_watchdog: wdt@c120000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc120000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>,
@@ -917,7 +917,7 @@ QORIQ_CLK_PLL_DIV(16)>,
 		};
 
 		cluster2_core3_watchdog: wdt@c130000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc130000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>,
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 801ba9612d36..1282b61da8a5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -387,7 +387,7 @@ serial3: serial@21d0600 {
 		};
 
 		cluster1_core0_watchdog: wdt@c000000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>,
@@ -397,7 +397,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 		};
 
 		cluster1_core1_watchdog: wdt@c010000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc010000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>,
@@ -407,7 +407,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 		};
 
 		cluster2_core0_watchdog: wdt@c100000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc100000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>,
@@ -417,7 +417,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 		};
 
 		cluster2_core1_watchdog: wdt@c110000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc110000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>,
@@ -427,7 +427,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 		};
 
 		cluster3_core0_watchdog: wdt@c200000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc200000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>,
@@ -437,7 +437,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 		};
 
 		cluster3_core1_watchdog: wdt@c210000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc210000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>,
@@ -447,7 +447,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 		};
 
 		cluster4_core0_watchdog: wdt@c300000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc300000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>,
@@ -457,7 +457,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 		};
 
 		cluster4_core1_watchdog: wdt@c310000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc310000 0x0 0x1000>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>,
-- 
2.30.2

