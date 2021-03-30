Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D8E34E2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhC3IPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhC3IPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:15:15 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D408C061764;
        Tue, 30 Mar 2021 01:15:13 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h25so11188133pgm.3;
        Tue, 30 Mar 2021 01:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3gDOC0Z8XAHbqFwCKdnmHJhX1d7vqsYcID7spPCLu5I=;
        b=pGCNEDaTrN3AHSTGljZgtNy5UYQtAcSOIdS0yv7w1jopGUUYzsIS6WjcT/JHAd2GOV
         YwV/D9YJNr6dany6dy6hcm1wLekHfBihFXlCdsrdDEXQG6AJ3exPJPPT+SMA4t6yGX4T
         s+fbUUhfsoFRmnMM8jFcYatzrYqEdP3+kAMFjI9vwtLxMYLfKQ0yHzkmcIKGDO54jzSz
         Na7+EujqqnAXCbwkPG2YYjxJ6dzn+d36xycvEGF/St3VleFR1EJlIhW35rFKLbS9gnjN
         gutr+YWB77FVgmpasJyJLu4QIFrfXOmdAEE8Rj89MHzBIjXzpfd9xnj7AgduAtnC/55/
         XQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3gDOC0Z8XAHbqFwCKdnmHJhX1d7vqsYcID7spPCLu5I=;
        b=osYRJTFl14slRGVDuoARBf4Gjfhl3wFFUZalmvSKLRCEltPsJOHLvjtFK93hdvTcw/
         M6tl7QUaAHaSdofCh/pPz9d2ZkD/QQb+ABYRc7CbBEJeQNXSXP7akWviewohJYT7/Gfj
         fptbiOBcsw+soaqQ4W3Wd4GNUOpIi1Oofcsft2lhr6gOvJqE+Ygezj7f63yDHxOqNf9W
         t2lhNNXa5EIjSeTzfBcdiu+tsCUJ37w+8L1IfhheROnu9IP7G6YVuwgU9Q9G62HYjClf
         P1EKdgjml47hJJ8w9Od2FsVv1TqyFvIF6xufl+MCvG3UbDih1EU19UbkuBLZuXtr9s0f
         ZkkQ==
X-Gm-Message-State: AOAM532c99t7SLFsKIqoq9PTGwjMhYvovMgrc7m3BuIpPd2P1atNDS0N
        lmQ7df2QvGnLtKSU3RVBRT3Nm3wQRVWBjY/a
X-Google-Smtp-Source: ABdhPJxg6ZAutLMLoP1f0Pv7BdtYsOfweV3TfVh6CMeUI036JsmhfN+aCX8NawWvcWOk66blgOnprg==
X-Received: by 2002:a62:dd8e:0:b029:20a:309:2fcd with SMTP id w136-20020a62dd8e0000b029020a03092fcdmr28785940pff.35.1617092112627;
        Tue, 30 Mar 2021 01:15:12 -0700 (PDT)
Received: from localhost.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id f20sm19496672pfa.10.2021.03.30.01.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 01:15:12 -0700 (PDT)
From:   Carlis <zhangxuezhi3@gmail.com>
To:     david@lechnology.com, zhangxuezhi1@yulong.com, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] dt-bindings: display: sitronix,st7789v-dbi: Add Waveshare 2inch LCD module
Date:   Tue, 30 Mar 2021 08:15:05 +0000
Message-Id: <20210330081505.116351-1-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Xuezhi Zhang" <zhangxuezhi1@yulong.com>

Document support for the Waveshare 2inch LCD module display, which is a
240x320 2" TFT display driven by a Sitronix ST7789V TFT Controller.

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>
---
v2:change compatible name.
v3:change auther name.
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

