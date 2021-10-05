Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A069421BA6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhJEBS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhJEBSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:18:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582B4C061745;
        Mon,  4 Oct 2021 18:17:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so749774pjw.0;
        Mon, 04 Oct 2021 18:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=eaTwpWsRaFKGnfCAdX99R61MOjsjEGVDtlmehFUQR94=;
        b=VhmDSsCPWMODDy3LzdVPvGLPmUFTY9HOxXUx0NUcLyTMGbDH1BQvLau4J0YqsD/2T4
         X61s+cdliYaxSifO4R4pi+3F5mv3jQjsnXJYmj8L+8Aym788Xb0gW0bicIK0aSsv0XDP
         lBisQ8B6rk6+dP8NsTy0N3nDh+99EEayXCiCuxn9lLxauUOTtgFpJHQJPI0aL+ibFTYK
         KvwWOHYE8OFptF/susMYXoxvpsXki0ivghddSwf6I5/cJTgu4fi8GWlRGnhtLX+bZqRI
         LUtBvdB3Fm2Z+FdmPtGv7vYxlo4JP807H6ieYAd69+WXGC43vf+CZPz37cvN6Y2YAKKN
         2b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eaTwpWsRaFKGnfCAdX99R61MOjsjEGVDtlmehFUQR94=;
        b=e/o8yCCXMBvbZ/fWHbYvpqvhyPvnl1viFG3+1etZP4ikrafcApGgrBQtCwKUkr10hz
         IW+HEPtuWyPz3gao2QHGcmAHNG3WZHyOkhpGdCWz0zbMOHlz2NdhPdzhPZ66gIZDnBVn
         hwxZ9vDxbfGmhIr+I2B/vYmfLxDSUC1/vL5BaDMZUVp2LkkTjvjjaOn5KfhorjyyrvgY
         S9kiJ7YTiUPcojEFuDzCX+Cqr8ffdtIiwctM80sI6SJza6YS5JgWMEq3QhxrFKukJz+4
         K2n/fQgvFdUNBYyqCLBuIOJ7rDr8Uau2BJfpHEpKOWWPFHJkQ+8WvENKqHna9xE2YoIx
         t5og==
X-Gm-Message-State: AOAM532eZ0N8eMB6LwQQYJjdoAIK4WlTGyG3zrBLokRRERKkVmUNfKs+
        3TIu0k4rYiFcZfyFzRs1ltE=
X-Google-Smtp-Source: ABdhPJxP/w2Xb+76tCMIsUN823o7tQJ2KGNHg1jx7s2daH1B4eHnCWSDFOJJhcXkoTsYotshi+PPbA==
X-Received: by 2002:a17:90a:29a6:: with SMTP id h35mr376547pjd.188.1633396624774;
        Mon, 04 Oct 2021 18:17:04 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:578:6fac:e123:108:2f69:cff1])
        by smtp.gmail.com with ESMTPSA id j6sm15162454pgq.0.2021.10.04.18.17.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Oct 2021 18:17:04 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        allen_lin@richtek.com
Subject: [PATCH 1/2] ASoC: dt-bindings: rt9120: Add initial bindings
Date:   Tue,  5 Oct 2021 09:16:54 +0800
Message-Id: <1633396615-14043-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add initial bindings for rt9120 audio amplifier.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../devicetree/bindings/sound/richtek,rt9120.yaml  | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/richtek,rt9120.yaml

diff --git a/Documentation/devicetree/bindings/sound/richtek,rt9120.yaml b/Documentation/devicetree/bindings/sound/richtek,rt9120.yaml
new file mode 100644
index 00000000..4d47a78
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/richtek,rt9120.yaml
@@ -0,0 +1,53 @@
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
+  richtek,use-dvdd-1p8v:
+    description: Indicate DVDD 1P8V is used, default for 3P3V or 5V design
+    type: boolean
+
+required:
+  - compatible
+  - reg
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
+        richtek,use-dvdd-1p8v;
+      };
+    };
-- 
2.7.4

