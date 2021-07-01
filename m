Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9CD3B8B2D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 02:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbhGAAY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 20:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238144AbhGAAYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 20:24:54 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5E7C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 17:22:24 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t9so4403078pgn.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 17:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HSdm070R4SM/eRkEfUHVyZ+M0Thpoj9fAA1Eqy/QCP4=;
        b=iDwJzjkg/Cb6xXcKJDcqkbedHRnU0N//h3MMRTg1+KnfRnJ9qoHHXuILtF5nlFNPto
         iGbKzvpVlyvCYQIRO74L9lyd8SjvhqGEx/t74r5T+zwGx1ahklXn/88A2YoeJpqyyQF3
         S++9jMJ/COOuShtlkkwQ3eJWPXVj8O4lYr53RtUIMFUBgPNHJnxHtQ3piI/m5Y6pp0Hj
         MrXHcnFcFRQbIUeX9jP8zLrY3jx3xXSVvqn8Jwudz/vVTOWDJ3ss3woHtWwfUDpyEi9v
         h0/SlzMlAMIfHY0xOxhvwFfFknUwaRARZ4jZQL2bFiHWmpyNvPw5YdkOuoivOpgvC/oA
         8tLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HSdm070R4SM/eRkEfUHVyZ+M0Thpoj9fAA1Eqy/QCP4=;
        b=g1zQHc/K9pux8aZAuD+fXQigJpRbRTzj5319IhQWsY5jSB5iYeLL2RzGTU7bVzZrhG
         9tEJ37NfKuJqOigvuaWANqLx7JeyyvUC8ZsmfbPMweJSSVdGOFob+rpJni7FowGIEp0y
         H31RmiCXWB7ed7cBKcfK9zhwKHXlcoVFEjziS3H3KpcocwWbn3sFS1q9QsRf2/A2pbHJ
         vdcO4yDAgVFSTgI2picTNk5lTh5QTBr4EQj0Jr6N+U2YOAEL9R7TzmznrIrvI8v1uj3F
         VO9Cwick0BZ5fpFQsvQVfh5XnDQgLdbQdK0gJYy7kbTRyplGknfLeWfY657rY3rbPqrX
         ySRQ==
X-Gm-Message-State: AOAM532iRa+wWOS105EqSUO+Drfws8yFzUxETw1c9wrR/wR6PSYuiJi2
        cU/kmWYd6LbXp7C3gK8P6Bi4kA==
X-Google-Smtp-Source: ABdhPJwSc0jIQ5LQ/MzvbgRgWdx1LngPkR32e6yXQdiDE/tHcpJn4TAdr2Bfkm/OdpsyZEgOtzaDJg==
X-Received: by 2002:a62:380c:0:b029:2f7:4057:c3ed with SMTP id f12-20020a62380c0000b02902f74057c3edmr38802381pfa.21.1625098943069;
        Wed, 30 Jun 2021 17:22:23 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c0:4701:ae70:8687:fcbc:6b3d:c844])
        by smtp.gmail.com with ESMTPSA id v6sm25117495pgk.33.2021.06.30.17.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 17:22:22 -0700 (PDT)
From:   Drew Fustini <drew@beagleboard.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Fu Wei <tekkamanninja@gmail.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Drew Fustini <drew@beagleboard.org>,
        Huan Feng <huan.feng@starfivetech.com>
Subject: [RFC PATH 1/2] dt-bindings: gpio: add starfive,jh7100-gpio bindings
Date:   Wed, 30 Jun 2021 17:20:38 -0700
Message-Id: <20210701002037.912625-2-drew@beagleboard.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210701002037.912625-1-drew@beagleboard.org>
References: <20210701002037.912625-1-drew@beagleboard.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the GPIO controller in the StarFive JH7100 SoC [1].

[1] https://github.com/starfive-tech/beaglev_doc

Signed-off-by: Drew Fustini <drew@beagleboard.org>
Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
---
 .../bindings/gpio/starfive,jh7100-gpio.yaml   | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/starfive,jh7100-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/starfive,jh7100-gpio.yaml b/Documentation/devicetree/bindings/gpio/starfive,jh7100-gpio.yaml
new file mode 100644
index 000000000000..8c9d14d9ac3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/starfive,jh7100-gpio.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/starfive,jh7100-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7100 GPIO controller
+
+maintainers:
+  - Huan Feng <huan.feng@starfivetech.com>
+  - Drew Fustini <drew@beagleboard.org>
+
+properties:
+  compatible:
+    items:
+      - const: starfive,jh7100-gpio
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt mapping, one per GPIO. Maximum 32 GPIOs.
+    minItems: 1
+    maxItems: 32
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+  - "#gpio-cells"
+  - gpio-controller
+
+additionalProperties: false
+
+examples:
+  - |
+      gpio@11910000 {
+        compatible = "starfive,jh7100-gpio";
+        reg = <0x11910000 0x10000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupts = <32>;
+      };
+
+...
-- 
2.27.0

