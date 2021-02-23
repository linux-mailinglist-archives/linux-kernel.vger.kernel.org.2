Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0E13230D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhBWSet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbhBWSed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:34:33 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84676C06174A;
        Tue, 23 Feb 2021 10:33:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8DF571F44741
Received: by jupiter.universe (Postfix, from userid 1000)
        id 35A844800DD; Tue, 23 Feb 2021 19:33:49 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCHv1 3/4] ARM: dts: imx: bx50v3: i2c GPIOs are open drain
Date:   Tue, 23 Feb 2021 19:33:45 +0100
Message-Id: <20210223183346.138575-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210223183346.138575-1-sebastian.reichel@collabora.com>
References: <20210223183346.138575-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly mark I2C GPIOs as open drain to fix the following
kernel message being printed:

enforced open drain please flag it properly in DT/ACPI DSDT/board file

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/boot/dts/imx6q-bx50v3.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index 2a98cc657595..10922375c51e 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -173,8 +173,8 @@ m25_eeprom: m25p80@0 {
 &i2c1 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	sda-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH>;
-	scl-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio5 26 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	scl-gpios = <&gpio5 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 	pca9547: mux@70 {
 		compatible = "nxp,pca9547";
@@ -315,15 +315,15 @@ mux1_i2c8: i2c@7 {
 &i2c2 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-1 = <&pinctrl_i2c2_gpio>;
-	sda-gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;
-	scl-gpios = <&gpio4 12 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio4 13 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	scl-gpios = <&gpio4 12 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 };
 
 &i2c3 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-1 = <&pinctrl_i2c3_gpio>;
-	sda-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
-	scl-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	scl-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 };
 
 &iomuxc {
-- 
2.30.0

