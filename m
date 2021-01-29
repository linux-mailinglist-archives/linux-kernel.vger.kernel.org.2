Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA20E308696
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhA2Hil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:38:41 -0500
Received: from st43p00im-ztdg10063201.me.com ([17.58.63.182]:36373 "EHLO
        st43p00im-ztdg10063201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232349AbhA2HiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1611905805; bh=jBKJKiixrDY49iH2B3Ue3W7GMRSc79RLukpuKGluao8=;
        h=From:To:Subject:Date:Message-Id;
        b=CykC5rniuFl0khuwDmncNWV0UZWSUrJOSXnDKcDfa3nPOdjOJsYgVoubQ1z6/R8ix
         gAFSgIEsLuIAEtWFKgYj7W4bzxczhSXU+lx40IfYDr2Acz24fbc4C9hqjDy1KHmbT+
         HAQYfKW7epanbrtXT+r7yM/wk8iNg95i+n0YBtJbKkcAbP6SGWv2+ROynvIiKSBiUL
         wy9/e2YaE/htdf/svnuO8bmaeTkNdORswHg3BL0fv8hTDcJSaMmPj0LDaFeDtKXGSh
         F56rEiR62bTEBkuSkbyITfu441/vqaGj0btid/9Jb91RRwL9aEKQOkaOELWYnvK9TK
         iYAtfHjdu1UFw==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10063201.me.com (Postfix) with ESMTPSA id D4F7A54050A;
        Fri, 29 Jan 2021 07:36:27 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v2 3/3] ARM: dts: sti: Introduce 4KOpen (stih418-b2264) board
Date:   Fri, 29 Jan 2021 08:34:47 +0100
Message-Id: <20210129073447.18778-4-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210129073447.18778-1-avolmat@me.com>
References: <20210129073447.18778-1-avolmat@me.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-29_03:2021-01-28,2021-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2101290039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4KOpen (B2264) is a board based on the STMicroelectronics STiH418 soc:
  - 2GB DDR
  - HDMI
  - Ethernet 1000-BaseT
  - PCIe (mini PCIe connector)
  - MicroSD slot
  - USB2 and USB3 connectors
  - Sata
  - 40 pins GPIO header

Signed-off-by: Alain Volmat <avolmat@me.com>
---
v2: fix bootargs (removal of console=)
    removal of rng11 node, moved into stih418.dtsi

 arch/arm/boot/dts/Makefile          |   3 +-
 arch/arm/boot/dts/stih418-b2264.dts | 123 ++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/stih418-b2264.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3d1ea0b25168..5ad1b0854b66 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1059,7 +1059,8 @@ dtb-$(CONFIG_ARCH_STI) += \
 	stih407-b2120.dtb \
 	stih410-b2120.dtb \
 	stih410-b2260.dtb \
-	stih418-b2199.dtb
+	stih418-b2199.dtb \
+	stih418-b2264.dtb
 dtb-$(CONFIG_ARCH_STM32) += \
 	stm32f429-disco.dtb \
 	stm32f469-disco.dtb \
diff --git a/arch/arm/boot/dts/stih418-b2264.dts b/arch/arm/boot/dts/stih418-b2264.dts
new file mode 100644
index 000000000000..b70a76d3faa2
--- /dev/null
+++ b/arch/arm/boot/dts/stih418-b2264.dts
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 STMicroelectronics
+ * Author: Alain Volmat <avolmat@me.com>
+ */
+/dts-v1/;
+#include "stih418.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+/ {
+	model = "STiH418 B2264";
+	compatible = "st,stih418-b2264", "st,stih418";
+
+	chosen {
+		bootargs = "clk_ignore_unused";
+		stdout-path = &sbc_serial0;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0xc0000000>;
+	};
+
+	cpus {
+		cpu@0 {
+			operating-points-v2 = <&cpu_opp_table>;
+			/* u-boot puts hpen in SBC dmem at 0xb8 offset */
+			cpu-release-addr = <0x94100b8>;
+		};
+		cpu@1 {
+			operating-points-v2 = <&cpu_opp_table>;
+			/* u-boot puts hpen in SBC dmem at 0xb8 offset */
+			cpu-release-addr = <0x94100b8>;
+		};
+		cpu@2 {
+			operating-points-v2 = <&cpu_opp_table>;
+			/* u-boot puts hpen in SBC dmem at 0xb8 offset */
+			cpu-release-addr = <0x94100b8>;
+		};
+		cpu@3 {
+			operating-points-v2 = <&cpu_opp_table>;
+			/* u-boot puts hpen in SBC dmem at 0xb8 offset */
+			cpu-release-addr = <0x94100b8>;
+		};
+	};
+
+	cpu_opp_table: opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <784000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <784000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <784000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <784000>;
+		};
+	};
+
+	aliases {
+		ttyAS0 = &sbc_serial0;
+		ethernet0 = &ethernet0;
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ethernet0 {
+	phy-mode = "rgmii";
+	pinctrl-0 = <&pinctrl_rgmii1 &pinctrl_rgmii1_mdio_1>;
+	st,tx-retime-src = "clkgen";
+
+	snps,reset-gpio = <&pio0 7 0>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 1000000>;
+
+	status = "okay";
+};
+
+&miphy28lp_phy {
+	phy_port0: port@9b22000 {
+		st,sata-gen = <2>; /* SATA GEN3 */
+		st,osc-rdy;
+	};
+};
+
+&mmc0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&sata0 {
+	status = "okay";
+};
+
+&sbc_serial0 {
+	status = "okay";
+};
+
+&spifsm {
+	status = "okay";
+};
+
+&st_dwc3 {
+	status = "okay";
+};
-- 
2.17.1

