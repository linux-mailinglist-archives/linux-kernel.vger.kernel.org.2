Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5353A427BFD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 18:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhJIQ3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 12:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhJIQ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 12:29:31 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA57C061762;
        Sat,  9 Oct 2021 09:27:34 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id s17so9256889ioa.13;
        Sat, 09 Oct 2021 09:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SC7yuE+y+yY04HdxUeULdqELR2rOPU50GZB4BwqAcXk=;
        b=gyneMYk2SYZinM2+aS9T33hNi9L+S/ef8XR4SxciZa2SXX+iUee1BB9RCWBv9u1AJO
         ZgOBgnculKgnAGRa7CrNx9/Y/Ck+dfhXbV+rqidawT+NIMqcsrnCuXnilHLzHozWQ2A2
         6VcJ/xluC9SgFZvEqybrsd0OLY6Mrq8c6a/yNvZ6WA1LaQF+q/hVkqPCCwClZjc8sxcZ
         GpZ6YLjxVbDoUAYLoN3IsDQ7pTVto6/NKHjAS1i3Q3Svfm7aHf55Bi13lV3siUw4g7vz
         Be9zOLAWS/nVvKNvFjyNY/PJhnhCMlyOtbKvLSCDRIL7LmSDrsXxeNZxWHqgLr5sFOEP
         ptZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SC7yuE+y+yY04HdxUeULdqELR2rOPU50GZB4BwqAcXk=;
        b=YZrOh5ctFE0vosLe47nJYjOZEj3fGfzuAvYrNZN8F66sranlTR5ok5bik1svo83wGL
         PDKrrl94iNmaZgrzqLX6tlDIiUFDaj/iKWKG3spzbdD7TFGK9TjbMoAHCjDVBKSufLBh
         cLPpkIY9AJowmXImcXkrVeCyvKyGE52Tkb50C7TKEwZpzjPja840NsXL4Yg6WNqgftZG
         JIkYFUEku4gAJqqjA3uRbw80EE9FxAKG4WZjRFO60Pk+q5o7qGlJj28vgezl9qiKc8go
         5l5za9/jFbgV+zt1qgNp55NQX0OGFEnQZeRqTSPEgblZKf+0bE0U+hJ9pDDzD0D3mwWX
         dxYA==
X-Gm-Message-State: AOAM5323lmNYPqAAoifa3IC4ILCHYPtU9KnX+tXVT+238n97pyeasW8J
        7MIJX0ywj88B6AmOKjhZvsQ=
X-Google-Smtp-Source: ABdhPJyppGKGyNDI/6yCWc9m04gVdtGmfW2N54kjD3LaaTGlYaTXW3TOfprE4Likwych2/jbudHHIQ==
X-Received: by 2002:a02:a18c:: with SMTP id n12mr878391jah.130.1633796854199;
        Sat, 09 Oct 2021 09:27:34 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:cb0f:c46c:9a27:ace])
        by smtp.gmail.com with ESMTPSA id y5sm1253722ilg.58.2021.10.09.09.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 09:27:33 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 9/9] arm64: dts: imx8mn: Enable GPU
Date:   Sat,  9 Oct 2021 11:26:59 -0500
Message-Id: <20211009162700.1452857-10-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009162700.1452857-1-aford173@gmail.com>
References: <20211009162700.1452857-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M-Nano features a GC7000. The Etnaviv driver detects it as:

    etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 6ac14903bcef..2aafc17d8aa3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1089,6 +1089,31 @@ gpmi: nand-controller@33002000 {
 			status = "disabled";
 		};
 
+		gpu: gpu@38000000 {
+			compatible = "vivante,gc";
+			reg = <0x38000000 0x8000>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MN_CLK_GPU_AHB>,
+				<&clk IMX8MN_CLK_GPU_BUS_ROOT>,
+				<&clk IMX8MN_CLK_GPU_CORE_ROOT>,
+				<&clk IMX8MN_CLK_GPU_SHADER>;
+			clock-names = "reg", "bus", "core", "shader";
+			assigned-clocks = <&clk IMX8MN_CLK_GPU_CORE>,
+					  <&clk IMX8MN_CLK_GPU_SHADER>,
+					  <&clk IMX8MN_CLK_GPU_AXI>,
+					  <&clk IMX8MN_CLK_GPU_AHB>,
+					  <&clk IMX8MN_GPU_PLL>,
+					  <&clk IMX8MN_CLK_GPU_CORE>,
+					  <&clk IMX8MN_CLK_GPU_SHADER>;
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

