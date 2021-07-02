Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB1F3B9D0C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 09:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhGBHkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 03:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230159AbhGBHkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 03:40:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEE1F61421;
        Fri,  2 Jul 2021 07:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625211449;
        bh=JntM5SsvC+TwzNi5LcjkIB38XM7r8DqFdl5GvXVXIfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mVnZie8/ibo8od7bdA+c4r9kWaJ8sSvMOfz2qnvrB1TmCy68yOiTgkPsJIckWR50j
         rRy8tuIhobnlefXLhippKy3ULbi5iXD5HtiyYdpeLaTp+eDWzXGzKX+nwXkqlBlNGY
         MxVMso6ooHipFFIznFJNPKj6aHgJFLDWjjAx1HkgNrtBbSsm+EdjhAAt2AQFtNPbL7
         Oe16m2tHUtGus8nrbmCqLjbYWWs1XLcHcm1dymuPcaDa+kFZW6WzZcTwXUxakpteQW
         o+y/IgtBSt7eqq5fwEMlZ+kMpOMDdv8xdy8E5d+fiPLsKnkkw5nM2SEhdXf9Swb2bG
         psll3JC/f73hA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lzDjo-000ga7-Uy; Fri, 02 Jul 2021 09:37:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Axel Lin" <axel.lin@ingics.com>,
        "Lee Jones" <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 7/8] dts: hisilicon: add support for the PMIC found on Hikey 970
Date:   Fri,  2 Jul 2021 09:37:22 +0200
Message-Id: <15a15a838d2fc08a08fb569ef1c0ba7bdf8b4c9d.1625211021.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625211021.git.mchehab+huawei@kernel.org>
References: <cover.1625211021.git.mchehab+huawei@kernel.org>
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
index 000000000000..48c739eacba0
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
+		hisilicon,spmi-channel = <2>;
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
+				ldo3: LDO3 { /* HDMI */
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
+				ldo17: LDO17 { /* USB HUB */
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
2.31.1

