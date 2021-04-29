Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E49C36F1B9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbhD2VQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbhD2VQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:16:06 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5DCC06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:15:18 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id z20-20020a0568301294b02902a52ecbaf18so10302295otp.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tsKgUNXVkGSV16m25rstq3CPA/gSdKXqhwk9cYckag4=;
        b=XTZkSmSldMj2DthYQn68iIY0GQk/RayHkBNO8nBqBkHe7X1YKbV2ojbkU7S/tS7PB8
         oKn6Sa0re/qA3YkVmWAHsYGK6zmTU40L2PXEeWcWlmbzUmJxMc7GmJ7Uhwk7R+EbzbGR
         5RDaf4uVeSRoS76x2p7Fq/gij5ar4dX/VfA9ECmUHMApmYOZWX6UPMQY0shRFpyQJHSO
         Az4sulYgg2ZGXOKfmoAVTITn1Ls6SI9qXsABB1nERrIlGqaVsX39KhUIWpehsKDk0OMh
         95mxG4jEbg6sESUYl1bcPFB6NegMEBmm2qrNH2KI/cmwsryZ+kE/EfOivfzX7sJ0wEIJ
         zhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tsKgUNXVkGSV16m25rstq3CPA/gSdKXqhwk9cYckag4=;
        b=cNkUp5aBhnJiRKn1Y7EqhA/HlAhW/jDctbDnWXFDfy4LK5gneq7bB9AHUvgIOg23EG
         Zq6c6zFPQmDcPJaQNi1CEuG6XnLeN4QB9v3tFuG+ilSDZEpgG2lEsk0fpBzIRYepryPN
         Lix0bw84eTKH2k/zhoHBgp7p1BrJv+zujqVvAIoYCGv9Yn41ng5V8tw7k/pBOIodBE9l
         pInR54R3zGQXCOi3ZWK+DycicISJ2tmia48pkUri5bla+PVvst/XDT4EetWMgooqxko7
         7Pr3WhnMjkVWr554fZ5Gw23i4fp6Vh9xK/frOKx77YIfs2NtpRv/qWvlDKiaquVCYwYS
         2Rhg==
X-Gm-Message-State: AOAM533CrqHhpGP059K+r2UXun9M7JE7UuThqplCw8viyHPvfJsbTeoE
        Ymy5CtiBVIm9OhBlmdyMd4vfVg==
X-Google-Smtp-Source: ABdhPJwC5O52GGITTLwu57jDvhGGAEtG+5OGIBKu2XvxDTMLZyDOpHsGbZ9LMUdI5frDzrD8cMjprQ==
X-Received: by 2002:a9d:4e05:: with SMTP id p5mr1087643otf.264.1619730918199;
        Thu, 29 Apr 2021 14:15:18 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y67sm242707otb.1.2021.04.29.14.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 14:15:17 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: [PATCH v7 3/6] arm64: dts: qcom: Add LPG to pm8916, pm8994, pmi8994 and pmi8998
Date:   Thu, 29 Apr 2021 14:15:14 -0700
Message-Id: <20210429211517.312792-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210429211517.312792-1-bjorn.andersson@linaro.org>
References: <20210429211517.312792-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PWM/LPG nodes to the PMICs currently supported by the binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v6:
- Extended patch to cover all the supported (arm64) PMICs

 arch/arm64/boot/dts/qcom/pm8916.dtsi  |  8 ++++++++
 arch/arm64/boot/dts/qcom/pm8994.dtsi  | 10 ++++++++++
 arch/arm64/boot/dts/qcom/pmi8994.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 10 ++++++++++
 4 files changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index f931cb0de231..db973e4ef9d3 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -119,6 +119,14 @@ pm8916_1: pmic@1 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8916_pwm: pwm {
+			compatible = "qcom,pm8916-pwm";
+
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
+
 		pm8916_vib: vibrator@c000 {
 			compatible = "qcom,pm8916-vib";
 			reg = <0xc000>;
diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/qcom/pm8994.dtsi
index c3876c82c874..9386cf12867d 100644
--- a/arch/arm64/boot/dts/qcom/pm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
@@ -134,6 +134,16 @@ pmic@1 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8994_lpg: lpg {
+			compatible = "qcom,pm8994-lpg";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
+
 		pm8994_spmi_regulators: regulators {
 			compatible = "qcom,pm8994-regulators";
 		};
diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
index e5ed28ab9b2d..b118e87ef59e 100644
--- a/arch/arm64/boot/dts/qcom/pmi8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
@@ -27,6 +27,16 @@ pmic@3 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmi8994_lpg: lpg {
+			compatible = "qcom,pmi8994-lpg";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
+
 		pmi8994_spmi_regulators: regulators {
 			compatible = "qcom,pmi8994-regulators";
 			#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index d230c510d4b7..a600c25d6667 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -41,5 +41,15 @@ lab: lab {
 				interrupt-names = "sc-err", "ocp";
 			};
 		};
+
+		pmi8998_lpg: lpg {
+			compatible = "qcom,pmi8998-lpg";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
 	};
 };
-- 
2.29.2

