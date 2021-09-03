Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1510C4005C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbhICTXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbhICTXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:23:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716D2C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 12:22:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d3-20020a17090ae28300b0019629c96f25so246973pjz.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hnF/e8xJrhWD/AMGCg/7SFP6mcesPXLBhPMYKZEsbD0=;
        b=ZCwFCmAKuzG3/8lMrM8j7z+BXXwcnXWvFGj+OyDjT6nP3X8EZHJdf22Ic2ME0ZQdoY
         tpV1i4j6yE3tOb8MhNm/bwdZOH+AGSh6h40Y4yRwZ4v7MUE/2z397obUKPMzmN0RNw2r
         eRjZDjSSKKB33XD+1KdBlWQCp1dYJbhRRvRdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hnF/e8xJrhWD/AMGCg/7SFP6mcesPXLBhPMYKZEsbD0=;
        b=CCgToxMsaSN6LyTqUydAEpJR2HUJ+uDJtFPCT35g//RXNmtPfwDpr49etdFF1YutM/
         J8aJAWDRH66+1dT7NTNX2/PzHjsP5NWdFSOj7YIToyZW++WY7Gh/i/nz4V+/vEVZ9jag
         kJ+eaoQ/gMkzmZxsZPgb7IVGpWmGv02eNV24AlecI23tR2uNB2hqP0OGvK+OxczqaG8O
         j/1ZVdBk2Q4ERh2z/PUC/fay9VyaTsepfdufSYteh2zzjtIZv0NKzqT1t+B8vWP8Mjme
         Vurz3tWs8/zSFUuGSnbIIIFdz2GIH0ZbMllLHRFq/ZgrJM9Yr1kN9sNzNbibW8hihPbD
         gJSQ==
X-Gm-Message-State: AOAM53269m/Nw/59PBL7gESHxK7Zqmbbd0WPoG1Bn8AXfk+xg7cI65j5
        wZox0vcu3Ejy16/mTOMQBIoW0A==
X-Google-Smtp-Source: ABdhPJwTznSK9vHgWZB8KCDbKVhij7pJCfTjoVIotQRhjy/j2avQBgQDFYT6cBkwCOe2b16hJ7lDuA==
X-Received: by 2002:a17:90b:188f:: with SMTP id mn15mr499401pjb.154.1630696943938;
        Fri, 03 Sep 2021 12:22:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:80b3:9f00:3170:fd8b])
        by smtp.gmail.com with UTF8SMTPSA id r13sm129013pgl.90.2021.09.03.12.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 12:22:23 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] arm64: dts: qcom: sc7180-trogdor: Delete ADC config for unused thermistors
Date:   Fri,  3 Sep 2021 12:22:19 -0700
Message-Id: <20210903122212.v2.1.I9777d0036ecbb749a4fb9ebb892f94c6e3a51772@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The charger thermistor on Lazor, CoachZ rev1 and Pompom rev1+2 is
either the wrong part or not stuffed at all, the same is true for
the skin temperature thermistor on CoachZ rev1. The corresponding
thermal zones are already disabled for these devices, in addition
delete the ADC nodes of the thermistors.

For Lazor and CoachZ rev1 also disable the PM6150 ADC and thermal
monitor since none of the ADC channels is used.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- also disable the ADC for Lazor and CoachZ rev1
- updated commit message

 .../boot/dts/qcom/sc7180-trogdor-coachz-r1.dts     | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi | 12 ++++++++++++
 .../boot/dts/qcom/sc7180-trogdor-pompom-r1.dts     |  8 ++++++++
 .../boot/dts/qcom/sc7180-trogdor-pompom-r2.dts     |  8 ++++++++
 4 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
index 21b516e0694a..8290d036044a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
@@ -23,6 +23,20 @@ &charger_thermal {
 	status = "disabled";
 };
 
+&pm6150_adc {
+	status = "disabled";
+
+	/delete-node/ skin-temp-thermistor@4e;
+	/delete-node/ charger-thermistor@4f;
+};
+
+&pm6150_adc_tm {
+	status = "disabled";
+
+	/delete-node/ charger-thermistor@0;
+	/delete-node/ skin-temp-thermistor@1;
+};
+
 /*
  * CoachZ rev1 is stuffed with a 47k NTC as thermistor for skin temperature,
  * which currently is not supported by the PM6150 ADC driver. Disable the
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index 00535aaa43c9..86c9e750995f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -54,6 +54,18 @@ &panel {
 	compatible = "boe,nv133fhm-n62";
 };
 
+&pm6150_adc {
+	status = "disabled";
+
+	/delete-node/ charger-thermistor@4f;
+};
+
+&pm6150_adc_tm {
+	status = "disabled";
+
+	/delete-node/ charger-thermistor@0;
+};
+
 &trackpad {
 	interrupts = <58 IRQ_TYPE_EDGE_FALLING>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
index e122a6b481ff..76a130bad60a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
@@ -26,6 +26,14 @@ &charger_thermal {
 	status = "disabled";
 };
 
+&pm6150_adc {
+	/delete-node/ charger-thermistor@4f;
+};
+
+&pm6150_adc_tm {
+	/delete-node/ charger-thermistor@0;
+};
+
 &pp3300_hub {
 	/* pp3300_l7c is used to power the USB hub */
 	/delete-property/regulator-always-on;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
index 4f32e6733f4c..88cf2246c18a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
@@ -22,3 +22,11 @@ / {
 &charger_thermal {
 	status = "disabled";
 };
+
+&pm6150_adc {
+	/delete-node/ charger-thermistor@4f;
+};
+
+&pm6150_adc_tm {
+	/delete-node/ charger-thermistor@0;
+};
-- 
2.33.0.153.gba50c8fa24-goog

