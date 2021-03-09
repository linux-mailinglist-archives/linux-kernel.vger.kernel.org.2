Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317A5331EB9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 06:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhCIFdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 00:33:24 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:51531 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhCIFdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 00:33:17 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DvkQ42JX9z1ryWv
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:33:16 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DvkQ42B0yz1qqkj
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:33:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id dcyAlTc5EmGa for <linux-kernel@vger.kernel.org>;
        Tue,  9 Mar 2021 06:33:15 +0100 (CET)
X-Auth-Info: SAlF13EIOFopzbaTvANEsYr6Q0v8N85tyH+ySaXeS2w=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:33:15 +0100 (CET)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 269BF18510F;
        Tue,  9 Mar 2021 06:31:22 +0100 (CET)
Received: by pollux.denx.de (Postfix, from userid 515)
        id 1B7351A0092; Tue,  9 Mar 2021 06:31:22 +0100 (CET)
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
Subject: [PATCH v2 4/4] arm64: imx8mp: imx8mp-phycore-som enable spi nor
Date:   Tue,  9 Mar 2021 06:31:16 +0100
Message-Id: <20210309053116.1486347-5-hs@denx.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309053116.1486347-1-hs@denx.de>
References: <20210309053116.1486347-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable the mt25qu256aba spi nor on the imx8mp-phycore-som.

Signed-off-by: Heiko Schocher <hs@denx.de>

---

Changes in v2:
- work in comments from Marco and Teresa
  - rename node into "'som_flash: flash@0 { }"
  - compatible is now first entry
  - removed #size-cells and #address-cells
    as no child node. If bootloader adds them bootloader
    can add them too.

 .../dts/freescale/imx8mp-phycore-som.dtsi     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
index 44a8c2337cee4..e648b1b6acdaa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
@@ -65,6 +65,20 @@ ethphy1: ethernet-phy@0 {
 	};
 };
 
+&flexspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+	status = "okay";
+
+	som_flash: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <80000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
 &i2c1 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -217,6 +231,17 @@ MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15		0x11
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

