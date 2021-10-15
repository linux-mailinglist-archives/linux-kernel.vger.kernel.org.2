Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C86842FBDB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 21:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242525AbhJOTTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 15:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhJOTTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 15:19:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A56C061570;
        Fri, 15 Oct 2021 12:17:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y3so28267653wrl.1;
        Fri, 15 Oct 2021 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iba2xUxNfqwouiEqt/f6pt++LWM4C+lzC054mKzStIY=;
        b=mukjM33GmlsZu/FmsHAIYZD8ruHg0OZVMIzOg28+Ka4iXF09QRGc4H7N81+eQ4pz+B
         x3neLYVfe/9PG4dy9XkhRWCWTeNkHLRfm9LbDVz82oGI6Kk+Jc0tXO3mt6jRpQ4W+6Rm
         mkCql9Mf0xDYPxUC9VhFzcsbVGS61ty8KsMTsR7snerUhhBp3ApqrzQv6JczE7iThzxA
         lnTSov5cZLKVgfIrNb/qhqOZbcjAT0EY/fP8ap8Q0idBMy8nxRt1J7cJn7U9/99lE87E
         1geMNqVq/OSlk5R6dSPeOJXzlgPl0AueD6rFlmhBKN+jdWvS4lYC6KXsr1lrARsmjHyK
         iBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iba2xUxNfqwouiEqt/f6pt++LWM4C+lzC054mKzStIY=;
        b=Y090JtzpH/1BbFVPgoYatGGrwvWbwHFFlfu28ZWSrxRs7LREZQ6f+hPwogifDZr1k/
         pkaMfhnrFetQqsWbBrH+ZidL8Cxqo4JIDJQsFW3kazEl4mSlhuMXE3RSAPs7ojayhyUf
         dltpLAes2apLksebg7njGAwfjHUmdANONedVkrjdP+od8qCGAW6vDBoWQgq3ywVI9w2D
         owe61JdhZ7Kgnlz9bjFxaN3eCGKeFh8N/bURYEaCclyJPprpftB73fhzbNWdQ4piqfuT
         5tChPSdZkwg5H6wCN8d9OUaMTzDTyFDVx4noxTAfOmdTgPeHT5gd6F0DK8tSD42ogoo3
         Pyrg==
X-Gm-Message-State: AOAM5331mYUFB++jOVbmfqRCD8Oo/dM0qiAfs4UdfEo9SaGp4rkn/DXg
        WKE+J5vZ23n80tfjWrlg21sCZ8XqC3A=
X-Google-Smtp-Source: ABdhPJwrJLpbGZrxdxIOCO3v3xY3m/TeMbSP2VxtUzhbFOeBVLAHOqGl7wC4toB8Sa7jrQrZc6XIpw==
X-Received: by 2002:a05:6000:1449:: with SMTP id v9mr16178127wrx.433.1634325464089;
        Fri, 15 Oct 2021 12:17:44 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id z1sm5591513wrt.94.2021.10.15.12.17.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Oct 2021 12:17:43 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     robh@kernel.org, john@phrozen.org, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: bus: add palmbus device tree bindings
Date:   Fri, 15 Oct 2021 21:17:41 +0200
Message-Id: <20211015191741.12963-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for palmbus controller present in all the MIPS
ralink based SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../devicetree/bindings/bus/palmbus.yaml      | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/palmbus.yaml

diff --git a/Documentation/devicetree/bindings/bus/palmbus.yaml b/Documentation/devicetree/bindings/bus/palmbus.yaml
new file mode 100644
index 000000000000..d5159a4f3cf8
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/palmbus.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/palmbus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ralink PalmBus Device Tree Bindings
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description: |
+  The ralink palmbus controller can be found in all ralink MIPS
+  SoCs. It provides an external bus for connecting multiple
+  external devices to the SoC.
+
+properties:
+  $nodename:
+    pattern: "^palmbus(@[0-9a-f]+)?$"
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  compatible:
+    const: palmbus
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+patternProperties:
+  # All other properties should be child nodes with unit-address and 'reg'
+  "^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+$":
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    palmbus@1e000000 {
+        compatible = "palmbus";
+        reg = <0x1e000000 0x100000>
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e000000 0x0fffff>;
+
+        syscon@0 {
+            compatible = "mediatek,mt7621-sysc", "syscon";
+            reg = <0x0 0x100>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+            ralink,memctl = <&memc>;
+            clock-output-names = "xtal", "cpu", "bus",
+                                 "50m", "125m", "150m",
+                                 "250m", "270m";
+        };
+
+        wdt@100 {
+            compatible = "mediatek,mt7621-wdt";
+            reg = <0x100 0x100>;
+        };
+    };
+
+...
-- 
2.33.0

