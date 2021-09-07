Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB354022DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 06:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhIGE0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 00:26:23 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:58200 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhIGE0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 00:26:21 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 1874PEhb031756; Tue, 7 Sep 2021 13:25:14 +0900
X-Iguazu-Qid: 34trVrK16G5dw5DW2U
X-Iguazu-QSIG: v=2; s=0; t=1630988714; q=34trVrK16G5dw5DW2U; m=d+hNUk+CCg0no2MI3kacZBgxgN7HA3TQyMzri5UixKc=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1513) id 1874PDQf006766
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 7 Sep 2021 13:25:13 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 969A610009A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:25:09 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 1874P9be032430
        for <linux-kernel@vger.kernel.org>; Tue, 7 Sep 2021 13:25:09 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     linux-arm-kernel@lists.infradead.org
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH] arm64: dts: visconti: Add PCIe host controller support for TMPV7708 SoC
Date:   Tue,  7 Sep 2021 13:25:00 +0900
X-TSB-HOP: ON
Message-Id: <20210907042500.1525771-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe node and fixed clock for PCIe in TMPV7708's dtsi,
and tmpv7708-rm-mbrc boards's dts.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../boot/dts/toshiba/tmpv7708-rm-mbrc.dts     |  6 +++
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi     | 52 +++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts b/arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts
index 29a4d9fc1e47..9375b0faeea2 100644
--- a/arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts
@@ -76,3 +76,9 @@ &pwm_mux {
 &pwm {
 	status = "okay";
 };
+
+&pcie {
+	status = "okay";
+	clocks = <&extclk100mhz>, <&clk600mhz>, <&clk25mhz>;
+	clock-names = "ref", "core", "aux";
+};
diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
index 4b4231ff43cf..5db9a012d6fc 100644
--- a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
@@ -134,6 +134,13 @@ uart_clk: uart-clk {
 		#clock-cells = <0>;
 	};
 
+	clk25mhz: clk25mhz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "clk25mhz";
+	};
+
 	clk125mhz: clk125mhz {
 		compatible = "fixed-clock";
 		clock-frequency = <125000000>;
@@ -148,6 +155,20 @@ clk300mhz: clk300mhz {
 		clock-output-names = "clk300mhz";
 	};
 
+	clk600mhz: clk600mhz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <600000000>;
+		clock-output-names = "clk600mhz";
+	};
+
+	extclk100mhz: extclk100mhz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "extclk100mhz";
+	};
+
 	wdt_clk: wdt-clk {
 		compatible = "fixed-clock";
 		clock-frequency = <150000000>;
@@ -441,6 +462,37 @@ pwm: pwm@241c0000 {
 			#pwm-cells = <2>;
 			status = "disabled";
 		};
+
+		pcie: pcie@28400000 {
+			compatible = "toshiba,visconti-pcie";
+			reg = <0x0 0x28400000 0x0 0x00400000>,
+			      <0x0 0x70000000 0x0 0x10000000>,
+			      <0x0 0x28050000 0x0 0x00010000>,
+			      <0x0 0x24200000 0x0 0x00002000>,
+			      <0x0 0x24162000 0x0 0x00001000>;
+			reg-names  = "dbi", "config", "ulreg", "smu", "mpu";
+			device_type = "pci";
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			num-viewport = <8>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges = <0x81000000 0 0x40000000 0 0x40000000 0 0x00010000
+				  0x82000000 0 0x50000000 0 0x50000000 0 0x20000000>;
+			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "intr";
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map =
+				<0 0 0 1 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
+				 0 0 0 2 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
+				 0 0 0 3 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
+				 0 0 0 4 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+			max-link-speed = <2>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.32.0


