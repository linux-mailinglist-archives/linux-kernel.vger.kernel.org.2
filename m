Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEA0325973
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhBYWQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbhBYWO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:14:58 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0721BC0617A9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:13:42 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id l7so357055pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dZZPUphwhGg2xXbRQl4BmeZhTTdyb8m8Owkqn4y9NNs=;
        b=bVU2P6jyIFZz0DCWzpDkeRk2VWaldPbbj9l6PTLI4f5+EX767iO0KlmwesT59WsQw7
         j3rukQtgsRJth/tpHAwa4kjEPrL5Kce4oLasq1zFujWL74temdjkjt42WjejSHJsI/UN
         ftg1yi4e0lwb8LrI1hiCSV5JOeCl+QRk1WI3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dZZPUphwhGg2xXbRQl4BmeZhTTdyb8m8Owkqn4y9NNs=;
        b=B3XtatvE2q0WpjmXvaTc77zsPb48zl/jDjwaa5VRdSASRpgKjC0+KRqFXN8tt9+j5p
         SX9xspkFxdEFQ4HGz/6m1WZ/xGQ/YCs/FyyDxPC/WACb21jhgwsRG5B4JYbJctkum2pI
         2lHzn4vwUDf8HB/q5MFz5vNtPESzx2KBiQ/NHNcH9mNy4l2fNkAijfYmS4yFZGgpQRZg
         McMe2Mext3O5QaqhiYSq/Hqn6cJAWSNCD5c1fWG/paS2DKrnrhh7InDvdXm+yGdcTSaF
         im5DWV7a6ts0GDJrCweDh2Uu680PHGuoUbOkLtIUPVqrZI4CFYPVuYXSl55bI82NlANJ
         4S5Q==
X-Gm-Message-State: AOAM5300T7oxEo2gZ4PvIL9jvs68dxNmc2/QXEKm8oLUZqHbMH+C5gtR
        sxiQg8ttJpKFEXuf9d+WU6cI3A==
X-Google-Smtp-Source: ABdhPJy/Soin/DbVqgiOZAuiU4VbFtMpI+/Vu0PShjlpgOld4qXK3IZ43J2YhOOC+aXLBU11BtZkwA==
X-Received: by 2002:a63:4b0a:: with SMTP id y10mr56958pga.144.1614291221626;
        Thu, 25 Feb 2021 14:13:41 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:8414:45a5:94c4:d35d])
        by smtp.gmail.com with ESMTPSA id jt21sm6713301pjb.51.2021.02.25.14.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 14:13:41 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] arm64: dts: qcom: Prep sc7180-trogdor trackpad IRQ for new boards
Date:   Thu, 25 Feb 2021 14:13:00 -0800
Message-Id: <20210225141022.3.Iddf6dc8102aa4fbc3847936226fc7bf2e2cd315c@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210225221310.1939599-1-dianders@chromium.org>
References: <20210225221310.1939599-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trackpad interrupt got renamed and also moved to a new GPIO on
newer boards.  Let's do the move in the "trogdor.dtsi" file and then
undo it in the two old boards.

NOTE: since none of the new boards have device trees yet, this change
looks silly on its own but it will make sense after more boards are
supported.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi      | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts   | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi     | 14 ++++++++------
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index 89e5cd29ec09..11269522da50 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -58,8 +58,22 @@ ap_ts: touchscreen@10 {
 	};
 };
 
+&trackpad {
+	interrupts = <58 IRQ_TYPE_EDGE_FALLING>;
+};
+
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
 
+&trackpad_int_1v8_odl {
+	pinmux {
+		pins = "gpio58";
+	};
+
+	pinconf {
+		pins = "gpio58";
+	};
+};
+
 &ts_reset_l {
 	pinconf {
 		/* This pin is not connected on -rev0, pull up to park. */
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
index 2cb522d6962e..bd2c783e0f2f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
@@ -68,6 +68,22 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&trackpad {
+	interrupts = <58 IRQ_TYPE_EDGE_FALLING>;
+};
+
+/* PINCTRL - modifications to sc7180-trogdor.dtsi */
+
+&trackpad_int_1v8_odl {
+	pinmux {
+		pins = "gpio58";
+	};
+
+	pinconf {
+		pins = "gpio58";
+	};
+};
+
 /* PINCTRL - board-specific pinctrl */
 
 &tlmm {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 25ab6572f9cf..4ad27b5c34d1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -642,14 +642,14 @@ ap_tp_i2c: &i2c7 {
 	status = "okay";
 	clock-frequency = <400000>;
 
-	trackpad@15 {
+	trackpad: trackpad@15 {
 		compatible = "elan,ekth3000";
 		reg = <0x15>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&trackpad_int_1v8_odl>;
+		pinctrl-0 = <&tp_int_odl>;
 
 		interrupt-parent = <&tlmm>;
-		interrupts = <58 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
 
 		vcc-supply = <&pp3300_fp_tp>;
 
@@ -1410,14 +1410,16 @@ pinconf-rx {
 		};
 	};
 
-	trackpad_int_1v8_odl: trackpad-int-1v8-odl {
+	/* Named trackpad_int_1v8_odl on earlier revision schematics */
+	trackpad_int_1v8_odl:
+	tp_int_odl: tp-int-odl {
 		pinmux {
-			pins = "gpio58";
+			pins = "gpio0";
 			function = "gpio";
 		};
 
 		pinconf {
-			pins = "gpio58";
+			pins = "gpio0";
 
 			/* Has external pullup */
 			bias-disable;
-- 
2.30.1.766.gb4fecdf3b7-goog

