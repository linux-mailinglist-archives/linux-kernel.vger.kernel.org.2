Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB09431C448
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 00:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBOXUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 18:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhBOXUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 18:20:35 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDD4C061786;
        Mon, 15 Feb 2021 15:19:55 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r21so10973272wrr.9;
        Mon, 15 Feb 2021 15:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/5ZniX0LykOLM7vTo98cR3yfVspFzsKulFcBGJ2QqmY=;
        b=py4ro74w+BFtF43v7JnhRr4PfGk7QLJED54igCm9xGy3b+Q6/YYFFY7qracvSCpGU5
         vOHruyOl6JHMNLEWfR2Gt8dVq61zvQmKRBXdNxLq6Wat6PlqmkrR1arLzYPidqLx/MC2
         bHV8v0IwEGgEItCpAhqP3j+MCqPsPtALLnzLrb9ZDRZrYKOGXoOzaJzFjjuIrPnK97Wg
         fve6so17J640Hxetusq8J0H2MtVpSyr2UNXgQfhHDGnAxoY6PoABp7IaZFlaoQ7n0881
         TrpCP6MnNYX0KSiuNeJwOyM3oV9kFjHS849Sl5dO6FK2MiCanXYs3v4pnbpSb30n41RE
         4Acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/5ZniX0LykOLM7vTo98cR3yfVspFzsKulFcBGJ2QqmY=;
        b=ED/NksROkOoQqGUJmuhKcPyFxHfXVVReIB/hUvS1xqJa9Q4byVSC0u5ZTCLqKXCj9A
         7gILUQbw8Vjk78uo4+isrKjbBCitCZ9PR6eBbX48v+cbjF1ZH6i8iM9DTVCtuwWPnTM1
         SSVAG/xo4sD9eifah2HKc/RJi7UHZUqz+/XdlEYFHytkmIV35MCwerZNAcD2W83gHMUY
         e89lbOjjRhtpJkPaHb37kfN06NIMZ+RU5H8NPoYG2KXmJL9/9LEN57qkAhuHqVnkDiow
         LImxZ6WLm9aAB+PqZRYdm6ct1/kfnFXozE6qoKThZMC+OlQQxMu7gNf1lTVm9YLWe3sW
         8+Zg==
X-Gm-Message-State: AOAM531JjIWBCzMyob4aclh0wHtG3hXDDFYfnZT4TTyavcKwWfMbSU4I
        xEh/OVuYZYNwBolJlkNVpfM=
X-Google-Smtp-Source: ABdhPJzQ7BOvth/uQcDxwgCtiUlK2fZsKPUK/C9xKnmYUhYPUtl1CtZyo3++3ZdIHZkHSBFw6aUO/A==
X-Received: by 2002:adf:f3c4:: with SMTP id g4mr20966511wrp.61.1613431193924;
        Mon, 15 Feb 2021 15:19:53 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd27008c8ad15d1b12a6b4.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:8c8a:d15d:1b12:a6b4])
        by smtp.gmail.com with ESMTPSA id f5sm963158wmf.15.2021.02.15.15.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 15:19:53 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 3/8] arm64: dts: imx8mm-nitrogen-r2: add espi2 support
Date:   Tue, 16 Feb 2021 00:19:38 +0100
Message-Id: <20210215231943.36910-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215231943.36910-1-adrien.grassein@gmail.com>
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description for espi support.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index 1b29d8a12d04..22acde0f3ba8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -10,6 +10,14 @@ / {
 	model = "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
 	compatible = "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
 
+	clocks {
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
@@ -39,6 +47,19 @@ &A53_3 {
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

