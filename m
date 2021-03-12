Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848A033882F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhCLJDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhCLJCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:02:49 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0955EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:02:48 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x21so89544pfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=coMaeMgwYndIuacusZtcjMM2Bpuh2O6iPW8BYwVPuYo=;
        b=gkCeYdJatw7igkk2aK8sIdyamQHpJJDqCfzeFQbDf2QdM6wEdjoo3pgGPBZ/VQ2rCK
         5SXbqGtipGvPHi7eSevO2BMl9O8STKUwEqQksCiVlkBPe3y5A2Vkgir07rqUZq2KbQo/
         5rOEml9oq0vLcQMl4/cgDmF5U9lZoy+409Y/sZdkvhV6R6fT+dQ1/HEtqoIX/zYYmKyu
         yA2EvkrQb/M2NwXdzUsuYD3RE/mOzFUgS5U6iMbiecWzFayXXxE5EvbWAc2cNb7hHVh5
         hnKLgqE3iK7VF1IAQjQZGlGqIi37jVpISjW7zrnS9twtYhIq0hAuA5ZK2bIOOaxFnLZM
         fm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=coMaeMgwYndIuacusZtcjMM2Bpuh2O6iPW8BYwVPuYo=;
        b=SvtwtzbkIsbIFbglZkmfjgFurW5evTpTWU1wvoybBGAnwEKDifosiJAMqnIKBIM94z
         3eD4f9GRh8FVWgtkFb0TtgK8bpQd9n7TnSfy0Vc1nv05cCCy26wZQAHKJHZM/kwyiI4o
         qkVfjMrjLPqax7hM6gvLIlCQY/8JV2/fR1UEUKXjixqBLwo3v3CWhiknji3EUKXvnNC2
         z9v2r9WYp0wvNtxuyOGoZMZ6XShp6+PiKOqeK9lIVpXSUaR+gcCJsGxVWxdvlhJmZwkI
         4bSrgu9KRVAl4Sd/MOevrZtZy6U5QNPa9wvKwZRUOsF1gjczKGxkzBTAGUuHr36E6JQA
         AYzg==
X-Gm-Message-State: AOAM531ht14Pi7YCeiOWGXgJ17tlxRM2foeqW603PTYV5D2ziIlTHQhE
        skUm7hpu/0FVniRzfCiUI24=
X-Google-Smtp-Source: ABdhPJyVYSOxPTEHpvK9d/fG0S60rVOswnNg32MxML3ktLFfobsQHWxlfkCrCf5DOFYv6b5lAG2IQw==
X-Received: by 2002:a65:5c42:: with SMTP id v2mr11042664pgr.339.1615539767596;
        Fri, 12 Mar 2021 01:02:47 -0800 (PST)
Received: from localhost.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id e24sm4862903pgl.81.2021.03.12.01.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:02:47 -0800 (PST)
From:   Carlis <zhangxuezhi3@gmail.com>
To:     zhangxuezhi1@yulong.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: display: sitronix,st7789v-dbi: Add Waveshare 2inch LCD module
Date:   Fri, 12 Mar 2021 09:02:41 +0000
Message-Id: <20210312090241.98359-1-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Carlis" <zhangxuezhi1@yulong.com>

Document support for the Waveshare 2inch LCD module display, which is a
240x320 2" TFT display driven by a Sitronix ST7789V TFT Controller.

Signed-off-by: Carlis <zhangxuezhi1@yulong.com>
---
v2:change compatible name.
---
 .../display/sitronix,st7789v-dbi.yaml         | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sitronix,st7789v-dbi.yaml

diff --git a/Documentation/devicetree/bindings/display/sitronix,st7789v-dbi.yaml b/Documentation/devicetree/bindings/display/sitronix,st7789v-dbi.yaml
new file mode 100644
index 000000000000..6abf82966230
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sitronix,st7789v-dbi.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sitronix,st7789v-dbi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sitronix ST7789V Display Panels Device Tree Bindings
+
+maintainers:
+  - Carlis <zhangxuezhi1@yulong.com>
+
+description:
+  This binding is for display panels using a Sitronix ST7789V
+  controller in SPI mode.
+
+allOf:
+  - $ref: panel/panel-common.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - description:
+          Waveshare 2" 240x320 Color TFT LCD
+        items:
+          - enum:
+              - waveshare,ws2inch
+          - const: sitronix,st7789v-dbi
+
+  spi-max-frequency:
+    maximum: 32000000
+
+  dc-gpios:
+    maxItems: 1
+    description: Display data/command selection (D/CX)
+
+  backlight: true
+  reg: true
+  reset-gpios: true
+  rotation: true
+
+required:
+  - compatible
+  - reg
+  - dc-gpios
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    backlight: backlight {
+            compatible = "gpio-backlight";
+            gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
+    };
+
+    spi {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            display@0{
+                    compatible = "waveshare,ws2inch", "sitronix,st7789v-dbi";
+                    reg = <0>;
+                    spi-max-frequency = <32000000>;
+                    dc-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
+                    reset-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
+                    rotation = <270>;
+            };
+    };
+
+...
-- 
2.25.1

