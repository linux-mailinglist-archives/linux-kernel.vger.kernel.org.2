Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F170B458F95
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbhKVNp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:45:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49002 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhKVNpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:45:23 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AMDg9QJ120970;
        Mon, 22 Nov 2021 07:42:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637588529;
        bh=71iTNYvSXz7PJ6/1p3pzVlud0Eg7uyTxPUQOHqjQ5fk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rn6JwJFJtVWpzj8o+ttD64AE/38KJ8JVu3BecZ1+3Biv3Y1oqF+v8OFB/Lv+J9NvD
         uFnS4c3Eet/jzXRt9LlouaY9j2k5fC3IQHe4O6fW4XczqRsGiBX9gyqBS9mCQ4Bwfa
         Do29VlRLOnZn6oEb21HoyxMhi5UN0UhLLH+aqE6k=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AMDg92m001060
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Nov 2021 07:42:09 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 22
 Nov 2021 07:42:09 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 22 Nov 2021 07:42:09 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AMDg04s023508;
        Mon, 22 Nov 2021 07:42:06 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/6] arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
Date:   Mon, 22 Nov 2021 19:11:53 +0530
Message-ID: <20211122134159.29936-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211122134159.29936-1-a-govindraju@ti.com>
References: <20211122134159.29936-1-a-govindraju@ti.com>
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
index c93ff1520a0e..8d592bf41d6f 100644
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
+		clocks = <&k3_clks 102 5>, <&k3_clks 102 0>;
+		clock-names = "hclk", "cclk";
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
+		clocks = <&k3_clks 103 5>, <&k3_clks 103 0>;
+		clock-names = "hclk", "cclk";
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

