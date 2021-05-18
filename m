Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC99387418
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347510AbhERIaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347500AbhERIal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:30:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C13C06138C
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 01:29:22 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1liv5x-00074c-4J; Tue, 18 May 2021 10:28:53 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1liv5v-0006nU-Iq; Tue, 18 May 2021 10:28:51 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH v1 2/9] ARM: dts: imx6dl-prtvt7: Remove backlight enable gpio
Date:   Tue, 18 May 2021 10:28:43 +0200
Message-Id: <20210518082850.26048-3-o.rempel@pengutronix.de>
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

The backlight power is controlled through the reg_bl_12v0 regulator.

Co-Developed-by: Robin van der Gracht <robin@protonic.nl>
Signed-off-by: Robin van der Gracht <robin@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-prtvt7.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-prtvt7.dts b/arch/arm/boot/dts/imx6dl-prtvt7.dts
index 428ed9f6bc17..a8e72c7699cd 100644
--- a/arch/arm/boot/dts/imx6dl-prtvt7.dts
+++ b/arch/arm/boot/dts/imx6dl-prtvt7.dts
@@ -21,14 +21,11 @@ memory@10000000 {
 
 	backlight_lcd: backlight-lcd {
 		compatible = "pwm-backlight";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_backlight>;
 		pwms = <&pwm1 0 500000>;
 		brightness-levels = <0 20 81 248 1000>;
 		default-brightness-level = <20>;
 		num-interpolated-steps = <21>;
 		power-supply = <&reg_bl_12v0>;
-		enable-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
 	};
 
 	keys {
@@ -315,12 +312,6 @@ MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS		0x130b0
 		>;
 	};
 
-	pinctrl_backlight: backlightgrp {
-		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT7__GPIO4_IO28	0x1b0b0
-		>;
-	};
-
 	pinctrl_can1phy: can1phy {
 		fsl,pins = <
 			/* CAN1_SR */
-- 
2.29.2

