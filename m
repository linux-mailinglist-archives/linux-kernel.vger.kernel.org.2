Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD5534F736
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhCaDGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbhCaDGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:06:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69D7C061574;
        Tue, 30 Mar 2021 20:06:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id s11so7463968pfm.1;
        Tue, 30 Mar 2021 20:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PuKYh+7/SwWSPDSj+RYvOzQGYT9KgG+npGBidcALI1g=;
        b=XiALZjoTAsRF7SAeMMjlGFO8GhBInfT4x9TKG1O8oDyv4Cdre3FinqAs6Oee+/rPHj
         yfaB9/rCPTBxLeXchHnFUuPISOkVNQN7QTOnofxsPr2o7WlpwObTDL/7qFAZblFfc5bb
         b2tjTes9GmLB53p+ocMYZSfYgnap2HAXZbcFGXE5hYzZatgmwUB1IIDkYv3ZZ0NqDFWw
         8b1Hx5jM4b7bkP7wJbmAGBqMbLJJWVzMZbWHXzjWiFVWRlo0PWBY7DGa8x18hA201YLC
         FxsW6VUEDmZcvIcEyHxBtbo/Ui5b9UvbYvMGJnypaEEKvv/YHENUelrNCKF1NA0ZARCn
         r2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PuKYh+7/SwWSPDSj+RYvOzQGYT9KgG+npGBidcALI1g=;
        b=Jq3PmhmW/P96zc6u+oLYkueHXWTbyln/En6LFK1tTxiOFxQqcSEkCOeNX9seJtXcdl
         dm1hgxWv6IXrK/qDVngsOHrAdDFIbm7oyJLMBGsl0TIXF8MGAnVXGRujf1iIBSL4GSrY
         XiHSn+XyYcTAQGCugnqT4SVNxXg/oG8Mi0x6rDnuDg0WRJi1E6Tfiu062s/6UQWVGSWb
         jKz/7GLTaVhEHPLbV/Wt9UFlcR7vNAQyPOI9Dye/mZOm/O39NI5UiIuW0SnilT3mWbqb
         /ElPtawHrAiaULHv+jn1q6GwC5ieExC8ofd/lkmUII8Zi/T9ljHMBkuQnAhioK8WjF2x
         BZEw==
X-Gm-Message-State: AOAM533uokwV2uAfCIH6gZUmRT3kUXZ1BDcVPmNxFsa88WtAtgWK4PKt
        bSW41WrvW1meqaFJ94Bvv9Y=
X-Google-Smtp-Source: ABdhPJzQYTt2Way0sS/KW989AK9p50mQqMVE4ZaUwaIuW7ErKJSZl02r21d7UXdbl4LVyBrSaiiFGQ==
X-Received: by 2002:a63:5805:: with SMTP id m5mr1142689pgb.370.1617159998273;
        Tue, 30 Mar 2021 20:06:38 -0700 (PDT)
Received: from localhost.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id k21sm375376pfi.28.2021.03.30.20.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:06:37 -0700 (PDT)
From:   Carlis <zhangxuezhi3@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, zhangxuezhi1@yulong.com,
        robh+dt@kernel.org
Cc:     sam@ravnborg.org, kraxel@redhat.com, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/2] dt-bindings: display: sitronix,st7789v-dbi: Add Waveshare 2inch LCD module
Date:   Wed, 31 Mar 2021 03:05:50 +0000
Message-Id: <20210331030550.119493-3-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331030550.119493-1-zhangxuezhi3@gmail.com>
References: <20210331030550.119493-1-zhangxuezhi3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuezhi Zhang <zhangxuezhi1@yulong.com>

Document support for the Waveshare 2inch LCD module display, which is a
240x320 2" TFT display driven by a Sitronix ST7789V TFT Controller.

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>
---
v2:change compatible value.
v3:change author name.
v4:delete a maintainer.
---
 .../display/sitronix,st7789v-dbi.yaml         | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sitronix,st7789v-dbi.yaml

diff --git a/Documentation/devicetree/bindings/display/sitronix,st7789v-dbi.yaml b/Documentation/devicetree/bindings/display/sitronix,st7789v-dbi.yaml
new file mode 100644
index 000000000000..79eb8f3fc25d
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
+  - Xuezhi Zhang <zhangxuezhi1@yulong.com>
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

