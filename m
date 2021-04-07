Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2796F356A19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbhDGKna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:43:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37226 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbhDGKn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:43:28 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 137Ah9QP124245;
        Wed, 7 Apr 2021 05:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617792189;
        bh=F1n6gbGW6vSa3ouqdmSuOTfCrAe3ZvjZ80iuQS1yWPA=;
        h=From:To:CC:Subject:Date;
        b=jVHHW5VH2hFRXkmax4OyfI9BbkUrjDF/q7/tboMLMYeegaoin+VTS71Mq7/dnyr0A
         fQQVdrnW5Scp/cSP+1QLPJXP4IilJbWwVXIfyy2twAYxhtq+7rl4pgwjKcgG8gwUdJ
         B4KvjFykl6PZb4I7QBsQFFAbDeQ5yyQ//bvhP5o0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 137Ah9nU026996
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Apr 2021 05:43:09 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 7 Apr
 2021 05:43:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 7 Apr 2021 05:43:09 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 137Ah6kS081028;
        Wed, 7 Apr 2021 05:43:06 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-am65: Add support for UHS-I modes in MMCSD1 subsystem
Date:   Wed, 7 Apr 2021 16:13:03 +0530
Message-ID: <20210407104303.25950-1-a-govindraju@ti.com>
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

[1] - https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf, section 12.3.6.1.1

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

test logs:
https://pastebin.ubuntu.com/p/vpYbY9QWh8/

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  1 -
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 33 +++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

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
index 9e87fb313a54..6f7292b6fe0a 100644
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

