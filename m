Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2F237AC54
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhEKQuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:50:14 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54290 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhEKQuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:50:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14BGmxsf009587;
        Tue, 11 May 2021 11:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620751739;
        bh=EXAHHMVat87Ts4QpaLnkvfakXOyXP0EushBlIk4YxAU=;
        h=From:To:CC:Subject:Date;
        b=V24NP39TD9uOX4Lr4LCxTO9F5JHfnVY7ADK/udWXy3Zp97C/pck+P6lCl2Qi4gqlT
         xGDySaKjuD5mTIQ5Lntqnmk4a2bvsBWRMRzz/eQCWhXu8jFVl57KptsoVbs18rtKEc
         oY+vwqode2qcmtZPNXEOmCuvgFQUWGzEzbD1X9rw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14BGmx0j118266
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 May 2021 11:48:59 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 11
 May 2021 11:48:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 11 May 2021 11:48:58 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14BGmpjT012233;
        Tue, 11 May 2021 11:48:52 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] arm64: dts: ti: k3-am65: Add support for UHS-I modes in MMCSD1 subsystem
Date:   Tue, 11 May 2021 22:18:49 +0530
Message-ID: <20210511164849.20016-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UHS-I speed modes are supported in AM65 S.R. 2.0 SoC[1].

Add support by removing the no-1-8-v tag and including the voltage
regulator device tree nodes for power cycling.

However, the 4 bit interface of AM65 SR 1.0 cannot be supported at 3.3 V or
1.8 V because of erratas i2025 and i2026 [2]. As the SD card is the primary
boot mode for development usecases, continue to enable SD card and disable
UHS-I modes in it to minimize any ageing issues happening because of
erratas.

k3-am6528-iot2050-basic and k3-am6548-iot2050-advanced boards use S.R. 1.0
version of AM65 SoC. Therefore, add no-1-8-v in sdhci1 device tree node of
the common iot2050 device tree file.

[1] - https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf, section 12.3.6.1.1
[2] - https://www.ti.com/lit/er/sprz452e/sprz452e.pdf

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

changes since v2:
- moved the no-1-8-v tag to common iot2050 dtsi file.

changes since v1:
- added no-1-8-v tag in sdhci1 dt nodes of k3-am6528-iot2050-basic and
  k3-am6548-iot2050-advanced boards as they use S.R.1.0 version AM65 SoC.

 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   |  1 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  1 -
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 33 +++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index de763ca9251c..46cc348cd4be 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -555,6 +555,7 @@
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
+	no-1-8-v;
 };
 
 &usb0 {
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index cb340d1b401f..632f32fce4a1 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -301,7 +301,6 @@
 		ti,otap-del-sel = <0x2>;
 		ti,trm-icp = <0x8>;
 		dma-coherent;
-		no-1-8-v;
 	};
 
 	scm_conf: scm-conf@100000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 9e87fb313a54..51c594b4dddb 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -91,6 +91,38 @@
 		#clock-cells = <0>;
 		clock-frequency = <24000000>;
 	};
+
+	evm_12v0: fixedregulator-evm12v0 {
+		/* main supply */
+		compatible = "regulator-fixed";
+		regulator-name = "evm_12v0";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc3v3_io: fixedregulator-vcc3v3io {
+		/* Output of TPS54334 */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_io";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&evm_12v0>;
+	};
+
+	vdd_mmc1_sd: fixedregulator-sd {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		vin-supply = <&vcc3v3_io>;
+		gpio = <&pca9554 4 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &wkup_pmx0 {
@@ -350,6 +382,7 @@
  * disable sdhci1
  */
 &sdhci1 {
+	vmmc-supply = <&vdd_mmc1_sd>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	ti,driver-strength-ohm = <50>;
-- 
2.17.1

