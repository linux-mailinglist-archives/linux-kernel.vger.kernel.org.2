Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9A45F5D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 21:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbhKZU2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 15:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbhKZU0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 15:26:09 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2544AC061757;
        Fri, 26 Nov 2021 12:22:06 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so7511685wms.3;
        Fri, 26 Nov 2021 12:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qq+/EDGbVO3mNT4nMhuGS7PpCY5cRArGWC5WLtDNkBk=;
        b=mkXwO8YUv0rvLYlDvbai45/oql7QB/Jl4vwIpxGY53LNifdr62W9JVHqV3+W8CaKcT
         fP1Os7ZW+6IavaKlwZodUaSaeeZrTf5ZW856mYhqIUGJ0XGchJLb6kPuPXzE0nnyHmZh
         g+lLZ4myjee77IQmJM0MuZZc8UZxCr8NgChRsK/0YHqtXb1w/3trpC1gUkGDhb1bUosq
         XodawD5kIj+8h4ONbecP8hktlf3HtyVazlppmdRcJLPJ/I7ZEWcMLC8bHmu+AoYTvRUd
         oodiFtassVrS9fG60XLKyAMN2+wzvYuamtp3yMiw1KNVVBLbZrp6RXvj0K+oWjtC4E9B
         nAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qq+/EDGbVO3mNT4nMhuGS7PpCY5cRArGWC5WLtDNkBk=;
        b=4SeOKNVN2wXRAbnwztPElnY37O01T5sMEKGh3Xmb+JxGgShYoPwBgoQ3k8TF1I/P5+
         avZGep1XZwHrftJzUGK4T4wEUIyEjJL1QVPq1ySQkRSMmIglpL5EkqcyXFuiwFc1jnaz
         tUvmm0Als96txZTdeNXlJzy4AG4xWW9GE/yTPIduiXGs+3L5zgBiVoUAlnLQbqcrVoGR
         NrWKCTq/ZPKZvIOPqRH5GNnba38PLvd+SGGGQHKpvSgO66LFEEZDORlLxDm8TuZe5DPC
         osadmn5Imt46eCspZ4eSiuY9u/upsmXBoyuup0R+NpgVUgYQBzmL5ZeX+5cwdwnehTSU
         Av7A==
X-Gm-Message-State: AOAM533nlxeJ2xq6NN/H5YCzB8blfMQi6t9tBfPjCihbHX0LnohLRdD6
        e5BFrbWlEcPx9D1NmFen5I2Oz2qa5ic=
X-Google-Smtp-Source: ABdhPJwMfpbgXrYtTy/dOfMsrG9kgfAzQdDWEJvt2KMJik3XelFxCHre8Bb1A9CoVH3nu9uWE/C1Zw==
X-Received: by 2002:a1c:4d8:: with SMTP id 207mr18243845wme.23.1637958124560;
        Fri, 26 Nov 2021 12:22:04 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id f18sm6358827wre.7.2021.11.26.12.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 12:22:04 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] dt-bindings: timer: Add Mstar MSC313e timer devicetree bindings documentation
Date:   Fri, 26 Nov 2021 21:21:42 +0100
Message-Id: <20211126202144.72936-5-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211126202144.72936-1-romain.perier@gmail.com>
References: <20211126202144.72936-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the documentation for the devicetree bindings of the Mstar
MSC313e timer driver, found from MSC313e SoCs and newer.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 .../bindings/timer/mstar,msc313e-timer.yaml   | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml b/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
new file mode 100644
index 000000000000..f4d43e141dd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/mstar,msc313e-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mstar MSC313e Timer Device Tree Bindings
+
+maintainers:
+  - Daniel Palmer <daniel@0x0f.com>
+  - Romain Perier <romain.perier@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - mstar,msc313e-timer
+      - mstar,ssd20xd-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  start-year: true
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    timer@6040 {
+        compatible = "mstar,msc313e-timer";
+        reg = <0x6040 0x40>;
+        clocks = <&xtal_div2>;
+        interrupts-extended = <&intc_fiq GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
-- 
2.33.0

