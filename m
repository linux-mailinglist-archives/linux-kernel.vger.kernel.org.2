Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9661C421C25
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhJEBny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhJEBnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:43:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1232C061745;
        Mon,  4 Oct 2021 18:42:02 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so1169966pjb.3;
        Mon, 04 Oct 2021 18:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=s6UCNbgA4zOmtHUh1yQA9ZhFRm18TSeyBBlpDkWHlak=;
        b=KBsQwKvI5SdXFVpWLoVHHWHx1u5EXn0hyVzP4iOxRVIOib9XdoRtnQo6H3skyX9SBY
         xItj4uQgU1pKh/pdwlfj6X48YdAtUlX+sHpWIs9eH+gQn6L/D11TtS4eqrBvs+UqzqW2
         F2H1/cDa5WWRLjN4iYMWEtfCXu4+ieRNFpunMvr2KfbZN9t1/uvWFRgi4FFhAeKruRKn
         v9201lhLA/MY2qCzS69ka4l0swv/dBBV/oAhkPFhCiY9CGLY0CdJBhuSD+cflSG2VevM
         eaFmmBezo2xMvvN3JqTlxE8DOLHhJVyC+WIP+2rCR1tV5X/FOC8uqfmr/V9V0gr0VybL
         SIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s6UCNbgA4zOmtHUh1yQA9ZhFRm18TSeyBBlpDkWHlak=;
        b=26rDKmMdPiEjPqYbahWcaThsoV+pVAUxLhQvyWjSY2nxmFPOpU3/PN6x10GuzzVMkX
         g0O3iOUlGREHLuK/Kwz2W5BkYrY1tWRZJKBW8T9Foo0A2eymshoJ0bTZhn02ybet0tbW
         iu/HQTUqQB29bHSsRsCH32ka5b9H2qiIHjNF6+PWWMpLaJ8yPOk2CvtCY8Z20lulS93K
         R1zu/mHV15SX4pLGJHkNZ0hNm3+H9ahMvCVhZHMhiYsQoJ5VX2bHYbegc2DHj5NY01fB
         o4O94JAA53GbW7sNHr2m5tzeJSdmhva5q2PZ/CcnDTmr9uATxagpz5Dc7YwQr4006GHR
         ULpg==
X-Gm-Message-State: AOAM532bNjXVSpZ6QVp3giDRzauNq1oxxunVbIBBfkqnYFsgx37Vxr2m
        b90fZCSje+HGOv1IbMfX8bw=
X-Google-Smtp-Source: ABdhPJyRg0lhvibN8+TSZs4jAh7rHB99yLAfjCIKV53GqJh8kbosu3bw1uCF0rDcBah6AhNIYzCzeg==
X-Received: by 2002:a17:90b:3805:: with SMTP id mq5mr477056pjb.7.1633398122360;
        Mon, 04 Oct 2021 18:42:02 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:578:6fac:e123:108:2f69:cff1])
        by smtp.gmail.com with ESMTPSA id h4sm108709pjm.14.2021.10.04.18.41.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Oct 2021 18:42:01 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        allen_lin@richtek.com
Subject: [PATCH v2 1/2] ASoC: dt-bindings: rt9120: Add initial bindings
Date:   Tue,  5 Oct 2021 09:41:31 +0800
Message-Id: <1633398092-19953-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add initial bindings for Richtek rt9120 audio amplifier.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Very appoligized. I forget to migrate this line from my test 5.10 kernel.
Without this line will cause sound card codec link fail.
Please use the patch v2 to review the bindings and source code.

V2
- Add missing #sound-dai-cells property.

---
 .../devicetree/bindings/sound/richtek,rt9120.yaml  | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/richtek,rt9120.yaml

diff --git a/Documentation/devicetree/bindings/sound/richtek,rt9120.yaml b/Documentation/devicetree/bindings/sound/richtek,rt9120.yaml
new file mode 100644
index 00000000..6d16795
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/richtek,rt9120.yaml
@@ -0,0 +1,58 @@
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
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
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
+        #sound-dai-cells = <0>;
+        pwdnn-gpios = <&gpio26 2 0>;
+        richtek,use-dvdd-1p8v;
+      };
+    };
-- 
2.7.4

