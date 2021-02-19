Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C1931FAFF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhBSOfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhBSOdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:33:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A64C061793;
        Fri, 19 Feb 2021 06:30:41 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v14so8799432wro.7;
        Fri, 19 Feb 2021 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4H0Bz2TfECAROvxfp3s0QlmQPX5jRVtptBfW0M3eHk=;
        b=LAkZ84Dz1Wyn50rifNxMQ2IKf51NayZ6rHyGa1/BaS1h5pJt6vDWuQZQPJAxSFB12R
         17BlaX0n17JAZKXUrtcWwf2OOFGRuBeig8Da7avbDs4O7WQnDzbA09Pj1/cKE/ZiK0Tq
         oTkUMpVPekj/6jkd/3aq01YQdCMLdrpvV9TPb27868A8dMyg7L2+RL+ZOaHAb1h0zdW0
         CD8zFzHJfWwME1M4tBU9iSERidq4hVvCxouDbn+PZNgypDO11nA4OFtH4Wg7W4dfQDcd
         xHKgF5rwxG9o/lamajgLNN8DSxB1ieR2YHC+eG7z+mRheh2LyF3qTqd2mPqXqbCq3TLS
         I0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4H0Bz2TfECAROvxfp3s0QlmQPX5jRVtptBfW0M3eHk=;
        b=uVv+BxqFDN8ym/t3AOHEvU9X26o1pqBfgn8pRqg3z/+E/4UY6TJGsLnHRXWP9gwtCj
         yWdGLuT4Nzi/7qIXcVo+10sbb7mOkqdsGi/AqRUGp4z0EQw8I3Ji6R+3VchdrI/0nWh9
         f1gD+mF4Ud8cAVyhOK41+wgeiI9KxOMB+AbIiMRtYLsLVh1xaOJaaW9IKPp8+YTcfUpH
         pEhlTixXc/DDM9N2Iu7ERGjqXomFZQBou1rwMfZ8laG/EezfPDhcU2NWVmxipw1910if
         Gp0C+TKkRvAO47S+A0HGhmeZSPQ5B3bOWBbIgzvIyrslTDefIS5l4ul3j2/270jjpfzi
         FXIA==
X-Gm-Message-State: AOAM531U7+ZVcsUQel0VQQNZ7IwuldyhJUMXL0m28JuacjetQe/LP9q0
        +MWRC1XdrhlLBAwIy4yZHww=
X-Google-Smtp-Source: ABdhPJyTobj7YTrU4Rrvu3X/peZO2rgPkk6+FtX/qWVPYfdP8hQ6HV5fviCU/BmT74+N6OxErKtLAg==
X-Received: by 2002:a5d:4287:: with SMTP id k7mr9292667wrq.317.1613745040031;
        Fri, 19 Feb 2021 06:30:40 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27003cf54d240f3b36ef.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:3cf5:4d24:f3b:36ef])
        by smtp.gmail.com with ESMTPSA id v9sm8348215wrn.86.2021.02.19.06.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 06:30:39 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 6/9] arm64: dts: imx8mm-nitrogen-r2: add PWMs
Date:   Fri, 19 Feb 2021 15:30:25 +0100
Message-Id: <20210219143028.207975-7-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219143028.207975-1-adrien.grassein@gmail.com>
References: <20210219143028.207975-1-adrien.grassein@gmail.com>
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
index 5c4085a8e76e..9a210ca63731 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -204,6 +204,33 @@ rtc@68 {
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
@@ -367,6 +394,30 @@ MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22 0x1c0
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

