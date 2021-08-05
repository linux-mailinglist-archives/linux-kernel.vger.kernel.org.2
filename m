Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36DD3E15CF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 15:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241731AbhHENg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhHENgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:36:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1128C061798;
        Thu,  5 Aug 2021 06:36:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id n17so8460655lft.13;
        Thu, 05 Aug 2021 06:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mNdeGEyYX1Vak0yu5eX0oZPh2UxD5oz0hL7/3gRiNyk=;
        b=vhZcQU3qfAt4jVnlRw/nE92RmQglKTGg4BCiGYuFgGasGiqf8140REhuR/54jRZ4Pa
         onddDyNja+1LmxLOEx76bb/31BD+W0IIefFUz+lE9hV+0HmiDe2XKEgdxDtEHXepcgYu
         ReUwwaGh9URhRMMDooRj8+D7VZCS/HjTK643mVnEr5ptc439ueVWMIysBk/a9wrmZmYV
         cgyaRQKH4vtL7w8dVLqIKNpio0qQvsVtb+uD9Z2ZpbN5guNwiKk998x9LfL1k+IhwJRh
         XJ+5XzQbDZkmR97tkMJKATFDKo+J+UdGMyiCReDPtXx2J0nZlYTeYx+wRJFXpVRbGgGZ
         7DBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNdeGEyYX1Vak0yu5eX0oZPh2UxD5oz0hL7/3gRiNyk=;
        b=TD1LZXHssXeR4Ou1rtcn91PvwQOnA6Amn0iSZOPGksN6LK8ut+8KuWzYhJWgVE3iq4
         FDcUFIs/GqbgqBlKnHVTFdMfGjnKHydjSYFy61qEEgqzdEP4BTYFBoVTaOGcj6Fhzi10
         V5AHnvifgOVffpFIxSua8Yx8clYf3XOL/gK0YUDtOuOkfyQttq+tHizo93RoPQBQDL22
         Go/7D8hJ9ZcDc2I+dS1kP8/JIxswv/iGrXQLFUByhmS6iOi/t5V7FDs5QegYXZqhbp4Y
         X/l6T1OQxT6moyHuSCyLgvNRxYhgXDwAdlXYLOjFgIH92OyadCkIziPAbEU90NbFezGm
         s99Q==
X-Gm-Message-State: AOAM530+R7Cy5K4zIvRyRKUVH9Hs+39xTju5qK/JlvO5i8+DpjzNCTNE
        1qnJn7GGSuYT5+U2qMMY6/ru+gzJsLTbvTVr
X-Google-Smtp-Source: ABdhPJy89JuYANp5EKu4gO9k819XSWANUU3lrYA/Dz6aWp+F2m9j/kBLxMKQH/RmHp/gwNROtTh5eQ==
X-Received: by 2002:a05:6512:3c9a:: with SMTP id h26mr3774206lfv.300.1628170569895;
        Thu, 05 Aug 2021 06:36:09 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id t3sm516232lfe.241.2021.08.05.06.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 06:36:09 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] drm/panel: Add DT bindings for Samsung S6D27A1 display panel
Date:   Thu,  5 Aug 2021 16:33:41 +0300
Message-Id: <20210805133343.27032-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805133343.27032-1-markuss.broks@gmail.com>
References: <YQmG6EbBherV+8px@ravnborg.org>
 <20210805133343.27032-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds device-tree bindings for the Samsung S6D27A1 RGB
DPI display panel.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../display/panel/samsung,s6d27a1.yaml        | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml
new file mode 100644
index 0000000000..c6c534aa87
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,s6d27a1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S6D27A1 display panel
+
+description: The S6D27A1 is a 480x800 DPI display panel from Samsung Mobile
+  Displays (SMD). The panel must obey the rules for a SPI slave device
+  as specified in spi/spi-controller.yaml
+
+maintainers:
+  - Markuss Broks <markuss.broks@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,s6d27a1
+
+  reg: true
+
+  interrupts:
+    description: provides an optional ESD (electrostatic discharge)
+      interrupt that signals abnormalities in the display hardware.
+      This can also be raised for other reasons like erroneous
+      configuration.
+    maxItems: 1
+
+  reset-gpios: true
+
+  vci-supply:
+    description: regulator that supplies the VCI analog voltage
+      usually around 3.0 V
+
+  vccio-supply:
+    description: regulator that supplies the VCCIO voltage usually
+      around 1.8 V
+
+  backlight: true
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  spi-max-frequency:
+    maximum: 1200000
+
+  port: true
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+  - spi-cpol
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        compatible = "spi-gpio";
+        sck-gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
+        miso-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+        mosi-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+        cs-gpios = <&gpio 3 GPIO_ACTIVE_HIGH>;
+        num-chipselects = <1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "samsung,s6d27a1";
+            spi-max-frequency = <1200000>;
+            spi-cpha;
+            spi-cpol;
+            reg = <0>;
+            vci-supply = <&lcd_3v0_reg>;
+            vccio-supply = <&lcd_1v8_reg>;
+            reset-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
+            interrupt-parent = <&gpio>;
+            interrupts = <5 IRQ_TYPE_EDGE_RISING>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&display_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.32.0

