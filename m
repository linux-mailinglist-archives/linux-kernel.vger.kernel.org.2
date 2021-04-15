Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78763605EC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhDOJgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbhDOJf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:35:57 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E355C061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:35:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w6so1152571pfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+86LqT5oinC3IBYbJbqOFlu8RNdurbYHgH1kxS9lr4=;
        b=QZ3xUzhLie38b8o4JWSAhQSC86r1et0WBeoUGAS6KhLP+G+/iFfzuB0sEiYsszBaju
         9EBjt8/JNrQc9OmH87qXGFeK7uTeztVOF4wNZjnCGi/V89k12D1EvsUS+4m4Dw6h2pPX
         Xad7JZV7ayNV9fOXwjmY3Fx4N6Hwny4zUObJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+86LqT5oinC3IBYbJbqOFlu8RNdurbYHgH1kxS9lr4=;
        b=jJ3VNN4J24puB08G5HDyDrnF1r2EH6zjsx2L4Y83ZOsKX4GjdUGgbIV1eiN9Gk5PnN
         wzi7nzuScjwPRChsZnNLRTY+nf0Ug0waNK58G1J6ZbZs1GJZ4/AD7W8LPD9uI43XEvVQ
         WU2DOqeuUYLYYEDlVCi/z4RVD79C3QU1F+CQ+P1kaK+FP18q/EPazKahtL0SF66wR1b/
         IjeldlskfxSOY80V6VuVM4QbAsw06cjx+JlKDD60NZOjM/1zsExz//q/EJV3nvuwwPZ5
         lKAuhQ61OTmYan/PHmxnvsl0klErTAM7b12F9dbjyNR6BM4JH97l3fPrTu7G0BR0dtAu
         rN9g==
X-Gm-Message-State: AOAM5319++w792qd83z6fuqkpxArekVzVUL2t0S1PbWT0MDOWDb2kF1Z
        RYKUM7WZ2eQHC5qsfktNtVkjhQ==
X-Google-Smtp-Source: ABdhPJxGucH3tKSvFEUCJSZK97KpyCmwuD/W5M5byPGAZynzdj2CR1IVsUuwpV7W+dyB5Kj8ESzTKA==
X-Received: by 2002:aa7:800a:0:b029:250:c8c5:64b3 with SMTP id j10-20020aa7800a0000b0290250c8c564b3mr2349531pfi.23.1618479334008;
        Thu, 15 Apr 2021 02:35:34 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:6432:a6cb:91d2:5e32])
        by smtp.gmail.com with ESMTPSA id a13sm1849502pgm.43.2021.04.15.02.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:35:33 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 6/8] arm64: dts: mt8183: Add kukui-jacuzzi-willow board
Date:   Thu, 15 Apr 2021 17:35:17 +0800
Message-Id: <20210415093519.1920877-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210415093519.1920877-1-hsinyi@chromium.org>
References: <20210415093519.1920877-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willow is known as Acer Chromebook 311 (C722/C722T)

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  2 ++
 .../mt8183-kukui-jacuzzi-willow-sku0.dts      | 13 +++++++++
 .../mt8183-kukui-jacuzzi-willow-sku1.dts      | 12 ++++++++
 .../mediatek/mt8183-kukui-jacuzzi-willow.dtsi | 28 +++++++++++++++++++
 4 files changed, 55 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index df70674949ce..5f43bbc2ea72 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -16,6 +16,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-damu.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-juniper-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kappa.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku0.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku272.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
new file mode 100644
index 000000000000..281265f082db
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi-willow.dtsi"
+
+/ {
+	model = "Google willow board sku0";
+	compatible = "google,willow-sku0", "google,willow", "mediatek,mt8183";
+};
+
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
new file mode 100644
index 000000000000..22e56bdc1ee3
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi-willow.dtsi"
+
+/ {
+	model = "Google willow board sku1";
+	compatible = "google,willow-sku1", "google,willow", "mediatek,mt8183";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
new file mode 100644
index 000000000000..3204c1abc4ee
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi.dtsi"
+
+&i2c2 {
+	clock-stretch-ns = <9500>;
+
+	trackpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+		hid-descr-addr = <0x20>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pins>;
+
+		interrupts-extended = <&pio 7 IRQ_TYPE_LEVEL_LOW>;
+
+		wakeup-source;
+	};
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_JUNIPER";
+};
-- 
2.31.1.295.g9ea45b61b8-goog

