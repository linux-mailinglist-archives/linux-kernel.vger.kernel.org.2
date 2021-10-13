Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBDA42B23E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 03:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbhJMBbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 21:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbhJMBbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 21:31:17 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B651AC061746;
        Tue, 12 Oct 2021 18:29:14 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 75so750198pga.3;
        Tue, 12 Oct 2021 18:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Zj8iHIqH+Xnz2r7eN2MsdU1Zj8zoSo9u4Ea2uh5oVk=;
        b=Ahn7C41xaOSYn5i5/CFIjFR2Iyuwx1hVDH5QUxnP8pm1qDeoTWsDoK7JfdqGgWMtcI
         dsZqGakmxoTylJxnZE7HDRL1984eG52K03hcU36Zt4AWFn0mYgty1p/m8cVYZhB6HZeG
         frB1lIiz0BBSS9b/aC/aDCOsrLKhcx76jeZW7h3GsVbMRbMxmO0pvtVmsjW7fauC52Cz
         Dgz0YsWnYCCe+ZlCkkDAkQApUjGlvVSS/5CHW54LNdl0PT0kvzp/llKj3ACpe6wL2n2J
         6ToQ01cgcfqM2pzcncLEEwPL0dADx66K+Nx2nyPB2aehgNlyQ3CfqmmFTNOuX4pIMIkM
         nnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Zj8iHIqH+Xnz2r7eN2MsdU1Zj8zoSo9u4Ea2uh5oVk=;
        b=SO1IFAWQqoTi2aOA8bZbMkasde4ye4x2SBeP6Aesl9SQaVR/c5gRfm7fzA6m1zrOJ8
         ++JpqCV2ORubPFAx9A+RNal8kBcGRN5t7PmHhXrUO2Mtphd8QNM1u5WJnxX7bL4mvCTg
         TG4p5CdTXetT0hfav+eXmMr9NIEG767xihoYm2XL2bcKltwMxv2g7sRseZPVhWZI0wFo
         zQFxDFQYInOmPDCwsq5TtnJWq8mSrcSKEkiGQOmlBnmUVzg9+JwELpWSZOT8lEDaEB7K
         AA1cDnXunY7vGyKs6rT0bRM0PiZac2uLf5AOfafdORx8TZt7M/6pZWpr8B9pr2BR3qwN
         X1Og==
X-Gm-Message-State: AOAM533xARkMl9L4t81+yiBbPIsdWCKCaYy/JVDoKjlgfKSrH0oFo5j1
        0bQrPOf7D/b7HDSVQFU+qvw=
X-Google-Smtp-Source: ABdhPJya3lUcWGxhpCf/15nteOT6Ymflh7gNPtL3WX+m3rWs7z9SK4GdLklnCnEBEEJTL9dqNlIV7A==
X-Received: by 2002:a62:1786:0:b0:445:1a9c:952a with SMTP id 128-20020a621786000000b004451a9c952amr35493622pfx.39.1634088554179;
        Tue, 12 Oct 2021 18:29:14 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:578:7fd7:52a:ae77:5bec:efe9])
        by smtp.gmail.com with ESMTPSA id b11sm12144788pge.57.2021.10.12.18.29.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Oct 2021 18:29:13 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     oder_chiou@realtek.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org, allen_lin@richtek.com
Subject: [PATCH v4 1/2] ASoC: dt-bindings: rt9120: Add initial bindings
Date:   Wed, 13 Oct 2021 09:28:38 +0800
Message-Id: <1634088519-995-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634088519-995-1-git-send-email-u0084500@gmail.com>
References: <1634088519-995-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add initial bindings for Richtek rt9120 audio amplifier.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../devicetree/bindings/sound/richtek,rt9120.yaml  | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/richtek,rt9120.yaml

diff --git a/Documentation/devicetree/bindings/sound/richtek,rt9120.yaml b/Documentation/devicetree/bindings/sound/richtek,rt9120.yaml
new file mode 100644
index 00000000..5655ca5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/richtek,rt9120.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/richtek,rt9120.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT9120 Class-D audio amplifier
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT9120 is a high efficiency, I2S-input, stereo audio power amplifier
+  delivering 2*20W into 8 Ohm BTL speaker loads. It supports the wide input
+  voltage  range from 4.5V to 26.4V to meet the need on most common
+  applications like as TV, monitors. home entertainment, electronic music
+  equipment.
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt9120
+
+  reg:
+    description: I2C device address
+    maxItems: 1
+
+  pwdnn-gpios:
+    description: GPIO used for power down, low active
+    maxItems: 1
+
+  dvdd-supply:
+    description: |
+      Supply for the default on DVDD power, voltage domain must be 3P3V or 1P8V
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - dvdd-supply
+  - '#sound-dai-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      rt9120@1a {
+        compatible = "richtek,rt9120";
+        reg = <0x1a>;
+        pwdnn-gpios = <&gpio26 2 0>;
+        dvdd-supply = <&vdd_io_reg>;
+        #sound-dai-cells = <0>;
+      };
+    };
-- 
2.7.4

