Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAAB34E996
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhC3NtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhC3Ns1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:48:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C34C061574;
        Tue, 30 Mar 2021 06:48:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hq27so24919818ejc.9;
        Tue, 30 Mar 2021 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+3EOZ+BiKLMx9cVwQE1QQOnnXxodL6X9K+oNxH3xRA=;
        b=aetLVVkZ9mDP/zHp1Z3wAEtDs0G3k4Tgtptg9qVC62yVxuFcH/bH1NKhYnqHujMlzy
         arsR73JfiOqoA1WGXiekmexSG94s65xPe3QOrPdzQOQBTQENKaaEUaSP/WjKa6b2ay1h
         8rl8AqJUJjJoED2GTGlS9Tmy3zLJSPlQ6/GPNLyLwpMQ7ER6qEpYnglksXSNA/1YdzxK
         5GnLVrMPfIxHcqkMnP2BG8iEC3FyratKojpbYUBabSnBTQ8Smreb31JqO4hN+iXZ6JM8
         zLCgPOm7n9iPHUGJSdgVm3qjxg2Z3LbvXngFAikxm2rCaoJ689Jvo/vevXL/1JW9K6kN
         DdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+3EOZ+BiKLMx9cVwQE1QQOnnXxodL6X9K+oNxH3xRA=;
        b=VDOs+Lueq8rx0i9P1Si0gBs9+/lavgrH2K3z47OlYai28SGejYHkmOZNkOHSZdXV8D
         b8GxPk9H4sp2jDSU7WEElbeLyBkvom8Y8+p2eUCylA38O3xy3vbRR/LosmSTwjMqf+xl
         nQO8ITmg8mu6mpkLzC3gGOMZHovdsFL7Vp5ILKgLY5lHKLmu4Be9FTejFMWstgeswOTk
         xafw+PwXXCK055pN11H+BYqj6JJLEJth9f0rrn1lYIUCRBd7MpfI3Z9y1TX/fYghGu5Z
         TTQ366zPyJQfX2uyLiNQMHvD+srZUzNNseItEKNVTTq4Gj0Rsdh6YRGNxrWd3Xin0A9b
         /Jnw==
X-Gm-Message-State: AOAM530ud+FJ7nDQxDTHydrn5m2WNP73uPzK8uNwJ8xprchWiWRvj4JA
        hD7el8PYlPhLOV8/quuOEUt3fbNgEyg=
X-Google-Smtp-Source: ABdhPJyVApA+moIOfgTjoYWSYe6huhRHCm6oYXLsZJTHueWGkqAvbpPBNiscrtVW/hVNUwe8yub+rQ==
X-Received: by 2002:a17:906:3c50:: with SMTP id i16mr33973863ejg.175.1617112105598;
        Tue, 30 Mar 2021 06:48:25 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id l12sm11114681edb.39.2021.03.30.06.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:48:25 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] dt-bindings: reserved-memory: Add Owl SoC serial number binding
Date:   Tue, 30 Mar 2021 16:48:16 +0300
Message-Id: <fb74862bec15f1e9e0c4d8b70ebd6c07c6eb1a40.1617110420.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for the Actions Semi Owl SoC serial number
reserved-memory range.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 .../actions,owl-soc-serial.yaml               | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml b/Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
new file mode 100644
index 000000000000..41b71f47ee6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/actions,owl-soc-serial.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl reserved-memory for SoC serial number
+
+maintainers:
+  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+
+description: |
+  Provide access to the memory region where the two parts of the Actions
+  Semi Owl SoC serial number (low & high) can be read from. This information
+  is provided by the bootloader, hence expose it under /reserved-memory node.
+
+  Please refer to reserved-memory.txt in this directory for common binding
+  part and usage.
+
+  This is currently supported only on the S500 SoC variant.
+
+properties:
+  compatible:
+    oneOf:
+      - const: actions,owl-soc-serial
+      - items:
+          - enum:
+              - actions,s500-soc-serial
+          - const: actions,owl-soc-serial
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: true
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        soc_serial: soc-serial@800 {
+            compatible = "actions,s500-soc-serial", "actions,owl-soc-serial";
+            reg = <0x800 0x8>;
+        };
+    };
+
+...
-- 
2.31.1

