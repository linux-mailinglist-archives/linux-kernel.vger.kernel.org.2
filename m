Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9799F329FDF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574774AbhCBDu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241580AbhCAVk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:40:29 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E12C0611C1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:34:56 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 192so5406961pfv.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMu+7km0fh8qJ3Qo5bu6T6EQOvNUU/ih7I+5FOmie9w=;
        b=G0n8KFEskVWnyDsbOmc7CSmQhKmgOLFeFtgl/BUDqDPq5GaZuJ7QirexijQnoowtD2
         IpQwHM7n8pzE1AEM62LtP8h361rFPTO5/8dGsVpu/nWcYii+KUPvKCUvueGPghYr6P7+
         OXHCyErGLtLJcIR54m8OKNfTMvOgO46kuWlCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMu+7km0fh8qJ3Qo5bu6T6EQOvNUU/ih7I+5FOmie9w=;
        b=BfjXaVtqXfWeEmbA3i9q1a5/9xfZ3D/nhK67jWWzfiLCBxe+H+b388HRN3pbp0b/+6
         lf9dwljkALEMdwj3IxyzY01BbgUOPSRYvwWMT61RTCskHNM8l5ftZgdNXDdjhcXsRP1x
         L6foflYt1XVnTpJlbjagDb+/1WGl/t2ag+Y6+730XsYC+w+IUgL/wJSLccZbdt+CAUS0
         0ravAKlIlsURw+l+jH3Dnv4RX98g/E70HJKXH6srNU6AOhs96BHlTNk71gxUCOveIrMo
         I0YsYx1f2mXKg3E9dFMkrT+fQW5TKQ604QmAoXrCveF0noi3WP85mJk/8m/ZMOzpAjyC
         a10w==
X-Gm-Message-State: AOAM531bBmZYZq1NEE24pzah6fIcklhGKCaH+UBVrTL1RHww3+zB5Uo0
        KWblunDK8CWdtZMZXHFdRo5ZxA==
X-Google-Smtp-Source: ABdhPJyahgHOTbow7XaDUrBV+/ZiSgxnmR4vbzmqBCfwRlr87IEiObiYSaL+vfz80QTOytc9PTDLbw==
X-Received: by 2002:a62:1911:0:b029:1ed:b722:3b50 with SMTP id 17-20020a6219110000b02901edb7223b50mr426547pfz.70.1614634496131;
        Mon, 01 Mar 2021 13:34:56 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c086:5f6:85dd:98c8])
        by smtp.gmail.com with ESMTPSA id f13sm790366pjj.1.2021.03.01.13.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 13:34:55 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/13] arm64: dts: qcom: sc7180-trogdor: Remove fp control pins in prep for coachz
Date:   Mon,  1 Mar 2021 13:34:31 -0800
Message-Id: <20210301133318.v2.7.Ifd7b86f826b18410eada75758a7bca1eebfa336d@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301213437.4165775-1-dianders@chromium.org>
References: <20210301213437.4165775-1-dianders@chromium.org>
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
Reviewed-by; Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 45 +-------------------
 1 file changed, 1 insertion(+), 44 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 8ae9606351a6..c44be536b288 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -810,7 +810,7 @@ cros_ec_fp: ec@0 {
 		interrupt-parent = <&tlmm>;
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&fp_to_ap_irq_l>, <&fp_rst_l>, <&fpmcu_boot0>, <&fpmcu_sel>;
+		pinctrl-0 = <&fp_to_ap_irq_l>;
 		spi-max-frequency = <3000000>;
 	};
 };
@@ -1235,48 +1235,6 @@ pinconf {
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
@@ -1292,7 +1250,6 @@ pinconf {
 		};
 	};
 
-
 	h1_ap_int_odl: h1-ap-int-odl {
 		pinmux {
 			pins = "gpio42";
-- 
2.30.1.766.gb4fecdf3b7-goog

