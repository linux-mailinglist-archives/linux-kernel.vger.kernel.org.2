Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D503BB9FF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhGEJSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhGEJSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:18:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48579C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 02:15:33 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s18so2641892pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 02:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vSiSNzG5KZZf416CrhQaG1dPb1YmOPojGaZZjdBOJgc=;
        b=BFPg6i0JHuxJouVPgdi/n+AfQt1pcfNAXgNsrUXh7ZCCAa8d4UKm5jriLB3obiTSOc
         xUsAJlN8mq0Nmd3XleKpK6BbVyzF2W8x+7IEgvWRAZ3llgJS2qD4ZQYlUfA2MEgujHmN
         tNmxiqIrQRBwGleBDwz0UaR0AJ3LQzuB5sZk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vSiSNzG5KZZf416CrhQaG1dPb1YmOPojGaZZjdBOJgc=;
        b=DSUbHiVnZS45eoYRFSl1aQsrgH5r1GXie0ABOsx4js/jF1Nziw8spJbtbxMc/GYl+v
         cM4xp67OEhhBfGlZTquNQW6HZ8f/2fGeJTMppktFnlBTayygmN1fTFJZ+S5EuwkIBGqt
         IDikUQn6S4jQOVXVbNBj3tO+pZg/cHMjUs2B0I5glfu918T25j1m/XM3ime07T0ZvrkN
         RvchZMsKvrjr4nZhpxBBsIGSf6/UczlHJMewl2MPvNetVAhWc+P3ee7mY1iVXVm/pWA7
         sU/oi6ioXjfjbD4joKLYwZdctmRl6W/rhEHd05PD1DFkXrTi7qKWlX10ZyyE+JnYIm0g
         hmCA==
X-Gm-Message-State: AOAM530qKgdZjCNyNuMq6T6GSwblv0dvrQGAzzg7rVLnUVA+WHlvXeZX
        woW1Mw3QURFDnvru9DhuvW0K5g==
X-Google-Smtp-Source: ABdhPJy+4V54kuPF+mY7xG+rWJ3137gTHJKmJsYbKZVkt4gXlxrug1J9xd1iJppkokzg2WmMZW/MXQ==
X-Received: by 2002:aa7:8154:0:b029:310:70d:a516 with SMTP id d20-20020aa781540000b0290310070da516mr14296925pfn.63.1625476532713;
        Mon, 05 Jul 2021 02:15:32 -0700 (PDT)
Received: from kansho.tok.corp.google.com ([2401:fa00:8f:203:cdc4:4be8:5ce4:df43])
        by smtp.gmail.com with ESMTPSA id 9sm12245176pfv.42.2021.07.05.02.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 02:15:32 -0700 (PDT)
From:   Kansho Nishida <kansho@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Shunli Wang <shunli.wang@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Kansho Nishida <kansho@chromium.org>
Subject: [PATCH v2 2/2] arm64: dts: mt8183: add kukui platform audio node
Date:   Mon,  5 Jul 2021 18:15:14 +0900
Message-Id: <20210705181443.v2.2.I6e9ce0f2a489f9a52299656cd966b38ae75e7552@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210705091514.912355-1-kansho@chromium.org>
References: <20210705091514.912355-1-kansho@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set pin control for the SoC sound node.
The compatibles are set by each model dts.

The codecs that each models use are:
burnet       ts3a227_max98357
damu         da7219_max98357
fennel       da7219_rt1015p
fennel14     da7219_rt1015p
juniper      ts3a227_max98357
kakadu       da7219_rt1015p
kappa        ts3a227_max98357
kenzo        ts3a227_max98357
kodama       ts3a227_max98357
krane        ts3a227_max98357
willow-sku0  da7219_max98357
willow-sku1  ts3a227_max98357

Signed-off-by: Kansho Nishida <kansho@chromium.org>
---

Changes in v2:
- Changed to the dual license GPL + MIT.

 arch/arm64/boot/dts/mediatek/mt6358.dtsi      |  1 +
 .../mt8183-kukui-audio-da7219-max98357a.dtsi  | 13 ++++
 .../mt8183-kukui-audio-da7219-rt1015p.dtsi    | 13 ++++
 .../mediatek/mt8183-kukui-audio-da7219.dtsi   | 54 +++++++++++++++
 .../mt8183-kukui-audio-max98357a.dtsi         | 13 ++++
 .../mediatek/mt8183-kukui-audio-rt1015p.dtsi  | 13 ++++
 ...mt8183-kukui-audio-ts3a227e-max98357a.dtsi | 13 ++++
 .../mt8183-kukui-audio-ts3a227e-rt1015p.dtsi  | 13 ++++
 .../mediatek/mt8183-kukui-audio-ts3a227e.dtsi | 32 +++++++++
 .../mediatek/mt8183-kukui-jacuzzi-burnet.dts  |  1 +
 .../mediatek/mt8183-kukui-jacuzzi-damu.dts    |  1 +
 .../mediatek/mt8183-kukui-jacuzzi-fennel.dtsi |  1 +
 .../mt8183-kukui-jacuzzi-juniper-sku16.dts    |  1 +
 .../mediatek/mt8183-kukui-jacuzzi-kappa.dts   |  1 +
 .../mediatek/mt8183-kukui-jacuzzi-kenzo.dts   |  1 +
 .../mt8183-kukui-jacuzzi-willow-sku0.dts      |  1 +
 .../mt8183-kukui-jacuzzi-willow-sku1.dts      |  1 +
 .../boot/dts/mediatek/mt8183-kukui-kakadu.dts |  1 +
 .../dts/mediatek/mt8183-kukui-kodama.dtsi     |  1 +
 .../boot/dts/mediatek/mt8183-kukui-krane.dtsi |  5 ++
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 67 +++++++++++++++++--
 21 files changed, 243 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-max98357a.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-rt1015p.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-max98357a.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-rt1015p.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-max98357a.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-rt1015p.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
index fa159b20379e..95145076b7e6 100644
--- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
@@ -13,6 +13,7 @@ pmic: mt6358 {
 
 		mt6358codec: mt6358codec {
 			compatible = "mediatek,mt6358-sound";
+			mediatek,dmic-mode = <0>; /* two-wires */
 		};
 
 		mt6358regulator: mt6358regulator {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-max98357a.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-max98357a.dtsi
new file mode 100644
index 000000000000..e4aeea4599f5
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-max98357a.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Google Kukui (and derivatives) da7219-max98357a sound card.
+ *
+ * Copyright 2019 Google LLC.
+ */
+
+#include "mt8183-kukui-audio-da7219.dtsi"
+#include "mt8183-kukui-audio-max98357a.dtsi"
+
+&sound {
+	compatible = "mediatek,mt8183_da7219_max98357";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-rt1015p.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-rt1015p.dtsi
new file mode 100644
index 000000000000..16ce5a3612ee
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-rt1015p.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Google Kukui (and derivatives) da7219-rt1015p sound card.
+ *
+ * Copyright 2020 Google LLC.
+ */
+
+#include "mt8183-kukui-audio-da7219.dtsi"
+#include "mt8183-kukui-audio-rt1015p.dtsi"
+
+&sound {
+	compatible = "mediatek,mt8183_da7219_rt1015p";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
new file mode 100644
index 000000000000..2c69e7658dba
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Google Kukui (and derivatives) audio fragment for da7219.
+ *
+ * Copyright 2020 Google LLC.
+ */
+
+&i2c5 {
+	da7219: da7219@1a {
+		pinctrl-names = "default";
+		pinctrl-0 = <&da7219_pins>;
+		compatible = "dlg,da7219";
+		reg = <0x1a>;
+		interrupt-parent = <&pio>;
+		interrupts = <165 IRQ_TYPE_LEVEL_LOW 165 0>;
+
+		dlg,micbias-lvl = <2600>;
+		dlg,mic-amp-in-sel = "diff";
+		VDD-supply = <&pp1800_alw>;
+		VDDMIC-supply = <&pp3300_alw>;
+		VDDIO-supply = <&pp1800_alw>;
+
+		status = "okay";
+
+		da7219_aad {
+			dlg,adc-1bit-rpt = <1>;
+			dlg,btn-avg = <4>;
+			dlg,btn-cfg = <50>;
+			dlg,mic-det-thr = <500>;
+			dlg,jack-ins-deb = <20>;
+			dlg,jack-det-rate = "32ms_64ms";
+			dlg,jack-rem-deb = <1>;
+
+			dlg,a-d-btn-thr = <0xa>;
+			dlg,d-b-btn-thr = <0x16>;
+			dlg,b-c-btn-thr = <0x21>;
+			dlg,c-mic-btn-thr = <0x3E>;
+		};
+	};
+};
+
+&pio {
+	da7219_pins: da7219_pins {
+		pins1 {
+			pinmux = <PINMUX_GPIO165__FUNC_GPIO165>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+};
+
+&sound {
+	mediatek,headset-codec = <&da7219>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-max98357a.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-max98357a.dtsi
new file mode 100644
index 000000000000..2b60967c0c1c
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-max98357a.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Google Kukui (and derivatives) audio fragment for max98357a.
+ *
+ * Copyright 2020 Google LLC.
+ */
+
+/ {
+	max98357a: max98357a {
+		compatible = "maxim,max98357a";
+		sdmode-gpios = <&pio 175 0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-rt1015p.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-rt1015p.dtsi
new file mode 100644
index 000000000000..658a764fe9ee
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-rt1015p.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Google Kukui (and derivatives) audio fragment for rt1015p.
+ *
+ * Copyright 2020 Google LLC.
+ */
+
+/ {
+	rt1015p: rt1015p {
+		compatible = "realtek,rt1015p";
+		sdb-gpios = <&pio 175 0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-max98357a.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-max98357a.dtsi
new file mode 100644
index 000000000000..260a5f561495
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-max98357a.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Google Kukui (and derivatives) ts3a227e-max98357a sound card.
+ *
+ * Copyright 2020 Google LLC.
+ */
+
+#include "mt8183-kukui-audio-max98357a.dtsi"
+#include "mt8183-kukui-audio-ts3a227e.dtsi"
+
+&sound {
+	compatible = "mediatek,mt8183_mt6358_ts3a227_max98357";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-rt1015p.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-rt1015p.dtsi
new file mode 100644
index 000000000000..2f7d1fa1c90f
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-rt1015p.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Google Kukui (and derivatives) mt6358-ts3a227-rt1015p sound card.
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+#include "mt8183-kukui-audio-ts3a227e.dtsi"
+#include "mt8183-kukui-audio-rt1015p.dtsi"
+
+&sound {
+	compatible = "mediatek,mt8183_mt6358_ts3a227_rt1015p";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e.dtsi
new file mode 100644
index 000000000000..0799c48ade19
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Google Kukui (and derivatives) audio fragment for ts3a227e.
+ *
+ * Copyright 2019 Google LLC.
+ */
+
+&i2c5 {
+	ts3a227e: ts3a227e@3b {
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts3a227e_pins>;
+		compatible = "ti,ts3a227e";
+		reg = <0x3b>;
+		interrupt-parent = <&pio>;
+		interrupts = <157 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+	};
+};
+
+&pio {
+	ts3a227e_pins: ts3a227e_pins {
+		pins1 {
+			pinmux = <PINMUX_GPIO157__FUNC_GPIO157>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+};
+
+&sound {
+	mediatek,headset-codec = <&ts3a227e>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
index a8d6f32ade8d..1a2ec0787d3c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "mt8183-kukui-jacuzzi.dtsi"
+#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
 
 / {
 	model = "Google burnet board";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
index 42ba9c00866c..0eca3ff8672a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "mt8183-kukui-jacuzzi.dtsi"
+#include "mt8183-kukui-audio-da7219-max98357a.dtsi"
 
 / {
 	model = "Google damu board";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
index bbe6c338f465..577519a775c0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "mt8183-kukui-jacuzzi.dtsi"
+#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
 
 &mt6358codec {
 	mediatek,dmic-mode = <1>; /* one-wire */
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts
index 36d2c3b3cadf..bc2c57f0a827 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "mt8183-kukui-jacuzzi-juniper.dtsi"
+#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
 
 / {
 	model = "Google juniper sku16 board";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
index b3f46c16e5d7..e5bd9191e426 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "mt8183-kukui-jacuzzi.dtsi"
+#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
 
 / {
 	model = "Google kappa board";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
index 6f1aa692753a..8fa89db03e63 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "mt8183-kukui-jacuzzi-juniper.dtsi"
+#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
 
 / {
 	model = "Google kenzo sku17 board";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
index 281265f082db..89208b843b27 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "mt8183-kukui-jacuzzi-willow.dtsi"
+#include "mt8183-kukui-audio-da7219-max98357a.dtsi"
 
 / {
 	model = "Google willow board sku0";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
index 22e56bdc1ee3..c7b20441d053 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "mt8183-kukui-jacuzzi-willow.dtsi"
+#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
 
 / {
 	model = "Google willow board sku1";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts
index 20eb0dc68f09..89a139a0ee44 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "mt8183-kukui-kakadu.dtsi"
+#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
 
 / {
 	model = "MediaTek kakadu board";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
index 3aa79403c0c2..06f8c80bf553 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "mt8183-kukui.dtsi"
+#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
 
 / {
 	ppvarn_lcd: ppvarn-lcd {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
index 30c183c96a54..a7b0cb3ff7b0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "mt8183-kukui.dtsi"
+#include "mt8183-kukui-audio-max98357a.dtsi"
 
 / {
 	ppvarn_lcd: ppvarn-lcd {
@@ -345,3 +346,7 @@ rst_pin {
 &qca_wifi {
 	qcom,ath10k-calibration-variant = "LE_Krane";
 };
+
+&sound {
+	compatible = "mediatek,mt8183_mt6358_ts3a227_max98357";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index ae549d55a94f..b709859b0a03 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -113,12 +113,18 @@ scp_mem_reserved: scp_mem_region {
 		};
 	};
 
-	max98357a: codec0 {
-		compatible = "maxim,max98357a";
-		sdmode-gpios = <&pio 175 0>;
+	sound: mt8183-sound {
+		mediatek,platform = <&afe>;
+		pinctrl-names = "default",
+				"aud_tdm_out_on",
+				"aud_tdm_out_off";
+		pinctrl-0 = <&aud_pins_default>;
+		pinctrl-1 = <&aud_pins_tdm_out_on>;
+		pinctrl-2 = <&aud_pins_tdm_out_off>;
+		status = "okay";
 	};
 
-	btsco: codec1 {
+	btsco: bt-sco {
 		compatible = "linux,bt-sco";
 	};
 
@@ -213,6 +219,11 @@ tboard_thermistor2: thermal-sensor2 {
 	};
 };
 
+&afe {
+	i2s3-share = "I2S2";
+	i2s0-share = "I2S5";
+};
+
 &auxadc {
 	status = "okay";
 };
@@ -400,6 +411,54 @@ &mt6358_vsim2_reg {
 };
 
 &pio {
+	aud_pins_default: audiopins {
+		pins_bus {
+			pinmux = <PINMUX_GPIO97__FUNC_I2S2_MCK>,
+				<PINMUX_GPIO98__FUNC_I2S2_BCK>,
+				<PINMUX_GPIO101__FUNC_I2S2_LRCK>,
+				<PINMUX_GPIO102__FUNC_I2S2_DI>,
+				<PINMUX_GPIO3__FUNC_I2S3_DO>, /*i2s to da7219/max98357*/
+				<PINMUX_GPIO89__FUNC_I2S5_BCK>,
+				<PINMUX_GPIO90__FUNC_I2S5_LRCK>,
+				<PINMUX_GPIO91__FUNC_I2S5_DO>,
+				<PINMUX_GPIO174__FUNC_I2S0_DI>, /*i2s to wifi/bt*/
+				<PINMUX_GPIO136__FUNC_AUD_CLK_MOSI>,
+				<PINMUX_GPIO137__FUNC_AUD_SYNC_MOSI>,
+				<PINMUX_GPIO138__FUNC_AUD_DAT_MOSI0>,
+				<PINMUX_GPIO139__FUNC_AUD_DAT_MOSI1>,
+				<PINMUX_GPIO140__FUNC_AUD_CLK_MISO>,
+				<PINMUX_GPIO141__FUNC_AUD_SYNC_MISO>,
+				<PINMUX_GPIO142__FUNC_AUD_DAT_MISO0>,
+				<PINMUX_GPIO143__FUNC_AUD_DAT_MISO1>; /*mtkaif3.0*/
+		};
+	};
+
+	aud_pins_tdm_out_on: audiotdmouton {
+		pins_bus {
+			pinmux = <PINMUX_GPIO169__FUNC_TDM_BCK_2ND>,
+				<PINMUX_GPIO170__FUNC_TDM_LRCK_2ND>,
+				<PINMUX_GPIO171__FUNC_TDM_DATA0_2ND>,
+				<PINMUX_GPIO172__FUNC_TDM_DATA1_2ND>,
+				<PINMUX_GPIO173__FUNC_TDM_DATA2_2ND>,
+				<PINMUX_GPIO10__FUNC_TDM_DATA3>; /*8ch-i2s to it6505*/
+			drive-strength = <MTK_DRIVE_6mA>;
+		};
+	};
+
+	aud_pins_tdm_out_off: audiotdmoutoff {
+		pins_bus {
+			pinmux = <PINMUX_GPIO169__FUNC_GPIO169>,
+				<PINMUX_GPIO170__FUNC_GPIO170>,
+				<PINMUX_GPIO171__FUNC_GPIO171>,
+				<PINMUX_GPIO172__FUNC_GPIO172>,
+				<PINMUX_GPIO173__FUNC_GPIO173>,
+				<PINMUX_GPIO10__FUNC_GPIO10>;
+			input-enable;
+			bias-pull-down;
+			drive-strength = <MTK_DRIVE_2mA>;
+		};
+	};
+
 	bt_pins: bt-pins {
 		pins_bt_en {
 			pinmux = <PINMUX_GPIO120__FUNC_GPIO120>;
-- 
2.32.0.93.g670b81a890-goog

