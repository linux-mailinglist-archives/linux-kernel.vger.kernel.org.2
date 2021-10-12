Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E05642B0CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbhJMAIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:08:40 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33324 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236297AbhJMAI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:08:27 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E60D9202E3A;
        Wed, 13 Oct 2021 02:06:23 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AEA31202E43;
        Wed, 13 Oct 2021 02:06:23 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 3C9C740BD3;
        Tue, 12 Oct 2021 17:06:23 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 10/17] ARM: dts: ls1021a: remove regulators simple-bus
Date:   Tue, 12 Oct 2021 18:58:16 -0500
Message-Id: <20211012235824.31096-11-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211012235824.31096-1-leoyang.li@nxp.com>
References: <20211012235824.31096-1-leoyang.li@nxp.com>
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
index 6db6604e7a18..6e469b46229f 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -25,19 +25,12 @@ sys_mclk: clock-mclk {
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
index e162a1599264..f5c03871b205 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -23,19 +23,12 @@ sys_mclk: clock-mclk {
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
2.25.1

