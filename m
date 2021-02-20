Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610F832030E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 03:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBTCMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 21:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhBTCMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 21:12:25 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEC0C061794
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 18:11:07 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id s23so1986328pji.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 18:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/bcmgFG5Q/B+6/HjkjoWIy++Ai0witxQcUitgDw+g4=;
        b=eRMxvTRh3HWfGoRuMVVLNT1xvUOCKcAvZTqpYvGnv2gaTMGTWW7XKM8/Xx5WDISdR+
         XKRwLK7ymE++esbSiXOycOJqCyl/poIunZtOuF25vCKgpFbb2jKdxOrMMoIxirXs84Yy
         Zg/GrVxZk8MHhhndLmeBx5Nvc9pSNXdCCga9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/bcmgFG5Q/B+6/HjkjoWIy++Ai0witxQcUitgDw+g4=;
        b=nOInfJEy1WgH4bDbDSSTrFf/k1rgq9BW9982mYfk0tpH1+pF2nujJoraOO13HSsoET
         a3yTUwFSrcVgbVGp4F8C1Z1LfEbj5uhqMghxxpHHwgwIN98JJDPnKe2Xa0Ilm9v4diWI
         mQTt1JJAQ5uAT/XicO4f9kWF/qKTfhF+Qmd81F/V/Lxt466oQFW0koTTThFSiTXaALjB
         Z/3CwKm6UYv1wvh8W8VutZKvL3I5AzxQUploTzHeVn2BOHpRiiuY+DRQr6LkE4gHLP4H
         zOyL5dD9gjqb7kqF8/Z4fGqeyJhIlmakPPr5T1mbOwMs6y+J76M9SaKtsImFuQZepPRr
         mrWg==
X-Gm-Message-State: AOAM533OHJMRXMfgWnHnrFXF6KlL+YDzQXvKD9fEN4bjZlCOhu3JZRO9
        boDWIlhf5VXG2bOf0f2ubc9HCw==
X-Google-Smtp-Source: ABdhPJzP3ewmp+T7JsEUpOd4wjUq4O4buC6eZbE+P/amgOtYEdsAckKh6zEdRG95+GTHN8EfwMsXYg==
X-Received: by 2002:a17:90a:ab8b:: with SMTP id n11mr11634378pjq.109.1613787067582;
        Fri, 19 Feb 2021 18:11:07 -0800 (PST)
Received: from localhost ([2620:15c:202:1:bdfd:8eaf:bd48:f73e])
        by smtp.gmail.com with UTF8SMTPSA id ca19sm749988pjb.31.2021.02.19.18.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 18:11:07 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sc7180: Delete charger thermal zone and ADC channel for lazor <= rev3
Date:   Fri, 19 Feb 2021 18:10:59 -0800
Message-Id: <20210219181032.3.Ia4c1022191d09fe8c56a16486b77796b83ffcae4@changeid>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
In-Reply-To: <20210219181032.1.I23e12818c4a841ba9c37c60b3ba8cfeeb048285f@changeid>
References: <20210219181032.1.I23e12818c4a841ba9c37c60b3ba8cfeeb048285f@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lazor rev3 and older are stuffed with a 47k NTC as thermistor for
the charger temperature which currently isn't supported by the
PM6150 ADC driver. Delete the charger thermal zone and ADC channel
to avoid the use of bogus temperature values.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts | 9 +++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts | 9 +++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts | 9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
index 30e3e769d2b4..0974dbd424e1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
@@ -14,6 +14,15 @@ / {
 	compatible = "google,lazor-rev0", "qcom,sc7180";
 };
 
+/*
+ * rev <= 3 are stuffed with a 47k NTC as charger thermistor which is currently
+ * not supported by the PM6150 ADC driver. Delete the thermal zone and ADC
+ * channel to avoid the use of bogus temperature values.
+ */
+/delete-node/ &charger_thermal;
+/delete-node/ &pm6150_adc_charger_thm;
+/delete-node/ &pm6150_adc_tm_charger_thm;
+
 &pp3300_hub {
 	/* pp3300_l7c is used to power the USB hub */
 	/delete-property/regulator-always-on;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
index c2ef06367baf..0381ca85ae97 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
@@ -14,6 +14,15 @@ / {
 	compatible = "google,lazor-rev1", "google,lazor-rev2", "qcom,sc7180";
 };
 
+/*
+ * rev <= 3 are stuffed with a 47k NTC as charger thermistor which is currently
+ * not supported by the PM6150 ADC driver. Delete the thermal zone and ADC
+ * channel to avoid the use of bogus temperature values.
+ */
+/delete-node/ &charger_thermal;
+/delete-node/ &pm6150_adc_charger_thm;
+/delete-node/ &pm6150_adc_tm_charger_thm;
+
 &pp3300_hub {
 	/* pp3300_l7c is used to power the USB hub */
 	/delete-property/regulator-always-on;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
index 240c3e067fac..b9473bba8f4a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
@@ -13,3 +13,12 @@ / {
 	model = "Google Lazor (rev3)";
 	compatible = "google,lazor-rev3", "qcom,sc7180";
 };
+
+/*
+ * rev <= 3 are stuffed with a 47k NTC as charger thermistor which is currently
+ * not supported by the PM6150 ADC driver. Delete the thermal zone and ADC
+ * channel to avoid the use of bogus temperature values.
+ */
+/delete-node/ &charger_thermal;
+/delete-node/ &pm6150_adc_charger_thm;
+/delete-node/ &pm6150_adc_tm_charger_thm;
-- 
2.30.0.617.g56c4b15f3c-goog

