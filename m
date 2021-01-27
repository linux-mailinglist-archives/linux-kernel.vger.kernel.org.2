Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EDD305F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343579AbhA0PLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:11:47 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44526 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343515AbhA0PKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:10:16 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10RF8aj4056795;
        Wed, 27 Jan 2021 09:08:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611760116;
        bh=8VbVEW4RcQdW1Uw39qIyzCA7fu/2iK2SmYNLQqDOF0U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Q8sOMWa9XoBscqP21uMhU1Ax3xWx5bcox0bKWmFZs5DJzHCSOfmyPjQOEmZ03xQcg
         DGfriOTRTZ5uKMvVQCVBcKfkZjc+mMqjKp4GCuF9XQZ+ETX7QPQYBS4+rFo+V/peBT
         lGRBd0qLqaRlLvsU/IBNjioOtkhMgJZ56Vktl8Cc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10RF8ZCa069364
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jan 2021 09:08:35 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 27
 Jan 2021 09:08:35 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 27 Jan 2021 09:08:35 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10RF8IHA064427;
        Wed, 27 Jan 2021 09:08:31 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] arm64: dts: ti: k3-j7200: Add support for higher speed modes in MMCSD subsystems
Date:   Wed, 27 Jan 2021 20:38:15 +0530
Message-ID: <20210127150815.16991-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210127150815.16991-1-a-govindraju@ti.com>
References: <20210127150815.16991-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following speed modes are now supported in J7200 SoC,
- HS200 and HS400 modes at 1.8 V card voltage, in MMCSD0 subsystem [1].
- UHS-I speed modes in MMCSD1 subsystem [1].

Add support for UHS-I modes by adding voltage regulator device tree nodes
and corresponding pinmux details, to power cycle and voltage switch cards.
Also set respective tags in sdhci0 and remove no-1-8-v tag from sdhci1
device tree nodes.

[1] - section 12.3.6.1.1 MMCSD Features, in
      https://www.ti.com/lit/ug/spruiu1a/spruiu1a.pdf

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

performance test logs using EXT4 filesystem for eMMC HS400 speed mode,
https://pastebin.ubuntu.com/p/KFphDYXj93/

performance test logs using EXT4 filesystem for SD SDR104 speed mode,
https://pastebin.ubuntu.com/p/GQKtwGT8Qg/

 .../dts/ti/k3-j7200-common-proc-board.dts     | 31 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  3 +-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 4a7182abccf5..1e1a0022822d 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -16,6 +16,29 @@
 		stdout-path = "serial2:115200n8";
 		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
 	};
+
+	vdd_mmc1: fixedregulator-sd {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpios = <&exp2 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	vdd_sd_dv: gpio-regulator-vdd-sd-dv {
+		compatible = "regulator-gpio";
+		regulator-name = "vdd_sd_dv";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_dv_pins_default>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		gpios = <&main_gpio0 55 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0
+			  3300000 0x1>;
+	};
 };
 
 &wkup_pmx0 {
@@ -70,6 +93,12 @@
 			J721E_IOPAD(0x120, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
 		>;
 	};
+
+	vdd_sd_dv_pins_default: vdd_sd_dv_pins_default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0xd0, PIN_INPUT, 7) /* (T5) SPI0_D1.GPIO0_55 */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -190,6 +219,8 @@
 	/* SD card */
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	pinctrl-names = "default";
+	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vdd_sd_dv>;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 75dffbb26d52..8392d771ef13 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -534,6 +534,8 @@
 		ti,trm-icp = <0x8>;
 		bus-width = <8>;
 		mmc-ddr-1_8v;
+		mmc-hs200-1_8v;
+		mmc-hs400-1_8v;
 		dma-coherent;
 	};
 
@@ -551,7 +553,6 @@
 		ti,otap-del-sel-sdr50 = <0xc>;
 		ti,otap-del-sel-sdr104 = <0x5>;
 		ti,otap-del-sel-ddr50 = <0xc>;
-		no-1-8-v;
 		dma-coherent;
 	};
 
-- 
2.17.1

