Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE2638241A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbhEQGTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:19:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55352 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbhEQGTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:19:45 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14H6IPTb040896;
        Mon, 17 May 2021 01:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621232305;
        bh=OJetcwDGbQX4ue/VlKx+DIF0UQkBwHYH6uHoefzoJOY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IE5ep8V1lOaWeYZz487oQpm8sdZkvjtoDeuHVy4DuqN3ETM85fo+GSkfb+wS0XLzB
         EcAX1LAPt4OoUhSXjiHhKVi97lBSFBw4+0zkWQo57apWtFAbkI9UB28HND7zrJHXA3
         moQ94b7IYW/NP22vZxmQPE8Kg/VM8qcHcqDY6bGI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14H6IPui021165
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 May 2021 01:18:25 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 17
 May 2021 01:18:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 17 May 2021 01:18:24 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14H6Hpl3003911;
        Mon, 17 May 2021 01:18:15 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, <a-govindraju@ti.com>
Subject: [PATCH v2 3/6] arm64: dts: ti: k3-am64-main: Add PCIe DT node
Date:   Mon, 17 May 2021 11:47:36 +0530
Message-ID: <20210517061739.5762-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517061739.5762-1-kishon@ti.com>
References: <20210517061739.5762-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 has one PCIe instance which can be configured in either
host mode (RC) or device mode (EP). Add PCIe DT node for host
mode and device mode here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 46 ++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index d4b0ddcc22ed..74fa6f918ec5 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -728,4 +728,50 @@
 			#clock-cells = <1>;
 		};
 	};
+
+	pcie0_rc: pcie@f102000 {
+		compatible = "ti,am64-pcie-host", "ti,j721e-pcie-host";
+		reg = <0x00 0x0f102000 0x00 0x1000>,
+		      <0x00 0x0f100000 0x00 0x400>,
+		      <0x00 0x0d000000 0x00 0x00800000>,
+		      <0x00 0x68000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 203 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&main_conf 0x4070>;
+		max-link-speed = <2>;
+		num-lanes = <1>;
+		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 114 0>, <&serdes0 CDNS_TORRENT_REFCLK_DRIVER>;
+		clock-names = "fck", "pcie_refclk";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xff>;
+		cdns,no-bar-match-nbits = <64>;
+		vendor-id = <0x104c>;
+		device-id = <0xb010>;
+		msi-map = <0x0 &gic_its 0x0 0x10000>;
+		ranges = <0x01000000 0x00 0x68001000  0x00 0x68001000  0x00 0x0010000>,
+			 <0x02000000 0x00 0x68011000  0x00 0x68011000  0x00 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x00000010 0x0>;
+	};
+
+	pcie0_ep: pcie-ep@f102000 {
+		compatible = "ti,am64-pcie-ep", "ti,j721e-pcie-ep";
+		reg = <0x00 0x0f102000 0x00 0x1000>,
+		      <0x00 0x0f100000 0x00 0x400>,
+		      <0x00 0x0d000000 0x00 0x00800000>,
+		      <0x00 0x68000000 0x00 0x08000000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 203 IRQ_TYPE_EDGE_RISING>;
+		ti,syscon-pcie-ctrl = <&main_conf 0x4070>;
+		max-link-speed = <2>;
+		num-lanes = <1>;
+		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 114 0>;
+		clock-names = "fck";
+		max-functions = /bits/ 8 <1>;
+	};
 };
-- 
2.17.1

