Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BE831DD0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhBQQMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbhBQQLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:11:41 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E25C061788;
        Wed, 17 Feb 2021 08:10:59 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v14so17966173wro.7;
        Wed, 17 Feb 2021 08:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hNvy72+6gzO283p8WQUToOZ669K7jG5ZFwqp2rKkt2A=;
        b=LslgCakGzI7AsGmiqdsJ1OZ6frE6sD9kUBikCJ4TokIBhete7f+n5IpojoqRJ1af9H
         tt4rA6OwTHuRrSckF7vZQw5/Fqo654eGn8PSO88wZS+yR3dlNIV5fhx7crkV1x36Mkyw
         ROCoAvWwUgdEwTs8xwRxHLMB7JD4iaywrQoAQiUHJIDghDUoYRY2On7QZ1ycvMH/Dhjl
         jbX5ap2v0VhhpXZblU2ZMbi4xJGZyP3QJvJFd0vpqVcUipeo6HVNmZIzEOMylqlh/cFb
         EcZZbGQ5geGIC+dh/UCRXoIV0q6pI/um2ZtrudnLXsR0bKqv+2oK45pNRLrIBk6T9Ept
         VyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hNvy72+6gzO283p8WQUToOZ669K7jG5ZFwqp2rKkt2A=;
        b=G/3/9xkyD0lcu9E5O4tXTJJdq7aKxqT5X+FUXjQfSaBJvUI2U5XC5Hcr2ZYfmiaKQP
         EoP6QNlK4nVhulGlmduoUeT/3mfjrQINM8yGu52JMAKpHt+hrQfVptVolMvEF7oKDjYG
         CpmbeWS9BKpf/RftkaA7mgPQwDhme1Z1wvoqpg6s9uGCmxEXF2I2RrJVwC5lijFrDnMY
         2zqeoPC7J4dwqpth3UrR9iQty9lXd4BnYwQFxhk7KQidRrpQuslESIVN0HpGtuy69K11
         HWMlRc5CkW1RUGnZUkGDvKvag4VQRzsv/KEu3Kk4B5QXVx+bs5ods6Ty1lSO5zksJXEh
         C5Kg==
X-Gm-Message-State: AOAM5326NUP3CugEaWg5A6ZrUmtCge6pZDo+Acp+R17GSmBtsl0BUpjd
        cgEt7SsAgkkM0LuejW62Hd0=
X-Google-Smtp-Source: ABdhPJxq8xDUvpRs3Dkjp+3UPT1n78J9P+aDQDJMJc+BjKuuFymyu3xz2FHD+GPA2qmupfCyb7BTNQ==
X-Received: by 2002:adf:e5d1:: with SMTP id a17mr16284wrn.260.1613578258335;
        Wed, 17 Feb 2021 08:10:58 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700605dcea117b1d0f0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:605d:cea1:17b1:d0f0])
        by smtp.gmail.com with ESMTPSA id e12sm4260260wrv.59.2021.02.17.08.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:10:58 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 3/8] arm64: dts: imx8mm-nitrogen-r2: add espi2 support
Date:   Wed, 17 Feb 2021 17:10:47 +0100
Message-Id: <20210217161052.877877-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217161052.877877-1-adrien.grassein@gmail.com>
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description for espi support.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index f62a25efc69e..c4bb22bb4e6a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -10,6 +10,14 @@ / {
 	model = "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
 	compatible = "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
 
+	clock {
+		clk16m: clk16m {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <16000000>;
+		};
+	};
+
 	reg_wlan_vmmc: regulator-wlan-vmmc {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -38,6 +46,19 @@ &A53_3 {
 	cpu-supply = <&reg_buck3>;
 };
 
+/* J15 */
+&ecspi2 {
+	assigned-clocks = <&clk IMX8MM_CLK_ECSPI2>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_40M>;
+	assigned-clock-rates = <40000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
@@ -270,6 +291,15 @@ &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0x140
+			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO	0x19
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0x19
+			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI	0x19
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
-- 
2.25.1

