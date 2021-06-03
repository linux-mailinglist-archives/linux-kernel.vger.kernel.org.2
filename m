Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476A539A308
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhFCOZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:25:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52894 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhFCOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:25:01 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 153ENCoj097011;
        Thu, 3 Jun 2021 09:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622730192;
        bh=Ps9WD6JyeTZxfA3Ol9ZaQRBlCX51sSBKBNSIql3lqwA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mpfzHZw+9FwDck+d+iY6IfTa50dbuVPCHGLzoNjfeqa/U5rCunWaXHUDZTG2xzZE8
         ARcQcKs/Ug6kPsZ9B9WtsVzavHM8/eujw2+96D7UbXUpf9EvCNCYxO0VD7SwUAoP+H
         Q+ZXYzjoke3ystOfFm4VKAKVwLFrosb0ks/lbb+A=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 153ENBTx005092
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jun 2021 09:23:12 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 09:23:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 3 Jun 2021 09:23:11 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 153EMpNI039957;
        Thu, 3 Jun 2021 09:23:06 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 3/5] arm64: dts: ti: k3-am642-evm: Enable PCIe and SERDES
Date:   Thu, 3 Jun 2021 19:52:49 +0530
Message-ID: <20210603142251.14563-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603142251.14563-1-kishon@ti.com>
References: <20210603142251.14563-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM642 EVM has a x4 lane PCIe connector. Enable PCIe in RC mode here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index dad0efa961ed..8c27f563a390 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -5,6 +5,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/mux/ti-serdes.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
@@ -466,3 +468,31 @@
 &mailbox0_cluster7 {
 	status = "disabled";
 };
+
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_PCIE0>;
+};
+
+&serdes0 {
+	serdes0_pcie_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz0 1>;
+	};
+};
+
+&pcie0_rc {
+	reset-gpios = <&exp1 5 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
+};
+
+&pcie0_ep {
+	phys = <&serdes0_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
+	status = "disabled";
+};
-- 
2.17.1

