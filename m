Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D40344C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhCVQrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhCVQql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:46:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE04C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:46:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so11364522pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9tXLejmbg/lBKLTRDRm1eVSjjj8v10t29RWZ/NArFmQ=;
        b=YiLkKnqBX8huivae3VnA2sNAL+Cjz9OmaFzNt0y+lU+OwGFmg8sqnGWlNBvgqv2TSD
         ptkZESS95n9SSuyXH1pzMHIt6dqfdDCGtZeDzHk+RrmPIp1MxRjTVI0Lj8l3ROBp0px3
         lywvzltzeOQ+wlGzrWDGpyDHAq+QkTqqX9ekk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9tXLejmbg/lBKLTRDRm1eVSjjj8v10t29RWZ/NArFmQ=;
        b=a+NmnqwaQzB14yWjkrTd9cR4M9RVopwJri+RhAefasuae92EWBRqkJ88szhusPUrQc
         M7d6JCu0D7b6vR3URPPwzhZeHtGYdaqSt74i6Ngi+2sypIwfX/WzYTFzkoJgmxXw5qrQ
         fNw4GYqDkoc2L2GfwANa4r37xke6aCC0o/lzq8y0ikWobDppE3xa3nkzwjgE39hn6MVL
         zuO3WsB0WQgfpqv3oUsnkz+wuBH99rvv+pKGXKsJhRMKMsTkCy/GiSttIZhTBzASBJLx
         U0Y9QreUd6rwcYPWxgtthi7jlfoR/YD1irDIYTE1R+RUN5x2k0LSStzgdLgvPaOzF+mI
         2/6w==
X-Gm-Message-State: AOAM531vpv3BF8Hs7xTVdnabz0cP+ywu893090TMV2u2PE7QQjORjTyB
        BhRDuC4pIDjMo5rtLx/8a/UzJQ==
X-Google-Smtp-Source: ABdhPJy8C0AwcQyI2vrhCGtjqKNxjqN80/fE4jQ0hIGC9orFEIIBRl3jl2AkYC3iqgy78MkjBV/sVA==
X-Received: by 2002:a17:90a:e60b:: with SMTP id j11mr13422pjy.42.1616431601248;
        Mon, 22 Mar 2021 09:46:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:90a9:b908:f93a:2f78])
        by smtp.gmail.com with UTF8SMTPSA id 6sm15327612pfv.179.2021.03.22.09.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 09:46:40 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 1/3] arm64: dts: qcom: sc7180: lazor: Simplify disabling of charger thermal zone
Date:   Mon, 22 Mar 2021 09:46:33 -0700
Message-Id: <20210322094628.v4.1.I6d587e7ae72a5a47253bb95dfdc3158f8cc8a157@changeid>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210322164635.273729-1-mka@chromium.org>
References: <20210322164635.273729-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f73558cc83d1 ("arm64: dts: qcom: sc7180: Disable charger
thermal zone for lazor") disables the charger thermal zone for
specific lazor revisions due to an unsupported thermistor type.
The initial idea was to disable the thermal zone for older
revisions and leave it enabled for newer ones that use a
supported thermistor. Finally the thermistor won't be changed
on newer revisions, hence the thermal zone should be disabled
for all lazor (and limozeen) revisions. Instead of disabling
it per revision do it once in the shared .dtsi for lazor.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- none

Changes in v3:
- fixed order of nodes in sc7180-trogdor-lazor.dtsi

Changes in v2:
- none

 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts | 9 ---------
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts | 9 ---------
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts | 9 ---------
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi   | 9 +++++++++
 4 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
index 5c997cd90069..30e3e769d2b4 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
@@ -14,15 +14,6 @@ / {
 	compatible = "google,lazor-rev0", "qcom,sc7180";
 };
 
-/*
- * Lazor is stuffed with a 47k NTC as charger thermistor which currently is
- * not supported by the PM6150 ADC driver. Disable the charger thermal zone
- * to avoid using bogus temperature values.
- */
-&charger_thermal {
-	status = "disabled";
-};
-
 &pp3300_hub {
 	/* pp3300_l7c is used to power the USB hub */
 	/delete-property/regulator-always-on;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
index d9fbcc7bc5bd..c2ef06367baf 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
@@ -14,15 +14,6 @@ / {
 	compatible = "google,lazor-rev1", "google,lazor-rev2", "qcom,sc7180";
 };
 
-/*
- * Lazor is stuffed with a 47k NTC as charger thermistor which currently is
- * not supported by the PM6150 ADC driver. Disable the charger thermal zone
- * to avoid using bogus temperature values.
- */
-&charger_thermal {
-	status = "disabled";
-};
-
 &pp3300_hub {
 	/* pp3300_l7c is used to power the USB hub */
 	/delete-property/regulator-always-on;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
index ea8c2ee09741..b474df47cd70 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
@@ -14,12 +14,3 @@ / {
 	model = "Google Lazor (rev3+)";
 	compatible = "google,lazor", "qcom,sc7180";
 };
-
-/*
- * Lazor is stuffed with a 47k NTC as charger thermistor which currently is
- * not supported by the PM6150 ADC driver. Disable the charger thermal zone
- * to avoid using bogus temperature values.
- */
-&charger_thermal {
-	status = "disabled";
-};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index 6b10b96173e8..00535aaa43c9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -21,6 +21,15 @@ &ap_sar_sensor {
 	semtech,avg-pos-strength = <64>;
 };
 
+/*
+ * Lazor is stuffed with a 47k NTC as charger thermistor which currently is
+ * not supported by the PM6150 ADC driver. Disable the charger thermal zone
+ * to avoid using bogus temperature values.
+ */
+&charger_thermal {
+	status = "disabled";
+};
+
 ap_ts_pen_1v8: &i2c4 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
2.31.0.rc2.261.g7f71774620-goog

