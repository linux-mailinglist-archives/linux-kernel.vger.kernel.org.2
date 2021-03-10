Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57D3333FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhCJOIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhCJOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:08:26 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74BFC061760;
        Wed, 10 Mar 2021 06:08:26 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id s21so1196846pfm.1;
        Wed, 10 Mar 2021 06:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tBolFQ1x2rNRaMhk8uUnuZteScWBmrRscFwYnmlVlLM=;
        b=NC67tWn9Zz+V51f/hWtxsUzbDZ4INedGgotRy1QUl6bRbLuEKwy+fEXP0i07mTYM+K
         Vresn4aZqR2Deuh1QUuIBzSBn+llkgG56uOUosGun0aj77dq0+ue3yaMs9/PBvHKs2w8
         Lo1meQrZFrBQSy+JXtBLxQNNqWFwpjfTQyzR76gUHV+CsRG/dvTmlpdYxQsHgAts0dLg
         nbEDHLOQTunUlV38YsZdO9OD9nBYYqQT6TAMM/G7ULdqmflr8jEVbXrV53aLkUCdvlDF
         MrLKRzPQSYcfh6jzDVp62EejkO+MlG2F0+jbfD60KSIK6scv0V/rjP1Oz/MpNmK6vAvw
         YrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tBolFQ1x2rNRaMhk8uUnuZteScWBmrRscFwYnmlVlLM=;
        b=hy/P+UAFKemb9mjm3wsxlSrwhvBclemHLQossRMud1PNP3aN7GHgqZETePoPyBMCT7
         4M71ZDyp5S+ADhHV490Lq6zYitN20qrnXXKT8P7VkQYIrcZdu92vB/CbFs/De4vYT12K
         Q8TqzK2/DuBXjc7oOrtKXAu0LVz6a5zD6zfUfvU3cZ0GLZSc6JYDsCPi1hSyZ2o2922D
         tKpgh2sP8vVVSWGXTJBDA066Oc8RV12I4G1jv0sV/4OzixTDIxrFqp4ab9G4LK5QxTnI
         0Ttlxyg1XzNtl9UwMT8NYaNz6vGQVjq6Ah7eG8Fk3fw3CODCkGcZgqGNYOxWpOAG0pe1
         miNg==
X-Gm-Message-State: AOAM531Mqb8uzZGdTuIqClx1aWf0v9fWURtX0ATYhu7/twFE0hyXh38e
        2iLw+nUdFZ3vXOr5/q0paPs=
X-Google-Smtp-Source: ABdhPJynonVj9YRFbVmgszHf+Qi3NNAnFYN3UzFg5ezxSROchVMTZ7qZNJi9sYU+kdrAQWLGAhNALQ==
X-Received: by 2002:aa7:850a:0:b029:1fc:ccaf:5d5c with SMTP id v10-20020aa7850a0000b02901fcccaf5d5cmr3025497pfn.80.1615385306290;
        Wed, 10 Mar 2021 06:08:26 -0800 (PST)
Received: from bf-rmsz-10.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id s76sm16413671pfc.110.2021.03.10.06.08.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Mar 2021 06:08:25 -0800 (PST)
From:   Carlis <zhangxuezhi3@gmail.com>
To:     zhangxuezhi1@yulong.com, daniel@ffwll.ch, robh+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: sitronix,st7789v: Add Waveshare 2inch LCD module
Date:   Wed, 10 Mar 2021 22:08:35 +0800
Message-Id: <1615385315-130920-1-git-send-email-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Carlis" <zhangxuezhi1@yulong.com>

Document support for the Waveshare 2inch LCD module display, which is a
240x320 2" TFT display driven by a Sitronix ST7789V TFT Controller.

Signed-off-by: Carlis <zhangxuezhi1@yulong.com>
---
 .../bindings/display/sitronix,st7789v.yaml         | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sitronix,st7789v.yaml

diff --git a/Documentation/devicetree/bindings/display/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/sitronix,st7789v.yaml
new file mode 100644
index 0000000..8a0f21a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sitronix,st7789v.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sitronix,st7789v.yaml#
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
+              - waveshare,ws-2inch-lcd
+          - const: sitronix,st7789v
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
+                    compatible = "waveshare,ws-2inch-lcd", "sitronix,st7789v";
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
1.9.1

