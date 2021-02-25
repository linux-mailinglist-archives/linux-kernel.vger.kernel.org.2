Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36B53255A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhBYSgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhBYSe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:34:27 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C76C06178C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:33:47 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o22so5417968pjs.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dczDGcMxnMxi6eKOiEgYT3QlZ+pzkcLtp6AZEyea/lU=;
        b=n6WqeJClDVfgbWgb38K8dOPiRTxQHJFP9XSGiTr1lIRjQVXiyhLzl8ktnfNN4H7fsb
         hUUcckm20XGtujRs6NBTehoXmal+B0jRTXmRR5BEgnILcljDycnyhSHDfmnc7QalO5pS
         figwRjpsgZRreYWciXh6NJn7x2sXWrYST0sNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dczDGcMxnMxi6eKOiEgYT3QlZ+pzkcLtp6AZEyea/lU=;
        b=ULauNtsjPlEc+N42QSZjGBJv9WVs0MzAc5wnkRmhRhBXy5PEfL9e+CyYudqyHzHsjQ
         i/xIZmE8+68rKy+hRiXkkeZltmBz8b9UHcY4ixL/cEi+hNP17TBF6iQ0jKIximzXhD3n
         n2uawkKw66X1EwJL7m9hm5c21RXmsZFfLPJvv8uPU5MOtya6YRqllRj6UlJl06BB4Yaa
         go7hbde1QysMHWUaz7Bk/ofFJkYwSedu7APs/Au6qpH9NjFE5prh/TqS+UP0QwQjjNSC
         X5EstnhXSHZep5EcDuGw97mNOZe0j2r850B/4Qx6Rwb10QpNWqWuLEiKT9GWxDSgYJuS
         cNvw==
X-Gm-Message-State: AOAM53176WLMswJW5Agkn/ZIX5R1Sq68CF4yx44dPp9CNdZLS8Ife0V7
        clRYPVRE5ipI4+Vz6vlrMXSZ4Q==
X-Google-Smtp-Source: ABdhPJzYNocc/wKqfPr8wieUt75o2p/AvWQamQcL4C5DkYkXXXACbkT6PEqFe+UWSYXMwgWG9ZBiWw==
X-Received: by 2002:a17:90a:ba16:: with SMTP id s22mr4722059pjr.88.1614278027281;
        Thu, 25 Feb 2021 10:33:47 -0800 (PST)
Received: from localhost ([2620:15c:202:1:1d8:8d0c:f75e:edd8])
        by smtp.gmail.com with UTF8SMTPSA id q23sm6885815pfl.123.2021.02.25.10.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 10:33:46 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 2/4] arm64: dts: qcom: sc7180: Disable charger thermal for lazor
Date:   Thu, 25 Feb 2021 10:33:35 -0800
Message-Id: <20210225103330.v2.2.Ia4c1022191d09fe8c56a16486b77796b83ffcae4@changeid>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
In-Reply-To: <20210225103330.v2.1.I6a426324db3d98d6cfae8adf2598831bb30bba74@changeid>
References: <20210225103330.v2.1.I6a426324db3d98d6cfae8adf2598831bb30bba74@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lazor is stuffed with a 47k NTC as thermistor for the charger
temperature which currently isn't supported by the PM6150 ADC
driver. Disable the charger thermal zone to avoid the use of
bogus temperature values.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- disable the thermal zone instead of deleting the zone and ADC nodes
- updated subject and commit message

 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts | 9 +++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts | 9 +++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts | 9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
index 30e3e769d2b4..5c997cd90069 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
@@ -14,6 +14,15 @@ / {
 	compatible = "google,lazor-rev0", "qcom,sc7180";
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
 &pp3300_hub {
 	/* pp3300_l7c is used to power the USB hub */
 	/delete-property/regulator-always-on;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
index c2ef06367baf..d9fbcc7bc5bd 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
@@ -14,6 +14,15 @@ / {
 	compatible = "google,lazor-rev1", "google,lazor-rev2", "qcom,sc7180";
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
 &pp3300_hub {
 	/* pp3300_l7c is used to power the USB hub */
 	/delete-property/regulator-always-on;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
index 1b9d2f46359e..19e69adb9e04 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
@@ -13,3 +13,12 @@ / {
 	model = "Google Lazor (rev3+)";
 	compatible = "google,lazor", "qcom,sc7180";
 };
+
+/*
+ * Lazor is stuffed with a 47k NTC as charger thermistor which currently is
+ * not supported by the PM6150 ADC driver. Disable the charger thermal zone
+ * to avoid using bogus temperature values.
+ */
+&charger_thermal {
+	status = "disabled";
+};
-- 
2.30.0.617.g56c4b15f3c-goog

