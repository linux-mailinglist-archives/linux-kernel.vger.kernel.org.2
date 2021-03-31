Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8D350874
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbhCaUo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:44:27 -0400
Received: from st43p00im-zteg10062001.me.com ([17.58.63.166]:38063 "EHLO
        st43p00im-zteg10062001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236759AbhCaUn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1617223436; bh=VcVAguE+Ld81/uBqahOdREcVt6Dk0BmX80B63ohRlQg=;
        h=From:To:Subject:Date:Message-Id;
        b=JFlAze69sDkmGDPVUddvb8S6gmGWdUFdgHKBE/IRjzp9ijuhWWMcwLuVKzOTB/f7a
         PBZScYf7z9T0RHSNAPT4fjvO5UM7PEKLjR5FXthFlLAmv6b9eNrTuXlZ/oPdCEyYV0
         5EyR95nZSVMqYBPt+Gkdt50KlTBECofCr9HippQm7OMZLyNtKaCGH1th07CkrKN6iq
         8tETQ0G/6oKxcX4cPQOzj4+dM2wq0cKDB5WjryLIz0EPB8tbr7YCUUNVYDsY0WM97E
         yMAyqyoEnFLJ7yziMTCX54s1Km+bp/NZrz1gLMKUU4lwslZZihzzQwIuaXrRuNRsD+
         9WvCYDTx8jFiA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10062001.me.com (Postfix) with ESMTPSA id 361C16C065C;
        Wed, 31 Mar 2021 20:43:54 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v3 13/13] ARM: dts: sti: Introduce 4KOpen (stih418-b2264) board
Date:   Wed, 31 Mar 2021 22:42:28 +0200
Message-Id: <20210331204228.26107-14-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331204228.26107-1-avolmat@me.com>
References: <20210331204228.26107-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-31=5F08:2021-03-31=5F02,2021-03-31=5F08,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 mlxscore=0
 spamscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103310144
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
v3: add 300MHz opp, add led, add ethernet pinctrl
v2: fix bootargs (removal of console=)
    removal of rng11 node, moved into stih418.dtsi

 arch/arm/boot/dts/Makefile          |   3 +-
 arch/arm/boot/dts/stih418-b2264.dts | 151 ++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/stih418-b2264.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8e5d4ab4e75e..3c1877627e91 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1061,7 +1061,8 @@ dtb-$(CONFIG_ARCH_STI) += \
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
index 000000000000..a99604bebf8c
--- /dev/null
+++ b/arch/arm/boot/dts/stih418-b2264.dts
@@ -0,0 +1,151 @@
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
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <784000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <784000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <784000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <784000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <784000>;
+		};
+	};
+
+	aliases {
+		ttyAS0 = &sbc_serial0;
+		ethernet0 = &ethernet0;
+	};
+
+	soc {
+		leds {
+			compatible = "gpio-leds";
+			green {
+				gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
+				default-state = "off";
+			};
+		};
+
+		pin-controller-sbc@961f080 {
+			gmac1 {
+				rgmii1-0 {
+					st,pins {
+						rxd0 = <&pio1 4 ALT1 IN DE_IO 300 CLK_A>;
+						rxd1 = <&pio1 5 ALT1 IN DE_IO 300 CLK_A>;
+						rxd2 = <&pio1 6 ALT1 IN DE_IO 300 CLK_A>;
+						rxd3 = <&pio1 7 ALT1 IN DE_IO 300 CLK_A>;
+						rxdv = <&pio2 0 ALT1 IN DE_IO 300 CLK_A>;
+					};
+				};
+			};
+		};
+
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

