Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8451742B652
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 08:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbhJMGGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 02:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbhJMGGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 02:06:51 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5823CC061570;
        Tue, 12 Oct 2021 23:04:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m14so1489562pfc.9;
        Tue, 12 Oct 2021 23:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MH9z8oRP1WEDSYSBSdmgw7YkHAb/fp8UIslbgmjVY44=;
        b=jsFSQ/yE1vIMk0ZXSOG9PWuCn5JQscSjwdkdEmx5aOvUYwvASQnDZakuR6eciLBhCD
         92h6e10Hpbm8ucmaq1aPOmMgftVR0sX95ktsmJ/WiRmU9Ayk7dCoe1VSFlq8ZA2hM2HU
         y2eKEyPSFUaDIn31Ep4clKCxYx/16sreoichvvDvxip+viqowN5qndQ4XvqcMpnEOqYT
         cqdDNwZvuF325dM6dDUmzd+ENrmQiCGm3PriDqt57028lAcewW7aWUxCLkdFmXXj6hU2
         AvAKXTnqjDIbL+YVRDtUrwUJNlqj38bL9KS/5aMy86pwVpw6Ox5HlXfuEsAf8lA6Cwto
         y7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MH9z8oRP1WEDSYSBSdmgw7YkHAb/fp8UIslbgmjVY44=;
        b=lqMW6GKpmAvCYltbHwBV492tRe5aG/UGvkqceN9gEon1w42tqCfiCVqTnHV7npQPVO
         +kzkSb2Y7Ij5WY+eFIcRxMJsOnR9i+EYZP23tYc9At4WBFq9YfFdNn6WlupUkBPiMreb
         1+/pMYxe/epQkEEm812wy7h0ldct/+g5WVrvuYsQeAu7Sr2lmOSjjpZHBjLHjS6o6SOc
         kfZI2VTs7PddtjplrLtKHP5JZPPPUQsTZWehBwl4b2BSiuDS4oG69IHzMb0J44KYnXUr
         8dCeMqvdx+RRH5lLCOLdB7lHI1C4nuNnXlXFnuH04vBA+d8latGr4TcioGxg3+78jTAY
         Rq8g==
X-Gm-Message-State: AOAM531dnss0FwnHy8ABx7W3jcnpYOXh7dqTXATsJX6pcqnbKUUaq2b9
        vzKufwCtuulKO1bV0Ewenp4=
X-Google-Smtp-Source: ABdhPJyqqqSApXRNIzuuH5iQRESjESRbu7jNUNmMjLGTCrUAzRTOBbZ2z4ajKRyTDITgvwz2iFDUkg==
X-Received: by 2002:a63:f410:: with SMTP id g16mr25875791pgi.201.1634105088816;
        Tue, 12 Oct 2021 23:04:48 -0700 (PDT)
Received: from SEL-LT-028891.maxim-ic.internal ([223.62.162.93])
        by smtp.gmail.com with ESMTPSA id w9sm5003461pjk.28.2021.10.12.23.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:04:48 -0700 (PDT)
From:   George Song <georgesong0119@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        george.song@maximintegrated.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "george.song" <george.song@analog.com>
Subject: [PATCH 1/2] ALSA SoC MAX98520 dt-bindings : Added device tree binding for max98520 Signed-off-by: George Song <george.song@maximintegrated.com>
Date:   Wed, 13 Oct 2021 15:04:41 +0900
Message-Id: <20211013060441.18177-1-georgesong0119@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "george.song" <george.song@analog.com>

---
 .../bindings/sound/maxim,max98520.yaml        | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98520.yaml

diff --git a/Documentation/devicetree/bindings/sound/maxim,max98520.yaml b/Documentation/devicetree/bindings/sound/maxim,max98520.yaml
new file mode 100644
index 000000000000..02481428e2ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max98520.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/maxim,max98520.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX98520 Speaker Amplifier Driver
+
+maintainers:
+  - Goerge Song <George.song@maximintegrated.com>
+
+properties:
+  compatible:
+    const: maxim,max98520
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device.
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
+      max98520: amplifier@38 {
+        compatible = "maxim,max98520";
+        reg = <0x38>;
+      };
+    };
-- 
2.25.1

