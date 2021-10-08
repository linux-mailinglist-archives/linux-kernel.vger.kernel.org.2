Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A5F4263EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 06:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhJHEw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 00:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhJHEw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 00:52:26 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25592C061570;
        Thu,  7 Oct 2021 21:50:32 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s75so1958388pgs.5;
        Thu, 07 Oct 2021 21:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Zj8iHIqH+Xnz2r7eN2MsdU1Zj8zoSo9u4Ea2uh5oVk=;
        b=en6IZ72ujMNigCYqRMhZdH6nb4v3yyY8kdx5ZLcvXf8/bilr2/+JsFl5DOgXpJcbu8
         7WYstew6waA92pE48bfaF3fQpLlhpTWh0GTRErluITfVaXfB5NUfDEOnjm3TRu3e8ofH
         FwV/nOC4k/PkgemQ5SQDsH7ssy5Y/DHevIAAq0N7h8zJVr4xrgQuZHTC9exras6X7/O+
         WYvOWsHRqH7nT2q2AO2SfwA8c+Y6n1YWYxIizv9qlV00dUt0DIA8n61LbGpLimM9K9rX
         tfBXUCt2UhAAa6fZmuXPtJknFAbtw2PLzF9t79u0vAamFfmFzSYxouaQUp0kSF7GCOCA
         Z+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Zj8iHIqH+Xnz2r7eN2MsdU1Zj8zoSo9u4Ea2uh5oVk=;
        b=jS3FrweVRCh+0MCFDixUGua9ZlG/kC2bt/dgkzBaFmuAgso+VsbRtEFldYaTJEGv3G
         t/F7wwFJve7CW1rnwIDBaCxtD9S5EqahSc408He/feWrQ1r6V7VoSxwSMNbQJQlO9Y0A
         Qt9qprNUbZneIublDaZv8gvkkseKatKRchd5mbBpAMJtom5Wpq8/jggUpMC0sBiKD4uf
         jS3tP2BGWefDX+OiyWoIPh7M8gyRdacswlWjQ1opQ0svvCTLcWe1pZaOt2LdfITTnF12
         Svfivhkq1Uqu0ZMOhv4pJ3uo5AvwWgaSksCU3H2bIYeLFWm6rkfALumTXVNaXdPlIOhC
         48uQ==
X-Gm-Message-State: AOAM531w0RdgyCeL7WuWkgTe/UNk+aZLBr2i4bMwPuR0Bmkm0NjgbY2B
        sGG2VzQ44mml5FeXEKXpOdQ=
X-Google-Smtp-Source: ABdhPJxWHPrCQ6OID5EzaLKAXNJdBWsWeUhT+WOHgDk3rI1uR/j5O49qxztLx/KwoLcVHUL4tQHXCg==
X-Received: by 2002:a62:7a4f:0:b0:448:6a41:14bb with SMTP id v76-20020a627a4f000000b004486a4114bbmr8269668pfc.31.1633668631638;
        Thu, 07 Oct 2021 21:50:31 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:5014:1d07:e136:b921:8d67])
        by smtp.gmail.com with ESMTPSA id f4sm885182pgn.93.2021.10.07.21.50.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Oct 2021 21:50:31 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     oder_chiou@realtek.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org, allen_lin@richtek.com
Subject: [PATCH v3 1/2] ASoC: dt-bindings: rt9120: Add initial bindings
Date:   Fri,  8 Oct 2021 12:50:11 +0800
Message-Id: <1633668612-25524-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633668612-25524-1-git-send-email-u0084500@gmail.com>
References: <1633668612-25524-1-git-send-email-u0084500@gmail.com>
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

