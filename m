Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E6136F1D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbhD2VRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237356AbhD2VRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:17:38 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A09C06138C;
        Thu, 29 Apr 2021 14:16:50 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b9so14461762iod.13;
        Thu, 29 Apr 2021 14:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jjYghAn3GYKlRzW30xaC+JWoAjT9ihkxsVSI8UNJwBw=;
        b=CPW/k6FzLpOKN2RZNvbpYeLdRdJegr1jP9a3EOUeuyllpSJMjIq/UXwkL7Gz1gv06P
         HWnm+gVWN0RLEGStIzSZZFmfbgNIS41BKvBNV4C/CEtq7G9yBz0cvrU762fJ4Y7BH7CM
         BUS9tqtcoMZINhx2JqvcEddtS7GcwtDMEmZQa4nCXogOc8dU5EqxMZhuUjuIsK33F3T+
         ZIjcBD53ttAc/Od9cvgqsis1riNwmygQ5o/mpQj4kvfQVVgO8LyavE6WR2n/YGLoY8GD
         1yWppWBOOCjK+vxXDJy2M9MNImpAged2acs2YbDuP0uKf0cf3SPCBB4lF/HIlOhsJ7ca
         rq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jjYghAn3GYKlRzW30xaC+JWoAjT9ihkxsVSI8UNJwBw=;
        b=EnUp9/YPLC9YcoFhXMoGlHCVlUrNNO2wHgjR0Cvd6ICjCNmpw2eAn4NYYnPTgEVdni
         MswtqVkPGO2b/qE0jDycH7CPXQ8LNIDiRFqIgKlCfjEkbgK0YBNTZX1Mcq+Hwpn+ZiPc
         B2JKkm20AfrOwmLxrc52ZPpjOSMxRmu8sDowJKLV++Tf8saWep+eWH+dP23Cw05vxjYn
         liKWdRlm5E8P3yxo8BFoIXvUTQx/G4d8l19dmaPC/AgibAIMTFaxVtHd+HUrKVFeradf
         wHP+hl3Jb0+K31Rw+n2qaP0J1jO98hXIoH+iJ2zVh0XuLIpHpg4HhMyD+/PLztsR9s+q
         xpKg==
X-Gm-Message-State: AOAM532B2BFiV6XeadwC/pmLGaS9foUsU3aLWMSWVVqTyPXPFvJLpFOG
        uOIhRyyRo820F0KLiBfTVHo=
X-Google-Smtp-Source: ABdhPJwoG7PPLrhqRaDUOYXGa5eYK++1PmUsrPg6b1IHR14ib8wvWaK9CiHcFuzZpaiTd5jomE90NQ==
X-Received: by 2002:a6b:720b:: with SMTP id n11mr1228980ioc.80.1619731009993;
        Thu, 29 Apr 2021 14:16:49 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8a74:d2ad:27b:e619])
        by smtp.gmail.com with ESMTPSA id q11sm1808076ile.56.2021.04.29.14.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 14:16:49 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     peng.fan@oss.nxp.com, marex@denx.de, frieder.schrempf@kontron.de,
        tharvey@gateworks.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 5/5] arm64: dts: imx8mn: Add GPU node
Date:   Thu, 29 Apr 2021 16:16:24 -0500
Message-Id: <20210429211625.1835702-6-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210429211625.1835702-1-aford173@gmail.com>
References: <20210429211625.1835702-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the documentation from NXP, the i.MX8M Nano has a
Vivante GC7000 Ultra Lite as its GPU core.

With this patch, the Etnaviv driver presents the GPU as:
   etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203

The stock operating voltage for the i.MX8M Nano is .85V which means
the GPU needs to run at 400MHz.  For boards where the operating
voltage is higher, this can be increased.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  Rebase on series starting https://lkml.org/lkml/2021/4/29/72
V2:  Move into this series
     Update clocking description

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index a2ca25aa8eb6..07a8ff58d44c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1040,6 +1040,31 @@ gpmi: nand-controller@33002000 {
 			status = "disabled";
 		};
 
+		gpu: gpu@38000000 {
+			compatible = "vivante,gc";
+			reg = <0x38000000 0x8000>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MN_CLK_GPU_AHB>,
+				<&clk IMX8MN_CLK_GPU_BUS_ROOT>,
+				<&clk IMX8MN_CLK_GPU_CORE_ROOT>,
+				<&clk IMX8MN_CLK_GPU_SHADER_DIV>;
+			clock-names = "reg", "bus", "core", "shader";
+			assigned-clocks = <&clk IMX8MN_CLK_GPU_CORE_SRC>,
+					  <&clk IMX8MN_CLK_GPU_SHADER_SRC>,
+					  <&clk IMX8MN_CLK_GPU_AXI>,
+					  <&clk IMX8MN_CLK_GPU_AHB>,
+					  <&clk IMX8MN_GPU_PLL>,
+					  <&clk IMX8MN_CLK_GPU_CORE_DIV>,
+					  <&clk IMX8MN_CLK_GPU_SHADER_DIV>;
+			assigned-clock-parents = <&clk IMX8MN_GPU_PLL_OUT>,
+						  <&clk IMX8MN_GPU_PLL_OUT>,
+						  <&clk IMX8MN_SYS_PLL1_800M>,
+						  <&clk IMX8MN_SYS_PLL1_800M>;
+			assigned-clock-rates = <0>, <0>, <800000000>, <400000000>, <1200000000>,
+				<400000000>, <400000000>;
+			power-domains = <&pgc_gpumix>;
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,
-- 
2.25.1

