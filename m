Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAC744A652
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 06:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241814AbhKIFga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 00:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240454AbhKIFg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 00:36:26 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A319C061766
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 21:33:40 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y5so8118351pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 21:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MIJkQVkt4xqve0BOXtxCBd9FeU0z9MmxfabsOKsl+NQ=;
        b=O7ua08acPuCdRgkIOO3pKqCQTGpOBbNWo7jk9qIzOmDT3PvJ7pRobO7xYF5+zGUc/W
         nayRDKzHDvH5eC+DpAEdOwRYRCs8251f7I8I96nTiuBJgWOeJ4vA8SXYx2YmVn//kH7a
         iL9Jx2JERdWWKq2kZQ+wVDGP3yfYX7UKIPY5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MIJkQVkt4xqve0BOXtxCBd9FeU0z9MmxfabsOKsl+NQ=;
        b=EI1ariJWGPr/JPjpbBHlfhjcHNZ9yOfqPFbfaECaZvqEal37ZE0/X5tmgwt+V8T8nb
         C+Q5lyq1a0OkrHfigkv0xvIyOg5+hu0anwj55FlFkjZg/MeuFuYwRXo/Q3uX7OH2dm2/
         28KBPY4EFRr/CnnF6AvNGraZAuy6Mt7/aqx9H2zNbNaM2pRLNt2FuUlAaAyoNjbZhBmf
         G/4OJmd7OD9fg945Ek7/64+QAU5eLYr3N/uyCpmCtQfcE2HNdjVFpspZNw5OTdc8tj/2
         aepbAXPrOwdaKgOl5KBn89rOinq+73W40Ci2awKgrgsfvBJAGnfBIRHZBzOw+k7WVzhp
         vIjA==
X-Gm-Message-State: AOAM531vFp3Dmmzr6JjWqQKL76wv0PhGjPeZobrlKb5fXlDY5o+ondlG
        Heesdvgy1JWLCcZsb2yu5zeFxDoQ9mm2VA==
X-Google-Smtp-Source: ABdhPJwc3Hhkt8mCaow1k05pyg0wyzvRdI4bicwfhIBrGmE+C/15WUA7k79+BZeNMBIos0lI9+vTTw==
X-Received: by 2002:a63:78a:: with SMTP id 132mr3894983pgh.83.1636436019769;
        Mon, 08 Nov 2021 21:33:39 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:cc3e:b71b:e327:fb32])
        by smtp.gmail.com with ESMTPSA id w5sm13741479pgp.79.2021.11.08.21.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 21:33:39 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] arm64: dts: mt8183: Add kukui-jacuzzi-cozmo board
Date:   Tue,  9 Nov 2021 13:33:29 +0800
Message-Id: <20211109053334.1840273-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
In-Reply-To: <20211109053334.1840273-1-hsinyi@chromium.org>
References: <20211109053334.1840273-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cozmo is known as Acer Chromebook 314 (CB314-2H/CB314-2HT)

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../mediatek/mt8183-kukui-jacuzzi-cozmo.dts   | 36 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 4f68ebed2e3188..045927402269a9 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -14,6 +14,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana-rev7.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-burnet.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-cozmo.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-damu.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-fennel-sku1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-fennel-sku6.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts
new file mode 100644
index 00000000000000..072133fb0f0162
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi.dtsi"
+#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
+
+/ {
+	model = "Google cozmo board";
+	compatible = "google,cozmo", "mediatek,mt8183";
+};
+
+&i2c_tunnel {
+	google,remote-bus = <0>;
+};
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
+	qcom,ath10k-calibration-variant = "GO_COZMO";
+};
-- 
2.34.0.rc0.344.g81b53c2807-goog

