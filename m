Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931323C9317
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 23:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhGNVaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 17:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbhGNVaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 17:30:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39244C061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 14:27:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f30so6090501lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 14:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=phystech-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5CCIvm8hXSdx2TujpbrlXspL0g5sYIpZoqTCzlboviQ=;
        b=SfAs/I+2DbGppQtITLGjESg5X+D3FRGlEBimGSQ9WYfp9x3Z17g/7QQzjZ2IAd3CgU
         v5Lh3Z45mdmsv3mmEOSJy9/kdzDi15JmD9fFZ6qjP6wfhGv3IhHjm3k9FOeEPmNf3B+N
         xUoyXhUXOXJBcU9sd0H1zt9nXrlovXPATkYSUVuMzBInpSijGOPBm6Ep6yCMXwD5Ft6a
         zFDxwJnu0v7/LOleaIA8sW1LQtNxnqbb5iysqk4lK7VzcelQgJj47BrHSh08Tm46QYfW
         x6nYlsMu1SUR4qWfze6TrgW1wSIWp3cS+lfDcuayxHZxF9Y5UjrHZmY9MlBhum/8P60i
         ptcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5CCIvm8hXSdx2TujpbrlXspL0g5sYIpZoqTCzlboviQ=;
        b=qRrzfLCHAo9OngvSpWijlUbdfXEZwEpwpEgXAUtUxd2Q92dlETIop8NnWK9EfWNiU9
         5dQ4WMIAiPUAVtl0BFvDfWRxtR1NbILbZy0hS+vJD3EIxvG2LqYDBoSvk5swjev3clEy
         6yK74onYRFlgUP84GP0rXHRCKiMmsiUd3Yp4SL+U62jSZT8S3PTIUXtlENG7WKbb6JZb
         rgqtAya+ErQvMT2cMKNeSwgvRQwrbxMVuvj5jNiZI4d3GizgWDe0cFW+7ty0DBTMlNn/
         yW5ByjeltDY2STIRrDXuuGh/6nZt6UCJyE4oDT6x5oJc7LvdcAHWxRtIuOwYNMGT7dXM
         k6fQ==
X-Gm-Message-State: AOAM5339wzmyzl+MwXM0r+AWrmKcaVD3j+5IEgvBJ7XcUHHi40hhZ11u
        P3W3HEjl9Nsxl5guYJoWl0F8Og==
X-Google-Smtp-Source: ABdhPJxfJygMkZY4rn0G6iVdyhfLRNVktcKAFttAbaPnqwDALGzDASmXZ7+nQ5CltBFHfnBh6kA0eQ==
X-Received: by 2002:a05:6512:23a6:: with SMTP id c38mr190537lfv.78.1626298037592;
        Wed, 14 Jul 2021 14:27:17 -0700 (PDT)
Received: from 192.168.1.3 ([2a00:1370:810e:abfe:9c62:44e3:b0ab:76fd])
        by smtp.gmail.com with ESMTPSA id f1sm252156lfs.211.2021.07.14.14.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 14:27:17 -0700 (PDT)
From:   Viktor Prutyanov <viktor.prutyanov@phystech.edu>
To:     sean@mess.org, mchehab@kernel.org, robh+dt@kernel.org,
        khilman@baylibre.com, narmstrong@baylibre.com
Cc:     jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, rockosov@gmail.com,
        Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Subject: [PATCH v5 1/2] media: rc: meson-ir-tx: document device tree bindings
Date:   Thu, 15 Jul 2021 00:27:05 +0300
Message-Id: <20210714212706.24945-2-viktor.prutyanov@phystech.edu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210714212706.24945-1-viktor.prutyanov@phystech.edu>
References: <20210714212706.24945-1-viktor.prutyanov@phystech.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds binding documentation for the IR transmitter
available in Amlogic Meson SoCs.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
---
 changes in v2:
   - compatible = "amlogic,meson-g12a-irblaster" added
   - clocks, clock-names and mod-clock updated
 changes in v3:
   - mod-clock removed
   - max-fifo-level added
 changes in v4:
   - irblaster -> ir-tx renaming
 changes in v5:
   - max-fifo-level -> amlogic,fifo-threshold (fifo-threshold
     == 128 - max-fifo-level)
   - amlogic,fifo-threshold becomes uint32 in range [0; 127]

 .../bindings/media/amlogic,meson-ir-tx.yaml   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/amlogic,meson-ir-tx.yaml

diff --git a/Documentation/devicetree/bindings/media/amlogic,meson-ir-tx.yaml b/Documentation/devicetree/bindings/media/amlogic,meson-ir-tx.yaml
new file mode 100644
index 000000000000..88655413495d
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/amlogic,meson-ir-tx.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/media/amlogic,meson-ir-tx.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson IR transmitter
+
+maintainers:
+  - Viktor Prutyanov <viktor.prutyanov@phystech.edu>
+
+description: |
+  Some Amlogic SoCs such as A311D and T950D4 have IR transmitter
+  (also called blaster) controller onboard. It is capable of
+  sending IR signals with arbitrary carrier frequency and duty cycle.
+
+properties:
+  compatible:
+    oneOf:
+      - const: amlogic,meson-ir-tx
+      - items:
+          - const: amlogic,meson-g12a-ir-tx
+          - const: amlogic,meson-ir-tx
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: sysclk
+      - const: xtal
+
+  amlogic,fifo-threshold:
+    description: TX FIFO threshold
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 127
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/g12a-clkc.h>
+
+    ir@ff80014c {
+      compatible = "amlogic,meson-g12a-ir-tx", "amlogic,meson-ir-tx";
+      reg = <0xff80014c 0x10>;
+      interrupts = <0 198 IRQ_TYPE_EDGE_RISING>;
+      clocks = <&clkc CLKID_CLK81>, <&xtal>;
+      clock-names = "sysclk", "xtal";
+      amlogic,fifo-threshold = <32>;
+    };
-- 
2.21.0

