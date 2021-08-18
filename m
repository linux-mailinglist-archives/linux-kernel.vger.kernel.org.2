Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C7A3F02CA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 13:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbhHRLeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 07:34:44 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:38834
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233798AbhHRLei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:34:38 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 3EF963F09C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 11:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629286443;
        bh=xf9DtxhwlDMZTjASHbiI97nvVp/QO2eQKaINmZtiMMI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Ls5IdmESzQKd3VvY7JVN5VGyEnGSXPJkwFXVNRkvAByAa8ztlvC8CidH35U1cSNEm
         e4+rtNz7zgu61Wf53qxPY66eRqMcZ6R0GVN/y+GGX7AUe3CHFgmtY914hLRFHyAVdG
         PXwa6IJG/HijgnnXgNeG+FI9KO+BwSvZEZZcsZ5xb/mQEiqQnptFR7M6GEucpmIDlU
         uTDs2d/a2nGuE4czxzeNrkDik1/wgzye0A8vpZrR+ER+C37GUU2D7qluRyBEcxyIBI
         aKjE+NOpAizkm4VO8oSegwLF6GfxWcWzZeGwPLIJJQRMz/KJ4gkprOIYIS36bjciU9
         ZMheAr9U+sG8w==
Received: by mail-ej1-f71.google.com with SMTP id x5-20020a1709064bc5b02905305454f5d1so746401ejv.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 04:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xf9DtxhwlDMZTjASHbiI97nvVp/QO2eQKaINmZtiMMI=;
        b=Ishqx7HxW+V7NV+1W9AR5EkHY4lWOEixE2y1RTx78PLJ5Wy0ycb1tIbtOovh4n7aGM
         uvf/nmrsFKH31/hG3NLyyMnbU0+7MQtKrcS1BjxHiybVX4VVyDAqEG9tuM48Pw41XICg
         ukQvvWctIPVaiJQ/1Jh+Uwbo1/TOh8BUm4v++i7/B0QWOSD55xnBjZKHJR4fuwQdy5B1
         Ubje7++XZlPjyCELHtyyVPCeEoInnttr/AAAgQS42aXasV9js3th6cONE2dM8CuFosfj
         a8yirEXdCXVHudCG0sn7IKVNjjmRAlp/VjC4UOGP3T6OuTgBmMWHPVJVC6spg9Gq9/jm
         4tSg==
X-Gm-Message-State: AOAM5316xF3apWHeCriQRHSQc1TgrvCJWoblMVihJY6C1flCXVJH/Y+m
        pLaZZjwltgGlPZ1gh1xrozIk2zs1YUeNKqpkJjWhcNIZluQeh6u06IlAI/j8ZKJo2xgYImiILIf
        AQvNmPj+qg1E8rhh28Laoczt0OtdZPL1TjKtIeBq8qQ==
X-Received: by 2002:a17:906:659:: with SMTP id t25mr9215116ejb.372.1629286442984;
        Wed, 18 Aug 2021 04:34:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGzPrE/RG8ucAVA49HtztLd7MsD18XKgb/JFNMyMjUCTwg5+ASBfW0PxVirFnRVVQtf10CHQ==
X-Received: by 2002:a17:906:659:: with SMTP id t25mr9215107ejb.372.1629286442836;
        Wed, 18 Aug 2021 04:34:02 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id s10sm1903141ejc.39.2021.08.18.04.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 04:34:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: memory: convert H8/300 bus controller to dtschema
Date:   Wed, 18 Aug 2021 13:33:25 +0200
Message-Id: <20210818113325.85216-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert H8/300 bus controller bindings to DT schema format using
json-schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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
index 000000000000..70487bb685cb
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
+    oneOf:
+      - const: renesas,h8300-bsc
+      - items:
+          - const: renesas,h8300h-bsc
+          - const: renesas,h8300-bsc
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

