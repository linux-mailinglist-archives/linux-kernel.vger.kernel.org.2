Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4C37A411
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhEKJzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:55:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43496 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhEKJzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:55:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14B9roQ6110601;
        Tue, 11 May 2021 04:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620726830;
        bh=z9UAR+/RmS3yDyR1l995bN55sFL4hrr9lxH1F4VEQjY=;
        h=From:To:CC:Subject:Date;
        b=cm46Afi4XVnDWcwhl5s9KL0Iy6F6+I+WbF9BVo3ajfVOkywNACexJC4IY0CjjwY2F
         m4KKWk6m/5xJUWzWYWEkZ7dgRuNhTIgDfaj3A6a2Jq1sSiTzSC9WzFw6fBPZjhT+oY
         K48yBApcghSnnsqY2vaJFR/QApUSWCRij2ryncGI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14B9roRt123002
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 May 2021 04:53:50 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 11
 May 2021 04:53:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 11 May 2021 04:53:49 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14B9rfrn089715;
        Tue, 11 May 2021 04:53:42 -0500
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
Subject: [PATCH v2] arm64: dts: ti: k3-am65: Add support for UHS-I modes in MMCSD1 subsystem
Date:   Tue, 11 May 2021 15:23:39 +0530
Message-ID: <20210511095339.16268-1-a-govindraju@ti.com>
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
version of AM65 SoC. Therefore, add no-1-8-v in sdhci1 device tree nodes
for these boards.

[1] - https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf, section 12.3.6.1.1
[2] - https://www.ti.com/lit/er/sprz452e/sprz452e.pdf

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  1 -
 .../boot/dts/ti/k3-am6528-iot2050-basic.dts   |  4 +++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 33 +++++++++++++++++++
 .../dts/ti/k3-am6548-iot2050-advanced.dts     |  4 +++
 4 files changed, 41 insertions(+), 1 deletion(-)

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
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
index 4f7e3f2a6265..485266960d5f 100644
--- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
@@ -40,6 +40,10 @@
 	status = "disabled";
 };
 
+&sdhci1 {
+	no-1-8-v;
+};
+
 &main_pmx0 {
 	main_uart0_pins_default: main-uart0-pins-default {
 		pinctrl-single,pins = <
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
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
index ec9617c13cdb..3643a19b5f33 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
@@ -55,6 +55,10 @@
 	disable-wp;
 };
 
+&sdhci1 {
+	no-1-8-v;
+};
+
 &main_uart0 {
 	status = "disabled";
 };
-- 
2.17.1

