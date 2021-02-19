Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AFC31FAF2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhBSOew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhBSObT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:31:19 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8381BC06178A;
        Fri, 19 Feb 2021 06:30:39 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v14so8799309wro.7;
        Fri, 19 Feb 2021 06:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y4DIdfEKyNw451jxX57sPrCnj00ly/uILGeFLmTL0xw=;
        b=iiX1mAeomuctMgZWT/jtdJ66XfG7vFJD8gczW02P73n/m85mOyhbCLh+D6RJ44nK9D
         d57iv92c50+ew4DbjACYZyu98kjFIj6JiKMR6cvVurZNRnrXkjA7GIjB1dZdK+wSneEp
         qJFvsfFS3xYJuSxBKE09DHBcG73IUDhj2eYMgUiMrLxU/2QKaxVpV3pGfhwIdcF/U5gX
         b6Kv40CmmUfITyr6BJIHZRmGc98ngd7kuw2kAfjMGGa6r1Iym5vuC4h6+2qGkW+uM7ZO
         oLNeZTvpPTlFBYecgOJ377NNggA+/eyQSp/BORp6XHQytu7kKVxEhm8IqusuD7JH2q0O
         alCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y4DIdfEKyNw451jxX57sPrCnj00ly/uILGeFLmTL0xw=;
        b=TwAIcajT5soiluCS8GElsXhXVTH2ysvCWG99K/vZzt5Gl/7cWwk18RPS3dSZDdQqP0
         Qm9pkiUMbKHZsfn0jE7e7vb5evziL+LhB4XX69CKsimKHpwRxvTJYtJddEN8paZ9DWKN
         TCM8OSj7JbKABRMe4D7Mf6NRM327yP4/FSPjc/iNy8WCSk2jKcq9nQNoOmwj6r/jFMJC
         PuYWEZDUr4yghaYqIhCb3a5yEtDeNK/ud6kskTVhqbA1bro/GCgGHecLU8EdrwdpLT3l
         1cBUAr42xEa/y//Qar3LhC2p0ZLXu1h9rPj6zJTQQCGZ9bszsX+lM75glK4ohvkQtoes
         G3fQ==
X-Gm-Message-State: AOAM533Fm5Y+dT8VCBZ192hb4H1oAzZDLulMruXf/SuYBq1XuBWQAtVu
        ycghFZ/wYoL0tYZAhRuZPZA=
X-Google-Smtp-Source: ABdhPJz8ZYQksf5HzU2+wMMqTEm2ik3mJB8ncyffuJhT360RklclSCc/POlgz5epGXhTS5FOPssadw==
X-Received: by 2002:a5d:47af:: with SMTP id 15mr9455422wrb.205.1613745038311;
        Fri, 19 Feb 2021 06:30:38 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27003cf54d240f3b36ef.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:3cf5:4d24:f3b:36ef])
        by smtp.gmail.com with ESMTPSA id v9sm8348215wrn.86.2021.02.19.06.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 06:30:38 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 3/9] arm64: dts: imx8mm-nitrogen-r2: add espi2 support
Date:   Fri, 19 Feb 2021 15:30:22 +0100
Message-Id: <20210219143028.207975-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219143028.207975-1-adrien.grassein@gmail.com>
References: <20210219143028.207975-1-adrien.grassein@gmail.com>
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
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index 48b3bf4316b8..af740170569c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -45,6 +45,19 @@ &A53_3 {
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
@@ -277,6 +290,15 @@ &iomuxc {
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

