Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AC231DD08
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhBQQMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbhBQQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:11:38 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E7AC0613D6;
        Wed, 17 Feb 2021 08:10:58 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 7so18044725wrz.0;
        Wed, 17 Feb 2021 08:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qXvAG0Ht5RzuxfjWtYroVCbbCFdJtXJlT0BNEQveRFc=;
        b=T1wagm6MlTdQTfnDyTtGayg7huLyVnuB3vn5OaWpkq7Lfzi9OFFHpn9M80c1RA7CRm
         o2sJmW5BfFkcgGV4f2cw3sLIstpbDWDJMssllr0PZhynT/kCHnMAKapU0d+RwHDV4X7B
         n/4YxHzN4ZyNcTil61sFzY3P8h/o3828rlMSFIDEvwk7QooA61oJOtnCf167OAQgEjVI
         M6VRXN2NmaRlhPkBI0CVPF1oDc2EwjtR41MyHFPpj6i1Wo5RKn8E9K+FRpARtiDUdZ0h
         PVsf7CDw1nlSeWM30F0J9Q6WSCvwAIZG8WwfLX8qAJdkTCtbfCJM9MSnxPZLZEr+IofO
         powg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qXvAG0Ht5RzuxfjWtYroVCbbCFdJtXJlT0BNEQveRFc=;
        b=gczAVzWoKd348eeYuS3DkFutnImafmBX2aKyLyO+iXSYBmQ6Anm6kqPeUdnx8Q3oL4
         TxnKYWE2/Z+EN1iYq0nKJ43I0gygOxAX79paxaBXP4DSy6a3/kjAgw2igsmGic5ESi8Z
         Jtk8QYm7vDXHoCkmRWDA90PIMf0xLoyLNIwj0RYNY2JurA6llgT6zs2DMUGV+7vYv6Xp
         bekNDj6uK5mhK+xk556qh/aHSkTvl1dNdXWu28vPledBLrFEOlD0Sc/JN3lkbQIHY4Wc
         UYzXnzbCLMDQIN1pFRbuTH7hBqoO3mRlm5k8VWK/xabjZt+gmLdgw733LQ0oQs7ZyVNM
         Jcxw==
X-Gm-Message-State: AOAM530eUTcaNevTp8N8PQ5tV5yLCiat+c9MJQY76qgz/0TVLLn39B4I
        AT1ODy/RW9g0iwovh2K926k=
X-Google-Smtp-Source: ABdhPJxPIxuzaBuseFFiMtALZd9eB5ak+Qhv+qYwBDUK8A+d47wnfaItW2gpGyfhGpFE6u6c6xLLIQ==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr29637wrl.108.1613578256918;
        Wed, 17 Feb 2021 08:10:56 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700605dcea117b1d0f0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:605d:cea1:17b1:d0f0])
        by smtp.gmail.com with ESMTPSA id e12sm4260260wrv.59.2021.02.17.08.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:10:56 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 1/8] arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
Date:   Wed, 17 Feb 2021 17:10:45 +0100
Message-Id: <20210217161052.877877-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217161052.877877-1-adrien.grassein@gmail.com>
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
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
index c0c384d76147..212dc9e5e85d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -9,6 +9,17 @@
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
+	};
 };
 
 &A53_0 {
@@ -206,6 +217,20 @@ &usdhc2 {
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
+	vqmmc-1-8-v;
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

