Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44D332597E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhBYWR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbhBYWPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:15:36 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA607C061225
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:13:47 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k22so3977885pll.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=arESgX5Z3N3iCGewREWU1o57veUfBdWu4eDQbMBYmaE=;
        b=f2Eb/wdBJU97cr4GLNa72yl6kxGFeGYULoTkAitf08xsslOKMYQe5gJsE59tMFy4CJ
         f5lZlrJnpM5aOiAxV7T8hoN/rVPNw+iMHSC76UILgVGoMTeDz1nwkWumRsVCuNuNPu16
         iSZiAXrgnyfKANqttrgR6kD5RhN8Q82n4e2yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=arESgX5Z3N3iCGewREWU1o57veUfBdWu4eDQbMBYmaE=;
        b=mCU/MtB11lSOgGI83xW79Azh1dBL6PphAt/akoL019nMv9vdH5Qo+cnyJim2NecSps
         TFo3rZefw7PYJ+1RG3ennIY5p8EvNq3RDh4IhhiribFjvaCEwJoWgXsHkATdAOumiznp
         /2SSkRG+Qqltap3dg9gJBNi5Evm4YBP1Z1mOHGNUCTB5TU/w+1AbwO9lmayipl3aMnaC
         AD66VEnxDEnRNEOOBFzFanzO/vn2Ob7WXa9c+6lbwQk0BIUXXT+8x1fdgcWfJr7ZhvgJ
         gQkERJnsbg6xCoZmD1evZNGWZNH8zh/XtEOeRsep8X0KtHpIothD35e4SlXA8OdyCjOD
         tawg==
X-Gm-Message-State: AOAM533meKqKXFTw8t5SxruWasLW30s5fD8IC2MnHXZQ8CgR8PsF9gmK
        iXl8bXf2GosHz8EKezOZo2tJGg==
X-Google-Smtp-Source: ABdhPJxwduD+b8B7aNNHY3EIxZROzfMBEMQOBk6DwarGAGySDGt1Rpz5rRESwYqZKgBK6C4PaTGmSg==
X-Received: by 2002:a17:90a:bb95:: with SMTP id v21mr68378pjr.30.1614291227294;
        Thu, 25 Feb 2021 14:13:47 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:8414:45a5:94c4:d35d])
        by smtp.gmail.com with ESMTPSA id jt21sm6713301pjb.51.2021.02.25.14.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 14:13:46 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] arm64: dts: qcom: sc7180-trogdor: Remove fp control pins in prep for coachz
Date:   Thu, 25 Feb 2021 14:13:04 -0800
Message-Id: <20210225141022.7.Ifd7b86f826b18410eada75758a7bca1eebfa336d@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210225221310.1939599-1-dianders@chromium.org>
References: <20210225221310.1939599-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru M Stan <amstan@chromium.org>

Removed the pinctrl and pin{mux,conf} for the control pins because:
1. The only need for them is for userspace control via flash_fp_mcu
2. cros-ec doesn't know what to do with them, and even if it did,
   it would interfere with flash_fp_mcu at the most inopportune times

Since we're not using hogs, we rely on AP firmware to set all the
control pins correctly.

Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Craig Hesling <hesling@chromium.org>
Signed-off-by: Alexandru M Stan <amstan@chromium.org>
[dianders: adjusted since coachz isn't upstream yet]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 45 +-------------------
 1 file changed, 1 insertion(+), 44 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 69bf600e1c9f..12397e31bef6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -808,7 +808,7 @@ cros_ec_fp: ec@0 {
 		interrupt-parent = <&tlmm>;
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&fp_to_ap_irq_l>, <&fp_rst_l>, <&fpmcu_boot0>, <&fpmcu_sel>;
+		pinctrl-0 = <&fp_to_ap_irq_l>;
 		spi-max-frequency = <3000000>;
 	};
 };
@@ -1233,48 +1233,6 @@ pinconf {
 		};
 	};
 
-	fpmcu_boot0: fpmcu-boot0 {
-		pinmux {
-			pins = "gpio10";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio10";
-			bias-disable;
-			drive-strength = <2>;
-			output-low;
-		};
-	};
-
-	fpmcu_sel: fpmcu-sel {
-		pinmux {
-			pins = "gpio22";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio22";
-			bias-disable;
-			drive-strength = <2>;
-			output-high;
-		};
-	};
-
-	fp_rst_l: fp-rst-l {
-		pinmux {
-			pins = "gpio5";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio5";
-			bias-disable;
-			drive-strength = <2>;
-			output-high;
-		};
-	};
-
 	fp_to_ap_irq_l: fp-to-ap-irq-l {
 		pinmux {
 			pins = "gpio4";
@@ -1290,7 +1248,6 @@ pinconf {
 		};
 	};
 
-
 	h1_ap_int_odl: h1-ap-int-odl {
 		pinmux {
 			pins = "gpio42";
-- 
2.30.1.766.gb4fecdf3b7-goog

