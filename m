Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789F13413E0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 04:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhCSDxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 23:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbhCSDw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 23:52:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3459C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 20:52:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso6021331pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 20:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0c6ue7k7W+aM2C/ru0d4xrULEj/JDjoLwyUHXQYoMxI=;
        b=nv1Nx7xsndUI6U29g+m86RII2Symog9Ppe+sR30OmWZ/YOOcqph1L5Jd+xN/HdcFoI
         vNlvlU4PBDG5QqNvjgjv95u0C5jUqB5wp/yPJQk5dZWi62DaM7wcWqD9KaGUAaKtyix8
         TZGSwWcexyzZOPo82x+EhmCLcjZyMOoWlrv4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0c6ue7k7W+aM2C/ru0d4xrULEj/JDjoLwyUHXQYoMxI=;
        b=KvYtPtkke41hWuppndwTiKjGU66nS2YoJYmPsRQ21VHd8yrddbIAtPkkdNjj0t+Xl7
         p9HyBy3xcvUYm1c6yfcI/isUROiaxiDVvmJbQyr8/bR55dGLQYFBmK56TXmC94jgSeF9
         TAzbwruJy+E7w+b9loMJADfm5N4Wo45qVEQ4p/Bt5xrTJ3nEzoYyVfWeWDVLYuzYc1GM
         7ksslEcP3huOPi9fhuCFBrlQvrag7HAT9PbgxuqYZF+JoKpnYKteEfy20LQ4uAilyK89
         /FxbhN99RK4SWzvz6FkvOCgyTcXfESX6zNnlXM5/7GklnRtZuJMYd6EwEiDgrpAdjnmc
         CDVQ==
X-Gm-Message-State: AOAM533Dv+tcZgjQEnpk7XCfOkOfiyN6oaruUsK1KDaGmihfaGj0/DhW
        Q4dTaAQC1YRkgAWN1xuHhcCWbSdfdY58cscD
X-Google-Smtp-Source: ABdhPJzAsFK+Zh3E/btZHCY105Qrc22+B+j7F68MDjbBqt+1bIvVfKn8q8ZxeM7+VANXIB/a25HmGg==
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr7574989pjt.120.1616125977224;
        Thu, 18 Mar 2021 20:52:57 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e12f:5c36:14f:bbf5])
        by smtp.gmail.com with ESMTPSA id u66sm3442180pfu.186.2021.03.18.20.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 20:52:56 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Ben Ho <Ben.Ho@mediatek.com>
Subject: [PATCH v4 4/4] arm64: dts: mt8183: Add kukui-jacuzzi-juniper board
Date:   Fri, 19 Mar 2021 11:52:45 +0800
Message-Id: <20210319035245.2751911-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319035245.2751911-1-hsinyi@chromium.org>
References: <20210319035245.2751911-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Juniper is known as Acer Chromebook Spin 311 (CP311-3H).

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../mt8183-kukui-jacuzzi-juniper-sku16.dts    | 13 +++++++++
 .../mt8183-kukui-jacuzzi-juniper.dtsi         | 27 +++++++++++++++++++
 3 files changed, 41 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 554105d2c389..db4753d82a4b 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -14,6 +14,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana-rev7.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-damu.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-juniper-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts
new file mode 100644
index 000000000000..36d2c3b3cadf
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi-juniper.dtsi"
+
+/ {
+	model = "Google juniper sku16 board";
+	compatible = "google,juniper-sku16", "google,juniper", "mediatek,mt8183";
+};
+
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi
new file mode 100644
index 000000000000..078bc765646f
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi
@@ -0,0 +1,27 @@
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
+
-- 
2.31.0.rc2.261.g7f71774620-goog

