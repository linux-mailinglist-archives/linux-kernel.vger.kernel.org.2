Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11D3358ABB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbhDHRF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhDHRFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:05:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9518FC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:05:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso1741207pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YVSTC6W3nYNbVnRN/o2kL063WCTg1tq+1lBFNgsIUgY=;
        b=GGcKuVYtePPs1oM61Be9wT9PB7rzBj7U94IBZoAi6I0/mLXLnvL/Ize15ocAsJhtct
         cExFyMb82+H/EDGsPPSZFRS6AM+/xbT0j0aleMEvZBEJpHb/sPk/Q2EHN+u4MxHDjBrG
         kaTRDa1uWHvM9yGj9Bb9DbAXctPwiKZBQrMP1W4yJqVXaIzG8CTDiJMSKInW2ppBaZ12
         bnUWK9zUDDLejBPTtz/Nfvvq+8L2LkWKkaXnQhg3tPYuc/dWw7tSemliIZPykK/o3Je7
         BMLgu68YK+a0wrxwfVM76KB2duFAFV/2m/bXD/g81BzcHOZJvz0R4GwxO6Ffe0U4Fwfm
         Pr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YVSTC6W3nYNbVnRN/o2kL063WCTg1tq+1lBFNgsIUgY=;
        b=pH3Rl8sc1Hsj3DaRacZihay68a0zFRBug45RnePSrJk2wp5LBT12u/2JR2Yig8IhJV
         eMkD/1Gw40uf3KhHCCE5HRfjMDDSwUmXfzjMM0dufaC1oAumSxl/BGJlf3JYbYmlSGM+
         xfq5cGSTYicsG3LJ3tcl1uDEq1NJcWZbcrugLqj+0kcLsiH+oTmKCpAoeCt6iej5wDjr
         nbbWzqqCCgbbkmsRjoK78ztdXMMF9GPlFxajev3Tko8GJgyK2kdGbJH3VC6vxDRNfHiG
         TF3MZqX3puFvYj+nsHZ2vyNX7x68KkYjLCVY/RvkgzavA/Z3FK1XYPNCElJthAbAH9Qx
         Ohng==
X-Gm-Message-State: AOAM532d9EWQiQyVobm1KNGidcIa1Htp2fF9tcN+/vjLoTtI7JDey3q+
        Rod87RLad8TMNxzqXzm4uNXCXICBz2oB
X-Google-Smtp-Source: ABdhPJxBlFT898/UUfLXASSQ1pSElEfPVEy4DCXYIrazy1SJ1wmv4D2Eono5ux/p4ieI6iE/yseP6g==
X-Received: by 2002:a17:902:b40e:b029:e9:51e:477f with SMTP id x14-20020a170902b40eb02900e9051e477fmr8580887plr.55.1617901512097;
        Thu, 08 Apr 2021 10:05:12 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id y194sm65183pfb.21.2021.04.08.10.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:05:11 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 01/15] ARM: dts: qcom: sdx55: Add support for A7 PLL clock
Date:   Thu,  8 Apr 2021 22:34:43 +0530
Message-Id: <20210408170457.91409-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
References: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SDX55 there is a separate A7 PLL which is used to provide high
frequency clock to the Cortex A7 CPU via a MUX.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index e4180bbc4655..41c90f598359 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -352,6 +352,14 @@ intc: interrupt-controller@17800000 {
 			      <0x17802000 0x1000>;
 		};
 
+		a7pll: clock@17808000 {
+			compatible = "qcom,sdx55-a7pll";
+			reg = <0x17808000 0x1000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "bi_tcxo";
+			#clock-cells = <0>;
+		};
+
 		watchdog@17817000 {
 			compatible = "qcom,apss-wdt-sdx55", "qcom,kpss-wdt";
 			reg = <0x17817000 0x1000>;
-- 
2.25.1

