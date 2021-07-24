Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D291A3D4495
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 05:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhGXDEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 23:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbhGXDDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 23:03:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A2DC061575;
        Fri, 23 Jul 2021 20:44:19 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so11665737pja.5;
        Fri, 23 Jul 2021 20:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HIJcQQZ2vH+eFbl0b4W6tu/X9LzbnNwvqBiC4k0Fytc=;
        b=Rhy1OnFnUKa0pETJY0jQAisJa+DRiS52JW6k5vDI0UHWc2fPfyzOTD5AZaL23+kZ7l
         nZRoRZwbXBq0iY5q7NOk4qyYUZHzANGHCEy/YxrctYMraVJzF6hNyct4BBReHmBCzj96
         JoFXdR2IUCX8Qa0Emoosr2/rm80dI/SToFipvIsyiT68ySw13iUzCBNl6t96LMHCanDs
         Zl9DeeL6TtPQz0mDnvirfacYwXpPU8QBPQWF1kzQCeRKjeC6Y5U+T473nRgihVWgs2C/
         c6pYXIOARyeGdZz7ARm9pVbfxQ4qBCkLJvFZGZfipBPMdJ8V81mtyp9WvSmV7MKg4NjF
         V8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HIJcQQZ2vH+eFbl0b4W6tu/X9LzbnNwvqBiC4k0Fytc=;
        b=ekpWtFviwuMffzXTS4pVP2I87cmoiw31DceY+3C+I0t+gR0mMFSSjMNfUI1rLUk9SM
         TAVVJUgG9CLrTxxi8u3O0QvogdogBiNlyOL91suSGrbZxS/ZVnfQWtNh8xXZxTinHz2y
         KURYh0qX2wDlkY5CeGblBFPqXQRtoSCNCkK4Z6rNILLrW5zFfC5gJNwZGr1o/yMoJOc5
         c+bVdP5D4tSeeQz4u4OqBVkjEYcha2wJbYJaf+Ldy38T9RJrDL/SHwUkgoCCBjHfQ5/2
         ufnsKJZPfj8UP9LsCkNbhddFHcglvQ2i/MzjSXH0C2rfgaBmiSBehVUSUBIq4sojJVR4
         zYcQ==
X-Gm-Message-State: AOAM532pNS6g3iX9I8CBo2kuaUUOgfA8QPXgvNYi6LbquLyZ30qNwC9y
        xcbCEzbhLW73agcgoVCy62E=
X-Google-Smtp-Source: ABdhPJwlcOi0gv6VYmZqlsNpfU5gc7Otmsc5iwXbyyruTBTQ2bV1i83B8XYAsTNAxQnl3V6V9WZxBA==
X-Received: by 2002:a63:fe51:: with SMTP id x17mr7735764pgj.58.1627098258760;
        Fri, 23 Jul 2021 20:44:18 -0700 (PDT)
Received: from localhost.localdomain ([23.228.102.68])
        by smtp.gmail.com with ESMTPSA id c17sm35118733pfv.68.2021.07.23.20.44.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jul 2021 20:44:18 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     laurent.pinchart@ideasonboard.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, linus.walleij@linaro.org,
        alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
        noralf@tronnes.org
Cc:     kbuild-all@lists.01.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dillon Min <dillon.minfei@gmail.com>
Subject: [PATCH v4 1/3] dt-bindings: display: panel: Add ilitek ili9341 panel bindings
Date:   Sat, 24 Jul 2021 11:44:01 +0800
Message-Id: <1627098243-2742-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1627098243-2742-1-git-send-email-dillon.minfei@gmail.com>
References: <1627098243-2742-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dillon Min <dillon.minfei@gmail.com>

Add documentation for "ilitek,ili9341" panel.

Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/lkml/1626853288-31223-2-git-send-email-dillon.minfei@gmail.com/
---
v4: no change.

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
1.9.1

