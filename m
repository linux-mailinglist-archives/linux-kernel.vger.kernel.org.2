Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B14314C32
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhBIJzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhBIJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:52:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12504C061356
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 01:51:55 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l9Pg3-0008AB-Ik; Tue, 09 Feb 2021 10:51:23 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l9Pg2-0007Kk-82; Tue, 09 Feb 2021 10:51:22 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 4/6] ARM: dts: imx6dl-prtvt7: add TSC2046 touchscreen node
Date:   Tue,  9 Feb 2021 10:51:19 +0100
Message-Id: <20210209095121.28098-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209095121.28098-1-o.rempel@pengutronix.de>
References: <20210209095121.28098-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen support to the Protonic VT7 board.

Co-Developed-by: Robin van der Gracht <robin@protonic.nl>
Signed-off-by: Robin van der Gracht <robin@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-prtvt7.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-prtvt7.dts b/arch/arm/boot/dts/imx6dl-prtvt7.dts
index d9cb1e41cc10..836026a0e219 100644
--- a/arch/arm/boot/dts/imx6dl-prtvt7.dts
+++ b/arch/arm/boot/dts/imx6dl-prtvt7.dts
@@ -266,6 +266,21 @@ &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi2>;
 	status = "okay";
+
+	touchscreen@0 {
+		compatible = "ti,tsc2046";
+		reg = <0>;
+		pinctrl-0 = <&pinctrl_tsc>;
+		pinctrl-names ="default";
+		spi-max-frequency = <100000>;
+		interrupts-extended = <&gpio3 20 IRQ_TYPE_EDGE_FALLING>;
+		pendown-gpio = <&gpio3 20 GPIO_ACTIVE_LOW>;
+		touchscreen-max-pressure = <4095>;
+		ti,vref-delay-usecs = /bits/ 16 <100>;
+		ti,x-plate-ohms = /bits/ 16 <800>;
+		ti,y-plate-ohms = /bits/ 16 <300>;
+		wakeup-source;
+	};
 };
 
 &i2c1 {
-- 
2.30.0

