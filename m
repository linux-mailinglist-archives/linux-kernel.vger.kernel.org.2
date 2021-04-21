Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0A8366799
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbhDUJHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbhDUJGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:06:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B2AC06138D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:21 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q2so3805041pfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P57ROu+aYfuik8qrfPLtqSBm2rpbyMiEgmmbtJHdOFE=;
        b=a5ERAKhqEwP0k4kUYBeBLluNoxQHnZ+aQNHev0yh1J0dSeCxIgaJKONIhLqnBpmKrI
         PiIBE7pRTAHnU+LJB7+5T1vXjQiUvGx5SBYU+PIgTyPwFir1tbeSOSMX5EdrH0+ds/is
         W/vDNCJYv0yhLXP+D1Zbyc04VTVunn5n8EvLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P57ROu+aYfuik8qrfPLtqSBm2rpbyMiEgmmbtJHdOFE=;
        b=OkIibDh6SJkQttPpgYgi1UCKSOBqG1MiR7abzWnxn1bYip4KfXHfebIc3HoMLaxOOo
         rTFvcJRimCzlw8y1LVeSENmcFAt2EBSJeyjwP5Gae4pvC13qTJROsP1+Gysbss8cmUSk
         kMqeJKTGWOy+ptZQ5o1ktP1I5dVEUm4iKpVNF/MfZ2U+MN+6UxZTf5+UlbiiX83jMVgg
         sWq9D4Lb5Ve/M1juXKcXEvWS8z677zspLfGz4Wam64wSPkJ23HL3hDwx4PV69R5UWwG0
         ohMTDirbJlbjR2CPZQtn8QgW9IQKGzmelcEA6Ey1ENYnqrlcbqf0LV6w2oaMw7KBdyDH
         ojzg==
X-Gm-Message-State: AOAM533sFW3FvoChIUdEGmwOTdn/SwVydywEBtci6W5qK7CIRf9z1jRH
        JtM5d9bDbTVnT6JY6z3RPUBECA==
X-Google-Smtp-Source: ABdhPJyMrZzup7KcFDMZHzpav5zxNMmHKGUoGyFh1p9QTxHzNC4m4ozhoncxMr8idGj6+LcS0xl1Bg==
X-Received: by 2002:a17:90a:6407:: with SMTP id g7mr9610511pjj.206.1618995980953;
        Wed, 21 Apr 2021 02:06:20 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:60c1:887e:ac53:9b5c])
        by smtp.gmail.com with ESMTPSA id jx20sm1495889pjb.41.2021.04.21.02.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 02:06:20 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 08/10] arm64: dts: mt8183: Add kukui-jacuzzi-burnet board
Date:   Wed, 21 Apr 2021 17:05:59 +0800
Message-Id: <20210421090601.730744-9-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210421090601.730744-1-hsinyi@chromium.org>
References: <20210421090601.730744-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Burnet is known as HP Chromebook x360 11MK G3 EE

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../mediatek/mt8183-kukui-jacuzzi-burnet.dts  | 30 +++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 5f43bbc2ea72..b33d0bc58021 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana-rev7.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-burnet.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-damu.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-juniper-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kappa.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
new file mode 100644
index 000000000000..a8d6f32ade8d
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi.dtsi"
+
+/ {
+	model = "Google burnet board";
+	compatible = "google,burnet", "mediatek,mt8183";
+};
+
+&mt6358codec {
+	mediatek,dmic-mode = <1>; /* one-wire */
+};
+
+&i2c0 {
+	touchscreen@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+		interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
+
+		post-power-on-delay-ms = <200>;
+		hid-descr-addr = <0x0020>;
+	};
+};
+
-- 
2.31.1.498.g6c1eba8ee3d-goog

