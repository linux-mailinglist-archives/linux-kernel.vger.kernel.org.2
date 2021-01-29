Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D204308DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhA2T4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:56:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233122AbhA2Tx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:53:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BF6A64E19;
        Fri, 29 Jan 2021 19:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611949925;
        bh=zLl/LXT9nD9oiff3TtR2evITRFPN8gyWpZ86jRIchpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XnxcbmlJjf145jvC7z/VDn/moQyH8N2Is7cwMYUAD+AukwUYMhOm9D7D4EMrvZmAI
         A1EJzXreeafarejH6zDDPWWnJPo0mx2wRP5qnpPFw0sCpz/tKTlB7UC1NuMAnrZx8n
         yR0cH3RiWLbNNYqfg0SCmpH48ZlxOxaayCRHxNDEbfm3yP2jgdFseo2jStzoz8nlfu
         wsI1qBeYCGIxwPN5QMY6fefL2nicV2qXIOQxJuCbbq4RaSNy/b/s/U8tNS9rrNObun
         zLcovJnR7LsNesO4FJtY8tAopASoorA7SbfMsH+RKL8nUbe6tUTesZ5HaNkLyPjg+3
         Wge6l7kIs3d5A==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l5ZoJ-007Wk8-B7; Fri, 29 Jan 2021 20:52:03 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 14/14] dts: hisilicon: add support for the PMIC found on Hikey 970
Date:   Fri, 29 Jan 2021 20:52:00 +0100
Message-Id: <a2798afcf239bb0cc00a9460dee82d4348831d9e.1611949675.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611949675.git.mchehab+huawei@kernel.org>
References: <cover.1611949675.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree for the HiSilicon 6421v600 SPMI PMIC, used
on HiKey970 board.

As we now have support for it, change the fixed regulators
used by the SD I/O to use the proper LDO supplies.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 22 +----
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     | 87 +++++++++++++++++++
 2 files changed, 90 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index 7f9f9886c349..5e6d7b329771 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -12,6 +12,7 @@
 
 #include "hi3670.dtsi"
 #include "hikey970-pinctrl.dtsi"
+#include "hikey970-pmic.dtsi"
 
 / {
 	model = "HiKey970";
@@ -39,23 +40,6 @@ memory@0 {
 		reg = <0x0 0x0 0x0 0x0>;
 	};
 
-	sd_1v8: regulator-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-1.8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-	};
-
-	sd_3v3: regulator-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
 	wlan_en: wlan-en-1-8v {
 		compatible = "regulator-fixed";
 		regulator-name = "wlan-en-regulator";
@@ -402,8 +386,8 @@ &dwmmc1 {
 	pinctrl-0 = <&sd_pmx_func
 		     &sd_clk_cfg_func
 		     &sd_cfg_func>;
-	vmmc-supply = <&sd_3v3>;
-	vqmmc-supply = <&sd_1v8>;
+	vmmc-supply = <&ldo16>;
+	vqmmc-supply = <&ldo9>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
new file mode 100644
index 000000000000..8cf45b962fea
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Hi6421v600 SPMI PMIC used at the HiKey970 Development Board
+ *
+ * Copyright (C) 2020, Huawei Tech. Co., Ltd.
+ */
+
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	spmi: spmi@fff24000 {
+		compatible = "hisilicon,kirin970-spmi-controller";
+		#address-cells = <2>;
+		#size-cells = <0>;
+		status = "okay";
+		reg = <0x0 0xfff24000 0x0 0x1000>;
+		spmi-channel = <2>;
+
+		pmic: pmic@0 {
+			compatible = "hisilicon,hi6421-spmi";
+			reg = <0 SPMI_USID>;
+
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			gpios = <&gpio28 0 0>;
+
+			regulators {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ldo3: LDO3 {
+					regulator-name = "ldo3";
+					regulator-min-microvolt = <1500000>;
+					regulator-max-microvolt = <2000000>;
+					regulator-boot-on;
+				};
+
+				ldo4: LDO4 { /* 40 PIN */
+					regulator-name = "ldo4";
+					regulator-min-microvolt = <1725000>;
+					regulator-max-microvolt = <1900000>;
+					regulator-boot-on;
+				};
+
+				ldo9: LDO9 { /* SDCARD I/O */
+					regulator-name = "ldo9";
+					regulator-min-microvolt = <1750000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-boot-on;
+				};
+
+				ldo15: LDO15 { /* UFS */
+					regulator-name = "ldo15";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-always-on;
+				};
+
+				ldo16: LDO16 { /* SD */
+					regulator-name = "ldo16";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-boot-on;
+				};
+
+				ldo17: LDO17 {
+					regulator-name = "ldo17";
+					regulator-min-microvolt = <2500000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				ldo33: LDO33 { /* PEX8606 */
+					regulator-name = "ldo33";
+					regulator-min-microvolt = <2500000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-boot-on;
+				};
+
+				ldo34: LDO34 { /* GPS AUX IN VDD */
+					regulator-name = "ldo34";
+					regulator-min-microvolt = <2600000>;
+					regulator-max-microvolt = <3300000>;
+				};
+			};
+		};
+	};
+};
-- 
2.29.2

