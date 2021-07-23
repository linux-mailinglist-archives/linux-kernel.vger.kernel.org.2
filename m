Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335B53D3371
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 06:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhGWD0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 23:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbhGWD0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 23:26:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24D4C061575;
        Thu, 22 Jul 2021 21:06:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j1so437950pjv.3;
        Thu, 22 Jul 2021 21:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B7rhomLLzwRgFfNNTM797mpLG3BiqS6x3e33hEPmJTQ=;
        b=SGgCTbvwYG1v+5tp6r3T4PLgjP/4PBx3FlYRSZedUbj8Q7Kly0YN2p2Q9sGasqkcP9
         zniQ+1QPUF/TaPtGoLFABC3ATUvZgbHOnbpFMc8DQQA6mijc9N8YXLNOo3bShwinLK2L
         mRCXD+rwSUYOescplYpusojv62U32AmIZNUWpSVEjoJxxKbIRdDCmyOLco577IjYeAeR
         HzseF5PMoRs2RJS33HBAft8nYJrTMnN6lUZ8YgkzvjOqwhaEgt4YUdtFroZ71fy/GQ2p
         Z71CdFvti5fjEzCU/KSQ9iT7fMlXcXipr4BQxQ5MY+0r4Gp06cZard3Ft6MBSKGvllsX
         mj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B7rhomLLzwRgFfNNTM797mpLG3BiqS6x3e33hEPmJTQ=;
        b=RWXMAncpcess+MJ2QS6nZKjdUnxZchCdBeFA3C7x9xcZduWthT/do3JizrSPlGs3vl
         YWsm2OSE3I//zHE5NYbry606kOOXttanPRXLIeSJw2qGuleMoB4tDRdRTnBBX7Kd8tMK
         /5YXqx3L4esaKXPPPPHujHwQPsWh3y+safjRKPBS74zNhWcSr98Nrr3VmSU6/pqHcQTz
         koDWhazCLJyo+s12tPUK1mmT0F9VkHi2B9kC0/7xEpBWp9sHITJBXO4w3xKdjVIG4wBH
         0XhBc9G2jlkuR+w7fKKpqiMa9RVoA4LutFUpLK5CHHrKr9ObsYcz8LPdiIbb7KmTaU9Q
         SScQ==
X-Gm-Message-State: AOAM530zKXU4xQLB4vR2ldyqHvUVqQCQZZP9Kmq04rPn0tcWQUaMHJWX
        97+5Tn3+WQXfakmW+OKo+Sk=
X-Google-Smtp-Source: ABdhPJykvEEecxAO8ZNgVcwsI6ew9t6mtT9/SC/ITDuPpUox4KucwUVfybx2mBKvkZiM9vXgiLdpFw==
X-Received: by 2002:a62:3344:0:b029:28c:6f0f:cb90 with SMTP id z65-20020a6233440000b029028c6f0fcb90mr2633175pfz.58.1627013213589;
        Thu, 22 Jul 2021 21:06:53 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id p3sm35474910pgi.20.2021.07.22.21.06.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jul 2021 21:06:53 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     laurent.pinchart@ideasonboard.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, linus.walleij@linaro.org,
        alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com
Cc:     noralf@tronnes.org, dianders@chromium.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dillon Min <dillon.minfei@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: display: panel: Add ilitek ili9341 panel bindings
Date:   Fri, 23 Jul 2021 12:06:41 +0800
Message-Id: <1627013203-23099-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627013203-23099-1-git-send-email-dillon.minfei@gmail.com>
References: <1627013203-23099-1-git-send-email-dillon.minfei@gmail.com>
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
v3:
- collect reviewed-by tags from linus.
- add link address.

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

