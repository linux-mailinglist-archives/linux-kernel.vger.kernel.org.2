Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B2D31C446
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 00:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBOXUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 18:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhBOXUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 18:20:34 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1958C061756;
        Mon, 15 Feb 2021 15:19:53 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v14so10992107wro.7;
        Mon, 15 Feb 2021 15:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VAZ+z9RPQnjL2U2FETJXjHQsIEsUO0eXpjreSRP0IuY=;
        b=CaRHkGDpZADGa3bTpGdpZkMNA86Ara5Okq+YOaaOdjj4EXC+5xZ16PGuXE2LmKr/RR
         Z7QI1S2Mp+W5a5pHmTNkc2qO7YouU7+qTUob8ihvK57TcLEebFLv+zfYvSeh4+Rcrvbl
         lbxktkgmQT0uVULvDOp6Wc8zoP2LddpSVY5fI872Cdvwv5eLfor+fbX3VfYqeU1WJ+4l
         Eyo9bFF1vXaqbEkzuSrww07GI8gUdlHzYZygtgUQBg8DxGT9TZhVlXh5xi8woZBpi77b
         O5gNK3gs6LmLSQg0fJpbbnVzY2LajwmsKYXHhJVKWytQ5/18+t6Cjp/En2cIhLufkKVW
         2rLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VAZ+z9RPQnjL2U2FETJXjHQsIEsUO0eXpjreSRP0IuY=;
        b=MyYZWU/yI2goTBUY1NFKVXRiq04GJHVbumNpbZ+d7O+TQIZJqpUCdTyfCqSuRrIsNP
         wCw6+fiALNbuLY/TFqTnfAZx/Szc21Eo3Zvb6Eq3bmIlpgj9ySMS7Xh1XcDwIRDuf1b3
         5SVagImJZQLZkq4Q38vu5Gpu+FcClm/nxYUgDbO+wMYkorcjwsvjA+dzGntsNnDuucpq
         Tg/VAQpZjQhXDSrqyD3pT6Qv0NIZzmfTKppFwSLgFg9K+oE42gM+Yvro0HCB5SZ7BtXr
         axCoNBzWueTaG9eUsVSjUmssZS7RWTpv0kok5T4cHPu1DTYSrDUuZDkVZeLMWmDwl7kb
         GZvA==
X-Gm-Message-State: AOAM533SwC+81mBxDdwGGHpZpSCRi36oRmms/n8mmAvt2+Rtkh3kOsFB
        r/jPIZ3qP7Bc58XXgcXyRlo=
X-Google-Smtp-Source: ABdhPJyWw4ayJ1Iicku+gjZvpmPl5A01/UF9AqQQPIx0eJKl4pTgZLBG8EDqrrWBIWyPewOqlvHSmg==
X-Received: by 2002:a5d:654d:: with SMTP id z13mr21841053wrv.62.1613431192398;
        Mon, 15 Feb 2021 15:19:52 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd27008c8ad15d1b12a6b4.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:8c8a:d15d:1b12:a6b4])
        by smtp.gmail.com with ESMTPSA id f5sm963158wmf.15.2021.02.15.15.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 15:19:52 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 1/8] arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
Date:   Tue, 16 Feb 2021 00:19:36 +0100
Message-Id: <20210215231943.36910-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215231943.36910-1-adrien.grassein@gmail.com>
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usdhc3 description which corresponds to the wifi/bt chip

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index c0c384d76147..bf20a40bcda0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -9,6 +9,18 @@
 / {
 	model = "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
 	compatible = "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
+
+	reg_wlan_vmmc: regulator-wlan-vmmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_wlan_vmmc>;
+		regulator-name = "reg_wlan_vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 20 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <70000>;
+	};
 };
 
 &A53_0 {
@@ -206,6 +218,19 @@ &usdhc2 {
 	status = "okay";
 };
 
+/* wlan */
+&usdhc3 {
+	bus-width = <4>;
+	sdhci-caps-mask = <0x2 0x0>;
+	non-removable;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	vmmc-supply = <&reg_wlan_vmmc>;
+	status = "okay";
+};
+
 &wdog1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wdog>;
@@ -264,6 +289,12 @@ MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22 0x1c0
 		>;
 	};
 
+	pinctrl_reg_wlan_vmmc: reg-wlan-vmmcgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20 0x16
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX 0x140
-- 
2.25.1

