Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F05D333B71
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 12:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhCJL2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 06:28:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36440 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbhCJL2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 06:28:23 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12ABSESQ018003;
        Wed, 10 Mar 2021 05:28:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615375694;
        bh=ge87k1lNVw4qDQDDKtQRqFjhE5UTWCSmp8i1undjTQ0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VmNS9yW2BX76QykXWWNfJf+KDGrt8gTicGI8JVxFprRMcxob9BVHL+v7T16TD7ut8
         ar1+5mX/jJxqNyR38gGLq9dntT6w62FC6UhKrmhXqwM2Chexmgmx+iz+xmBT/o16Nh
         t+LX94SDV3vREiVvE0E5aP21JzUm+9Ish9LT/zcQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12ABSErm011552
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 05:28:14 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 05:28:13 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 05:28:13 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12ABRxlU094609;
        Wed, 10 Mar 2021 05:28:10 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am642-evm: Add USB support
Date:   Wed, 10 Mar 2021 16:57:58 +0530
Message-ID: <20210310112758.1982-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310112758.1982-1-a-govindraju@ti.com>
References: <20210310112758.1982-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 EVM board has a micro USB 2.0 AB connector and the USB0_VBUS is
connected with a resistor divider in between. USB0_DRVVBUS pin is muxed
between USB0_DRVVBUS and GPIO1_79 signals.

Add the corresponding properties and set the pinmux mode for USB subsystem
in the evm dts file.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Acked-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 962ef807e286..45fdcf3220a8 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -201,6 +201,12 @@
 			AM64X_IOPAD(0x0144, PIN_OUTPUT, 4) /* (Y11) PRG1_PRU1_GPO15.RGMII2_TX_CTL */
 		>;
 	};
+
+	main_usb0_pins_default: main-usb0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
+		>;
+	};
 };
 
 &main_uart0 {
@@ -313,6 +319,18 @@
 	disable-wp;
 };
 
+&usbss0 {
+	ti,vbus-divider;
+	ti,usb2-only;
+};
+
+&usb0 {
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usb0_pins_default>;
+};
+
 &cpsw3g {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mdio1_pins_default
-- 
2.17.1

