Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0415D3796F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhEJS0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhEJS0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:26:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DA8C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 11:25:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d11so17597377wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IA+mE070EGJp8sOVYovOMc17oE3lYWvffqteaPcfIVY=;
        b=WdHVdgArrAfk+1tBnhrIbojqIPJpqqXY0eDpblWF7One+upDGTaN8pQjgpuBhyV11x
         aK/b2fwIVWbYeEnehU2M5vbRY+J2fKKEOAg6Hnzr5J7D4u8Yjy5b/L2dELB2oLFyF4nP
         KFZ91Y7++DP1IqXswAIqNIA5iLLZ6a+B//i4dLOYOS/pu7GpDocA+ltp8W8PQN6hCSU+
         dY04KX5BuxCqbyiNT1DUAokstUEbeJq58ZVo6B4DePmNEhn2X2s2m/RjXLIv30S1HNS7
         p0V/GYzYBZvpu8UTW6I9q0XOVALokp/XSxPh8IGJ+BP6Thfr9EoPLiOZHeoT9sRKmcdT
         d2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IA+mE070EGJp8sOVYovOMc17oE3lYWvffqteaPcfIVY=;
        b=bIwsaa1amEEtGzFrs8NS0GdjTLtYkPciXgCCNHgLOyALtMzdPbu+sfcgditwDAmPY8
         qOf4MMfL1RYsTxdbTd+B22R2Be6BtX3hiohb714Wmx4YPF6REOB3vBJGdZEF6D73BKml
         M9DzfpgdUkYyFZxn7kcV2IZLQy/dd76AkAWytaYk7u9uYiklmD7i2JV6IliFp+5GTQ/c
         WRjNnUshjvFw5Khr9tQHcvhu1OQ2UThXLTy7WbHZ66S83JjB5YClX0xYdaw7wk1mV/R9
         zll1RgDkhS60Me3b4JgDR9BDWwIBNlnUuWfZa66wxh0i6RLl3FbunyHnH5gnvG/X1pju
         ujtw==
X-Gm-Message-State: AOAM533OCg1oRXjfgocrvilGqrZ6f7ZefQ6nfWbRlZWOY7khuSm1MEJ2
        twsMQu2x6VMkJkWlcr2X2hDsow==
X-Google-Smtp-Source: ABdhPJz5aohqhzhsbUNr7TYZz5k2LY2t4k+wvZN9P+UJoTrr78Ibsovp7Jy0r0wJ3jm8XIbdAgaQsg==
X-Received: by 2002:a5d:64e6:: with SMTP id g6mr31910513wri.216.1620671112430;
        Mon, 10 May 2021 11:25:12 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id k10sm1109598wmf.0.2021.05.10.11.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 11:25:11 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2] dt-bindings: convert rtc/faraday,ftrtc01 to yaml
Date:   Mon, 10 May 2021 18:25:05 +0000
Message-Id: <20210510182505.3968936-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts rtc/faraday,ftrtc01.txt to yaml.
This permits to detect some missing properties: reg, resets, interrupts

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- fixed issues reported by Rob Herring https://lore.kernel.org/linux-rtc/20210506174539.GA536770@robh.at.kernel.org/T/#t
 .../bindings/rtc/faraday,ftrtc010.txt         | 28 ---------
 .../bindings/rtc/faraday,ftrtc010.yaml        | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml

diff --git a/Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt b/Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
deleted file mode 100644
index e3938f5e0b6c..000000000000
--- a/Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Faraday Technology FTRTC010 Real Time Clock
-
-This RTC appears in for example the Storlink Gemini family of
-SoCs.
-
-Required properties:
-- compatible : Should be one of:
-  "faraday,ftrtc010"
-  "cortina,gemini-rtc", "faraday,ftrtc010"
-
-Optional properties:
-- clocks: when present should contain clock references to the
-  PCLK and EXTCLK clocks. Faraday calls the later CLK1HZ and
-  says the clock should be 1 Hz, but implementers actually seem
-  to choose different clocks here, like Cortina who chose
-  32768 Hz (a typical low-power clock).
-- clock-names: should name the clocks "PCLK" and "EXTCLK"
-  respectively.
-
-Examples:
-
-rtc@45000000 {
-	compatible = "cortina,gemini-rtc";
-	reg = <0x45000000 0x100>;
-	interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&foo 0>, <&foo 1>;
-	clock-names = "PCLK", "EXTCLK";
-};
diff --git a/Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml b/Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml
new file mode 100644
index 000000000000..657c13b62b67
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/faraday,ftrtc010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Faraday Technology FTRTC010 Real Time Clock
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+  This RTC appears in for example the Storlink Gemini family of SoCs.
+
+properties:
+  compatible:
+    oneOf:
+      - const: faraday,ftrtc010
+      - items:
+          - const: cortina,gemini-rtc
+          - const: faraday,ftrtc010
+
+  resets:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    items:
+      - description: PCLK clocks
+      - description: EXTCLK clocks. Faraday calls it CLK1HZ and says the clock
+          should be 1 Hz, but implementers actually seem to choose different
+          clocks here, like Cortina who chose 32768 Hz (a typical low-power clock).
+
+  clock-names:
+    items:
+      - const: "PCLK"
+      - const: "EXTCLK"
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    rtc@45000000 {
+      compatible = "cortina,gemini-rtc", "faraday,ftrtc010";
+      reg = <0x45000000 0x100>;
+      interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&foo 0>, <&foo 1>;
+      clock-names = "PCLK", "EXTCLK";
+    };
-- 
2.26.3

