Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFAE3B95E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 20:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhGASJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 14:09:23 -0400
Received: from finn.gateworks.com ([108.161.129.64]:51866 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229844AbhGASJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 14:09:22 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1lz0zl-004R0S-Dk; Thu, 01 Jul 2021 18:01:01 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] ARM: dts: imx6qdl-gw5xxx: add missing USB OTG OC pinmux
Date:   Thu,  1 Jul 2021 11:00:57 -0700
Message-Id: <20210701180057.4055-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB OTG over-current pinmux to the GW51xx/GW52xx/GW54xx/GW553x
boards.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 1 +
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 1 +
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 1 +
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 3c04b5a4f3cb..069c27fab432 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -626,6 +626,7 @@
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
 			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0 /* OTG_PWR_EN */
+			MX6QDL_PAD_KEY_COL4__USB_OTG_OC		0x17059
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 8e587e17e75d..b1df2beb2832 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -728,6 +728,7 @@
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
 			MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x1b0b0 /* OTG_PWR_EN */
+			MX6QDL_PAD_KEY_COL4__USB_OTG_OC		0x17059
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 29ba24c273e9..cda48bf2f168 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -812,6 +812,7 @@
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
 			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0 /* PWR_EN */
+			MX6QDL_PAD_KEY_COL4__USB_OTG_OC		0x17059
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
index c15b9cc63bf8..4662408b225a 100644
--- a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
@@ -687,6 +687,7 @@
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
 			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0 /* OTG_PWR_EN */
+			MX6QDL_PAD_KEY_COL4__USB_OTG_OC		0x17059
 		>;
 	};
 
-- 
2.17.1

