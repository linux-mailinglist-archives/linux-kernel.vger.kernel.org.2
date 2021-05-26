Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254D9391A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhEZObW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:31:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43188 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbhEZObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:31:21 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QETj2a108533;
        Wed, 26 May 2021 09:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622039385;
        bh=Ps9WD6JyeTZxfA3Ol9ZaQRBlCX51sSBKBNSIql3lqwA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=G/cxHSxy0yjpcEZyoY6ldwEg6Sw8XF1a/A0wqMUrc9X0aJwRh1JNWYyn9NxYotOgM
         dFgAgLd11s/mCxa4Ls7RjRVO1wXhlkYAKu/BWnUgr4TS3ettKg9xlVQaN/7Ff2fdFb
         /i61+3VysPGT6NY1Ra1OOKt2X2XEUhzi1tHx5fgA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QETjb0018758
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 09:29:45 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 09:29:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 09:29:44 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QETMcc030380;
        Wed, 26 May 2021 09:29:38 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 3/5] arm64: dts: ti: k3-am642-evm: Enable PCIe and SERDES
Date:   Wed, 26 May 2021 19:59:19 +0530
Message-ID: <20210526142921.12127-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210526142921.12127-1-kishon@ti.com>
References: <20210526142921.12127-1-kishon@ti.com>
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

