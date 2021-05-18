Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990CB387F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 19:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351339AbhERRzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 13:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351288AbhERRzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 13:55:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EAEC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:54:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d11so11184692wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CWPyuzoJy/mScoWjTd2g156JIqxC7nCj/J8y8W+5TIQ=;
        b=gFITqRQ42/kzXwvlJxXPZLz9mArPh+pgdzCUd/Jxd1yrL6hggF14NdJNillhgJdwyX
         Sce0Br+HzNLf+LOydSu6aplcnaRFCsjewZ+DGhQFzn95i9HvdGi7Vj0BFatbdG9lD2Oy
         mvNPsKvV+132xtqDcIQ2zn1o0rRLooZVm6bkQJ+onnbx88YTgoTors2oG8C38Zwb49Xj
         ynvUDuaGkuN57coAxPIG3Gjp3LW+ruLhQTAVMx1wHLTTJq5YGgg/bCyW2W/Zo7ywGYPh
         F57HYLCKxLUOIKXusNpVCm7AxFQBEFqVWk3gcMS6EfxZl5WffEcfM8tVle8Pmyb/8oYd
         NuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CWPyuzoJy/mScoWjTd2g156JIqxC7nCj/J8y8W+5TIQ=;
        b=il6HVoOOHUYvxmku7TcdpD8CYQHOheg8UkClEzfrmqbNd/VyVa3vXNoOTGtE5hRLGB
         y67w6/PzsDLp95sf4X6YtMSoYkOBTuTuGkZvvh3ZhwyCl2MoXIklrmR7tPuoOfEAg1kF
         dfpyM97FWVwSjJbu1C0C0VlZv8dVxSQAIlqHjoJ8xFODbyF3SCEm2iFmj78N/QTMQBZm
         QV25Em+Mp/Gvzjt/qXDpNdaGaOJA3CGM06AP0nKca6guum708dHR0oovaoKZWu7s2PLh
         u4XBPmYG53eOKSjsMSX3ZLsOYgC7BQ+GgMm7wfAGfWDZA+xB1mD3lrZmnHn1x2SWTXhE
         wsHw==
X-Gm-Message-State: AOAM533i3ga1mmcZuieRigBHFuzlCUgHTBE57DdmVuC2woMMLuI/3Lxg
        x7zOo3rkvyTGVx55vrOuQvyQYw==
X-Google-Smtp-Source: ABdhPJzoBUSu3qBReU3Wn0C/GcMbanCzAN+0PiM0fvT4m9u2qWF6Q6o+Gx0yv3qirYtHdkj9jj/OzQ==
X-Received: by 2002:a5d:4003:: with SMTP id n3mr8552995wrp.173.1621360464840;
        Tue, 18 May 2021 10:54:24 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id a17sm14458963wrt.53.2021.05.18.10.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 10:54:24 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: pwm: pwm-mtk-disp: convert to YAML schema
Date:   Tue, 18 May 2021 19:54:19 +0200
Message-Id: <20210518175422.2678665-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the dt-binding documentation for pwm-mtk-disp to YAML.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt  | 44 ----------
 .../devicetree/bindings/pwm/pwm-mtk-disp.yaml | 83 +++++++++++++++++++
 2 files changed, 83 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
deleted file mode 100644
index 902b271891ae..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-MediaTek display PWM controller
-
-Required properties:
- - compatible: should be "mediatek,<name>-disp-pwm":
-   - "mediatek,mt2701-disp-pwm": found on mt2701 SoC.
-   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
-   - "mediatek,mt8167-disp-pwm", "mediatek,mt8173-disp-pwm": found on mt8167 SoC.
-   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
- - reg: physical base address and length of the controller's registers.
- - #pwm-cells: must be 2. See pwm.yaml in this directory for a description of
-   the cell format.
- - clocks: phandle and clock specifier of the PWM reference clock.
- - clock-names: must contain the following:
-   - "main": clock used to generate PWM signals.
-   - "mm": sync signals from the modules of mmsys.
- - pinctrl-names: Must contain a "default" entry.
- - pinctrl-0: One property must exist for each entry in pinctrl-names.
-   See pinctrl/pinctrl-bindings.txt for details of the property values.
-
-Example:
-	pwm0: pwm@1401e000 {
-		compatible = "mediatek,mt8173-disp-pwm",
-			     "mediatek,mt6595-disp-pwm";
-		reg = <0 0x1401e000 0 0x1000>;
-		#pwm-cells = <2>;
-		clocks = <&mmsys CLK_MM_DISP_PWM026M>,
-			 <&mmsys CLK_MM_DISP_PWM0MM>;
-		clock-names = "main", "mm";
-		pinctrl-names = "default";
-		pinctrl-0 = <&disp_pwm0_pins>;
-	};
-
-	backlight_lcd: backlight_lcd {
-		compatible = "pwm-backlight";
-		pwms = <&pwm0 0 1000000>;
-		brightness-levels = <
-			  0  16  32  48  64  80  96 112
-			128 144 160 176 192 208 224 240
-			255
-		>;
-		default-brightness-level = <9>;
-		power-supply = <&mt6397_vio18_reg>;
-		enable-gpios = <&pio 95 GPIO_ACTIVE_HIGH>;
-	};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
new file mode 100644
index 000000000000..0f016c81cd53
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pwm/pwm-mtk-disp.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek display PWM controller
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Lee Jones <lee.jones@linaro.org>
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt2701-disp-pwm
+          - mediatek,mt6595-disp-pwm
+          - mediatek,mt8173-disp-pwm
+      - items:
+          - const: mediatek,mt8167-disp-pwm
+          - const: mediatek,mt8173-disp-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock used to generate PWM signals
+      - description: sync signal from the mmsys module
+
+  clock-names:
+    items:
+      - const: main
+      - const: mm
+
+  "#pwm-cells":
+    const: 2
+
+  power-domains:
+    description:
+      List of phandles and PM domain specifiers, as defined by bindings of the
+      PM domain provider (see also ../power_domain.txt).
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/gpio/gpio.h>
+    pwm0: pwm@1401e000 {
+      compatible = "mediatek,mt8173-disp-pwm";
+      reg = <0x1401e000 0x1000>;
+      #pwm-cells = <2>;
+      clocks = <&mmsys CLK_MM_DISP_PWM026M>,
+               <&mmsys CLK_MM_DISP_PWM0MM>;
+      clock-names = "main", "mm";
+      pinctrl-names = "default";
+      pinctrl-0 = <&disp_pwm0_pins>;
+    };
+
+    backlight_lcd: backlight_lcd {
+      compatible = "pwm-backlight";
+      pwms = <&pwm0 0 1000000>;
+      brightness-levels = <
+        0  16  32  48  64  80  96 112
+        128 144 160 176 192 208 224 240
+        255
+      >;
+      default-brightness-level = <9>;
+      power-supply = <&mt6397_vio18_reg>;
+      enable-gpios = <&pio 95 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.31.1

