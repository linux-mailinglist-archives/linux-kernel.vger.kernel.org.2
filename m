Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E6C44057B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 00:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhJ2Wa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 18:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhJ2WaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 18:30:22 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D397C061714
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 15:27:53 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e65so11139656pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pBGj7qKKms3b2NXRBKaGnHpCJouTkoQqy6fKnEekhNY=;
        b=HnbdUP09jt/Ip+O+QEZkJAXPTGAdoEOmiuIo7tioz6ookERAs68KtEBMoC462xl/me
         kb2Og2bKOMc7h9F1zyB1a8NltGPJi3bAdgaMkQ42Ru3oQsjrYMNNW+f2L5m60GHj9UB3
         eMub9B2fIa6iBDm8GBsRqxLeCWQmMF7dyljWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pBGj7qKKms3b2NXRBKaGnHpCJouTkoQqy6fKnEekhNY=;
        b=B66PiKrY9Fhz9B/UI+jaD98qxTmGvsvWiXd8QVH0l49i+qrcn1gt4/AsaxODlsYlgm
         2OdzBfsBbGx+sa67WCDFg3mvVVCDhzNm/1LBbNIOdATnSLxzeQfUoCQfZoAzr23640T6
         NJA+RGxvlFLtlAe/gorE5LMvYzP8cYSBhPmpjs3J84R3lHnzq+dmYXy0BQVEmFhGhOFH
         ES8DJgoIFj+AV79cxADZo481Lx7zj/Q7EGTrL+xvP88enR+eGi2pVhMXchCXjwwIrxSO
         VDAe8j1YCyXAS7mjBrHhdDXyIazzk3KY+yiFMrS8IeN1YjBT5UqJrY74x+gwLT/fo9Cs
         R/AQ==
X-Gm-Message-State: AOAM532Wl9KWnNX6XCANFTnUwuoILtv77sKTpsxFWdWMKVCO/kNbv9IF
        fHbcts06wypqdAg8LhygYqWjtwz9WSbs6A==
X-Google-Smtp-Source: ABdhPJyhStJ5juboVFPzsjtTdtdTQzEsB1jPXhWgGnAadxRg2EvPj3HJ4quI2OMUP0sEyC29HswtDg==
X-Received: by 2002:a62:4e87:0:b0:47b:dbbf:c6f0 with SMTP id c129-20020a624e87000000b0047bdbbfc6f0mr13518472pfb.47.1635546472895;
        Fri, 29 Oct 2021 15:27:52 -0700 (PDT)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:e956:ddc4:6e27:e270])
        by smtp.gmail.com with ESMTPSA id v14sm7756660pff.199.2021.10.29.15.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 15:27:52 -0700 (PDT)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     swboyd@chromium.org, dianders@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: dts: sc7180: Support Homestar rev4
Date:   Fri, 29 Oct 2021 15:27:43 -0700
Message-Id: <20211029152647.v3.4.If7aaa8e36f1269acae5488035bd62ce543756bf8@changeid>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211029152647.v3.1.Ie17e51ad3eb91d72826ce651ca2786534a360210@changeid>
References: <20211029152647.v3.1.Ie17e51ad3eb91d72826ce651ca2786534a360210@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support Homestar rev4 board where Parade ps8640 is added as the
second source edp bridge.

Support different edp bridge chips in different board revisions,
now we move the #incldue line of the edp bridge dts fragment (e.g.
sc7180-trogdor-ti-sn65dsi86.dtsi) from "sc7180-trogdor-homestar.dtsi"
to per-board-rev dts files.

Since the edp bridge dts fragment overrides 'dsi0_out', which is
defined in "sc7180.dtsi", move the #incldue line of "sc7180.dtsi" from
"sc7180-trogdor-homestar.dtsi" to per-board-rev dts files too, before
the #include line of the edp bridge dts fragment.

Signed-off-by: Philip Chen <philipchen@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

(no changes since v2)

Changes in v2:
- Explain why "sc7180.dtsi" is moved out of "sc7180-trogdor-homestar.dtsi"
  in the commit message.

 arch/arm64/boot/dts/qcom/Makefile               |  1 +
 .../dts/qcom/sc7180-trogdor-homestar-r2.dts     |  2 ++
 .../dts/qcom/sc7180-trogdor-homestar-r3.dts     |  6 ++++--
 .../dts/qcom/sc7180-trogdor-homestar-r4.dts     | 17 +++++++++++++++++
 .../boot/dts/qcom/sc7180-trogdor-homestar.dtsi  |  3 ---
 5 files changed, 24 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index f637c4d3729f..ba99aba1d51a 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r3.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r4.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1-kb.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dts
index db6c2da67cea..70032983fb65 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dts
@@ -7,6 +7,8 @@
 
 /dts-v1/;
 
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 #include "sc7180-trogdor-homestar.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dts
index 3fd8aa5bb7a6..e92e2e9e48ed 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dts
@@ -7,9 +7,11 @@
 
 /dts-v1/;
 
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 #include "sc7180-trogdor-homestar.dtsi"
 
 / {
-	model = "Google Homestar (rev3+)";
-	compatible = "google,homestar", "qcom,sc7180";
+	model = "Google Homestar (rev3)";
+	compatible = "google,homestar-rev3", "qcom,sc7180";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dts
new file mode 100644
index 000000000000..fb27106bbb4a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Homestar board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-homestar.dtsi"
+
+/ {
+	model = "Google Homestar (rev4+)";
+	compatible = "google,homestar", "qcom,sc7180";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index 4ab890b2a1d4..f32369af1351 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -5,13 +5,10 @@
  * Copyright 2021 Google LLC.
  */
 
-#include "sc7180.dtsi"
-
 ap_ec_spi: &spi6 {};
 ap_h1_spi: &spi0 {};
 
 #include "sc7180-trogdor.dtsi"
-#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
 
 / {
 	/* BOARD-SPECIFIC TOP LEVEL NODES */
-- 
2.33.1.1089.g2158813163f-goog

