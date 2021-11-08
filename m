Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06286447AF6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 08:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbhKHHaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 02:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbhKHHaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 02:30:06 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D5CC061764
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 23:27:22 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v23so5516485pjr.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 23:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bqa39s+vxgVR+dxhrZtkvgAdK1DW/ZPp25VXvulqjaE=;
        b=QhFa2WeZX88Bs0WCf7fMhuD7QMmVgzU8otVrSy7Zgz1HaGsQRqOTXucXWIpvs4gsRT
         SN4D4YeiYcu/maV/BBTiUz5HKHNmZqWurD9lzouupzMQcht/m+aWI9YgXc9Case492Ts
         Q2PEbtPj1aNCgQso90RqjSRYrVL1xie3it4VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bqa39s+vxgVR+dxhrZtkvgAdK1DW/ZPp25VXvulqjaE=;
        b=0RmCT8L3O4XNxTkFgteVZHlAZ0lszKrsCm6T7GX5O/ZG07mqNWkQf0y0/B9C9nBxzH
         Aka2iZuILPUmePpCuYs7WLOp3O0nM6S15n9SsfPReBszr4bcpJiA6QFd4AnABmSIwfZi
         +pbq/ST/BEyZJJSlCqQ65RJHxie1ziDcbDOaxvihLRHGoUXnN5RPW0n7ol1K7z8Z5nBp
         PV6/FW+O1uWps/tZupy8LRFj3r+nMIyQLMg7gkY07Wv8d2tRPfax/zAgvktshcWRBYpQ
         E3zCv/iUjAwzzshd+1fc7+yPRu/E8gRarcCWOCJGletL8dgEeCIgGzRNHIwBOMObx2Zy
         tuYw==
X-Gm-Message-State: AOAM530bJouqJoN8fxMJw2hD15coXh84k0iKdPLYB7Jb+Qy9niPzqB8U
        /LhfLnzwSIJzuseTxpNIO89bKQ==
X-Google-Smtp-Source: ABdhPJw8fTIJIR0QspPBLwT2xjfJCUaQF6HsFhnrIs7lc4mG337MzXvoExoAoIEvLCsKriqpETCotQ==
X-Received: by 2002:a17:90b:4d92:: with SMTP id oj18mr49333764pjb.188.1636356441798;
        Sun, 07 Nov 2021 23:27:21 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5f03:6a9b:24e8:3a2e])
        by smtp.gmail.com with ESMTPSA id e8sm11684972pgn.46.2021.11.07.23.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 23:27:21 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] arm64: dts: mt8183: Add more fennel SKUs
Date:   Mon,  8 Nov 2021 15:27:07 +0800
Message-Id: <20211108072711.1628566-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
In-Reply-To: <20211108072711.1628566-1-hsinyi@chromium.org>
References: <20211108072711.1628566-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fennel sku7 and fennel14 sku2, which use different audio codec than
previous fennel/fennel14 boards.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  2 ++
 .../mt8183-kukui-jacuzzi-fennel-sku1.dts      |  1 +
 .../mt8183-kukui-jacuzzi-fennel-sku6.dts      |  1 +
 .../mt8183-kukui-jacuzzi-fennel-sku7.dts      | 33 +++++++++++++++++++
 .../mediatek/mt8183-kukui-jacuzzi-fennel.dtsi |  1 -
 .../mt8183-kukui-jacuzzi-fennel14-sku2.dts    | 17 ++++++++++
 .../mt8183-kukui-jacuzzi-fennel14.dts         |  1 +
 7 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 045927402269a9..9834bd659d1530 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -18,7 +18,9 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-cozmo.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-damu.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-fennel-sku1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-fennel-sku6.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-fennel-sku7.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-fennel14.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-fennel14-sku2.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-juniper-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kappa.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kenzo.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
index ef6257c9a2d2ff..dec11a4eb59e30 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "mt8183-kukui-jacuzzi-fennel.dtsi"
+#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
 
 / {
 	model = "Google fennel sku1 board";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
index 899c2e42385c27..37e6e58f63b7e3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "mt8183-kukui-jacuzzi-fennel.dtsi"
+#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
 
 / {
 	model = "Google fennel sku6 board";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
new file mode 100644
index 00000000000000..0e09604004d5e7
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi-fennel.dtsi"
+#include "mt8183-kukui-audio-ts3a227e-rt1015p.dtsi"
+
+/ {
+	model = "Google fennel sku7 board";
+	compatible = "google,fennel-sku7", "google,fennel", "mediatek,mt8183";
+};
+
+&touchscreen {
+	status = "okay";
+
+	compatible = "hid-over-i2c";
+	reg = <0x10>;
+	interrupt-parent = <&pio>;
+	interrupts = <155 IRQ_TYPE_LEVEL_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&touchscreen_pins>;
+
+	post-power-on-delay-ms = <10>;
+	hid-descr-addr = <0x0001>;
+};
+
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_FENNEL";
+};
+
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
index 577519a775c057..bbe6c338f465ee 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
@@ -5,7 +5,6 @@
 
 /dts-v1/;
 #include "mt8183-kukui-jacuzzi.dtsi"
-#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
 
 &mt6358codec {
 	mediatek,dmic-mode = <1>; /* one-wire */
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dts
new file mode 100644
index 00000000000000..3fc5a6181d7e66
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi-fennel.dtsi"
+#include "mt8183-kukui-audio-ts3a227e-rt1015p.dtsi"
+
+/ {
+	model = "Google fennel14 sku2 board";
+	compatible = "google,fennel-sku2", "google,fennel", "mediatek,mt8183";
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_FENNEL14";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts
index e8c41f6b4b0d4e..23ad0b91e9776f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "mt8183-kukui-jacuzzi-fennel.dtsi"
+#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
 
 / {
 	model = "Google fennel14 sku0 board";
-- 
2.34.0.rc0.344.g81b53c2807-goog

