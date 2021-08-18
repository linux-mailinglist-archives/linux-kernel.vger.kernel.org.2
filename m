Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41D73F0CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 22:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhHRUah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 16:30:37 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:50402
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230440AbhHRUaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 16:30:35 -0400
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 17DFA41281
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629318600;
        bh=afNSlBvYu02DicXjmlIdMONOuSvA1ml27PmqTZLXujg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=gvosiqpASmpHWtMNTBMqs2x21azdEdZlOpTGDPVk3clDgvfTvJn41f4q2xJ795A6D
         56KQTinhUBvBOz7ACdlCiB75c0astNr1gL4w/4u+KKJ6BqSw+u4QUa61We+TA9bw9p
         l4JxfJD1+pRfINUiTRzo/jYXRKsD54P8QvomK5OTDV7hYT3beYtU0+LITZrClpLN5H
         MFLk5mxyUh9od89uuGGg5MF3figueQUUjXiEGyuz5CeZE92aGbHzZH2bHZEb9zfbvX
         KBY1r4mtgeZQ0JBVAwF5w72u+QEFmdNLCmy4IoF2LVqbj7d5RA+oVy4FvCfnDj4yq3
         xxfiUBqc8NjcQ==
Received: by mail-ej1-f69.google.com with SMTP id q19-20020a1709064cd3b02904c5f93c0124so1310272ejt.14
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=afNSlBvYu02DicXjmlIdMONOuSvA1ml27PmqTZLXujg=;
        b=cG7XZdNZc+/oAvC5A0Jxgb8beoz0yc35bAI7Mli7/ww4b3JyhPQ90GBpMw3wMH8EkL
         vUdMQ5s+/o48xsdBSsooNlNcdQoVdIgGcaGvpXCf9t8RKsFM6sd3LKrZLaTzWpHjCHOQ
         9HIn+398voR8202mJcH3MbgW5r3xa21LO2xx3haB5WfBtsEBk+39YN351zXZ33FE/ySR
         BgYAincqX5fegLYBb3iu/vUXsq6cRhACzaQ+u1WODabAqqFXqVyK4WbUaN4+r0inkNki
         Wav/pRgMTHiN9bHzltntkN6ao7sxC9lyx6xiw0Eis57IxhQh+LlpcS52d6a+PFCTztET
         5NGg==
X-Gm-Message-State: AOAM531t9cxez38gP1JD8TeBkE9l2SMSd6YbVPJT98SLziV8cuOHAruX
        s6SZgJeVncuh+d349SFfVmqBMvcRmdJkgALuKZSZYHKNDgfWpMJ9cnbJDKj32YaUHprDtkZ//cT
        LmosrU659OJFGjY2LmAy+AiGSg/8DAfsNsoGWUaOf3w==
X-Received: by 2002:a17:906:b09:: with SMTP id u9mr11332283ejg.496.1629318599349;
        Wed, 18 Aug 2021 13:29:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlUwyt6DegBZjxkBvS1uKXPBCiQbCpt2q/GzSfMQsrwy3+z3k3UkYEhAMP6kPHoNFybCXXjQ==
X-Received: by 2002:a17:906:b09:: with SMTP id u9mr11332256ejg.496.1629318598975;
        Wed, 18 Aug 2021 13:29:58 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id d3sm589073edv.48.2021.08.18.13.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 13:29:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: memory: convert H8/300 bus controller to dtschema
Date:   Wed, 18 Aug 2021 22:29:53 +0200
Message-Id: <20210818202953.16862-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert H8/300 bus controller bindings to DT schema format using
json-schema.

The conversion also extends the bindings to match what is really used in
existing devicetree sources (the original file mentions only
"renesas,h8300-bsc" but "renesas,h8300h-bsc" and "renesas,h8s-bsc" are
used with it).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Add renesas,h8s-bsc pointed by Rob.
2. Extend commit log.
---
 .../memory-controllers/renesas,h8300-bsc.txt  | 12 -------
 .../memory-controllers/renesas,h8300-bsc.yaml | 35 +++++++++++++++++++
 2 files changed, 35 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt b/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt
deleted file mode 100644
index cdf406c902e2..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-* H8/300 bus controller
-
-Required properties:
-  - compatible: Must be "renesas,h8300-bsc".
-  - reg: Base address and length of BSC registers.
-
-Example.
-	bsc: memory-controller@fee01e {
-		compatible = "renesas,h8300h-bsc", "renesas,h8300-bsc";
-		reg = <0xfee01e 8>;
-	};
-
diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml
new file mode 100644
index 000000000000..2b18cef99511
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/renesas,h8300-bsc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: H8/300 bus controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,h8300h-bsc
+          - renesas,h8s-bsc
+      - const: renesas,h8300-bsc
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
+    memory-controller@fee01e {
+        compatible = "renesas,h8300h-bsc", "renesas,h8300-bsc";
+        reg = <0xfee01e 8>;
+    };
-- 
2.30.2

