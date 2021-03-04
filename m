Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D7C32D942
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 19:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhCDSGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 13:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhCDSFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 13:05:42 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A32C061763
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 10:04:26 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id w18so19500895pfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 10:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6KaN9zbLzNpUQuVveUaLqGIfMdvHfJjzSPxZEmeLTs=;
        b=FvZ28nglfwSySTl0qfHNPTPX3XWeh7RvzwMdKpMVNglbCiuiu3yZQK6aUB+s31c9uP
         lEMdeiYHvcxN1iinwlWRgmie/nqKOxeiX7Gqe51m9czFv8mWFvH3aAivgNoF/ON/u/Nn
         Ahmgxxe3VHbZB08d+1v+zSqBC/BQfUlC5aS9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6KaN9zbLzNpUQuVveUaLqGIfMdvHfJjzSPxZEmeLTs=;
        b=kzSJHFUfOOXpDfwwg1E37IaQHiHM2IRAjBxIl1+rtbfEXipCrtcM9kqO9a5ZJtEI6d
         UudMZOT8ULePRSVHfhemX0NaUQ8A5tKSjxQuHco1C7qay2SYFwZkaes1Wxvat3Lt++TH
         z4L8Jg2B/PAeqrXs9GT/054urmYtSiH8MbqE7EVWwlI5PH1HA1OSSesLcIEuq2VSSQ2f
         5Q887d4Pnxprc5soAiYfqQIFBT/rs1X+CvT+1Wbz+CQBye4MRkX5hy0Nd4EkihvqsG8V
         rPpCT+65JTsbVV8ByaDp1y1G37nY+bTQtFoWTnPv2GGXUhLICH7fMnM/wXYfF8alodsq
         iDFA==
X-Gm-Message-State: AOAM531OTIirKxHQ0M3MCxSYL2II0x2jvVOPB4fTt/eBqiRkjadtPSs6
        tNPHw9iE/PIb9uKThNszAu9H3g==
X-Google-Smtp-Source: ABdhPJzbyIQnz9X8WG1yUzbD+tZZn9lIS9S0KdW44tucV9eijEWYAr84bAdQ3OJrUH6+L+kwv8KbXA==
X-Received: by 2002:a63:1d45:: with SMTP id d5mr4645310pgm.52.1614881066476;
        Thu, 04 Mar 2021 10:04:26 -0800 (PST)
Received: from localhost ([2620:15c:202:1:69fe:a9f8:ca53:af2b])
        by smtp.gmail.com with UTF8SMTPSA id d6sm71426pfq.109.2021.03.04.10.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 10:04:26 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/4] arm64: dts: qcom: sc7180: Add pompom rev3
Date:   Thu,  4 Mar 2021 10:04:13 -0800
Message-Id: <20210304100341.2.I7fef1a0e82bd2f3c1bc35501f8652e027aae4fcc@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210304180415.1531430-1-mka@chromium.org>
References: <20210304180415.1531430-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only kernel visible change with respect to rev2 is that pompom
rev3 changed the charger thermistor from a 47k to a 100k NTC to use
a thermistor which is supported by the PM6150 ADC driver.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 .../dts/qcom/sc7180-trogdor-pompom-r2-lte.dts |  4 +-
 .../dts/qcom/sc7180-trogdor-pompom-r2.dts     |  4 +-
 .../dts/qcom/sc7180-trogdor-pompom-r3-lte.dts | 14 ++++++
 .../dts/qcom/sc7180-trogdor-pompom-r3.dts     | 46 +++++++++++++++++++
 4 files changed, 64 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dts

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dts
index 791d496ad046..00e187c08eb9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dts
@@ -9,6 +9,6 @@
 #include "sc7180-trogdor-lte-sku.dtsi"
 
 / {
-	model = "Google Pompom (rev2+) with LTE";
-	compatible = "google,pompom-sku0", "qcom,sc7180";
+	model = "Google Pompom (rev2) with LTE";
+	compatible = "google,pompom-rev2-sku0", "qcom,sc7180";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
index 984d7337da78..2b2bd906321d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
@@ -10,8 +10,8 @@
 #include "sc7180-trogdor-pompom.dtsi"
 
 / {
-	model = "Google Pompom (rev2+)";
-	compatible = "google,pompom", "qcom,sc7180";
+	model = "Google Pompom (rev2)";
+	compatible = "google,pompom-rev2", "qcom,sc7180";
 };
 
 &keyboard_controller {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dts
new file mode 100644
index 000000000000..067cb75a011e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pompom board device tree source
+ *
+ * Copyright 2020 Google LLC.
+ */
+
+#include "sc7180-trogdor-pompom-r3.dts"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+/ {
+	model = "Google Pompom (rev3+) with LTE";
+	compatible = "google,pompom-sku0", "qcom,sc7180";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dts
new file mode 100644
index 000000000000..12d2d1e8e9e1
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dts
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pompom board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor-pompom.dtsi"
+
+/ {
+	model = "Google Pompom (rev3+)";
+	compatible = "google,pompom", "qcom,sc7180";
+};
+
+&keyboard_controller {
+	function-row-physmap = <
+		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
+		MATRIX_KEY(0x03, 0x02, 0)	/* T2 */
+		MATRIX_KEY(0x02, 0x02, 0)	/* T3 */
+		MATRIX_KEY(0x01, 0x02, 0)	/* T4 */
+		MATRIX_KEY(0x03, 0x04, 0)	/* T5 */
+		MATRIX_KEY(0x02, 0x04, 0)	/* T6 */
+		MATRIX_KEY(0x01, 0x04, 0)	/* T7 */
+		MATRIX_KEY(0x02, 0x09, 0)	/* T8 */
+		MATRIX_KEY(0x01, 0x09, 0)	/* T9 */
+		MATRIX_KEY(0x00, 0x04, 0)	/* T10 */
+	>;
+	linux,keymap = <
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
+		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
+		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
+		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
+
+		MATRIX_KEY(0x03, 0x09, KEY_SLEEP)	/* LOCK key */
+
+		CROS_STD_MAIN_KEYMAP
+	>;
+};
-- 
2.30.1.766.gb4fecdf3b7-goog

