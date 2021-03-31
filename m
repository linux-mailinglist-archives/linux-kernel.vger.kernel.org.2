Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205E935031E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 17:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbhCaPRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 11:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbhCaPQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 11:16:33 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE58AC061761
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 08:16:31 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n138so29706193lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SmxIAdsrO4AgDCAX3+XBJ4r3+d8Vawzl+TBPeB7hZmY=;
        b=lM50oytrwY6820uCVWhN3Xgux4/CS1zLxbDA7casJCBo2vs+VEInatulHQMjvMuf+i
         YjijfBihlfXwIhOJny0I9uHCncyo5qpdQCX25utcuExFeVw0uZFqj1KxpM9L+QLqCZfU
         elPHXtXWUq74JCEfhYxvq8UeKIgZAfLgvT1n9bjYcvytABWQtp6krsGIR+Mkl3TZH8Xc
         A0SDS+JNSuKZGFhiNjAU2AXap/kR29+nUZxRCdpa/FJsjShNNTfvbClV61zRAVL8FmA+
         YJmQIlS2tFTsqgIX2gSquKagwoePlTqiMEzF883YP+BxSsMHWSSriOICdAgYItqfdjOd
         fijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SmxIAdsrO4AgDCAX3+XBJ4r3+d8Vawzl+TBPeB7hZmY=;
        b=nYQLCuDv3xMa5YTp3MEvA2oBKHaCWa5MFC70VraIR5LDxIEq0K9od4vim959Uaq9co
         bn7uNhswMWoxJ0c0McSEOM+cqhRg88FfdoAMthgqSVEyTWqOr9Jgf2Pg8os4QLu7399m
         QbU5NIr3kWMZl7UomzlJRSCMT4jqACJeS8O2K8RVZe1ub/dVOFTfzDkwTqE820j7mTeM
         cF3xN8NTzhktj4IJDK/vntTtiVSk73Yv0WDjHDbyU5EM8iyIsJ2x1hcaBBX4ovvab3r6
         mmnRw3zbbWEMcmoI6TzIXVRGZK+EL6s3Dw5zREjupnGMc6Oo+sTOVoVo3JzK5tDFz3lL
         Tnvg==
X-Gm-Message-State: AOAM530BCE0sZqykq+O3gUAMVjR8WSBeDm+8/oi6KcgDAY7vmWTQ+2RL
        uLYGbKlTv6BjHpAaxVWbGrxTMQ==
X-Google-Smtp-Source: ABdhPJwZGyPkKAu6t4HVJG/Qoihc1J15mDpTKDAWp2WWqxkBF/Sk47OQTjaBY6lJfRvciQWsyFqV0Q==
X-Received: by 2002:ac2:5f0a:: with SMTP id 10mr2685067lfq.415.1617203790111;
        Wed, 31 Mar 2021 08:16:30 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t201sm266738lff.70.2021.03.31.08.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 08:16:29 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Manu Gautam <mgautam@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 6/7] arm64: dts: qcom: sm8250: switch usb1 qmp phy to USB3+DP mode
Date:   Wed, 31 Mar 2021 18:16:13 +0300
Message-Id: <20210331151614.3810197-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331151614.3810197-1-dmitry.baryshkov@linaro.org>
References: <20210331151614.3810197-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB1 QMP PHY is not just a USB3 PHY, but USB3+DP PHY. Change device tree
nodes accordingly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 947e1accae3a..0f79e6885004 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2097,12 +2097,11 @@ usb_2_hsphy: phy@88e4000 {
 		};
 
 		usb_1_qmpphy: phy@88e9000 {
-			compatible = "qcom,sm8250-qmp-usb3-phy";
+			compatible = "qcom,sm8250-qmp-usb3-dp-phy";
 			reg = <0 0x088e9000 0 0x200>,
-			      <0 0x088e8000 0 0x20>;
-			reg-names = "reg-base", "dp_com";
+			      <0 0x088e8000 0 0x40>,
+			      <0 0x088ea000 0 0x200>;
 			status = "disabled";
-			#clock-cells = <1>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -2116,7 +2115,7 @@ usb_1_qmpphy: phy@88e9000 {
 				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
 			reset-names = "phy", "common";
 
-			usb_1_ssphy: lanes@88e9200 {
+			usb_1_ssphy: usb3-phy@88e9200 {
 				reg = <0 0x088e9200 0 0x200>,
 				      <0 0x088e9400 0 0x200>,
 				      <0 0x088e9c00 0 0x400>,
@@ -2128,6 +2127,20 @@ usb_1_ssphy: lanes@88e9200 {
 				clock-names = "pipe0";
 				clock-output-names = "usb3_phy_pipe_clk_src";
 			};
+
+			dp_phy: dp-phy@88ea200 {
+				reg = <0 0x088ea200 0 0x200>,
+				      <0 0x088ea400 0 0x200>,
+				      <0 0x088eac00 0 0x400>,
+				      <0 0x088ea600 0 0x200>,
+				      <0 0x088ea800 0 0x200>,
+				      <0 0x088eaa00 0 0x100>;
+				#phy-cells = <0>;
+				#clock-cells = <1>;
+				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_phy_pipe_clk_src";
+			};
 		};
 
 		usb_2_qmpphy: phy@88eb000 {
-- 
2.30.2

