Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FB136E37B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 05:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbhD2DHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 23:07:03 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56292 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhD2DG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 23:06:59 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 24DBE1A047E;
        Thu, 29 Apr 2021 05:06:13 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BEBDF1A11E2;
        Thu, 29 Apr 2021 05:06:08 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0986F402D2;
        Thu, 29 Apr 2021 05:06:02 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shengjiu.wang@gmail.com
Subject: [PATCH 2/2] ARM: dts: imx6qdl-sabresd: Configure the gpio for hp detect
Date:   Thu, 29 Apr 2021 10:50:27 +0800
Message-Id: <1619664627-12470-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619664627-12470-1-git-send-email-shengjiu.wang@nxp.com>
References: <1619664627-12470-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the gpio for hp detect for wm8962 sound card

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index d20eaac6c5d6..4728dc612912 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -97,6 +97,8 @@ sound {
 		compatible = "fsl,imx6q-sabresd-wm8962",
 			   "fsl,imx-audio-wm8962";
 		model = "wm8962-audio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hp>;
 		ssi-controller = <&ssi2>;
 		audio-codec = <&codec>;
 		audio-asrc = <&asrc>;
@@ -546,6 +548,13 @@ MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE	0x1f8b0
 			>;
 		};
 
+		pinctrl_hp: hpgrp {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_RST__GPIO7_IO08          0x80000000
+				MX6QDL_PAD_GPIO_9__GPIO1_IO09           0x80000000
+			>;
+		};
+
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <
 				MX6QDL_PAD_CSI0_DAT8__I2C1_SDA		0x4001b8b1
-- 
2.27.0

