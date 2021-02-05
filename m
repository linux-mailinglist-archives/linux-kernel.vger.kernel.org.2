Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04001311975
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhBFDG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:06:28 -0500
Received: from inva020.nxp.com ([92.121.34.13]:45690 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbhBFCil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:38:41 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 031341A0262;
        Sat,  6 Feb 2021 00:50:54 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BE5AA1A024F;
        Sat,  6 Feb 2021 00:50:53 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 3758F40A63;
        Fri,  5 Feb 2021 16:50:53 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 10/15] ARM: dts: ls1021a: remove regulators simple-bus
Date:   Fri,  5 Feb 2021 17:47:29 -0600
Message-Id: <20210205234734.3397-11-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20210205234734.3397-1-leoyang.li@nxp.com>
References: <20210205234734.3397-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no regulator bus in hardware.  So move the regulator nodes out
and remove the regulators simple-bus.  This also make the dts align with
the simple-bus schema.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm/boot/dts/ls1021a-qds.dts | 19 ++++++-------------
 arch/arm/boot/dts/ls1021a-twr.dts | 19 ++++++-------------
 2 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 9b0f9212e777..01fe0e7665f4 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -25,19 +25,12 @@
 		clock-frequency = <24576000>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_3p3v: regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	reg_3p3v: regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
 	};
 
 	sound {
diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index 01bf316bcc99..2f63a9cb755c 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -23,19 +23,12 @@
 		clock-frequency = <24576000>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_3p3v: regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	reg_3p3v: regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
 	};
 
 	sound {
-- 
2.17.1

