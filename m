Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05B545E837
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 08:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359121AbhKZHKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbhKZHIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:08:42 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC17C061746
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:05:30 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id n85so7996227pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KvsdfS4yAXK8qGr4kUwpkhkSA11Udv6JYNv1Y5Hw6v0=;
        b=BYKWBAs3Zfsl/r+tx3SI7o4yI8UFQFU9x8CrYin/iiqLTKcCro+j7FPe/TVapOoQpZ
         4RQp0MTKeRnGEK/8O9JRX9Wdn8lNNy6j7X+mWrtUBrkrGZpBK8QgnZKQLLZ9H01PkIkr
         9MjfAhOM9lbJQD1BXXMkjX+HfheUJvW6Mgss5ExeuXZaJduTssm7PjKtKy8dDEn6uYSu
         8ewWu0VglAmJiHLjdrxV4gb4ln+kgFWdbRIMTcX57ECqBO8GG7Hjx0NtCoTgPPuprN54
         38wVyIc/eM/fpaRll5rgu5HVYv5n32GzvhgnIJj8V6YNMAwa8Dcucfic956o6G95gWC3
         Xu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KvsdfS4yAXK8qGr4kUwpkhkSA11Udv6JYNv1Y5Hw6v0=;
        b=1Q3Eh/Tfa/LxAmn3Fl4vHIub8C0r18xwuF3ylUZZ5WOQIVNA18bZI5t2RoVS0+dj8W
         seKP5srTrh/5TlU3IZdYVf9DPYNlzX2w6LrK3M+sfP2ajpiBhRxoG31ILXSV3rnhj0n9
         E8GDSs5b8lOH6sdReN9+J7eCMc5Hbp8lawXTqxOF9DTHKb/bknDdeetBXfaoBcr8SdSO
         tV7qqGs1kVz85mL1637R8gdAP2BGbIT+fSB7RjwBSFlXlcFvkxelnhxOCSBPWQC2NQK9
         JsAB//alx8Rp+Wbf219XFzXH+PfepTGY2gGzvveevvT4ixocfyOetFftzSKksBgsAzAd
         UXFQ==
X-Gm-Message-State: AOAM531opaIr1ENrtI9N5kcjDk+kuh9cjZNhEe+nfs1nnMu4wgOC/ivl
        aa5WCeD38x3TS07Y71XxECk2tviKENmp
X-Google-Smtp-Source: ABdhPJwGYyuWRiOHyU6/h8MNBCE9mgEzQr1HiVzHqqd5qT9loqL3FpaJWqvt2EWurtiOTfpD4o7dwA==
X-Received: by 2002:a63:b22:: with SMTP id 34mr20153957pgl.454.1637910330163;
        Thu, 25 Nov 2021 23:05:30 -0800 (PST)
Received: from localhost.localdomain ([117.215.117.247])
        by smtp.gmail.com with ESMTPSA id d12sm4042104pgf.19.2021.11.25.23.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 23:05:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/6] ARM: dts: qcom: sdx55: Add support for PCIe PHY
Date:   Fri, 26 Nov 2021 12:35:15 +0530
Message-Id: <20211126070520.28979-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126070520.28979-1-manivannan.sadhasivam@linaro.org>
References: <20211126070520.28979-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for PCIe PHY used in SDX55 platform. This PHY is
used by the PCIe EP controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 44526ad9d210..16995782dfdf 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -309,6 +309,41 @@ qpic_nand: nand-controller@1b30000 {
 			status = "disabled";
 		};
 
+		pcie0_phy: phy@1c07000 {
+			compatible = "qcom,sdx55-qmp-pcie-phy";
+			reg = <0x01c07000 0x1c4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&gcc GCC_PCIE_AUX_PHY_CLK_SRC>,
+				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_CLKREF_CLK>,
+				 <&gcc GCC_PCIE_RCHNG_PHY_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "refgen";
+
+			resets = <&gcc GCC_PCIE_PHY_BCR>;
+			reset-names = "phy";
+
+			assigned-clocks = <&gcc GCC_PCIE_RCHNG_PHY_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			status = "disabled";
+
+			pcie0_lane: lanes@1c06000 {
+				reg = <0x01c06000 0x104>, /* tx0 */
+				      <0x01c06200 0x328>, /* rx0 */
+				      <0x01c07200 0x1e8>, /* pcs */
+				      <0x01c06800 0x104>, /* tx1 */
+				      <0x01c06a00 0x328>, /* rx1 */
+				      <0x01c07600 0x800>; /* pcs_misc */
+				clocks = <&gcc GCC_PCIE_PIPE_CLK>;
+				clock-names = "pipe0";
+
+				#phy-cells = <0>;
+				clock-output-names = "pcie_pipe_clk";
+			};
+		};
+
 		ipa: ipa@1e40000 {
 			compatible = "qcom,sdx55-ipa";
 
-- 
2.25.1

