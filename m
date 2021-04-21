Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BB1366798
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbhDUJHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbhDUJGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:06:52 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC63C06138E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c17so28151772pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hAjIGxekuyAA7cwweyyVFB1n6+uBzXOB8jhxw225zw8=;
        b=GZyk77PZAYerJMI9C7HUNI8XqR3ZaN4WDgZIO9bgwTRKJSo1yEOoMT6N9Fqr1kxMh+
         ZABhOMRYXruV6MBiQPuwt1vRsV6ZvS9QuKLV23yUG/hTBplsHUl23vEL0wrfrcaB+/RI
         csOVmdILhNQr2rb+P4HQ/rwYZDqo2dhy/TM28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hAjIGxekuyAA7cwweyyVFB1n6+uBzXOB8jhxw225zw8=;
        b=k9GH35CGlHaQaMeVfhhUxA10tFfx82ddYPyHNPQQC0A+9RuQ+As+Eq5FZq5AKL7epr
         FA0Hl7syiYlvZ0mJ1uks4x1M9I3yKr7bBIVbN+7WJRUTfVP8T4a26WSYIbxkLAlqFK8Y
         SFtVSSI7bHKTlmC68rGBlsv31xsCE+u5I40Y/EBrx1ReLE8/eafPZtYoTMvYwy/9Zdiv
         oMIFxDX7531LNd8rXl0iHPQiwEQtrSdHyfwe6eZi5uaflPZ2wnK9Ni2xokK/bmLk45rd
         RYJKoC/szZuC7yHnjbLv3NZcPkI5ZHMq3v7by40X7FIvwuRwfqKY7vPIjy+42uGprZe0
         YswQ==
X-Gm-Message-State: AOAM530AXBh/twZCgogvH1VH3MtlnKJt5+EwwI2nvWftX2oapvoAE2Xe
        d8sT0vMVVcvhr+DefFomYt3XGg==
X-Google-Smtp-Source: ABdhPJz3473fVZTsBnKmOW4FOjUqYl8PKnmrIzEG9KRa91PZwY6PVdaFgMDg+lti3LhmrG8DWeqrjA==
X-Received: by 2002:a17:90b:50f:: with SMTP id r15mr10028613pjz.39.1618995979076;
        Wed, 21 Apr 2021 02:06:19 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:60c1:887e:ac53:9b5c])
        by smtp.gmail.com with ESMTPSA id jx20sm1495889pjb.41.2021.04.21.02.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 02:06:18 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 07/10] arm64: dts: mt8183: Add kukui-jacuzzi-willow board
Date:   Wed, 21 Apr 2021 17:05:58 +0800
Message-Id: <20210421090601.730744-8-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210421090601.730744-1-hsinyi@chromium.org>
References: <20210421090601.730744-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willow is known as Acer Chromebook 311 (C722/C722T)

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  2 ++
 .../mt8183-kukui-jacuzzi-willow-sku0.dts      | 13 ++++++++++
 .../mt8183-kukui-jacuzzi-willow-sku1.dts      | 12 +++++++++
 .../mediatek/mt8183-kukui-jacuzzi-willow.dtsi | 26 +++++++++++++++++++
 4 files changed, 53 insertions(+)
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
index 000000000000..76d33540166f
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi.dtsi"
+
+&i2c2 {
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
2.31.1.498.g6c1eba8ee3d-goog

