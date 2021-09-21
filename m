Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABCB413186
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhIUKaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:30:46 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:38534
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231859AbhIUKal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:30:41 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E7F654025C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632220152;
        bh=kkbd1KDb/nWZxhh/ldmlBfFp4mqYT4gxg/2gkTeLxNM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PMT63a9+wUj8Ked82vumhOIP8SXCE2PuQur5KgHRFab7DbRgg11SsczmvHYVnzGxU
         jZS/nCWhYtHkBLfGbH0+HBOQCIlQon3Sm2ussmqN5ZDV2xKXiYcBqaIgkMOozXHojf
         Hdc8kjeCWVciWkju4YG1llymsSIK5JjllLqvFx3b8u1wcCbVYQeYXUnYb5AsGFNgF7
         hKFF3twn+GyEf4mBruYBp24aNTx2uuqIf03zwHzw8XQRNfhQpzzAIAl4KSCvynTaRz
         JSAhFA5BSfT0hZt3DLpZcix5muLbIw52dEd8YywZ4XhHrvsUAi9NDWhRBDQqPwFSS4
         EYZFkfODfDXfw==
Received: by mail-wr1-f71.google.com with SMTP id s13-20020a5d69cd000000b00159d49442cbso8410215wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkbd1KDb/nWZxhh/ldmlBfFp4mqYT4gxg/2gkTeLxNM=;
        b=BDHWcPsMl8SYk/hgCPMNPyB7luNpG7rhtVFy/UESz9Ic0Gaz4rmLtrdPyRoWtywWb8
         F6/4NFzbrvEa230D3tgZTDfwUIClMmhNhEp9G+EOo5pTsyOrUrGcIUhlbXG6/uIsdp0G
         ZC7vL5baHXJPvH0IIUbBIb35IvSFYTDN5thbh70BBzjq9Rl25LiK5lEWRfmjtvik1juM
         +gNh8zs1Jg2eQBsLPgEt8ZXaRtcRYXquxkkZCmTM6t7QXW8qu6xC6/rs4x6MD6u7qkPx
         WIE8Fyj3iYkLTUYTJIU8HLOzoP6qjrvE1F1XnYgcWtJOTszygrgB9Pkbu3woy6VH3AZF
         nSYQ==
X-Gm-Message-State: AOAM531Lx5xYDtDxvCmqaIOpCFIK5pfPmFFEJRiusARrw8+mScif1RWT
        G68fHPRLATXQXqUWsid+1MvR3ID6VZDsCAllGeEaSnpdJdw6lUqRv/VT3+9kOFnJwETmO2jRTrN
        iQZ1TeeJFrfh4dPtZFXkFj/Pi9Jfa6TvmrFeWlW2Ttw==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr33587493wrw.330.1632220152607;
        Tue, 21 Sep 2021 03:29:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynCvd3iC/PeHFEd5pjxqSIDrSlRmcR2Me65OCSTR5w4e17865m6RoWwEe2gXcDFUzI51ZGtQ==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr33587469wrw.330.1632220152423;
        Tue, 21 Sep 2021 03:29:12 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id m29sm20072380wrb.89.2021.09.21.03.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 03:29:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: hwmon: ti,tmp102: add bindings and remove from trivial devices
Date:   Tue, 21 Sep 2021 12:28:28 +0200
Message-Id: <20210921102832.143352-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TI TMP102 temperature sensor does not fit into trivial devices
bindings due to additional properties.  Add separate bindings for it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/hwmon/ti,tmp102.yaml  | 47 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
new file mode 100644
index 000000000000..d3eff4fac107
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/ti,tmp102.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TMP102 temperature sensor
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,tmp102
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sensor@48 {
+            compatible = "ti,tmp102";
+            reg = <0x48>;
+            interrupt-parent = <&gpio7>;
+            interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+            #thermal-sensor-cells = <1>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index c9333fb81fdf..6ad0628741cf 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -317,8 +317,6 @@ properties:
             # I2C Touch-Screen Controller
           - ti,tsc2003
             # Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
-          - ti,tmp102
-            # Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
           - ti,tmp103
             # Thermometer with SPI interface
           - ti,tmp121
-- 
2.30.2

