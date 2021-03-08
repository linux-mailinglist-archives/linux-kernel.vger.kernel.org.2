Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5AB330E8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCHMki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCHMkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:40:07 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471D2C06174A;
        Mon,  8 Mar 2021 04:40:07 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a18so11238321wrc.13;
        Mon, 08 Mar 2021 04:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2LA8/5m2YlrOTBqAtldyUhtslhzmNNTEthEphR9Wf3U=;
        b=OvE22xB7IoQp92L1rLiZDQFrmcE4kZ7XEoi11rTKRRuOyKVoLLApoWt69ApJwNmeBV
         SXAg0QplnyQg6cK5WJ35WN2VmxG2Nr+Uab/71x5uqtBu/pPPASh1HcyGCZBM1xJVQuwc
         6NjHfBOYJjuE6v/uoVcJvxVE3zYLgd/dE+kCQi3dpOouo4Lr82aGjWcKJy1oroGND/os
         b2eTdXOhceRs7uDPqnVtHv7HoHMZBRzSkS9/T9s5T7VAhjXF6nqcKGh0+zuh8aYqTzWp
         LDBGYb9I5Lr5sDTtIWsGHW3us4BmtUIOW8lmibNqe7tuup3u2uu8TZ/u/HPiIFtdgloi
         DI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2LA8/5m2YlrOTBqAtldyUhtslhzmNNTEthEphR9Wf3U=;
        b=VKq1kQrHp4Szr991sCoZKilw6PP/cuHbgw3V20WFUkO6zFBiVIXI9hNT9JjuuQmhq6
         9VjCn9RXB5ve+t7GRfTJPif6XmpJrnM+yciH3v8D0Mz6P9pdymkJEbROc/maN1s025s4
         rBn64MoGYC9X4koB5DGyz7AjAnuxVtQcPN8LzFPWG3UxXTa3aGhKeb4AgL0ssRx2WeWk
         fidCMnbIZkR65sBGK33IOb5np+6HevWtmKR3K0b1aiKW9pWl14l8YgJy3UyEZzxRlsbj
         gUBGtCP4LU/o7zJzhtqpLmmJcp9jANgBpThkj8cv/7V6yMG3mt2UCW4+ueW4YIJiI9RJ
         a5bg==
X-Gm-Message-State: AOAM533rlnXVGaGSBbfSdNUQ9Vr3c1sgTB+vBd1aZ9TFYhAB5RE/fUSC
        ENstW07wUkk+TqQURBPtq12L6cVUUHmCTQ==
X-Google-Smtp-Source: ABdhPJyPXZFgr74KWhYqrwQAfu6ypmutgoyrZvk0cEkhUOKdZnfinoX8GmOPAmjrsoV6ozjqGo+kjw==
X-Received: by 2002:a5d:640b:: with SMTP id z11mr22123835wru.327.1615207205841;
        Mon, 08 Mar 2021 04:40:05 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270095bc7625808eade0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:95bc:7625:808e:ade0])
        by smtp.gmail.com with ESMTPSA id l4sm12206118wrt.60.2021.03.08.04.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 04:40:05 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     devicetree@vger.kernel.org, will@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        krzk@kernel.org, robh+dt@kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, catalin.marinas@arm.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 1/1] arm64: dts: imx8mm-nitrogen-r2: add espi2 support
Date:   Mon,  8 Mar 2021 13:39:58 +0100
Message-Id: <20210308123958.254116-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308123958.254116-1-adrien.grassein@gmail.com>
References: <20210308123958.254116-1-adrien.grassein@gmail.com>
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
index 4f4cf7df5a5a..0c5949b40eeb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -52,6 +52,19 @@ &A53_3 {
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
@@ -286,6 +299,15 @@ &iomuxc {
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

