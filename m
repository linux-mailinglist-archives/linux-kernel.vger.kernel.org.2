Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA85A391A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhEZObO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:31:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41312 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbhEZObM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:31:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QETcs9053342;
        Wed, 26 May 2021 09:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622039378;
        bh=fGO2h0FalNRLYtLet4xVIFeW18fXKzPP8/zVoDKLW9Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Y5EYwNHxCmxEDcpGCe+OiWAyFC1lQiTLZ1XM9fTuAcDa3qQJflZnZ3SXuW5DKtzB/
         FLUwTQJN6R6SScHLGzQ63H8mO7XQqkAPyhB6TQ6XCe39O8Y/XvdLZcp4nSipMl/qUr
         29UgKwQG6IMJc4XqcCuSF58cKr2/72y9dBH5nUqk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QETco0018655
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 09:29:38 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 09:29:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 09:29:37 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QETMcb030380;
        Wed, 26 May 2021 09:29:34 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 2/5] arm64: dts: ti: k3-am64-main: Add PCIe DT node
Date:   Wed, 26 May 2021 19:59:18 +0530
Message-ID: <20210526142921.12127-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210526142921.12127-1-kishon@ti.com>
References: <20210526142921.12127-1-kishon@ti.com>
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
index a67f10406a8e..9c77f7da5d28 100644
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

