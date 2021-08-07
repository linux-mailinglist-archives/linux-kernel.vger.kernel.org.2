Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75373E34F3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhHGKlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:41:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33369 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232183AbhHGKkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:40:47 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4AE1D5C00E9;
        Sat,  7 Aug 2021 06:40:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 07 Aug 2021 06:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=UMe+3P4YUXxWD
        B9MuMuOzPb8/JlMM81hk5eWcH49tWQ=; b=ciUm3OtPkK5ydIeT5RkMHP2L0Igy5
        QqXoId1lpanqcP/9KfYPqMKLV47Z5oi/4Ui0PEux9aa+Tl4XGqgqn7DI2vsb8cFQ
        KCAob/w3ZnZCFwqlqD2bW9MozoQgulO38H+Q0O6HVDL5vLyoIW7VsGR/TolAg8/g
        w7eIS62smhdld7sT+0NMxF/1/2YW21IQYj+B+tDPBSHF5e7N1pZGdvAbViqiTjQF
        Dw9Xlbco2WHeTunM9dIvCEgs+Ha1vKIaFDOCFrNFHcr2YbZw/7Mmhuzksf2Sm4BA
        B6cyHBO1rO9+7YADGH2krYNFxSDSMjCJF9pPAh4TnagRUU4PbXdFfbTcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=UMe+3P4YUXxWDB9MuMuOzPb8/JlMM81hk5eWcH49tWQ=; b=tUzJonKn
        WUCVDoGEq38tajjeb0unvDLig/zlfYrtE4RKjeGF9hAVXzPaX4x6Cv2QCxSNgOi1
        ufGEmEUGl7L/ZGZ8NObWEuGW+Rp3NlMDoVZVdiCw1o9mVbNYWe+4BFQphG8HToEU
        8epLVGVhjISUsd7h1lAiYUxO+3tnXyTfC25HTfiGorLdqOb18qIoV19fOA/wE6RF
        uATJeu72hSgbsPPO+bXvagoHxeLVpZS/AGMWk520M9O85VI5YWwQtoEbetcIpfls
        uRnfT3tKCQdVLJCq2FUUDBwYyPNa4EJ5tZFSpAGYw2FwGCg9+rcRjlFGVfdhcfva
        L1pbPTzQm9p+Ug==
X-ME-Sender: <xms:HmMOYQ-xMEZxBKR6LxhrgldQ1flnLHN3s-piPcfODrKP20ET2hqd6w>
    <xme:HmMOYYv5mCUIUGsWsGUf4-TeT4aJpZt9sbd67fADB2eAnTQkqvcF0vjPf8spS5cQT
    iSrcq9LQK7slV_317M>
X-ME-Received: <xmr:HmMOYWB62f-53c0-nnAsEZlrtlDVNJ8tYWPDfm1bHuvp4JiKmvOXJ4ikVBNv8VK1oPlXhrOQWVg0tfJjKnsZplt2Q7Di9ZndQUkbjGSf2nvaB3VNnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeefgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:HmMOYQfH7qgEzSfWFJw2DMMOP9MrrQ_9ZqB4YGUlA_VN6QTDIeHm_w>
    <xmx:HmMOYVPMMj0QSRi5uBWVq4RP4xPCnkk7SKLS1vewQmCzSOJ1oDZebQ>
    <xmx:HmMOYaktnonrhceEQhrkqEOw9OsJ35_-qzBJ_gK2M3NNeQLyIyYc_g>
    <xmx:HmMOYYf8L-PZmYzcsZJ1-nVOlvOk6WBJ-NhsXs0UJFxY3PIssuXNkw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Aug 2021 06:40:26 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v10 09/11] ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
Date:   Sat,  7 Aug 2021 20:39:38 +1000
Message-Id: <20210807103940.152-10-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807103940.152-1-alistair@alistair23.me>
References: <20210807103940.152-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index cc33b53ae6ba..2f0c4fda38a3 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -86,6 +86,33 @@ wacom_digitizer: digitizer@9 {
 	};
 };
 
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	epd_pmic: sy7636a@62 {
+		compatible = "silergy,sy7636a";
+		reg = <0x62>;
+		status = "okay";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_epdpmic>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#thermal-sensor-cells = <0>;
+
+		epd-pwr-good-gpios = <&gpio6 21 GPIO_ACTIVE_HIGH>;
+		regulators {
+			reg_epdpmic: vcom {
+				regulator-name = "vcom";
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -179,6 +206,13 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
 		>;
 	};
 
+	pinctrl_epdpmic: epdpmicgrp {
+		fsl,pins = <
+			MX7D_PAD_SAI2_RX_DATA__GPIO6_IO21 0x00000074
+			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11 0x00000014
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
@@ -186,6 +220,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
 		>;
 	};
 
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX7D_PAD_I2C4_SDA__I2C4_SDA		0x4000007f
+			MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.31.1

