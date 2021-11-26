Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A4F45E841
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 08:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359133AbhKZHMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359095AbhKZHKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:10:43 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6746C06175A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:05:37 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v23so6596157pjr.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xpnvk+P6+J5KeBQ3RLjlX2Qd1TA1FjdtzXROZlGQQ9o=;
        b=y5lNxPAFVZt5WqCBLomEWdrZGuqfzLD3/bg0wORd4thXlAAdLBJlnur+h+WN2cS4rv
         ytGeYT9vLXhW3mqrcmY487BW/Z1wG0j/FHV5t8tzxtCbgo3rQJGPf0l8/VuO1TzKh5bw
         gbNjP5Smv4au3vS9a+uZ+y82JRyG2oh0ZCuJobfv73CeyVXqJnaVaLBZj6D1wnx6v3cW
         5pANjxLWSQZ8QHtq4Fu4KQ396ZWCn4FrLLPBt+buUbwTCjb+4sgjrJqK5iBU7Ilo7MrT
         SITh173mE380kNVOkAoXVq8tVpb+o69Bg9HpXXLCIl2iqSGo29rCGPtJOJhtHifp1ErI
         fpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xpnvk+P6+J5KeBQ3RLjlX2Qd1TA1FjdtzXROZlGQQ9o=;
        b=Qcb8Vyf00WAicwdrF68NjguaJ1nRk+xJoIrCkaJyIOzk+l4HMHtFH69DpHl2BteBAr
         J2fFMlJ3p+wXDI8dT4kbOx8q3H073y5HcOVv9dEP0SsyA9uMuMBOQhoosgRkgh68zBcm
         FCw05xrlKj3kuMgnwLeKjIagdrXkzLrY5Vmqjgu/7WejW7weEEjDE0Yb4+hHCDSefnRU
         SVUiW9q3DTFQKZNVBn24+N26mvD3Fk0npVoLNa4MacPCYLwbiEgmp4j3QgzdnCK5kcCq
         CbY7TuwfCzQPRrdfG6Qi/thHh1aOUddUQxUrprJrbgtXLJZLwrCZqCWXQLBARUJpE3jt
         FKTg==
X-Gm-Message-State: AOAM532vi8xdA8OFY0BCxxpuMwb4OUQLgquaxjiawK+ZaIQac4gu/aSj
        aZWxP7aofDNidnc2j4yMTaI9LCtA+m5z
X-Google-Smtp-Source: ABdhPJyaim441LG4xUyR9rryoQGB3Dy2neQA8jvi6Dp3B/UdCe7rDmR0t43v74UUci84Ql8HKLxhrg==
X-Received: by 2002:a17:90a:fe0b:: with SMTP id ck11mr13375522pjb.15.1637910337401;
        Thu, 25 Nov 2021 23:05:37 -0800 (PST)
Received: from localhost.localdomain ([117.215.117.247])
        by smtp.gmail.com with ESMTPSA id d12sm4042104pgf.19.2021.11.25.23.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 23:05:37 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/6] ARM: dts: qcom: sdx55-fn980: Enable PCIe EP
Date:   Fri, 26 Nov 2021 12:35:18 +0530
Message-Id: <20211126070520.28979-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126070520.28979-1-manivannan.sadhasivam@linaro.org>
References: <20211126070520.28979-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PCIe Endpoint controller on the Telit FN980 TLB board based
on Qualcomm SDX55 platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/qcom-sdx55-telit-fn980-tlb.dts   | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
index e8b5327afbe7..01ac91738f34 100644
--- a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
@@ -243,6 +243,14 @@ &pcie0_phy {
 	vdda-pll-supply = <&vreg_l4e_bb_0p875>;
 };
 
+&pcie_ep {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_ep_clkreq_default &pcie_ep_perst_default
+		     &pcie_ep_wake_default>;
+};
+
 &qpic_bam {
 	status = "ok";
 };
@@ -267,6 +275,44 @@ &remoteproc_mpss {
 	memory-region = <&mpss_adsp_mem>;
 };
 
+&tlmm {
+	pcie_ep_clkreq_default: pcie_ep_clkreq_default {
+		mux {
+			pins = "gpio56";
+			function = "pcie_clkreq";
+		};
+		config {
+			pins = "gpio56";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	pcie_ep_perst_default: pcie_ep_perst_default {
+		mux {
+			pins = "gpio57";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio57";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+
+	pcie_ep_wake_default: pcie_ep_wake_default {
+		mux {
+			pins = "gpio53";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio53";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+};
+
 &usb_hsphy {
 	status = "okay";
 	vdda-pll-supply = <&vreg_l4e_bb_0p875>;
-- 
2.25.1

