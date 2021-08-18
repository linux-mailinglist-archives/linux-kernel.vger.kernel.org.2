Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CB83F02C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 13:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbhHRLeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 07:34:07 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:38796
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233798AbhHRLeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:34:04 -0400
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 2E9EA40CD1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 11:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629286409;
        bh=s81TGuRZwiBLUJDdn1CFX9wwF3yLRc0TxkRTxMwR41M=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=i6qKnCQwRZlGigf4MhyMplmGMer2FBy/IvnqH/7vvmpRswseECIRAPhol6QvcntnI
         yhQUDZzqP4WksDgSzHHvAoQk5THv7t5XliR8N31CJuG0wswbz+onCiKo5QJkFIC8vK
         T0KF0+LtoPZ4Mgxhw6pwDM/ltpABWvK2SRE3oKYkekByHkGJRtlRETjQ6VPtMDa444
         JM6uX5is6i8qDdgYOHIvNPDvFqZwVpWKTGc1mNt0tnF4kO5Dc4FBtbFoCKAU7abgGy
         7+LNkzoPJ7sDMdtnLJ/DR0xhvrONWJhZnK49CJuV79iosMIW71PICXGxFzmGnVuGmM
         +9xiBqG+AcTqg==
Received: by mail-ej1-f69.google.com with SMTP id u23-20020a1709064ad700b005bb12df6cb9so735899ejt.20
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 04:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s81TGuRZwiBLUJDdn1CFX9wwF3yLRc0TxkRTxMwR41M=;
        b=dmX+rloScE6QRUWuAlF0kpC2fMj8gkisgrELrBcfAOzX3Ss86HpeZVeo9uGFIjXHlm
         ZiwaoOKKuwA7nRAxAS1/3P6vzbN5K5dJk9Wxuhv8531IZnpBwpCUX5R/cuTzDpBXwAah
         8wly6Ge2A+3x/DQBGAAdi3li2yeP5joWaY/SB28t2/zkzsf53mJRnqJ4Uqh/9M2vqZsR
         RcXuXQpYKk0MNTP2pNOK/9Vetd8gyZP0nT5s80Cs7lx/TAadbTwjSP/ekffobNachmSK
         g0C4LCqV5XHEKKElfywglIgWnI65xvPOgeape/OsNibklGATm5I3GYoTz4v8HmLlK9KT
         OiPw==
X-Gm-Message-State: AOAM531OdMT7Oq1aKy7FpgeYpGai8t8E04r+9N/4n/EjTDEHTUSk+nKM
        GHIKuLD0Qz0rI9g2XSha6PumxEvnZkvaA4OvUstoi1v3ZYfOJ/ygMQ4e22NDhKYVrmEBNXplWdX
        LElCFczH16uw0hm2DS0PaEtIRGGGZVe2Bq1c3FqJv4g==
X-Received: by 2002:a17:906:6884:: with SMTP id n4mr9126634ejr.265.1629286408918;
        Wed, 18 Aug 2021 04:33:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5z51bjsNMxFkuXX9PWcuQT8bwmBKAAd0DCknaS+T6xU+Sol777Zqx+EX6leBGBdqXcPeGIQ==
X-Received: by 2002:a17:906:6884:: with SMTP id n4mr9126619ejr.265.1629286408789;
        Wed, 18 Aug 2021 04:33:28 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id w5sm1960024ejz.25.2021.08.18.04.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 04:33:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: memory: convert TI a8xx DDR2/mDDR memory controller to dtschema
Date:   Wed, 18 Aug 2021 13:32:48 +0200
Message-Id: <20210818113248.85084-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Texas Instruments da8xx DDR2/mDDR memory controller bindings to
DT schema format using json-schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../memory-controllers/ti,da8xx-ddrctl.yaml   | 35 +++++++++++++++++++
 .../memory-controllers/ti-da8xx-ddrctl.txt    | 20 -----------
 2 files changed, 35 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti,da8xx-ddrctl.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti,da8xx-ddrctl.yaml b/Documentation/devicetree/bindings/memory-controllers/ti,da8xx-ddrctl.yaml
new file mode 100644
index 000000000000..9ed51185ff99
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ti,da8xx-ddrctl.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ti,da8xx-ddrctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments da8xx DDR2/mDDR memory controller
+
+maintainers:
+  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  Documentation:
+    OMAP-L138 (DA850) - http://www.ti.com/lit/ug/spruh82c/spruh82c.pdf
+
+properties:
+  compatible:
+    const: ti,da850-ddr-controller
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    memory-controller@b0000000 {
+        compatible = "ti,da850-ddr-controller";
+        reg = <0xb0000000 0xe8>;
+    };
diff --git a/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt b/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
deleted file mode 100644
index ec1dd408d573..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-* Device tree bindings for Texas Instruments da8xx DDR2/mDDR memory controller
-
-The DDR2/mDDR memory controller present on Texas Instruments da8xx SoCs features
-a set of registers which allow to tweak the controller's behavior.
-
-Documentation:
-OMAP-L138 (DA850) - http://www.ti.com/lit/ug/spruh82c/spruh82c.pdf
-
-Required properties:
-
-- compatible:		"ti,da850-ddr-controller" - for da850 SoC based boards
-- reg:			a tuple containing the base address of the memory
-			controller and the size of the memory area to map
-
-Example for da850 shown below.
-
-ddrctl {
-	compatible = "ti,da850-ddr-controller";
-	reg = <0xb0000000 0xe8>;
-};
-- 
2.30.2

