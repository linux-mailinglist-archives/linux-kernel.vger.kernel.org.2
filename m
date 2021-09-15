Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD17E40BF79
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbhIOFzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:55:55 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60324 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbhIOFzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:55:46 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18F5sPfe078817;
        Wed, 15 Sep 2021 00:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631685265;
        bh=pltqAs+YOhjy3EkF5pfP2nsBUkDXYIj0zWlXJYedrN0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VhNYI0Sr+qlGl5zqjFw0uUHVrRGtsnMq8phkZ84CYQ9NBzQjMBaNgbHIhE76gQQSB
         n4R5QHJJ+Gy6qbo32wUSuRoyXDUYwUW/WAR1bwfNKVErf1G6iGHRLIHYMb4bkuoxhp
         1bJx6ooGJvyS7TQX9khGvaAQJ249iIoshptBeb5k=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18F5sPI1011132
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 00:54:25 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Sep 2021 00:54:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Sep 2021 00:54:25 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18F5rwsf023333;
        Wed, 15 Sep 2021 00:54:21 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 6/6] arm64: dts: ti: k3-am65-main: Cleanup "ranges" property in "pcie" DT node
Date:   Wed, 15 Sep 2021 11:23:58 +0530
Message-ID: <20210915055358.19997-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210915055358.19997-1-kishon@ti.com>
References: <20210915055358.19997-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*dtbs_check* on
"Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml" YAML file
resulted in the following errors.

pcie@5500000: ranges: 'oneOf' conditional failed, one must be fixed:
pcie@5600000: ranges: 'oneOf' conditional failed, one must be fixed

Cleanup "ranges" property in "pcie" DT node to fix the above errors.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index ba4e5d3e1ed7..ce8bb4a61011 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -692,8 +692,8 @@
 		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <3>;
 		#size-cells = <2>;
-		ranges = <0x81000000 0 0          0x0 0x10020000 0 0x00010000
-			  0x82000000 0 0x10030000 0x0 0x10030000 0 0x07FD0000>;
+		ranges = <0x81000000 0 0          0x0 0x10020000 0 0x00010000>,
+			 <0x82000000 0 0x10030000 0x0 0x10030000 0 0x07FD0000>;
 		ti,syscon-pcie-id = <&pcie_devid>;
 		ti,syscon-pcie-mode = <&pcie0_mode>;
 		bus-range = <0x0 0xff>;
@@ -725,8 +725,8 @@
 		power-domains = <&k3_pds 121 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <3>;
 		#size-cells = <2>;
-		ranges = <0x81000000 0 0          0x0   0x18020000 0 0x00010000
-			  0x82000000 0 0x18030000 0x0   0x18030000 0 0x07FD0000>;
+		ranges = <0x81000000 0 0          0x0   0x18020000 0 0x00010000>,
+			 <0x82000000 0 0x18030000 0x0   0x18030000 0 0x07FD0000>;
 		ti,syscon-pcie-id = <&pcie_devid>;
 		ti,syscon-pcie-mode = <&pcie1_mode>;
 		bus-range = <0x0 0xff>;
-- 
2.17.1

