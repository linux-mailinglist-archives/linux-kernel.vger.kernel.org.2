Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E983E358E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 15:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhHGNbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 09:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhHGNbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 09:31:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80863C0613CF;
        Sat,  7 Aug 2021 06:31:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z4so14875011wrv.11;
        Sat, 07 Aug 2021 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kk2TIJBnBsHrY0AgCcZBpUvM/otmEEmZg6Qy6Fa8m0w=;
        b=mcZnW5oS+yRq1JQFhADJdjJ+Qm3qDs+lxYg17QHokll9uTbhTK//RiWJo+aHcMksu+
         8VWX31qHEedTdcshDWsou2q6xut1GrDetkPpVyphRKnjLbb/I04knHy4Pu2ufVmNjcJN
         zG9mx5k03gNJuzyK/p6y9/pwc7hP2a9k21pUsMavxza9N+OctSkQ4jDsL4KxkxoPm3K+
         koBlnyHfNzIrHqN6AQTfroHl9viudqj6hl56/CnhtHFVohrA9CG0jkHruMaRfyGbliPa
         eOjKI6OM3Q5R0jNQHktDE2168ug8DN+ZbUDwXkxejOEbQb/XNuaxkJ/2wDyZWiHUPlGx
         YICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kk2TIJBnBsHrY0AgCcZBpUvM/otmEEmZg6Qy6Fa8m0w=;
        b=F+8/AtFY0ksCtCY1IPl2d/NTLKpoOlZoz1qmkLO4Lny1EFvmr2/ICOXDn8/gs1QsGA
         OS03xvW2ynFDoKQ/615PVzkF9e3BFfPI1feShkLjM8gOI3FHLgKV6Jm67OdJUDh6e/KG
         41NaF+grNqC4IDqQLNjQVVaGaNLSzvahpSXpaWhofwmuOFVjU69uQzTYGVvQutc1QnTF
         ji6fSxZBenKvM6vD6YKfgG2FNZysWebnYIDDu8A6C+z5T59dIcZSkaIX2gi0pvlBksGS
         PjAm5fdseMvHwaE7CnjEF0pl6BP/JShhcbnFPom3N/srI62pAc4CjE2YbifAdGArrsJw
         4uGw==
X-Gm-Message-State: AOAM533Cp1JAeUxd9wnT6hIECFIb86k6Xd/y4ZlhGyVEhaw+rWxoA2SN
        k4A1YBS7SKlOj1fST26Kxo/UE0NxIIFSS9ht
X-Google-Smtp-Source: ABdhPJyKb3aiwWpDg94pDY+FHs78zd+4PsHG9ofn+rnRt8EnDFCf7TEcA3wtFnsf47dGAKd0uJodnw==
X-Received: by 2002:adf:cf07:: with SMTP id o7mr15662037wrj.216.1628343084070;
        Sat, 07 Aug 2021 06:31:24 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id x12sm13254454wrt.35.2021.08.07.06.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 06:31:23 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>
Subject: [PATCH v2 1/2] drm/panel: Add DT bindings for Samsung S6D27A1 display panel
Date:   Sat,  7 Aug 2021 16:31:10 +0300
Message-Id: <20210807133111.5935-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807133111.5935-1-markuss.broks@gmail.com>
References: <YQw7M7OF6OZLcLjk@ravnborg.org>
 <20210807133111.5935-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds device-tree bindings for the Samsung S6D27A1 RGB
DPI display panel.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>

v1 -> v2:
changed additionalProperties to unevaluatedProperties;
added vci-supply and vccio-supply as required;
---
 .../display/panel/samsung,s6d27a1.yaml        | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml
new file mode 100644
index 0000000000..26e3c820a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml
@@ -0,0 +1,98 @@
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
+  - vci-supply
+  - vccio-supply
+  - spi-cpha
+  - spi-cpol
+  - port
+
+unevaluatedProperties: false
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

