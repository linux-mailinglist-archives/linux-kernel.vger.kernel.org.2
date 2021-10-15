Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAE542EC81
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbhJOIiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:38:51 -0400
Received: from comms.puri.sm ([159.203.221.185]:44794 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237146AbhJOIir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:38:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 8698EDFE40;
        Fri, 15 Oct 2021 01:36:11 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KTQfCWuuvvJJ; Fri, 15 Oct 2021 01:36:10 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        krzk@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [RFC PATCH v1 2/4] arm64: dts: imx8mq-librem5: describe power supply for cameras
Date:   Fri, 15 Oct 2021 10:35:04 +0200
Message-Id: <20211015083506.4182875-3-martin.kepplinger@puri.sm>
In-Reply-To: <20211015083506.4182875-1-martin.kepplinger@puri.sm>
References: <20211015083506.4182875-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CAMERA_PWR_EN controls two different power supplies that cameras will use.
The hardware killswitch controls a third one. Describe that appropriately.

The pinctrl that describes the gpio that is used in 2 places here is added
to the pmic. The pmic is powered early enough to make sure this will work.

this patch is not ideal and hence an RFC I'm not yet signing-off on: When
putting the same pinctrl property into the 2 regulator nodes (instead of the
pmic), we get:

imx8mq-pinctrl 30330000.pinctrl: pin MX8MQ_IOMUXC_GPIO1_IO00 already requested by regulator-csi-1v8; cannot claim for regulator-vcam-2v8
imx8mq-pinctrl 30330000.pinctrl: pin-10 (regulator-vcam-2v8) status -22
imx8mq-pinctrl 30330000.pinctrl: could not request pin 10 (MX8MQ_IOMUXC_GPIO1_IO00) from group camerapwrgrp  on device 30330000.pinctrl

so that's a limitation to use the pinctrl only in one place. Is that
intended or am I missing something?

The one other possibility I see is to add *another* regulator that looks
something like so - that would be the only one controlling the gpio and having
the pinctrl property:

	reg_camera_pwr_en: regulator-camera-pwr-en {
		compatible = "regulator-fixed";
		regulator-name = "CAMERA_PWR_EN";
		pinctrl-names = "default";
		pinctrl-0 = <&pinctrl_camera_pwr>;
		gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
		enable-active-high;
	};

and the regulators I actually *want* to describe would all include

		vin-supply = <&reg_camera_pwr_en>;

My problem with that alternative is that I basically describe a regulator that
doesn't really exist in hardware. Do you know what's the prefererred way to
describe our hardware here?

thank you very much!

                                martin
---
 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 50 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 3f7524400a63..c385f9e0d5f7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -60,6 +60,40 @@ reg_aud_1v8: regulator-audio-1v8 {
 		enable-active-high;
 	};
 
+	/*
+	 * the pinctrl for reg_csi_1v8 and reg_vcam_1v8 is added to the PMIC
+	 * since we can't have it twice in the 2 different regulator nodes.
+	 */
+	reg_csi_1v8: regulator-csi-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "CAMERA_VDDIO_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&reg_vdd_3v3>;
+		gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	/* controlled by the CAMERA_POWER_KEY HKS */
+	reg_vcam_1v2: regulator-vcam-1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "CAMERA_VDDD_1V2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&reg_vdd_1v8>;
+		enable-active-high;
+	};
+
+	reg_vcam_2v8: regulator-vcam-2v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "CAMERA_VDDA_2V8";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&reg_vdd_3v3>;
+		gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_gnss: regulator-gnss {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -307,6 +341,20 @@ MX8MQ_IOMUXC_NAND_DQS_GPIO3_IO14	0x83
 		>;
 	};
 
+	pinctrl_camera_pwr: camerapwrgrp {
+		fsl,pins = <
+			/* CAMERA_PWR_EN_3V3 */
+			MX8MQ_IOMUXC_GPIO1_IO00_GPIO1_IO0	0x83
+		>;
+	};
+
+	pinctrl_csi1: csi1grp {
+		fsl,pins = <
+			/* CSI1_NRST */
+			MX8MQ_IOMUXC_ENET_RXC_GPIO1_IO25	0x83
+		>;
+	};
+
 	pinctrl_charger_in: chargeringrp {
 		fsl,pins = <
 			/* CHRG_INT */
@@ -689,7 +737,7 @@ pmic: pmic@4b {
 		compatible = "rohm,bd71837";
 		reg = <0x4b>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
+		pinctrl-0 = <&pinctrl_pmic>, <&pinctrl_camera_pwr>;
 		clocks = <&pmic_osc>;
 		clock-names = "osc";
 		clock-output-names = "pmic_clk";
-- 
2.30.2

