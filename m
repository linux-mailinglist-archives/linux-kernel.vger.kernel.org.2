Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D6D387408
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347454AbhERIaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346294AbhERIaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:30:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D885DC061756
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 01:28:59 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1liv5x-00074h-4D; Tue, 18 May 2021 10:28:53 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1liv5v-0006oD-NS; Tue, 18 May 2021 10:28:51 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH v1 7/9] ARM: dts: imx6qdl-vicut1: add interrupt-counter nodes
Date:   Tue, 18 May 2021 10:28:48 +0200
Message-Id: <20210518082850.26048-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210518082850.26048-1-o.rempel@pengutronix.de>
References: <20210518082850.26048-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

interrupt-counter is mainline now, so we can add missing counter nodes.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 41 ++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
index eb25d21a2ace..b9e305774fed 100644
--- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
@@ -40,6 +40,27 @@ comp0_out: endpoint {
 		};
 	};
 
+	counter-0 {
+		compatible = "interrupt-counter";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_counter0>;
+		gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+	};
+
+	counter-1 {
+		compatible = "interrupt-counter";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_counter1>;
+		gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
+	};
+
+	counter-2 {
+		compatible = "interrupt-counter";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_counter2>;
+		gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
@@ -254,7 +275,7 @@ &gpio1 {
 
 &gpio2 {
 	gpio-line-names =
-		"", "", "", "", "", "", "", "",
+		"count0", "count1", "count2", "", "", "", "", "",
 		"REV_ID0", "REV_ID1", "REV_ID2", "REV_ID3", "REV_ID4",
 			"BOARD_ID0", "BOARD_ID1", "BOARD_ID2",
 		"", "", "", "", "", "", "", "ON_SWITCH",
@@ -572,6 +593,24 @@ MX6QDL_PAD_KEY_ROW3__GPIO4_IO13			0x13008
 		>;
 	};
 
+	pinctrl_counter0: counter0grp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D0__GPIO2_IO00			0x1b000
+		>;
+	};
+
+	pinctrl_counter1: counter1grp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D1__GPIO2_IO01			0x1b000
+		>;
+	};
+
+	pinctrl_counter2: counter2grp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D2__GPIO2_IO02			0x1b000
+		>;
+	};
+
 	pinctrl_ecspi1: ecspi1grp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D17__ECSPI1_MISO			0x100b1
-- 
2.29.2

