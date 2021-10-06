Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA3A424175
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhJFPkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:40:43 -0400
Received: from finn.gateworks.com ([108.161.129.64]:52404 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230014AbhJFPkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:40:42 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1mY90C-007Az4-24; Wed, 06 Oct 2021 15:38:40 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2] arm64: dts: imx8mm-venice-gw7901.dts: disable pgc_gpumix
Date:   Wed,  6 Oct 2021 08:38:36 -0700
Message-Id: <20211006153836.13760-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b21269b12e48 ("arm64: dts: imx8mm: add GPC node") the
GW7901 will hang during kernel init because it does not power the unused
GPU voltage rails on the IMX8MM. Disable pgc_gpumix to work around this.

We also disable the GPU devices that depend on the gpumix power domain
and pgc_gpu to avoid them staying in a probe deferred state forever.

Additionally as the MIPI voltage rail is also not connected on this
board we disable pgc_mipi and disp_blk_ctrl.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2:
 - also disable pgc_gpu to keep gpu from getting in probe deferred state
 - also disable pgc_mipi and disp_blk_ctrl as the MIPI power rails are
   not connected
---
 .../dts/freescale/imx8mm-venice-gw7901.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index bafd5c8ea4e2..21c546c4628d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -255,6 +255,10 @@
 	};
 };
 
+&disp_blk_ctrl {
+	status = "disabled";
+};
+
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_spi1>;
@@ -282,6 +286,14 @@
 	};
 };
 
+&gpu_2d {
+	status = "disabled";
+};
+
+&gpu_3d {
+	status = "disabled";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -632,6 +644,18 @@
 	status = "okay";
 };
 
+&pgc_gpu {
+	status = "disabled";
+};
+
+&pgc_gpumix {
+	status = "disabled";
+};
+
+&pgc_mipi {
+	status = "disabled";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>, <&pinctrl_uart1_gpio>;
-- 
2.17.1

