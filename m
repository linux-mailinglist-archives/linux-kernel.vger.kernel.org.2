Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5044057A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 00:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhJ2WaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 18:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhJ2WaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 18:30:21 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E215C0613B9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 15:27:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 127so10480902pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 15:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4+ZA8NEy3SNBtiPt0mgLmXVJxFi8cUQuAEoLvYAu/8=;
        b=fJdnclm/yO3BkGQ3spuBFUXgeWyOk7wFRQ1YJBdOf6IcWSE+hS9ygHo3Jq2tldkMC8
         fAQ46+Co9lDAddI4TzifnjEFd6Wb5Fi5xEcEvfQe8YTucaP5VZQcNSFrF0I9Fy697b/+
         HQSOZYofz+QBOhFRAVBEawdxyAgSxFgF9speU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4+ZA8NEy3SNBtiPt0mgLmXVJxFi8cUQuAEoLvYAu/8=;
        b=S7bOqkJ0eT4bU8qr9Dytuo4oPU+RNTeXSMlTS4NO/DsDJvAEYNR6i8i+2yp50ALstw
         BSByDMJ28VbK6lJDMZxBeMdWC4fd7Bh8B3IO8aEearjjvmP8ceJmZIzaGVrDI72s/39i
         XDexssh3efCr/B4S2mxywBEp641ZQSmrGRZC3KCKusYI/2FAZmUpgGCJ9+EwnFvjJah1
         mCDRaWJxlKHdgyj3cL38e7VOpTb2ogFsDjxX+RPjauE7QRtR76HbbhMSU/n47jgUAXxr
         Dufutjws1Mj80IDCKlP+1sWSXH9LN0QPRvUgDE+m2NqJX1hCOvTzdjZI4OgZltZ+FtKV
         bVjg==
X-Gm-Message-State: AOAM5318Iprg+ScfN/v8lcQxuozaEm8r9Jij9CtQ2pQxYJhF2ZSLKRVi
        rcJHhf6RQLDpaCDz8nU+7/265EUyLa6Hkg==
X-Google-Smtp-Source: ABdhPJwHWdiF3t9XLK6OBPJBwrM/4jrIy+y1c5BW+YgtzaIxZwKCsPAoXthdb941qGNN0diETM1J/w==
X-Received: by 2002:a63:7d01:: with SMTP id y1mr10261732pgc.343.1635546471265;
        Fri, 29 Oct 2021 15:27:51 -0700 (PDT)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:e956:ddc4:6e27:e270])
        by smtp.gmail.com with ESMTPSA id v14sm7756660pff.199.2021.10.29.15.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 15:27:51 -0700 (PDT)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     swboyd@chromium.org, dianders@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 3/4] arm64: dts: sc7180: Support Lazor/Limozeen rev9
Date:   Fri, 29 Oct 2021 15:27:42 -0700
Message-Id: <20211029152647.v3.3.Ie56f55924f5c7706fe3194e710bbef6fdb8b5bc6@changeid>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211029152647.v3.1.Ie17e51ad3eb91d72826ce651ca2786534a360210@changeid>
References: <20211029152647.v3.1.Ie17e51ad3eb91d72826ce651ca2786534a360210@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support Lazor/Limozeen rev9 board where Parade ps8640 is added as the
second source edp bridge.

To support different edp bridge chips in different board revisions,
now we move the #incldue line of the edp bridge dts fragment (e.g.
sc7180-trogdor-ti-sn65dsi86.dtsi) from "sc7180-trogdor-lazor.dtsi" to
per-board-rev dts files.

Since the edp bridge dts fragment overrides 'dsi0_out', which is
defined in "sc7180.dtsi", move the #incldue line of "sc7180.dtsi" from
"sc7180-trogdor-lazor.dtsi" to per-board-rev dts files too, before
the #include line of the edp bridge dts fragment.

Signed-off-by: Philip Chen <philipchen@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Retroactively edit the v2 change log slightly

(no changes since v2)

Changes in v2:
- Explain why "sc7180.dtsi" is moved out of "sc7180-trogdor-lazor.dtsi"
  in the commit message.
- In limozeen (nots) r5 dts, replace "google,rev5-sku5" with
  "google,lazor-rev5-sku5" and sort it
- In limozeen (nots) r9 dts, drop the support for "sku5".
- In limozeen r4 dts, remove the redundant "google,lazor-rev6-sku4" and
  add "google,lazor-rev7-sku4".
- Do not add panel compatible in -r9 dts files.
- Move the #include line of gpio.h from sc7180.dtsi to the bridge dts
  fragments, and factor out this change to patch 1/3.

 arch/arm64/boot/dts/qcom/Makefile             |  9 +++-
 .../sc7180-trogdor-lazor-limozeen-nots-r4.dts |  2 +-
 .../sc7180-trogdor-lazor-limozeen-nots-r5.dts | 31 +++++++++++++
 ...sc7180-trogdor-lazor-limozeen-nots-r9.dts} |  8 ++--
 .../qcom/sc7180-trogdor-lazor-limozeen-r4.dts | 46 +++++++++++++++++++
 ...s => sc7180-trogdor-lazor-limozeen-r9.dts} |  6 ++-
 .../boot/dts/qcom/sc7180-trogdor-lazor-r0.dts |  2 +
 .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts |  2 +
 .../dts/qcom/sc7180-trogdor-lazor-r3-kb.dts   |  9 +++-
 .../dts/qcom/sc7180-trogdor-lazor-r3-lte.dts  |  9 +++-
 .../boot/dts/qcom/sc7180-trogdor-lazor-r3.dts |  8 +++-
 .../dts/qcom/sc7180-trogdor-lazor-r9-kb.dts   | 22 +++++++++
 .../dts/qcom/sc7180-trogdor-lazor-r9-lte.dts  | 30 ++++++++++++
 .../boot/dts/qcom/sc7180-trogdor-lazor-r9.dts | 18 ++++++++
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  3 --
 15 files changed, 188 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dts
 rename arch/arm64/boot/dts/qcom/{sc7180-trogdor-lazor-limozeen-nots.dts => sc7180-trogdor-lazor-limozeen-nots-r9.dts} (60%)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dts
 rename arch/arm64/boot/dts/qcom/{sc7180-trogdor-lazor-limozeen.dts => sc7180-trogdor-lazor-limozeen-r9.dts} (82%)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 6b816eb33309..f637c4d3729f 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -64,9 +64,14 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r3-kb.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r3-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9-kb.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9-lte.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r4.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r9.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r4.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r5.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r9.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r2.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts
index 6ebde0828550..850776c5323d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts
@@ -5,7 +5,7 @@
  * Copyright 2020 Google LLC.
  */
 
-#include "sc7180-trogdor-lazor-limozeen-nots.dts"
+#include "sc7180-trogdor-lazor-limozeen-nots-r5.dts"
 
 / {
 	model = "Google Lazor Limozeen without Touchscreen (rev4)";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dts
new file mode 100644
index 000000000000..f360ff27226e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor Limozeen board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+/ {
+	model = "Google Lazor Limozeen without Touchscreen (rev5 - rev8)";
+	/* No sku5 post-rev5 */
+	compatible = "google,lazor-rev5-sku5", "google,lazor-rev5-sku6",
+		"google,lazor-rev6-sku6", "google,lazor-rev7-sku6",
+		"google,lazor-rev8-sku6", "qcom,sc7180";
+};
+
+/delete-node/&ap_ts;
+
+&panel {
+	compatible = "innolux,n116bca-ea1", "innolux,n116bge";
+};
+
+&sdhc_2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
similarity index 60%
rename from arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dts
rename to arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
index 0456c7e05d00..4e35aec6a1e5 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
@@ -2,17 +2,19 @@
 /*
  * Google Lazor Limozeen board device tree source
  *
- * Copyright 2020 Google LLC.
+ * Copyright 2021 Google LLC.
  */
 
 /dts-v1/;
 
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
 #include "sc7180-trogdor-lte-sku.dtsi"
 
 / {
-	model = "Google Lazor Limozeen without Touchscreen";
-	compatible = "google,lazor-sku6", "google,lazor-sku5", "qcom,sc7180";
+	model = "Google Lazor Limozeen without Touchscreen (rev9+)";
+	compatible = "google,lazor-sku6", "qcom,sc7180";
 };
 
 /delete-node/&ap_ts;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dts
new file mode 100644
index 000000000000..42b4bbcc76f4
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dts
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor Limozeen board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+/ {
+	model = "Google Lazor Limozeen (rev4 - rev8)";
+	compatible = "google,lazor-rev4-sku4", "google,lazor-rev5-sku4",
+		"google,lazor-rev6-sku4", "google,lazor-rev7-sku4",
+		"google,lazor-rev8-sku4", "qcom,sc7180";
+};
+
+/delete-node/&ap_ts;
+
+&ap_ts_pen_1v8 {
+	ap_ts: touchscreen@10 {
+		compatible = "elan,ekth3500";
+		reg = <0x10>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_l>, <&ts_reset_l>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+
+		vcc33-supply = <&pp3300_ts>;
+
+		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&panel {
+	compatible = "auo,b116xa01";
+};
+
+&sdhc_2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
similarity index 82%
rename from arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dts
rename to arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
index e6ad6dae4e60..dc47842bc662 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
@@ -2,16 +2,18 @@
 /*
  * Google Lazor Limozeen board device tree source
  *
- * Copyright 2020 Google LLC.
+ * Copyright 2021 Google LLC.
  */
 
 /dts-v1/;
 
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
 #include "sc7180-trogdor-lte-sku.dtsi"
 
 / {
-	model = "Google Lazor Limozeen";
+	model = "Google Lazor Limozeen (rev9+)";
 	compatible = "google,lazor-sku4", "qcom,sc7180";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
index 30e3e769d2b4..b142006478ea 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
@@ -7,6 +7,8 @@
 
 /dts-v1/;
 
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
index c2ef06367baf..59740799fa3a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
@@ -7,6 +7,8 @@
 
 /dts-v1/;
 
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts
index dcb41afdc82a..18ef9da71998 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts
@@ -7,12 +7,17 @@
 
 /dts-v1/;
 
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
 #include "sc7180-lite.dtsi"
 
 / {
-	model = "Google Lazor (rev3+) with KB Backlight";
-	compatible = "google,lazor-sku2", "qcom,sc7180";
+	model = "Google Lazor (rev3 - 8) with KB Backlight";
+	compatible = "google,lazor-rev3-sku2", "google,lazor-rev4-sku2",
+		"google,lazor-rev5-sku2", "google,lazor-rev6-sku2",
+		"google,lazor-rev7-sku2", "google,lazor-rev8-sku2",
+		"qcom,sc7180";
 };
 
 &keyboard_backlight {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
index be44900602d7..c5c9feff41b8 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
@@ -7,12 +7,17 @@
 
 /dts-v1/;
 
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
 #include "sc7180-trogdor-lte-sku.dtsi"
 
 / {
-	model = "Google Lazor (rev3+) with LTE";
-	compatible = "google,lazor-sku0", "qcom,sc7180";
+	model = "Google Lazor (rev3 - 8) with LTE";
+	compatible = "google,lazor-rev3-sku0", "google,lazor-rev4-sku0",
+		"google,lazor-rev5-sku0", "google,lazor-rev6-sku0",
+		"google,lazor-rev7-sku0", "google,lazor-rev8-sku0",
+		"qcom,sc7180";
 };
 
 &ap_sar_sensor {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
index b474df47cd70..7adcedbf080d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts
@@ -7,10 +7,14 @@
 
 /dts-v1/;
 
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 #include "sc7180-trogdor-lazor.dtsi"
 #include "sc7180-lite.dtsi"
 
 / {
-	model = "Google Lazor (rev3+)";
-	compatible = "google,lazor", "qcom,sc7180";
+	model = "Google Lazor (rev3 - 8)";
+	compatible = "google,lazor-rev3", "google,lazor-rev4",
+		"google,lazor-rev5", "google,lazor-rev6", "google,lazor-rev7",
+		"google,lazor-rev8", "qcom,sc7180";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
new file mode 100644
index 000000000000..7f5c015e1ecb
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor board device tree source
+ *
+ * Copyright 2020 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-lite.dtsi"
+
+/ {
+	model = "Google Lazor (rev9+) with KB Backlight";
+	compatible = "google,lazor-sku2", "qcom,sc7180";
+};
+
+&keyboard_backlight {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
new file mode 100644
index 000000000000..344b57c035d0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+/ {
+	model = "Google Lazor (rev9+) with LTE";
+	compatible = "google,lazor-sku0", "qcom,sc7180";
+};
+
+&ap_sar_sensor {
+	status = "okay";
+};
+
+&ap_sar_sensor_i2c {
+	status = "okay";
+};
+
+&keyboard_backlight {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts
new file mode 100644
index 000000000000..83f6a4eb5ae5
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-lite.dtsi"
+
+/ {
+	model = "Google Lazor (rev9+)";
+	compatible = "google,lazor", "qcom,sc7180";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index 8b79fbb75756..69666f92176a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -5,13 +5,10 @@
  * Copyright 2020 Google LLC.
  */
 
-#include "sc7180.dtsi"
-
 ap_ec_spi: &spi6 {};
 ap_h1_spi: &spi0 {};
 
 #include "sc7180-trogdor.dtsi"
-#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 
 &ap_sar_sensor {
 	semtech,cs0-ground;
-- 
2.33.1.1089.g2158813163f-goog

