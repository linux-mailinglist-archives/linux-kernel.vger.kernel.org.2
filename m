Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16F23AE42C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhFUH1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhFUH1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:27:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BA2C061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:25:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c5so294540pfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CDm4Fe12mdxq5DdIPspRuN5iFshZ9EbPE5vdu5Oxm04=;
        b=YZOmFhde+7WJEAJJcHhiE2RoCfiZ5+Xre9HWv6er8mZGYPFwx86A5pI5HvqQ2aIYJa
         mGQl507iONMiu2Njyt//5ToHzpgInx4NxnruZObcvkMMVEwmlvPwD1V4WVl+A4Mn9tpU
         Es22Hpp1Cbf2desjyFjngKNPKVp4vgR3lYPsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDm4Fe12mdxq5DdIPspRuN5iFshZ9EbPE5vdu5Oxm04=;
        b=ugSkshg0YU2McQZaEtOeKtGHI14MS5xuXpjMy0XEPHNQDd4GSAwOIBt4bEfWbpA14y
         zbAo+GpbL/CMdYVbbcRmJeEBjNh0beaRu+1POS9njK3UwEDYsk2GcEmMn1fXz41HqfpP
         zOuIX/bDhRvAeSy2NFZbFFSNhzyeZzLOVF6rdBdVTNS9NHFPa6xJch6CyrZ5Nglyb6F8
         WLJLJhgdvH3BNPwyA3GkHB33uCiVrOjy3lwEAPRdsQ4kYeQOKq2SXR6D3SWfMGr2OcoL
         SthRNSFcPt+7/C2ADYRzQ+nmqia16kA+qkU1TgWbQS0uURvAHN6iCww92hJBiljQ1OSH
         4YSg==
X-Gm-Message-State: AOAM531wnEE7gJvyv7+Dcm47+ihHH7H3mNjSbwPR5x0Gf+xa/xcJQvit
        sVjMh+/l95GJAkaEL2ZQlGVNcg==
X-Google-Smtp-Source: ABdhPJxxKWIiejU1Buqyxc/58klL8XS905Uz5TdWMrAYfu8+TVmMNfyDjpogOLqWfZadZDexODr4cQ==
X-Received: by 2002:a65:63d2:: with SMTP id n18mr22683982pgv.447.1624260333918;
        Mon, 21 Jun 2021 00:25:33 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00a:a884:139:e97f:a55d:7f66])
        by smtp.gmail.com with ESMTPSA id 21sm13951294pfh.103.2021.06.21.00.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 00:25:33 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tomasz Figa <t.figa@samsung.com>,
        Fancy Fang <chen.fang@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Anthony Brandon <anthony@amarulasolutions.com>,
        Francis Laniel <francis.laniel@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Milco Pratesi <milco.pratesi@engicam.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH 8/9] arm64: dts: imx8mm: Add MIPI DSI pipeline
Date:   Mon, 21 Jun 2021 12:54:23 +0530
Message-Id: <20210621072424.111733-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621072424.111733-1-jagan@amarulasolutions.com>
References: <20210621072424.111733-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MIPI DSI pipeline for i.MX8MM.

Video pipeline start from eLCDIF to MIPI DSI and respective
Panel or Bridge on the backend side.

Add support for it.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 59 +++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 5f68182ed3a6..bc09fce0f6a9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1047,6 +1047,65 @@ lcdif: lcdif@32e00000 {
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF>;
 				status = "disabled";
+
+				port {
+					lcdif_out_dsi: endpoint {
+						remote-endpoint = <&dsi_in_lcdif>;
+					};
+				};
+			};
+
+			dsi: dsi@32e10000 {
+				compatible = "fsl,imx8mm-sec-dsim";
+				reg = <0x32e10000 0xa0>;
+				clocks = <&clk IMX8MM_CLK_DSI_CORE>,
+					 <&clk IMX8MM_CLK_DSI_PHY_REF>;
+				clock-names = "bus", "phy_ref";
+				assigned-clocks = <&clk IMX8MM_CLK_DSI_CORE>,
+						  <&clk IMX8MM_VIDEO_PLL1_OUT>,
+						  <&clk IMX8MM_CLK_DSI_PHY_REF>;
+				assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_266M>,
+							 <&clk IMX8MM_VIDEO_PLL1_BYPASS>,
+							 <&clk IMX8MM_VIDEO_PLL1_OUT>;
+				assigned-clock-rates = <266000000>, <594000000>, <27000000>;
+				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&dphy>;
+				phy-names = "dphy";
+				power-domains = <&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI>;
+				samsung,burst-clock-frequency = <891000000>;
+				samsung,esc-clock-frequency = <54000000>;
+				samsung,pll-clock-frequency = <27000000>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						dsi_in_lcdif: endpoint@0 {
+							reg = <0>;
+							remote-endpoint = <&lcdif_out_dsi>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+					};
+				};
+			};
+
+			dphy: dphy@32e100a4 {
+				compatible = "fsl,imx8mm-sec-dsim-dphy";
+				reg = <0x32e100a4 0xbc>;
+				clocks = <&clk IMX8MM_CLK_DSI_PHY_REF>;
+				clock-names = "phy_ref";
+				#phy-cells = <0>;
+				power-domains = <&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DPHY>;
+				status = "disabled";
 			};
 
 			dispmix_blk_ctl: blk-ctl@32e28000 {
-- 
2.25.1

