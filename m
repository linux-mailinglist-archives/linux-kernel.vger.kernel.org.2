Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBA83BE97F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 16:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhGGOQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 10:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhGGOQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:16:27 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D03C061762
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 07:13:46 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q184so2366992ljq.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 07:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=phystech-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D48upNITuZQ7GxH7t+3W6Zs1sM24tqoIWBJvLBt11aY=;
        b=kumI8yaxyXNAjfsGRunvWWmZwcXMYZe8/wCQAMwBdcpsgxLWJaSQ2A+OySWdvoLjYL
         aJI2+0W2ray3WizYeDGQsiEo+yZ7c0MO+XcngdKRGO7uXDzllfbJHUVuZykg55KywFlD
         WxJ1R1kwR6JjPH6ylkLAHzNFS/uUBqCBlWbuUF9+wo+LhKkwnr0kT0Qr3MM9gSbwoAKG
         JV+VuZFqHj+ZaOsunJvMG+L4Ui+fwGnt63sLQ23aDuEeg7q7ehhTfhDUb7ie2WlHAGZG
         Wel9HxdCRPKYDdeuJCbdo63G48z3FryA2rJEHV1Evapb+D28ys/uro7iMWHTWIVhZT6L
         cjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D48upNITuZQ7GxH7t+3W6Zs1sM24tqoIWBJvLBt11aY=;
        b=WUl0lZa6WevJF/a4ADQAOzclD7LZGSBffUIU43rbXnfedwox3kN1HUT4iqqhLyFrwS
         IctaswCqniJTyzUjQi7KlNZ3Y3c+rILPfZ7x5N/HUn8bEqzwq/8x3z/hUUHXE8L+efV/
         TOq1Bz0NlopW2ZeOya+PZ7SlJLany5rCFhVmzMZaSWAmxd4AKjAoRqToeUt1KOvNU6oq
         FHkziKKKRpJnkBORWQya9EfGMNNXPv6Ij1o1SjhrGOMJ5WW4pXVVZjrUlk4bKdJx4uhM
         kwb6NGqhrjrO9LMZa88bPsrzncwmIkC3m8LF/3QiBkkjUJC70tUvGiKo4263EIpO1f56
         C3UQ==
X-Gm-Message-State: AOAM532pRQRyfjMRW8RH8Nr+e9D8flirrZEbdjKXUwV3p1tP4alEbbZO
        q30ig1xBIyx2ywH25d0q1Wz3jQ==
X-Google-Smtp-Source: ABdhPJwFuTbf0DDVJF2QxYY3TBGA3dij2GWhA8mkPDMipPjERDQrxv5hPiRoDq9+mSPRZFQbH14/cg==
X-Received: by 2002:a2e:7306:: with SMTP id o6mr19670986ljc.125.1625667224544;
        Wed, 07 Jul 2021 07:13:44 -0700 (PDT)
Received: from 192.168.1.3 ([2a00:1370:810e:abfe:9c62:44e3:b0ab:76fd])
        by smtp.gmail.com with ESMTPSA id a26sm205077ljq.120.2021.07.07.07.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 07:13:43 -0700 (PDT)
From:   Viktor Prutyanov <viktor.prutyanov@phystech.edu>
To:     sean@mess.org, mchehab@kernel.org, robh+dt@kernel.org,
        khilman@baylibre.com, narmstrong@baylibre.com
Cc:     jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, rockosov@gmail.com,
        Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Subject: [PATCH v2 1/2] media: rc: meson-irblaster: document device tree bindings
Date:   Wed,  7 Jul 2021 17:13:22 +0300
Message-Id: <20210707141323.20757-2-viktor.prutyanov@phystech.edu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210707141323.20757-1-viktor.prutyanov@phystech.edu>
References: <20210707141323.20757-1-viktor.prutyanov@phystech.edu>
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

 .../media/amlogic,meson-irblaster.yaml        | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/amlogic,meson-irblaster.yaml

diff --git a/Documentation/devicetree/bindings/media/amlogic,meson-irblaster.yaml b/Documentation/devicetree/bindings/media/amlogic,meson-irblaster.yaml
new file mode 100644
index 000000000000..711b7e029275
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/amlogic,meson-irblaster.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/media/amlogic,meson-irblaster.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson IR blaster
+
+maintainers:
+  - Viktor Prutyanov <viktor.prutyanov@phystech.edu>
+
+description: |
+  Some Amlogic SoCs such as A311D and T950D4 have IR transmitter
+  (blaster) controller onboard. It is capable of sending IR signals
+  with arbitrary carrier frequency and duty cycle.
+
+properties:
+  compatible:
+    oneOf:
+      - const: amlogic,meson-irblaster
+      - items:
+          - const: amlogic,meson-g12a-irblaster
+          - const: amlogic,meson-irblaster
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
+  mod-clock:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/g12a-clkc.h>
+
+    irblaster@ff80014c {
+      compatible = "amlogic,meson-g12a-irblaster", "amlogic,meson-irblaster";
+      reg = <0xff80014c 0x10>;
+      interrupts = <0 198 IRQ_TYPE_EDGE_RISING>;
+      clocks = <&clkc CLKID_CLK81>, <&xtal>;
+      clock-names = "sysclk", "xtal";
+      mod-clock = "xtal";
+    };
-- 
2.21.0

