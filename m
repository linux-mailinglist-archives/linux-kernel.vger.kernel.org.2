Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CDC31D87B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhBQLfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhBQL2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:28:30 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE90C0698E1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:22:32 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id n13so14851582ejx.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=286RxVm6s4VDjxxxqjBmiZOHysbJWKqcglXnnU7P2aM=;
        b=RT+TLiemYSV6Bdv01L3qpnE8UMbo+Ye/dyePdVd52B4MSJjWLz1MjQq8ouonPLP97e
         iXKj3ICIQXFQc6JwE28xp9MBoGbrMSZ0U57SKisMqGy+76qOBmBvYQfxNwfFL2qqCSiA
         a/PusaOEmficDbWnyrHPqWyVLYZQ6Nim3JaK/eJgFyMbjjuaz/vNhA2TtiCu/F03sJT6
         EETixLedfd+D8it1ZZ0imHEynDsHRXMo+ILYov0GMtXDKDB/i85TOYqJm0xJ/gtymkAu
         0LDOFPRNOLexAsRHcIjsdmSNP1O/cwMwBPTJBjVrCiWxNxBmTTBZEsZaS/ZsM4PDTehI
         a1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=286RxVm6s4VDjxxxqjBmiZOHysbJWKqcglXnnU7P2aM=;
        b=B+1amOjk5rHU7qqbPJ1GdmtUCzHgFDRsIZAokQXGM5wplhQbaBIhsv8D+GBZiU3/PJ
         KLbZGHYxNHm5WK5qAFIotcUO9To7Mx6r99QQ4566P64IE+vY1LU5ElGIsx7yfrJVNYxp
         kdPqxSkJceUp+tkekX8/E+k437C48fxYfjp0tm6PbaDK9Negy2syd87yUqRL9b72v4rL
         TrILBMoHhp3VktkN8lWmwHq+m7wNWANKMSSzDYP8aJYyjd2E2XwiFYGCIu8vc+V6PwRN
         2qe34BNN6dE8eZkYCDnIr3iFfbdX6ekDFpWpBW7FnPwTm3YG3/fouXHDbMGw7SR+FQ6G
         /e4A==
X-Gm-Message-State: AOAM532wtJ0wE3CVxALl37ZoRhz3/DP//fUt77xmsNYg4nhRdIp3RKRI
        emQ3B8s6dX2jGb0DCVTmpTWkVQ==
X-Google-Smtp-Source: ABdhPJzPT0tenMklKMMKJF6ZLYAaarjoI9roxnBybLWcY5X0oVtkBpx+aj8jh6FuIfYtujQg/bHxvA==
X-Received: by 2002:a17:906:380b:: with SMTP id v11mr13515904ejc.183.1613560951201;
        Wed, 17 Feb 2021 03:22:31 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:4815:d4dc:ff5a:704a])
        by smtp.gmail.com with ESMTPSA id h10sm934344edk.45.2021.02.17.03.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 03:22:30 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v5 20/22] arm64: dts: sdm845: Add CAMSS ISP node
Date:   Wed, 17 Feb 2021 12:21:20 +0100
Message-Id: <20210217112122.424236-21-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210217112122.424236-1-robert.foss@linaro.org>
References: <20210217112122.424236-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the camss dt node for sdm845.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 135 +++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index bcf888381f14..4fe93c69908a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3911,6 +3911,141 @@ videocc: clock-controller@ab00000 {
 			#reset-cells = <1>;
 		};
 
+		camss: camss@a00000 {
+			compatible = "qcom,sdm845-camss";
+
+			reg = <0 0xacb3000 0 0x1000>,
+				<0 0xacba000 0 0x1000>,
+				<0 0xacc8000 0 0x1000>,
+				<0 0xac65000 0 0x1000>,
+				<0 0xac66000 0 0x1000>,
+				<0 0xac67000 0 0x1000>,
+				<0 0xac68000 0 0x1000>,
+				<0 0xacaf000 0 0x4000>,
+				<0 0xacb6000 0 0x4000>,
+				<0 0xacc4000 0 0x4000>;
+			reg-names = "csid0",
+				"csid1",
+				"csid2",
+				"csiphy0",
+				"csiphy1",
+				"csiphy2",
+				"csiphy3",
+				"vfe0",
+				"vfe1",
+				"vfe_lite";
+
+			interrupts = <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 477 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 479 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "csid0",
+				"csid1",
+				"csid2",
+				"csiphy0",
+				"csiphy1",
+				"csiphy2",
+				"csiphy3",
+				"vfe0",
+				"vfe1",
+				"vfe_lite";
+
+			power-domains = <&clock_camcc IFE_0_GDSC>,
+				<&clock_camcc IFE_1_GDSC>,
+				<&clock_camcc TITAN_TOP_GDSC>;
+
+			clocks = <&clock_camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&clock_camcc CAM_CC_CPAS_AHB_CLK>,
+				<&clock_camcc CAM_CC_CPHY_RX_CLK_SRC>,
+				<&clock_camcc CAM_CC_IFE_0_CSID_CLK>,
+				<&clock_camcc CAM_CC_IFE_0_CSID_CLK_SRC>,
+				<&clock_camcc CAM_CC_IFE_1_CSID_CLK>,
+				<&clock_camcc CAM_CC_IFE_1_CSID_CLK_SRC>,
+				<&clock_camcc CAM_CC_IFE_LITE_CSID_CLK>,
+				<&clock_camcc CAM_CC_IFE_LITE_CSID_CLK_SRC>,
+				<&clock_camcc CAM_CC_CSIPHY0_CLK>,
+				<&clock_camcc CAM_CC_CSI0PHYTIMER_CLK>,
+				<&clock_camcc CAM_CC_CSI0PHYTIMER_CLK_SRC>,
+				<&clock_camcc CAM_CC_CSIPHY1_CLK>,
+				<&clock_camcc CAM_CC_CSI1PHYTIMER_CLK>,
+				<&clock_camcc CAM_CC_CSI1PHYTIMER_CLK_SRC>,
+				<&clock_camcc CAM_CC_CSIPHY2_CLK>,
+				<&clock_camcc CAM_CC_CSI2PHYTIMER_CLK>,
+				<&clock_camcc CAM_CC_CSI2PHYTIMER_CLK_SRC>,
+				<&clock_camcc CAM_CC_CSIPHY3_CLK>,
+				<&clock_camcc CAM_CC_CSI3PHYTIMER_CLK>,
+				<&clock_camcc CAM_CC_CSI3PHYTIMER_CLK_SRC>,
+				<&gcc GCC_CAMERA_AHB_CLK>,
+				<&gcc GCC_CAMERA_AXI_CLK>,
+				<&clock_camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				<&clock_camcc CAM_CC_SOC_AHB_CLK>,
+				<&clock_camcc CAM_CC_IFE_0_AXI_CLK>,
+				<&clock_camcc CAM_CC_IFE_0_CLK>,
+				<&clock_camcc CAM_CC_IFE_0_CPHY_RX_CLK>,
+				<&clock_camcc CAM_CC_IFE_0_CLK_SRC>,
+				<&clock_camcc CAM_CC_IFE_1_AXI_CLK>,
+				<&clock_camcc CAM_CC_IFE_1_CLK>,
+				<&clock_camcc CAM_CC_IFE_1_CPHY_RX_CLK>,
+				<&clock_camcc CAM_CC_IFE_1_CLK_SRC>,
+				<&clock_camcc CAM_CC_IFE_LITE_CLK>,
+				<&clock_camcc CAM_CC_IFE_LITE_CPHY_RX_CLK>,
+				<&clock_camcc CAM_CC_IFE_LITE_CLK_SRC>;
+			clock-names = "camnoc_axi",
+				"cpas_ahb",
+				"cphy_rx_src",
+				"csi0",
+				"csi0_src",
+				"csi1",
+				"csi1_src",
+				"csi2",
+				"csi2_src",
+				"csiphy0",
+				"csiphy0_timer",
+				"csiphy0_timer_src",
+				"csiphy1",
+				"csiphy1_timer",
+				"csiphy1_timer_src",
+				"csiphy2",
+				"csiphy2_timer",
+				"csiphy2_timer_src",
+				"csiphy3",
+				"csiphy3_timer",
+				"csiphy3_timer_src",
+				"gcc_camera_ahb",
+				"gcc_camera_axi",
+				"slow_ahb_src",
+				"soc_ahb",
+				"vfe0_axi",
+				"vfe0",
+				"vfe0_cphy_rx",
+				"vfe0_src",
+				"vfe1_axi",
+				"vfe1",
+				"vfe1_cphy_rx",
+				"vfe1_src",
+				"vfe_lite",
+				"vfe_lite_cphy_rx",
+				"vfe_lite_src";
+
+			iommus = <&apps_smmu 0x0808 0x0>,
+				 <&apps_smmu 0x0810 0x8>,
+				 <&apps_smmu 0x0c08 0x0>,
+				 <&apps_smmu 0x0c10 0x8>;
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		cci: cci@ac4a000 {
 			compatible = "qcom,sdm845-cci";
 			#address-cells = <1>;
-- 
2.27.0

