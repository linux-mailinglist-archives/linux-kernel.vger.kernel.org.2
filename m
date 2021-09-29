Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F17C41BDAD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 05:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244099AbhI2DpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 23:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244115AbhI2DpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 23:45:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE8CC061767
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 20:43:17 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so830782pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 20:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DdGxFZl6atvUpTyvNvQjUqEOKV5hQQ0OgkqUqC3owd0=;
        b=Fi/DD7kyMatSKuFi+7rfk5bVggZQufMuuoIsIA8IvDVfpl08QajYjitc2Qtf5idFO8
         7nCBmYueDmtm9WkH+ADOeGVFUMOk5n+wHyHGs1ipqeRisjBxjEqVtgEwHIQEJ+HolRyO
         e1lJK6FKQ3EZumVRY4G/RB5fXMh1JqCXBOcLlciJFc16s84yYJThdi/aHgvau2p26nil
         m8m3hlEqmA0a82ayBI2UD9Hqx9+6vXP9AbFJ1WszGkvITPK4lE1h2TAQ5XM79hhuCsOx
         qEdLPfQL4DFwyPxtk91jhGCMLgK20ZYawCJcJl6cLlIkxFbSlWWJWOGilDqf+9t55SGD
         16NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DdGxFZl6atvUpTyvNvQjUqEOKV5hQQ0OgkqUqC3owd0=;
        b=DXeilw7jtVQxBH+nPUUh2PCq/JgfkZQCYoROK6ASsM/YtBaGE8/V8+oSloYtNmyM+Q
         2kAP3/XhC8eODNkVUJvK4kwgU0BVgL8ONsss35D63SfGj3/O8EL64Iv8L20PPp5EyRUd
         AcQf3gwrGRD3ZAc/BuZLk19Iz/rg5/b9lieSLpWzbl5xKAROjB4s58Bi5FQqEAJ5oG3p
         7pcxPAHyI+R+PJEwdU98uIhJglh5H+etCkzFIU3bBD1ah+lV0fWnmwXEfBoNWJVAgBUN
         Qe5qlYengDBPyTpGiJXScOCxn8Jn/T60eT2cGtoVCvwbxE2R6+kWJZXvlZgWXq/82W6a
         y4aQ==
X-Gm-Message-State: AOAM532bUe3h4VoEtaVvVv5iDx2cM1Mp4XIEQVany19kRhz1/BYb5dUh
        u/5yKOZfWU1nwQGSfPL5mIfFxA==
X-Google-Smtp-Source: ABdhPJxR6Q+dwvvAlulmgyy85HyD13UmRB9sM1jEj6BZ+uB9eLjhRF3eW7TOfSIPhRP//vWeWQVfGA==
X-Received: by 2002:a17:90b:4a44:: with SMTP id lb4mr3915805pjb.140.1632886997283;
        Tue, 28 Sep 2021 20:43:17 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id b7sm533032pfb.20.2021.09.28.20.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 20:43:16 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 05/10] arm64: dts: qcom: Drop max-microamp and vddp-ref-clk properties from QMP PHY
Date:   Wed, 29 Sep 2021 11:42:48 +0800
Message-Id: <20210929034253.24570-6-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210929034253.24570-1-shawn.guo@linaro.org>
References: <20210929034253.24570-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following properties are not supported and causing dtbs_check
warnings.

- vdda-phy-max-microamp
- vdda-pll-max-microamp
- vddp-ref-clk-max-microamp
- vddp-ref-clk-always-on

Drop them from QMP PHY nodes.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts              | 3 ---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi                 | 4 ----
 arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi      | 4 ----
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts                  | 2 --
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts                  | 2 --
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts                   | 2 --
 arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts | 2 --
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts                   | 2 --
 arch/arm64/boot/dts/qcom/sm8250-hdk.dts                   | 2 --
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts                   | 2 --
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts                   | 2 --
 arch/arm64/boot/dts/qcom/sm8350-mtp.dts                   | 2 --
 12 files changed, 29 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
index a57c60070cdc..567b33106556 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
@@ -395,9 +395,6 @@
 
 	vdda-phy-supply = <&vreg_l28a_0p925>;
 	vdda-pll-supply = <&vreg_l12a_1p8>;
-
-	vdda-phy-max-microamp = <18380>;
-	vdda-pll-max-microamp = <9440>;
 };
 
 &venus {
diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index a1d15eab8553..af67c641df4e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -371,10 +371,6 @@
 	vdda-phy-supply = <&vreg_l1a_0p875>;
 	vdda-pll-supply = <&vreg_l2a_1p2>;
 	vddp-ref-clk-supply = <&vreg_l26a_1p2>;
-	vdda-phy-max-microamp = <51400>;
-	vdda-pll-max-microamp = <14600>;
-	vddp-ref-clk-max-microamp = <100>;
-	vddp-ref-clk-always-on;
 };
 
 &usb3 {
diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
index 0f5c7828a901..654188027f79 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
@@ -480,10 +480,6 @@
 	vdda-phy-supply = <&vreg_l1a_0p875>;
 	vdda-pll-supply = <&vreg_l2a_1p2>;
 	vddp-ref-clk-supply = <&vreg_l26a_1p2>;
-	vdda-phy-max-microamp = <51400>;
-	vdda-pll-max-microamp = <14600>;
-	vddp-ref-clk-max-microamp = <100>;
-	vddp-ref-clk-always-on;
 };
 
 &usb3 {
diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 8ac96f8e79d4..100254489b87 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -1212,9 +1212,7 @@
 	status = "okay";
 
 	vdda-phy-supply = <&vreg_l5a_0p88>;
-	vdda-max-microamp = <89900>;
 	vdda-pll-supply = <&vreg_l9a_1p2>;
-	vdda-pll-max-microamp = <18800>;
 };
 
 &usb_1 {
diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index 5ae2ddc65f7e..6f05934b4ccc 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -328,9 +328,7 @@
 	status = "okay";
 
 	vdda-phy-supply = <&vreg_l8c_1p2>;
-	vdda-max-microamp = <87100>;
 	vdda-pll-supply = <&vreg_l5a_0p88>;
-	vdda-pll-max-microamp = <18300>;
 };
 
 &usb_1 {
diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
index 335aa0753fc0..37ddca0f0223 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
@@ -419,9 +419,7 @@
 	status = "okay";
 
 	vdda-phy-supply = <&vdda_ufs_2ln_core_1>;
-	vdda-max-microamp = <90200>;
 	vdda-pll-supply = <&vreg_l3c_1p2>;
-	vdda-pll-max-microamp = <19000>;
 };
 
 &usb_1_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
index 736da9af44e0..6802097f576f 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
@@ -507,9 +507,7 @@
 	status = "okay";
 
 	vdda-phy-supply = <&vdda_ufs_2ln_core_1>;
-	vdda-max-microamp = <90200>;
 	vdda-pll-supply = <&vreg_l3c_1p2>;
-	vdda-pll-max-microamp = <19000>;
 };
 
 &usb_1_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
index b484371a6044..46b5cf9a1192 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
@@ -416,9 +416,7 @@
 	status = "okay";
 
 	vdda-phy-supply = <&vdda_ufs_2ln_core_1>;
-	vdda-max-microamp = <90200>;
 	vdda-pll-supply = <&vreg_l3c_1p2>;
-	vdda-pll-max-microamp = <19000>;
 };
 
 &usb_1_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/sm8250-hdk.dts b/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
index 47742816ac2f..3b082472062b 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
@@ -409,9 +409,7 @@
 	status = "okay";
 
 	vdda-phy-supply = <&vreg_l5a_0p88>;
-	vdda-max-microamp = <89900>;
 	vdda-pll-supply = <&vreg_l9a_1p2>;
-	vdda-pll-max-microamp = <18800>;
 };
 
 &usb_1_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 062b944be91d..5ffbcdd387ba 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -647,9 +647,7 @@
 	status = "okay";
 
 	vdda-phy-supply = <&vreg_l5a_0p875>;
-	vdda-max-microamp = <90200>;
 	vdda-pll-supply = <&vreg_l9a_1p2>;
-	vdda-pll-max-microamp = <19000>;
 };
 
 &usb_1 {
diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 56093e260ddf..be062377c936 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -251,9 +251,7 @@
 	status = "okay";
 
 	vdda-phy-supply = <&vreg_l5b_0p88>;
-	vdda-max-microamp = <91600>;
 	vdda-pll-supply = <&vreg_l6b_1p2>;
-	vdda-pll-max-microamp = <19000>;
 };
 
 &usb_1 {
diff --git a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
index bd95009c1875..5a8a966c475c 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
@@ -318,9 +318,7 @@
 	status = "okay";
 
 	vdda-phy-supply = <&vreg_l5b_0p88>;
-	vdda-max-microamp = <91600>;
 	vdda-pll-supply = <&vreg_l6b_1p2>;
-	vdda-pll-max-microamp = <19000>;
 };
 
 &usb_1 {
-- 
2.17.1

