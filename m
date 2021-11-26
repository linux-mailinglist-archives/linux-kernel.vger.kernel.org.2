Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4B345E83D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 08:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359179AbhKZHMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359083AbhKZHKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:10:40 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCF9C061758
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:05:35 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so7352874pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gk4rvCV03RBbs3lJ8Y+UfCA+XfTtLzCTArp4r19KoX4=;
        b=kq+NA/2nl4C90qPVmPb+HK0Uw7fRdLs8uHrlkM7/LwgySoHhMCXqku0eL7Rvn0UVax
         OKZuZ7fOyg8p61xbK5kFp6kRH9H9WJtqfRUnd8hEIzzTL0yDITTntzmDBz7VXKdnOK8W
         d7Vf+FroJErXGTQsD+gyzV3udX//Sko+QlfBbraXOrYFkctyOsClxJkTuQfiivv/lmoA
         eNRCsPFG3H0NHq58cDcrL5SIHpXKw46zHfoDxqXVtH3YlRUmCu9fcvaUxQS0Iy8Q6sqS
         pPrl4cXB0eoR8Jkp4q6giQDslNs57Nfv0WTAie2Pjk+9ukWcDWyM2neXUOnLTIqoxO4T
         6Pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gk4rvCV03RBbs3lJ8Y+UfCA+XfTtLzCTArp4r19KoX4=;
        b=Ikkt8xVLclCnkXNF2GlDhlYtOHiBnaT8KHmhjNu3VsB5BuPNWZg5BG6QinddKqRa51
         H4x8L/aBUV0jeZRYwzv6MIgYFfIfSfwvETnbwE3sehmeHYtCTpQTDAKo9XLS/3YPu3A+
         tm7El38UCd3OSIKdJiW5dJUZt6J2tErv0FZZuMVuF+lgf4MrogJaW4Cj0OLkwvl1MlF/
         hxh9BIELRqa0hQw3BdVPbSpXX66TAHALo4lbvIm971qsDzyn6DavhMErGvU3fG8eboOK
         G43/o+JDYrOwtJVKl+u2Nar9bT2Ht3V1LreGMPDkOVjTHVeLarPquRb2PGBZIwMP9Lv1
         clEA==
X-Gm-Message-State: AOAM530pges4KaJ26GSKfJwkkqmTHupWl0so5dJ5OpN6jv8RHIjvtFBY
        qBj7Cazd0AXYFJZmltoMVflf
X-Google-Smtp-Source: ABdhPJwyJ3QPUaQnOjSIwwYHoJeXvkZX5jatZhE6626mg+WZeVAYCu8/ojO+2dhuZLRyZ1mkFIppkQ==
X-Received: by 2002:a17:902:f209:b0:141:99d1:7cef with SMTP id m9-20020a170902f20900b0014199d17cefmr35941245plc.70.1637910334998;
        Thu, 25 Nov 2021 23:05:34 -0800 (PST)
Received: from localhost.localdomain ([117.215.117.247])
        by smtp.gmail.com with ESMTPSA id d12sm4042104pgf.19.2021.11.25.23.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 23:05:34 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/6] ARM: dts: qcom: sdx55: Add support for PCIe EP
Date:   Fri, 26 Nov 2021 12:35:17 +0530
Message-Id: <20211126070520.28979-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126070520.28979-1-manivannan.sadhasivam@linaro.org>
References: <20211126070520.28979-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for PCIe Endpoint controller on the Qualcomm SDX55 platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 45 +++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 16995782dfdf..5d769b3f2d35 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/clock/qcom,gcc-sdx55.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interconnect/qcom,sdx55.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -391,6 +392,11 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
+		tcsr: syscon@1fcb000 {
+			compatible = "syscon";
+			reg = <0x01fc0000 0x1000>;
+		};
+
 		sdhc_1: sdhci@8804000 {
 			compatible = "qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x08804000 0x1000>;
@@ -403,6 +409,45 @@ sdhc_1: sdhci@8804000 {
 			status = "disabled";
 		};
 
+		pcie_ep: pcie-ep@40000000 {
+			compatible = "qcom,sdx55-pcie-ep";
+			reg = <0x01c00000 0x3000>,
+			      <0x40000000 0xf1d>,
+			      <0x40000f20 0xc8>,
+			      <0x40001000 0x1000>,
+			      <0x40002000 0x10000>,
+			      <0x01c03000 0x3000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
+				    "mmio";
+
+			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
+
+			clocks = <&gcc GCC_PCIE_AUX_CLK>,
+				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLEEP_CLK>,
+				 <&gcc GCC_PCIE_0_CLKREF_CLK>;
+			clock-names = "aux", "cfg", "bus_master", "bus_slave",
+				      "slave_q2a", "sleep", "ref";
+
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global", "doorbell";
+			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
+			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
+			resets = <&gcc GCC_PCIE_BCR>;
+			reset-names = "core";
+			power-domains = <&gcc PCIE_GDSC>;
+			phys = <&pcie0_lane>;
+			phy-names = "pciephy";
+			max-link-speed = <3>;
+			num-lanes = <2>;
+
+			status = "disabled";
+		};
+
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sdx55-mpss-pas";
 			reg = <0x04080000 0x4040>;
-- 
2.25.1

