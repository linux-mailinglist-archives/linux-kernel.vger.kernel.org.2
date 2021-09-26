Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54EE41873C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 10:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhIZIBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 04:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhIZIBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 04:01:34 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9796C061575
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 00:59:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k26so8232327pfi.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 00:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KeFG2L210wqchABrBFQU+ZWbvaIgktVvqERsFworlRY=;
        b=NkTJxPQZpJKife6OlEHwOcrz6mv8N9JQFijpguQNx+e+g2xCfm/GGAWGLKxp14B2dm
         bZ+RpiV0bkQRHk5hyFyQoil6o3yHjKw2biEiLKIvgbYBfdwIHDhm5Iavhq7RhYAsvaoh
         tUcNpqUKojglCXYvdvkvYseaCtzLUYx2QavYi8+IpurVVDmBAzBykZBTI7Hf3gGQTCV/
         rPcHw9S0B6zYll+dyMSppWxBR4DDQEAVJRFPL+odCkRhyingl7QYjvP1CjvrbEzXWmXK
         N4FxAOpjzHJnzegA1cav3drzVv62WGNUgiPNxeAqowA05flYpJC/lG1RTPkfuNgxs4s4
         tyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KeFG2L210wqchABrBFQU+ZWbvaIgktVvqERsFworlRY=;
        b=5E/2A+zXcvTmF3CV10OHI8KMqPmAqnQwI5iximsQnIPVMYhmXvTtx/Osb0fGebX6y3
         aDYyJ9ZkJh+OdwBNQGsI92g9u4cxrbdifj2eeQD7qdtyKNJC7YCu/FP+drbJ84mbEvHd
         txiNekSLzTKyrO8HDtSSjAkKOa6zUgV4xCtSvLoB8BxDgznELqhis1x3KtWv9WThpJwq
         I5M+Lci20vugMdsgSgHBluhVBQGfbPqy9oF7hEGwHKR3pA6MZ9nlBrz14siLhLdxSVmj
         gwnJMMstw/8odtU0InOw61uTSCiW8usHMmokrM6C9Z4C17m0BgvNke0ZRKvDKMutQnjA
         IUhw==
X-Gm-Message-State: AOAM5337kXCkJEGBQgRkNqXd5WzIXlacYcD0cyPjMTDEPONk0RSxgUXT
        1yCOkMf7sUzoqBVP9JG6WlOatQ==
X-Google-Smtp-Source: ABdhPJzHA5DQeFhtbfU2GFZmjR1tDDk5FkWoY1bqKW7Y2oB1tr/7IfozFaGRKj+g33dRnBcdo0mrTw==
X-Received: by 2002:aa7:8434:0:b0:43c:222b:1d3d with SMTP id q20-20020aa78434000000b0043c222b1d3dmr17827249pfn.84.1632643198223;
        Sun, 26 Sep 2021 00:59:58 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id 4sm12426012pjb.21.2021.09.26.00.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 00:59:57 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Caleb Connolly <caleb@connolly.tech>,
        Amit Pundir <amit.pundir@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] arm64: dts: qcom: Drop vdd-supply from qusb2-phy devices
Date:   Sun, 26 Sep 2021 15:59:51 +0800
Message-Id: <20210926075951.28034-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at qcom,qusb2-phy.yaml bindings and qusb2_phy_vreg_names[] in
qusb2-phy driver, vdd-supply is not a supported/valid property.  Drop it
from qusb2-phy devices on various boards.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180-idp.dts               | 1 -
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi          | 1 -
 arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi | 1 -
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi            | 2 --
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts            | 2 --
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts               | 2 --
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi   | 1 -
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts  | 1 -
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts  | 2 --
 9 files changed, 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index acdb36f4479f..5ec47eaa4a90 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -429,7 +429,6 @@
 
 &usb_1_hsphy {
 	status = "okay";
-	vdd-supply = <&vreg_l4a_0p8>;
 	vdda-pll-supply = <&vreg_l11a_1p8>;
 	vdda-phy-dpdm-supply = <&vreg_l17a_3p0>;
 	qcom,imp-res-offset-value = <8>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 0f2b3c00e434..ed68f1233d66 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -928,7 +928,6 @@ ap_spi_fp: &spi10 {
 
 &usb_1_hsphy {
 	status = "okay";
-	vdd-supply = <&vdd_qusb_hs0_core>;
 	vdda-pll-supply = <&vdda_qusb_hs0_1p8>;
 	vdda-phy-dpdm-supply = <&vdda_qusb_hs0_3p1>;
 	qcom,imp-res-offset-value = <8>;
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index 11d0a8c1cf35..b05d5433a674 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -228,7 +228,6 @@
 &qusb2phy {
 	status = "okay";
 
-	vdd-supply = <&vreg_l1b_0p925>;
 	vdda-pll-supply = <&vreg_l10a_1p8>;
 	vdda-phy-dpdm-supply = <&vreg_l7b_3p125>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index dfd1b42c07fd..12fa059bef5a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -807,7 +807,6 @@ ap_ts_i2c: &i2c14 {
 &usb_1_hsphy {
 	status = "okay";
 
-	vdd-supply = <&vdda_usb1_ss_core>;
 	vdda-pll-supply = <&vdda_qusb_hs0_1p8>;
 	vdda-phy-dpdm-supply = <&vdda_qusb_hs0_3p1>;
 
@@ -829,7 +828,6 @@ ap_ts_i2c: &i2c14 {
 &usb_2_hsphy {
 	status = "okay";
 
-	vdd-supply = <&vdda_usb2_ss_core>;
 	vdda-pll-supply = <&vdda_qusb_hs0_1p8>;
 	vdda-phy-dpdm-supply = <&vdda_qusb_hs0_3p1>;
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 2d5533dd4ec2..894be3b6aea5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -940,7 +940,6 @@
 &usb_1_hsphy {
 	status = "okay";
 
-	vdd-supply = <&vreg_l1a_0p875>;
 	vdda-pll-supply = <&vreg_l12a_1p8>;
 	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
 
@@ -968,7 +967,6 @@
 &usb_2_hsphy {
 	status = "okay";
 
-	vdd-supply = <&vreg_l1a_0p875>;
 	vdda-pll-supply = <&vreg_l12a_1p8>;
 	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 52dd7a858231..08485eb5963a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -517,7 +517,6 @@
 &usb_1_hsphy {
 	status = "okay";
 
-	vdd-supply = <&vdda_usb1_ss_core>;
 	vdda-pll-supply = <&vdda_qusb_hs0_1p8>;
 	vdda-phy-dpdm-supply = <&vdda_qusb_hs0_3p1>;
 
@@ -551,7 +550,6 @@
 &usb_2_hsphy {
 	status = "okay";
 
-	vdd-supply = <&vdda_usb2_ss_core>;
 	vdda-pll-supply = <&vdda_qusb_hs0_1p8>;
 	vdda-phy-dpdm-supply = <&vdda_qusb_hs0_3p1>;
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index d4355522374a..911105d7603d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -580,7 +580,6 @@
 &usb_1_hsphy {
 	status = "okay";
 
-	vdd-supply = <&vdda_usb1_ss_core>;
 	vdda-pll-supply = <&vdda_qusb_hs0_1p8>;
 	vdda-phy-dpdm-supply = <&vdda_qusb_hs0_3p1>;
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index c60c8c640e17..9dc173c1f0be 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -496,7 +496,6 @@
 &usb_1_hsphy {
 	status = "okay";
 
-	vdd-supply = <&vreg_l1a_0p875>;
 	vdda-pll-supply = <&vreg_l12a_1p8>;
 	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
 
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 385e5029437d..e330721cd6cd 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -646,7 +646,6 @@
 &usb_1_hsphy {
 	status = "okay";
 
-	vdd-supply = <&vdda_usb1_ss_core>;
 	vdda-pll-supply = <&vdda_qusb_hs0_1p8>;
 	vdda-phy-dpdm-supply = <&vdda_qusb_hs0_3p1>;
 
@@ -674,7 +673,6 @@
 &usb_2_hsphy {
 	status = "okay";
 
-	vdd-supply = <&vdda_usb2_ss_core>;
 	vdda-pll-supply = <&vdda_qusb_hs0_1p8>;
 	vdda-phy-dpdm-supply = <&vdda_qusb_hs0_3p1>;
 
-- 
2.17.1

