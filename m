Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9177358ADB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhDHRGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhDHRGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:06:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911DFC0613D9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:05:48 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id j7so1382273plx.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3x6NN0RMF6oM3dbqENncJ4pFgq9ZKIyr1RsN2Tb2XX8=;
        b=NRAy4n+M8JIo/MIPJ7wWmm2Nghtrk0v0IMH60Z9LkBM0OhvUOLCE2X+4n7kq8hwPMb
         Bj+/b314XEZAolws4BAfpOxjekvhUPwYwWK1fn6kzVkuYzSY/19802VFalFHExfnXfpE
         pDU8KnMPR81IQqHQLnh8mFb0dA8MW/169NPaNGf+9qhTRThFiPNX05ZbYQlZD+MOYad3
         KU3YgJOUTJXnX6DXaC9MlmS93lJVc07LfhnNXMpa3/PzRKvqzCD21fhqLMgPid3njDCG
         7Syam/5V3PUREw9OSiFxOjXUjK7Cwk04TmCZiCmTuiBa16BNNpYGqGFi32wO61cDE50Z
         VQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3x6NN0RMF6oM3dbqENncJ4pFgq9ZKIyr1RsN2Tb2XX8=;
        b=dAUeFDB+ALn/4UPHm0sAA2gC/vKaL5ZHJJbOnv+x+dNiNEnaiSo+Zd6A+6xvhqU2TO
         nnJA6WBzW9hsSoqIBXBb5TtKZWg/WHYqdzMOtY+Phnk0sw0Fda3IuSbFgLrILqUcmX3U
         yjt/UQb3H0v/9n6r+pvYlwZbBrv1TSvHIorPnoWGY4+Gz8XvGCzdDtDckpeSD/bEeLLd
         0corLD32xwz8o9zQolWDHxVIAtlF38OriwpUQplpV/eqO9pGd3sm0LmuZ9bdF4ZdPjbM
         XTIbCTu0fXjHsufcNnh9faC0a/EiVxHricoZa0Xe48XemyIELAPOMC1BPvoF/DrYVgFL
         EtpQ==
X-Gm-Message-State: AOAM53322bm91CpXlf9infyiDAiTN7k4/ZjBv2Z5KuJHRO1sIFggKABM
        YPSubbW2ibD48lO17MLFpsCe
X-Google-Smtp-Source: ABdhPJxZ9ceevhue4KAsxMou2ASMZad2hEJM1+3mn4l2Mzr7yr6xD04auXkO1OvEXuoUV2P4XZ12Ug==
X-Received: by 2002:a17:902:8bcb:b029:e6:a4a1:9d7e with SMTP id r11-20020a1709028bcbb02900e6a4a19d7emr8602380plo.25.1617901547954;
        Thu, 08 Apr 2021 10:05:47 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id y194sm65183pfb.21.2021.04.08.10.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:05:47 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 15/15] ARM: dts: qcom: sdx55: Add Modem remoteproc node
Date:   Thu,  8 Apr 2021 22:34:57 +0530
Message-Id: <20210408170457.91409-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
References: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add modem support to SDX55 using the PAS remoteproc driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/qcom-sdx55-telit-fn980-tlb.dts   |  5 +++
 arch/arm/boot/dts/qcom-sdx55.dtsi             | 33 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
index 6da366ec15b3..3065f84634b8 100644
--- a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
@@ -255,6 +255,11 @@ nand@0 {
 	};
 };
 
+&remoteproc_mpss {
+	status = "okay";
+	memory-region = <&mpss_adsp_mem>;
+};
+
 &usb_hsphy {
 	status = "okay";
 	vdda-pll-supply = <&vreg_l4e_bb_0p875>;
diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index aa3edecf5810..bed83d1ddc29 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -328,6 +328,39 @@ sdhc_1: sdhci@8804000 {
 			status = "disabled";
 		};
 
+		remoteproc_mpss: remoteproc@4080000 {
+			compatible = "qcom,sdx55-mpss-pas";
+			reg = <0x04080000 0x4040>;
+
+			interrupts-extended = <&intc GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready", "handover",
+					  "stop-ack", "shutdown-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd SDX55_CX>,
+					<&rpmhpd SDX55_MSS>;
+			power-domain-names = "cx", "mss";
+
+			qcom,smem-states = <&modem_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 114 IRQ_TYPE_EDGE_RISING>;
+				label = "mpss";
+				qcom,remote-pid = <1>;
+				mboxes = <&apcs 15>;
+			};
+		};
+
 		usb: usb@a6f8800 {
 			compatible = "qcom,sdx55-dwc3", "qcom,dwc3";
 			reg = <0x0a6f8800 0x400>;
-- 
2.25.1

