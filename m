Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAAF3C6EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 12:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbhGMKx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 06:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbhGMKxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 06:53:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C511C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 03:51:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u3so5770471plf.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 03:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xzH7sesTaozGr2aBJCA9PbVMd+/TXsUDxdM6aSXl45Y=;
        b=UfdEgV6ejBlsj8JxfNTCpyqoujkZOrd26OFYbtyNGrFFn1w8vIXL3x/tuh8kYEN7zh
         gMfxw3nWN67wNY+Ia620l6fmfgeo/5SjhwpvWAQldauqCMbEN1360puiqwBIkfK5Q4uZ
         wpSwJXVJjy3E6hA7Xjo4ciCm1nwSoklVD0YtzlI7ndrcYmCfBkYSFY80XKzfNVNVyMst
         nFIHVvEmojYLFlPQ2vf2P4X/xU56jTh3kY+isL6DcaxrPFjSjGwGKwIfDMUc7lh/xYoG
         z4d/R32YPIe0nHFMqPqcSzBaoBw9/4vKH5Sp/SESjA6uqWTeDPV9t93lEi7qZGCipQA5
         YXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xzH7sesTaozGr2aBJCA9PbVMd+/TXsUDxdM6aSXl45Y=;
        b=bx6YKc9tJ7X0YS3Khd1XhyVgqMkCU38CGzsr+D+0PsHc1kekfOUo4fgPK5ou2Defsf
         moFZ7+AiINYOB01gZHonkI79EJ+LtYdOTWQV2hAF4jOCoA7CcezKiZZCU+2UYpNrnSLG
         EK4AUL3FFvwG6J68QjtL1syg5q9/On8Mks7JAaPMZxkPM7NxXE2FVH9JnBtIJyL1p/5Z
         Z+dkue/JgZOEFVDDqvs3zM8qtMaJq1pP547L3LGnIwWodubEs/j/j91VcNsl6IQcAu2V
         +qZ1j7xfnrhSbVYDjTT2VctXoDHEOtULBeqdyjnr4l9+ScKyVpYNWtGWhDcdstKjRbnp
         dLlA==
X-Gm-Message-State: AOAM532tI3pi5d2Ghc6EYm3jDFpahO4YuL/Ng/3Una5T+7Z04q0QIK6J
        cuaGRqlJqjQylOrzb1rKN/6NMg==
X-Google-Smtp-Source: ABdhPJwILSYWfsnEQ84NtkqSWa5u44NasPrQyL0/31BO0LHU+8bXmC3BJV9TCS/WGUJGHGqqDIiLVA==
X-Received: by 2002:a17:90b:1294:: with SMTP id fw20mr18966339pjb.100.1626173460987;
        Tue, 13 Jul 2021 03:51:00 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id i8sm5898474pfk.18.2021.07.13.03.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 03:51:00 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 5/5] dt-bindings: gpio: Add bindings for gpio-virtio
Date:   Tue, 13 Jul 2021 16:20:34 +0530
Message-Id: <268086e273df0c53e3a9a1e751304c63e50ebe12.1626173013.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1626173013.git.viresh.kumar@linaro.org>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio-virtio represents a virtio GPIO controller and this patch adds
binding for the same. The gpio-virtio subnode can be part of a
virtio,mmio node and is based on its binding.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Depends on:

https://lore.kernel.org/lkml/7c716c2eb7ace5b5a560d8502af93101dbb53d24.1626170146.git.viresh.kumar@linaro.org/
---
 .../devicetree/bindings/gpio/gpio-virtio.yaml | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-virtio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml b/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
new file mode 100644
index 000000000000..c813cdfd60fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/gpio-virtio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtio memory mapped GPIO controller
+
+maintainers:
+  - Viresh Kumar <viresh.kumar@linaro.org>
+
+description:
+  Virtio GPIO controller, see /schemas/virtio/mmio.yaml for more details.
+
+allOf:
+  - $ref: /schemas/gpio/gpio.yaml#
+
+properties:
+  $nodename:
+    pattern: '^gpio-virtio@[0-9]+$'
+
+  reg:
+    description:
+      The cell is the device ID of the GPIO device (VIRTIO_ID_GPIO) as per
+      dt-bindings/virtio/virtio_ids.h.
+    const: 41
+    $ref: /schemas/virtio/mmio.yaml#/properties/reg
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
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/virtio/virtio_ids.h>
+
+    virtio@3000 {
+        compatible = "virtio,mmio";
+        reg = <0x3000 0x100>;
+        interrupts = <41>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        gpio-virtio@0 {
+            reg = <VIRTIO_ID_GPIO>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+        };
+    };
+
+...
-- 
2.31.1.272.g89b43f80a514

