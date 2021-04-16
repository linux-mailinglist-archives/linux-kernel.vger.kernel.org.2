Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBFC3625E3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhDPQlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbhDPQle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:41:34 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D4FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:41:09 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c17so18708392pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZMOmO5LN0ke3Gr4hXLuwWjBNhQf+GYhYKHtL/Hu3is=;
        b=mJAWqjHklkMTtKytyF5E9inqF42WAwm+wP/AtT0DcSPSM0pAcbOOwfmaKJPSKyMLiM
         RT+qKRj3FedE5AbJxnvK6hDF9VdiFLJz1V+hM7H5TIhyYKI6fHiOOHrnjzIU+MBKa4nt
         d4CWCmGjeeydCjyB9iIHjHjtizeDxwnmTTCr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZMOmO5LN0ke3Gr4hXLuwWjBNhQf+GYhYKHtL/Hu3is=;
        b=ORFgUynjqirsRFEaKxenMjS704OlvGU+Kf2AKDAEmnzNM/cyEJWMAfBk7k+wvpHPmN
         nu8OoVHCvO+Z+AQOogAMVGg7bc0zFZobrnLwwuTMtqBs82GHTDzjxMCDTXWhgOc5l3qc
         K6JdlG5V/ZLGkHtuD1HYFt4B2vHDpGVfmiDr87kghjASW+ERLAkuohCYtQddx9Cl5wKF
         3njQlpX5SllTRd0MJwm2j0iRRnqqu/mil/6nGlaK3htOKmS6652k613SdZnCuyTgccio
         LNiLhjdnCNrY5nHHhUe5/psk/nqXenUZLuzGAy19Qd24d6KhGBNtqdCnlyYWU8qgHGUu
         nNqA==
X-Gm-Message-State: AOAM530WsGqiFgJNEIFPIBul1GQw2uQJGR24ZNt0skYpzDM/HgyUDjkv
        QR1umUPxUCUqIWrCRe8psbj/yg==
X-Google-Smtp-Source: ABdhPJwYdZttMSn0r6BcUdOMYSvSo48ucJ3fXtdCmNbN3RvQyiXm/NIATHP5LRRKrWaCGXB76VaRcg==
X-Received: by 2002:a62:1c88:0:b029:255:fbb5:f79d with SMTP id c130-20020a621c880000b0290255fbb5f79dmr8939219pfc.51.1618591269144;
        Fri, 16 Apr 2021 09:41:09 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ccd5:218f:365:b90f])
        by smtp.gmail.com with ESMTPSA id g14sm6187186pjh.28.2021.04.16.09.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 09:41:08 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 6/8] arm64: dts: mt8183: Add kukui-jacuzzi-willow board
Date:   Sat, 17 Apr 2021 00:40:53 +0800
Message-Id: <20210416164055.3223088-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416164055.3223088-1-hsinyi@chromium.org>
References: <20210416164055.3223088-1-hsinyi@chromium.org>
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
2.31.1.368.gbe11c130af-goog

