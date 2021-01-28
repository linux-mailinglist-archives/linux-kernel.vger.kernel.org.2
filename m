Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E083070BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhA1IJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:09:18 -0500
Received: from st43p00im-ztdg10061801.me.com ([17.58.63.170]:55407 "EHLO
        st43p00im-ztdg10061801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231748AbhA1IIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:08:35 -0500
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2021 03:08:34 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1611820710; bh=FSgaKGCiFPenWfymsqIEJP0WGHvjnaLoyczl6YjPC+w=;
        h=From:To:Subject:Date:Message-Id;
        b=TNI9W4Jm7D/U6zVX1ipOliIM0nfnjNgY3qd/c13eCialTv9lz7HbMb6oLdHCoXO5t
         FGc4LtCJpPfVZHW5ZPjpakosaykYCYYhdNWOr/tLRWkC2OLUwMDQWR2ZbhaYYAtLhu
         3Zr2pvr1pNuYtkES1uiPsOgAdbcvnI62KyEFBmbdAu9qD2iRnNlKydEYA8TRoq79Uh
         ETWi1kNeUyyWgX9qQQx+JqkWBnz9KRy+XtZF4Zxcw+uZGKP9mpwthGRNTbtvaXbVKP
         l6ZryM4ggWQGRKGXCEu1vTBUitZSHCYBcsqgUh0obrd9OQH+JGKwhww63GoZEsM4kr
         mCMCkKvvF9akw==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10061801.me.com (Postfix) with ESMTPSA id 43ED38C02F6;
        Thu, 28 Jan 2021 07:58:27 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 2/2] ARM: dts: sti: Introduce 4KOpen (stih418-b2264) board
Date:   Thu, 28 Jan 2021 08:58:25 +0100
Message-Id: <20210128075825.10368-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_02:2021-01-27,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2101280039
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
 arch/arm/boot/dts/Makefile          |   3 +-
 arch/arm/boot/dts/stih418-b2264.dts | 127 ++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+), 1 deletion(-)
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
index 000000000000..55529cd7c8a6
--- /dev/null
+++ b/arch/arm/boot/dts/stih418-b2264.dts
@@ -0,0 +1,127 @@
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
+		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
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
+&rng11 {
+	status = "disabled";
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

