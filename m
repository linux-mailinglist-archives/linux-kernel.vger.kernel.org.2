Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F394A4234CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhJFAHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbhJFAHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:07:21 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F63C06174E;
        Tue,  5 Oct 2021 17:05:30 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b78so912408iof.2;
        Tue, 05 Oct 2021 17:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLAxQdhoFe7v2vMVDyp/8Fr7Jukarsi+bCPeqRNe98M=;
        b=IqyWOBm3QzJtcUSGGdL25ly8ZDLzh3Zn8ZTUT5ZgrAt6jLwtTFX6W9iInXDrhjjj63
         EWgh9zLjb5Jp02vubkPEhfzBYgtXO6gdzkDpP1NFX8U/l0hfPzQtxeXgFPyjkCges2i0
         LX4JF/r+kFmErO/B87kt4D39/0weVWzMe/JTkOHNgzeXx/qbpgNCuDmM5MPd8eQ5zA7O
         HCafRFk1jhUsPLey+vie63HTxLnGXTTixKMO9+2LWlqGJJLaGAoxED1Qh5MQI3tBlbYa
         3MH4q59BdlO+T80NDWpU7z4Ku9Q0zrcBSFIdh7YXrOitLuUjt4ywj6C8daV2vkIgwJHg
         xRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLAxQdhoFe7v2vMVDyp/8Fr7Jukarsi+bCPeqRNe98M=;
        b=ObFyn9Qg4M6FW6Ww3NIUl20fbWij58EeNY6XIzOIUlfJvh1cBf16mPTCaE5sndtuLY
         +2988QwjGxaM2GH+GSxSII3F3hCpmT2j16It7fTbXTWryBW3AOjMnvp4TQK3XN794Iik
         AGv58hQ3lgrLS9PL2VqnknlDIpjPZ4mQffOcj0Dc5TK1utLyVE+kl24BEAruDBpnodQG
         IYxYhHpgJuIc7j9AfS2DoZWF2n9boRuDeuOmSNprtvjnWu/rywxLPl2zdLy04+06rMZ9
         QjhyeXvHlo9pKiUOd6q/7ye1p9Zw60z45Pv8vvmuR5PJ7jB2YQym6VBkt8I1o/VUsGP0
         GS3w==
X-Gm-Message-State: AOAM531rHbHcI50KONg3ik86mPMNJzAmjKRhyECyLu4HZlFkKj13lt+h
        mmalas1PjAivDlNoxMLz8T4=
X-Google-Smtp-Source: ABdhPJzDQh6yuWWYopVdkwBNX2GzrDeNJDUhUXZl5orB7yTsXH9jvMxTa4Wk21lZRPe4YbfVVFFHIg==
X-Received: by 2002:a02:1088:: with SMTP id 130mr4859821jay.87.1633478729803;
        Tue, 05 Oct 2021 17:05:29 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:94fc:9a4b:2e18:e915])
        by smtp.gmail.com with ESMTPSA id y2sm11338646ioj.12.2021.10.05.17.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 17:05:29 -0700 (PDT)
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
Subject: [PATCH 7/7] arm64: dts: imx8mn: Enable GPU
Date:   Tue,  5 Oct 2021 19:05:04 -0500
Message-Id: <20211006000505.627334-7-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006000505.627334-1-aford173@gmail.com>
References: <20211006000505.627334-1-aford173@gmail.com>
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
index 57f67257d2fd..46144a7482d3 100644
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

