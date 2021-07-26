Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B5D3D571F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhGZJaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:30:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44494 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhGZJaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:30:02 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16QAAMcb009328;
        Mon, 26 Jul 2021 05:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1627294222;
        bh=A4hiCbfPyccdnDJYgEyHnuwAvwjU46RUaLP4C+HxXkE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Xvf5TtvVskiSIJxki+S/7qgYy5CGall1PSlxYwShTHwKWr2bTCWEcrZf2ox4losmy
         ygcu2xw3AC8nGNnUaF1ZeLfXGgAgZ/PFB+aoF7XXu6AAeWdF1j0Fq+bSXO8XDGBMcu
         Izo4Cbubzn/aNrHvNgOExiEND1soZLhTtbJ4/bTg=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16QAAMGI017137
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Jul 2021 05:10:22 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 26
 Jul 2021 05:10:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 26 Jul 2021 05:10:22 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16QAACRe067730;
        Mon, 26 Jul 2021 05:10:18 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH v2 1/6] arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
Date:   Mon, 26 Jul 2021 15:40:07 +0530
Message-ID: <20210726101012.26983-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210726101012.26983-1-a-govindraju@ti.com>
References: <20210726101012.26983-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

Add Support for two MCAN controllers present on the am65x SOC. Both support
classic CAN messages as well as CAN-FD.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index c93ff1520a0e..6445f2d976e8 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -159,6 +159,36 @@
 		};
 	};
 
+	m_can0: mcan@40528000 {
+		compatible = "bosch,m_can";
+		reg = <0x0 0x40528000 0x0 0x400>,
+		      <0x0 0x40500000 0x0 0x4400>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 102 0>, <&k3_clks 102 5>;
+		clock-names = "cclk", "hclk";
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 544 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 545 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	m_can1: mcan@40568000 {
+		compatible = "bosch,m_can";
+		reg = <0x0 0x40568000 0x0 0x400>,
+		      <0x0 0x40540000 0x0 0x4400>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 103 0>, <&k3_clks 103 5>;
+		clock-names = "cclk", "hclk";
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 547 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 548 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
 	fss: fss@47000000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.17.1

