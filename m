Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A15C309C6D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhAaNp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 08:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhAaLc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 06:32:26 -0500
X-Greylist: delayed 740 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 31 Jan 2021 03:07:21 PST
Received: from forward101j.mail.yandex.net (forward101j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9103C06174A;
        Sun, 31 Jan 2021 03:07:21 -0800 (PST)
Received: from forward100q.mail.yandex.net (forward100q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb97])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id DA8811BE10DC;
        Sun, 31 Jan 2021 13:54:56 +0300 (MSK)
Received: from vla3-eea282d0d1fe.qloud-c.yandex.net (vla3-eea282d0d1fe.qloud-c.yandex.net [IPv6:2a02:6b8:c15:2583:0:640:eea2:82d0])
        by forward100q.mail.yandex.net (Yandex) with ESMTP id D0DA17080004;
        Sun, 31 Jan 2021 13:54:56 +0300 (MSK)
Received: from vla1-1bc5b51c612f.qloud-c.yandex.net (vla1-1bc5b51c612f.qloud-c.yandex.net [2a02:6b8:c0d:89c:0:640:1bc5:b51c])
        by vla3-eea282d0d1fe.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 9aQN5COtRa-suHSJsSu;
        Sun, 31 Jan 2021 13:54:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1612090496;
        bh=x54Eh5zKLxajbavx3Y26WB3HuzuneTq+axTaFN0C58s=;
        h=Subject:To:From:Message-Id:Cc:Date;
        b=h8hHCEsxZQ6yIUiQPMNNIJQEpWbIRMvf1dRlwp6gq/J1TIuCK41Wdw4JDSpcM9uPI
         w0Op5qeal8DBnADiYY9+321UJjiuYFSfgElPYjxp/2ZagpBioHzjKzNgSS/8AoJgp8
         yoCvFfZTQ7BrOLRGU6Xystp4chyQdjFzpwbijX3g=
Authentication-Results: vla3-eea282d0d1fe.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-1bc5b51c612f.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 3hzVEppz0N-stKqwEpU;
        Sun, 31 Jan 2021 13:54:55 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Dima Azarkin <azdmg@yandex.ru>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dima Azarkin <azdmg@yandex.ru>
Subject: [PATCH] ARM: dts: imx6qdl-wandboard: add scl/sda gpios definitions for i2c bus recovery
Date:   Sun, 31 Jan 2021 13:54:25 +0300
Message-Id: <20210131105425.21459-1-azdmg@yandex.ru>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c bus on imx6qdl-wandboard has intermittent issues where SDA can freeze
on low level at the end of transaction so the bus can no longer work. This
impacts reading of EDID data leading to incorrect TV resolution and no audio.

This scenario is improved by adding scl/sda gpios definitions to implement the
i2c bus recovery mechanism.

Signed-off-by: Dima Azarkin <azdmg@yandex.ru>
---
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index c070893c509e..b62a0dbb033f 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -97,15 +97,21 @@
 
 &i2c1 {
 	clock-frequency = <100000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio3 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio3 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 };
 
 &i2c2 {
 	clock-frequency = <100000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio4 12 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio4 13 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	codec: sgtl5000@a {
@@ -185,6 +191,13 @@
 			>;
 		};
 
+		pinctrl_i2c1_gpio: i2c1gpiogrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D21__GPIO3_IO21		0x4001b8b0
+				MX6QDL_PAD_EIM_D28__GPIO3_IO28		0x4001b8b0
+			>;
+		};
+
 		pinctrl_i2c2: i2c2grp {
 			fsl,pins = <
 				MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
@@ -192,6 +205,13 @@
 			>;
 		};
 
+		pinctrl_i2c2_gpio: i2c2gpiogrp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL3__GPIO4_IO12		0x4001b8b0
+				MX6QDL_PAD_KEY_ROW3__GPIO4_IO13		0x4001b8b0
+			>;
+		};
+
 		pinctrl_mclk: mclkgrp {
 			fsl,pins = <
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0
-- 
2.17.1

