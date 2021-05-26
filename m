Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DB8391A32
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhEZOb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:31:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41342 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhEZObY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:31:24 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QETnhp053471;
        Wed, 26 May 2021 09:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622039389;
        bh=iOZkqfsqaVcoyRAJqzab8GdtmEBlK2SCryqfuxCDmhA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=n3o/QB5/5xpE9r8ucI/hV/xo0v+qpMlyXUwbpqyhj6h3wtSWdsE5XtAPVltBJMaS7
         HPenw+Vl8jLqSM+xDX24ydaAmTr/5GmuyOddEEhBzltXSfoYWKP92Cr6D+21fc+Msz
         T6TY2Bg12PZshglFbpd/mKkpf+YCZXecwWhKBtsQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QETnQ3040677
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 09:29:49 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 09:29:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 09:29:49 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QETMcd030380;
        Wed, 26 May 2021 09:29:45 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 4/5] arm64: dts: ti: k3-am642-sk: Enable USB Super-Speed HOST port
Date:   Wed, 26 May 2021 19:59:20 +0530
Message-ID: <20210526142921.12127-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210526142921.12127-1-kishon@ti.com>
References: <20210526142921.12127-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB Super-Speed HOST port.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 8424cd071955..077b87656fbc 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -5,6 +5,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/mux/ti-serdes.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
 #include "k3-am642.dtsi"
@@ -85,6 +87,12 @@
 		>;
 	};
 
+	main_usb0_pins_default: main-usb0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
+		>;
+	};
+
 	main_i2c1_pins_default: main-i2c1-pins-default {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
@@ -235,6 +243,33 @@
 	disable-wp;
 };
 
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_USB>;
+};
+
+&serdes0 {
+	serdes0_usb_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_USB3>;
+		resets = <&serdes_wiz0 1>;
+	};
+};
+
+&usbss0 {
+	ti,vbus-divider;
+};
+
+&usb0 {
+	dr_mode = "host";
+	maximum-speed = "super-speed";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usb0_pins_default>;
+	phys = <&serdes0_usb_link>;
+	phy-names = "cdns3,usb3-phy";
+};
+
 &cpsw3g {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mdio1_pins_default
-- 
2.17.1

