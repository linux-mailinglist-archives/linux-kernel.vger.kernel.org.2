Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835173230D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhBWSef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:34:35 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45636 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbhBWSed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:34:33 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8DE511F44730
Received: by jupiter.universe (Postfix, from userid 1000)
        id 3259A4800DC; Tue, 23 Feb 2021 19:33:49 +0100 (CET)
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
Subject: [PATCHv1 2/4] ARM: dts: imx: ba16: improve PHY information
Date:   Tue, 23 Feb 2021 19:33:44 +0100
Message-Id: <20210223183346.138575-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210223183346.138575-1-sebastian.reichel@collabora.com>
References: <20210223183346.138575-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PHY voltage supply information fixing the following kernel message:

2188000.ethernet supply phy not found, using dummy regulator

Also add PHY clock information to avoid depending on the bootloader
programming correct values.

The bootloader also sets some reserved registers in the PHY as
advised by Qualcomm, which is not supported by the bindings/kernel
driver, so the reset GPIO has not been added intentionally.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/boot/dts/imx6q-ba16.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
index 4793ef5171aa..a684d999e605 100644
--- a/arch/arm/boot/dts/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
@@ -177,6 +177,18 @@ &fec {
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii-id";
 	status = "okay";
+	phy-supply = <&reg_3p3v>;
+	phy-handle = <&phy0>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy0: ethernet-phy@4 {
+			reg = <4>;
+			qca,clk-out-frequency = <125000000>;
+		};
+	};
 };
 
 &hdmi {
-- 
2.30.0

