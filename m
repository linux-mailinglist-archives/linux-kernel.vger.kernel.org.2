Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F318C3CB5E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhGPKXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbhGPKXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:23:47 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E8BC06175F;
        Fri, 16 Jul 2021 03:20:52 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t9so9520981pgn.4;
        Fri, 16 Jul 2021 03:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uwvb3QWku+HNovH19DlhDz0b4w6Vu5NMYC9MHw5EcPM=;
        b=KwueLB6SEOIvNcXwpAvMp4AbdQfduP3fAkeNyfZBcHiOLPzPKjbMF4oIMk3dHea7ue
         HyOI+Fx3Rj94cdRsFt3c8jef3xKdrFjptu4lZVHdqqb2lM7oBB7GwXZK5/MYhOEydA1U
         ltEz5C4j0WcMYFLK0d9SY0pGfmmAUA400qx43duaJNT1CSswGTPsXHEP+RI2IFmVKHmQ
         Z73LHVnEQcqFwrhPoK9jzbSQwjJyhhIAp6tQ4hJMwbLDvbZf6hcjeXKBjX8u7DRKYi6g
         OFDbDPVFUFp1Au4Se96+tnpjw6Nq/5gRSbH2uGrAHfnmA+cyM50UEs0BefHSdYSYapcT
         qh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uwvb3QWku+HNovH19DlhDz0b4w6Vu5NMYC9MHw5EcPM=;
        b=HRXykhrkJgMK8z674LHKfmI3lyhuqU+/Uees886BSCJfyug1F2+3KPBNX9OikAVOrf
         B9Lq7F61AsuQr2LCh3RBkLlU57nz9cEbzOm6A1mM5Mx2v4ywilzrb23ZbbnKHfEc5SZ9
         SxrWdbHF0WWVGUpfNs/V/0PN+tc/6vx/hbkYkBjPCOiw+LNibp39g2S5vbZ0g2r493UV
         EVjhqxufofhZ6ZeiNZoZbgekjv96eT1FOzqr+nKZrd3OeSU1oam79ZQBW4rR93eFTTRu
         sJZFjXYwibcuTZ6SRstLlC/oBxH50N3ybY9iV5e7bcfy//hM6pkqRglhRKrCUSJefEft
         BjKQ==
X-Gm-Message-State: AOAM530sT9kW86q2JDWo8PBiMBMlxPmzu6GXh/Rz5Z0zIzSVKW9Nz1Xa
        7kAdVvV4UsbLlejzhfY9P7KGoP8Gdmblo+OE
X-Google-Smtp-Source: ABdhPJzFtu7JjB2t0Zj1kRNmPyfIWq0L24tJIZ1LdUS6HEDrlpsVzcKp5Jcj1xs08LByu7MsdLtrMw==
X-Received: by 2002:aa7:8683:0:b029:32e:2a35:941e with SMTP id d3-20020aa786830000b029032e2a35941emr9892595pfo.44.1626430852131;
        Fri, 16 Jul 2021 03:20:52 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id f3sm8051285pjt.19.2021.07.16.03.20.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jul 2021 03:20:51 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     noralf@tronnes.org, dianders@chromium.org,
        alexandre.torgue@foss.st.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dillon Min <dillon.minfei@gmail.com>
Subject: [PATCH 1/2] dt-bindings: display: panel: Add ilitek ili9341 panel bindings
Date:   Fri, 16 Jul 2021 18:20:42 +0800
Message-Id: <1626430843-23823-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626430843-23823-1-git-send-email-dillon.minfei@gmail.com>
References: <1626430843-23823-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dillon Min <dillon.minfei@gmail.com>

Add documentation for "ilitek,ili9341" panel.

Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
---
 .../bindings/display/panel/ilitek,ili9341.yaml     | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
new file mode 100644
index 000000000000..2172f889af3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
@@ -0,0 +1,69 @@
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
+    description: Display data/command selection (D/CX)
+
+  spi-3wire: true
+
+  spi-max-frequency:
+    const: 10000000
+
+  port: true
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

