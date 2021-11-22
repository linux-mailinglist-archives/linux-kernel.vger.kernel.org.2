Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DF3458F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239697AbhKVNpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:45:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59186 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239521AbhKVNpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:45:39 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AMDgReV101450;
        Mon, 22 Nov 2021 07:42:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637588548;
        bh=R7b+26Ge6Y3ZdvGzdc/1Ao8T0zcbp1l6n6UKhX3rY3c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IvIcrixGkYrav7m5myQfOiaRxHudeozP22Wosx8wAJUMP8vkjQol8VuhA6Dleld0o
         jOxzMAUJ6kvcsqDcRFMGx9NjlsDnKDTNVSF6kq+vrCqbs8uA0tutHWcODjGt9u5qWx
         sSzvV4dkZc8N12k58BLK8AokiS+hDu9HnN3UX2A4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AMDgRsH001620
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Nov 2021 07:42:27 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 22
 Nov 2021 07:42:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 22 Nov 2021 07:42:27 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AMDg04w023508;
        Mon, 22 Nov 2021 07:42:24 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/6] arm64: dts: ti: k3-am64-main: Add support for MCAN
Date:   Mon, 22 Nov 2021 19:11:57 +0530
Message-ID: <20211122134159.29936-6-a-govindraju@ti.com>
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

Add Support for two MCAN controllers present on the am64x SOC. Both support
classic CAN messages as well as CAN-FD.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 5ad638b95ffc..07cadbfcc436 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1253,4 +1253,32 @@
 			bus_freq = <1000000>;
 		};
 	};
+
+	main_mcan0: can@20701000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x20701000 0x00 0x200>,
+		      <0x00 0x20708000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 98 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 98 5>, <&k3_clks 98 0>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan1: can@20711000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x20711000 0x00 0x200>,
+		      <0x00 0x20718000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 99 TI_SCI_PD_EXCLUSIVE>;
+		clocks =  <&k3_clks 99 5>, <&k3_clks 99 0>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
 };
-- 
2.17.1

