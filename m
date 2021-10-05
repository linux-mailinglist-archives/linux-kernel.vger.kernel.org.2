Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DBB422C5C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbhJEPZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:25:54 -0400
Received: from finn.gateworks.com ([108.161.129.64]:52140 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230059AbhJEPZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:25:52 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1mXmIJ-00798p-2A; Tue, 05 Oct 2021 15:23:51 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] arm64: dts: imx8mm-venice-gw7901.dts: disable pgc_gpumix
Date:   Tue,  5 Oct 2021 08:23:48 -0700
Message-Id: <20211005152348.17325-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d39d4bb15310 ("arm64: dts: imx8mm: add GPC node") the
GW7901 will hang during kernel init because it does not power the unused GPU
voltage rails on the IMX8MM. Disable pgc_gpumix to work around this.

We also disable the GPU devices that depend on the gpumix power domain
to avoid them staying in a probe deferred state forever.

Cc: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 .../boot/dts/freescale/imx8mm-venice-gw7901.dts      | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index bafd5c8ea4e2..e0153ce35722 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -282,6 +282,14 @@
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
@@ -632,6 +640,10 @@
 	status = "okay";
 };
 
+&pgc_gpumix {
+	status = "disabled";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>, <&pinctrl_uart1_gpio>;
-- 
2.17.1

