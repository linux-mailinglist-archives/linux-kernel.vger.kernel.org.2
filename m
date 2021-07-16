Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39DB3CB56C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 11:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhGPJrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 05:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbhGPJrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:47:06 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECA9C061766;
        Fri, 16 Jul 2021 02:44:11 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id m83so8497633pfd.0;
        Fri, 16 Jul 2021 02:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1JuzSaJeX++ckGWb53wf2z0OIXSlH3HjOOCWZ8LzlB8=;
        b=RrmRxtQJYJHug+4681IZOjE1binXrtH7BvMSoNlzX9eqH+BGBLGOHk+/W4dXovFyMR
         Zud733tbnhYLcSObrtJgYbaGbV7korNtaoeO9987RtQdXm6isY8qY0C6Mjc5bcobQAW4
         U+eia9H7c7ot6RuTDeB9jjUgyKqpWTbRxQJq4V9oXpG4kqar5uQ8d5Yld2NptKJp5G6N
         7XCDkJQT95IVlddvYJHOrwScc/MxLUAz3H+1VLeeMoRWf9RnTaH0EQCawMgGpQei27O2
         Wb58lSDy21I80aXEfOQm7622QSXWmpjuT+AnBZvaH/E344dkKV03kvDgnYhaoCtRP9Iz
         dr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JuzSaJeX++ckGWb53wf2z0OIXSlH3HjOOCWZ8LzlB8=;
        b=PvgSSNFdvcsyZsnkOKSpsqc6oyIL9GZfzOl5eOQL4sA7gKyFJ2/OVhBqBG1h9jksgO
         1W2qgdcHlsWJdlo1NEQk8cak39VxsEezEB+eJfhxAZfNAnZIJg32AtnUXCD0S5iWr14O
         HOSGxM2prB+QJoJs9dFKSB84QpPAoSIvPBdWNjYYEnYWJpCk3TDzhXNNELkGzd11gO2d
         2GIVWIMcO6Hcuqf5Bg/E2pCIqX/j98wyuNznFwRYU+I7VsTPUzVdMC9U8D0AyXvqW7So
         W42KAAzbd3fIVV35yUZ1xnELPOqg72g+jQXcjs6LTfy4wCbvN+yHpat3ES+m0xfs+d4B
         S6jw==
X-Gm-Message-State: AOAM532Cdu39xRBgoGKe1G29K8eTvvW5Rr3R0mgNv27Dthlh1qAW9Cy+
        FVd5L49rHTiHehERX1N10DE=
X-Google-Smtp-Source: ABdhPJwHAvbqLIirNjVveYH4wzjNWCVGuA9LLfRVJhgHVtNE+bW15gdmRZusmu6XwTRTonxig/AFMA==
X-Received: by 2002:a63:1246:: with SMTP id 6mr2865211pgs.436.1626428650771;
        Fri, 16 Jul 2021 02:44:10 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.138])
        by smtp.gmail.com with ESMTPSA id m21sm9508800pfo.159.2021.07.16.02.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 02:44:10 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com,
        matti.vaittinen@fi.rohmeurope.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        inux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/3] dt-bindings: power: Add bindings document for Charger support on MT6360 PMIC
Date:   Fri, 16 Jul 2021 17:43:52 +0800
Message-Id: <20210716094353.140536-3-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716094353.140536-1-gene.chen.richtek@gmail.com>
References: <20210716094353.140536-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add bindings document for Charger support on MT6360 PMIC

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/power/supply/mt6360_charger.yaml | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml b/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
new file mode 100644
index 000000000000..b89b15a5bfa4
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/mt6360_charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Battery charger driver for MT6360 PMIC from MediaTek Integrated.
+
+maintainers:
+  - Gene Chen <gene_chen@richtek.com>
+
+description: |
+  This module is part of the MT6360 MFD device.
+  Provides Battery Charger, Boost for OTG devices and BC1.2 detection.
+
+properties:
+  compatible:
+    const: mediatek,mt6360-chg
+
+  richtek,vinovp-microvolt:
+    description: Maximum CHGIN regulation voltage in uV.
+    enum: [ 5500000, 6500000, 11000000, 14500000 ]
+
+
+  usb-otg-vbus-regulator:
+    type: object
+    description: OTG boost regulator.
+    $ref: /schemas/regulator/regulator.yaml#
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    mt6360_charger: charger {
+      compatible = "mediatek,mt6360-chg";
+      richtek,vinovp-microvolt = <14500000>;
+
+      otg_vbus_regulator: usb-otg-vbus-regulator {
+        regulator-compatible = "usb-otg-vbus";
+        regulator-name = "usb-otg-vbus";
+        regulator-min-microvolt = <4425000>;
+        regulator-max-microvolt = <5825000>;
+      };
+    };
+...
-- 
2.25.1

