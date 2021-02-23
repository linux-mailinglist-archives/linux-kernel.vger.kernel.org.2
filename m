Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02D4323154
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhBWTUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhBWTST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:18:19 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EEFC061794;
        Tue, 23 Feb 2021 11:17:01 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d11so4350983wrj.7;
        Tue, 23 Feb 2021 11:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nvmk6VcgOPfnZULg+CSrt//m+evR7qGp/zbCIO7ljps=;
        b=jQLXywRGKZXBhmRfM1HRhpEhmKpfa0AQP3aDoYnuYtUKE4Cu61bXPkRBQo6F7tCO9x
         +65WLV4yYBw+Jz/iAJkOKoiBK4abvbk/WqobrnX1bs8ZHhESIgklkE6ydP6swoQPdgVM
         NIGINhM+79CINU+JZ/tizZZwEzjnnQVzDxWBdomRQG44Cns4Y6m8kcQLsUOw1GQskLhT
         izjpJM2LEqyONE7a2htos/ACwQugIXj+obydLwmd8az8yFl0ZMyWSIZQKGOOdFmUYqbQ
         pohZbtq6fR968lCMPyBzBlBHv+J0MewZ9vUhPCJcn8zrZXS2bi4mnmGogHnVpNheblux
         BzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nvmk6VcgOPfnZULg+CSrt//m+evR7qGp/zbCIO7ljps=;
        b=DM0MZJUinmTEqUscS0G2ioqbqCq+xS6bVHMPSJHaHO3r4JlY54+adILRGp5g7sBGyl
         ZJ0breYmYeQICWHTkSaRWQAVPB4I6lFSIt+/e+0Xx3kiP/CSYp2mPmXxZACTRRshZctw
         010dmhivboeIbDEbJhUAQQAjlotPvUMn8AgR7hug+WHph6F/Xg/b2E71NtSA+V169HAe
         68jbonXLtzD8TOAG7sxjPBEq7hj3bT+9XknICK6fE/Mj1KeouNvzx0s8IGKLpIrSTiyz
         qczb9kAVm+vKFmy/jGBsxVsedFoXN3f3VknMhYjLhSBDxUqOVK5Oy+NuCSgwznPeB1kp
         E40g==
X-Gm-Message-State: AOAM532sUa1XJ//dcZrbCw0kPGXCw9dViKi+k6yBGsO5IN7r0fhZjcPn
        xUDXxr7veRYIjS06OB5y7Hc=
X-Google-Smtp-Source: ABdhPJyiNRN+wnUvJfI5H2JU8+yGCtMOWJo306mgwzvnZHTfmwi9Z59TV+Vr1g3dSGSv/FVEkVx+Sw==
X-Received: by 2002:a5d:60cd:: with SMTP id x13mr9533640wrt.328.1614107820532;
        Tue, 23 Feb 2021 11:17:00 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd270084c09ff22cc10cb2.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:84c0:9ff2:2cc1:cb2])
        by smtp.gmail.com with ESMTPSA id a21sm3611413wmb.5.2021.02.23.11.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:17:00 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 07/10] arm64: dts: imx8mm-nitrogen-r2: add PWMs
Date:   Tue, 23 Feb 2021 20:16:49 +0100
Message-Id: <20210223191652.436397-7-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223191652.436397-1-adrien.grassein@gmail.com>
References: <20210223191652.436397-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for the four PWMs.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index e44c5963040d..cabcd6f19d56 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -211,6 +211,33 @@ rtc@68 {
 	};
 };
 
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm2 {
+	assigned-clocks = <&clk IMX8MM_CLK_PWM2>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_40M>;
+	assigned-clock-rates = <40000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "okay";
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
 /* BT */
 &uart1 {
 	pinctrl-names = "default";
@@ -376,6 +403,30 @@ MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22 0x1c0
 		>;
 	};
 
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_PWM1_OUT 0x16
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT 0x16
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_TX_PWM3_OUT 0x16
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_MCLK_PWM4_OUT 0x16
+		>;
+	};
+
 	pinctrl_reg_wlan_vmmc: reg-wlan-vmmcgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20 0x16
-- 
2.25.1

