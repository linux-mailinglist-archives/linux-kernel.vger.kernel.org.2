Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D828F3D09F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 09:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbhGUHCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbhGUHBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:01:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93642C061766;
        Wed, 21 Jul 2021 00:41:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gv20-20020a17090b11d4b0290173b9578f1cso520271pjb.0;
        Wed, 21 Jul 2021 00:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n6ei/14DVfwbmyUg2CaUeORvt7ARyvKM0pVLkX4lBpQ=;
        b=dh8NNOGfvF4zrfy/ykeWjlLud5qJzKqOnfZOMsJp9rSFYQlln9F4uXJr0+E4N7xXJJ
         vbH0VPWIX7ubrcelc7b4dCNVSFtO2m8SJHFLkLJW1/eYs5GD9iE7OxInaQVmz1xmUygH
         ZVv5N203A/MZkzz2Lx/LrZBQjnyYSe7hum5KG+t4NCAPDn5oJ8jtI1zANR+pRMa3EbEm
         eewpWGg5ZfvEMmkOn6zoxrGSKNOCNCwzM6pjXYlX1NBFr9x/AetKJbivzFe11OefpGeR
         zlulxJUMKmMv6tf7QngOmKdSOMzQ7usC+rMCRx+2wwHeiTsBeMeSXOGxDVK4C3BjYzap
         dQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n6ei/14DVfwbmyUg2CaUeORvt7ARyvKM0pVLkX4lBpQ=;
        b=qk3dIRqXnlnxuSSQp8kJ8E4hdXYEN5ssIzQMa7KMRDvnDQDxG6OgDgQ6sxGzHd44S1
         3JNAy4I4py0C7V02di2xWTMJVKX4caM9wxUGcqncawxNer5XZDMDAqpw4L8jdRFquGxl
         eI5Fv0bTX55ialvhoWLf75C314uMf588i/e40dhFjqFRq5xYmYqiGaVwtBQN5zOZNA0Z
         7R6HEg3wfzMC8ou0iPrME9WP/24/4SV9zKhdwiJiMwlF2t7hrPSTuNIX5ZeEUx+pDFX2
         FHOWdsAdA11ZNGNF6uPJOJDuRjpo2YH7YoQeag1j/R5SKwv3phW/zw/Hy54rgloXexp0
         u7Qg==
X-Gm-Message-State: AOAM532uXJvBtdgwHegd7l+ph85qhrpxunFGGihA4TlsJVFXNcdvI2jy
        /fc23EFpZWrgADQ+Hl1UZoc=
X-Google-Smtp-Source: ABdhPJxsZm8Qd4VqoHrvx4ByRo/6aWAjSbf8dp+znoR9PjhsDNuBu6wI/rzIMOmgA8f3cZ7A9s2Uew==
X-Received: by 2002:a17:902:c105:b029:12a:5a94:6c3a with SMTP id 5-20020a170902c105b029012a5a946c3amr26833710pli.14.1626853299153;
        Wed, 21 Jul 2021 00:41:39 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id i8sm4841867pjh.36.2021.07.21.00.41.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jul 2021 00:41:38 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, linus.walleij@linaro.org,
        alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com
Cc:     noralf@tronnes.org, dianders@chromium.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dillon Min <dillon.minfei@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: display: panel: Add ilitek ili9341 panel bindings
Date:   Wed, 21 Jul 2021 15:41:26 +0800
Message-Id: <1626853288-31223-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626853288-31223-1-git-send-email-dillon.minfei@gmail.com>
References: <1626853288-31223-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dillon Min <dillon.minfei@gmail.com>

Add documentation for "ilitek,ili9341" panel.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
changes in v2:
- add {vci, vddi, vddi-led}-supply bulk regulator according to linus
  suggestion, thanks.
- add DBI panel in D/CX description.

 .../bindings/display/panel/ilitek,ili9341.yaml     | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
new file mode 100644
index 000000000000..2ed010f91e2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9341.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek-9341 Display Panel
+
+maintainers:
+  - Dillon Min <dillon.minfei@gmail.com>
+
+description: |
+  Ilitek ILI9341 TFT panel driver with SPI control bus
+  This is a driver for 320x240 TFT panels, accepting a rgb input
+  streams with 16 bits or 18 bits.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          # ili9341 240*320 Color on stm32f429-disco board
+        - st,sf-tc240t-9370-t
+      - const: ilitek,ili9341
+
+  reg: true
+
+  dc-gpios:
+    maxItems: 1
+    description: Display data/command selection (D/CX) of this DBI panel
+
+  spi-3wire: true
+
+  spi-max-frequency:
+    const: 10000000
+
+  port: true
+
+  vci-supply:
+    description: Analog voltage supply (2.5 .. 3.3V)
+
+  vddi-supply:
+    description: Voltage supply for interface logic (1.65 .. 3.3 V)
+
+  vddi-led-supply:
+    description: Voltage supply for the LED driver (1.65 .. 3.3 V)
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - dc-gpios
+  - port
+
+examples:
+  - |+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel: display@0 {
+                 compatible = "st,sf-tc240t-9370-t",
+                              "ilitek,ili9341";
+                 reg = <0>;
+                 spi-3wire;
+                 spi-max-frequency = <10000000>;
+                 dc-gpios = <&gpiod 13 0>;
+                 port {
+                         panel_in: endpoint {
+                           remote-endpoint = <&display_out>;
+                      };
+                 };
+             };
+        };
+...
+
-- 
2.7.4

