Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F153533085C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 07:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCHGmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 01:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbhCHGmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:42:17 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989F4C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 22:42:16 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Dv8073Kvpz1rx8F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:42:15 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Dv8073DcTz1qsST
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:42:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id hytvmXu0wfyH for <linux-kernel@vger.kernel.org>;
        Mon,  8 Mar 2021 07:42:14 +0100 (CET)
X-Auth-Info: CRX5RWwb3CSwu5NfU5z2gH5m59c4QUIymyG4QyuSQKI=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:42:14 +0100 (CET)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id B7323181B9F;
        Mon,  8 Mar 2021 07:40:52 +0100 (CET)
Received: by pollux.denx.de (Postfix, from userid 515)
        id AC8A31A0092; Mon,  8 Mar 2021 07:40:52 +0100 (CET)
From:   Heiko Schocher <hs@denx.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Heiko Schocher <hs@denx.de>, Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Teresa Remmet <t.remmet@phytec.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: imx8mp: imx8mp-phycore-som enable spi nor
Date:   Mon,  8 Mar 2021 07:40:46 +0100
Message-Id: <20210308064046.1576267-3-hs@denx.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308064046.1576267-1-hs@denx.de>
References: <20210308064046.1576267-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable the mt25qu256aba spi nor on the imx8mp-phycore-som.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 .../dts/freescale/imx8mp-phycore-som.dtsi     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
index 44a8c2337cee4..0284e7a5c6bba 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
@@ -65,6 +65,22 @@ ethphy1: ethernet-phy@0 {
 	};
 };
 
+&flexspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+	status = "okay";
+
+	flash0: mt25qu256aba@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <80000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
 &i2c1 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -217,6 +233,17 @@ MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15		0x11
 		>;
 	};
 
+	pinctrl_flexspi0: flexspi0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK		0x1c2
+			MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B	0x82
+			MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00	0x82
+			MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01	0x82
+			MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02	0x82
+			MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03	0x82
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c3
-- 
2.29.2

