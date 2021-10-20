Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C56943540E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhJTTxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhJTTxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:53:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712ACC06161C;
        Wed, 20 Oct 2021 12:51:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r18so375170wrg.6;
        Wed, 20 Oct 2021 12:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rEPbVntSVNxrbhdJwi/7dPL1juvL8UMRg34+Vcw02A0=;
        b=D/944o960+AH1AnjpNsW45QQHAF9MVw6BSZrk4pfxU2gI9dBiY5WPhpDd6+ywu8KrU
         wnuGJ2D+ozGuRZhF3VDb0scNqPzShxH3/1O/5BVmMKqm6qv4nUWpjRaH6hV8HNEZ8dCE
         9w15KoJC3/s/LYdU/hAIWgcOHA3u51n1HWkY5iZjKspGIMPVEiwU9SIhfKAx+9R86O6x
         433Msh5C8uo8lUTItNR5Brif130MPX1rOpYAzGM7iGoOdt+cFVeo0/bA3PvjJE3Gq2Qb
         wGLpn9R1fj3462kGLRRjwZ+nsKI/c9o4d5JnWDaNhVWPZJtgqGwvWdAhMEizAPjMCMOE
         gqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rEPbVntSVNxrbhdJwi/7dPL1juvL8UMRg34+Vcw02A0=;
        b=614Ja7TY07w42mj8skwx9QzfcgfxThaobong580NJ+Y3ZkrDdPevOIZhuNomrZFvce
         ToFSQ3hSA6mN7PVI3jYnA+6NsqNlPL9a7oZlsoZiMFfMJLGwrmywsRhKXJ9hYFii1cvx
         W6oEqYxdIpl2XMLIYSpIH+AUkt71gmYFMYO13CRaqeReKZoASfuv/5bYb4w+uCfhElz2
         Dtq+UZmQ6Gcg7oJXQC4wgjY/AAwAQ088Nsic8mvR1qtrckqII3+V9E4PfpCHFcuJ1cRs
         S0P0u5WlY56Gp3fTbkdxheALYrWVnIKzH/Ol1jjB5+lVkSV+n6byit1ze/olxncYlw07
         UPNA==
X-Gm-Message-State: AOAM532lsPEmBoP5MWB7aE2rDpxm+c+W6uYEPv7wID9P0VaIestad0I1
        Kcj9Ayusf/dyZN7bRtMRVR8=
X-Google-Smtp-Source: ABdhPJyrDaJa0UTdawpxf/nBYOHmNqDCNEkIFFaONFmF21uOpkE6Y/wVQ3QwqYaFe/BIxGKf1hNttw==
X-Received: by 2002:a5d:47c3:: with SMTP id o3mr1581002wrc.25.1634759488962;
        Wed, 20 Oct 2021 12:51:28 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-b9f5-df00-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:b9f5:df00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id f3sm2741310wml.11.2021.10.20.12.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 12:51:28 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, kishon@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 1/2] dt-bindings: phy: Add the Amlogic Meson8 HDMI TX PHY bindings
Date:   Wed, 20 Oct 2021 21:51:06 +0200
Message-Id: <20211020195107.1564533-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211020195107.1564533-1-martin.blumenstingl@googlemail.com>
References: <20211020195107.1564533-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic Meson8, Meson8b and Meson8m2 all include an identical (or at
least very similar) HDMI TX PHY. The PHY registers are part of the HHI
register area.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../phy/amlogic,meson8-hdmi-tx-phy.yaml       | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
new file mode 100644
index 000000000000..1f085cdd1c85
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/amlogic,meson8-hdmi-tx-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson8, Meson8b and Meson8m2 HDMI TX PHY
+
+maintainers:
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+description: |+
+  The HDMI TX PHY node should be the child of a syscon node with the
+  required property:
+
+  compatible = "amlogic,meson-hhi-sysctrl", "simple-mfd", "syscon"
+
+  Refer to the bindings described in
+  Documentation/devicetree/bindings/mfd/syscon.yaml
+
+properties:
+  $nodename:
+    pattern: "^hdmi-phy@[0-9a-f]+$"
+
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,meson8b-hdmi-tx-phy
+              - amlogic,meson8m2-hdmi-tx-phy
+          - const: amlogic,meson8-hdmi-tx-phy
+      - const: amlogic,meson8-hdmi-tx-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    description:
+      HDMI TMDS clock
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    hdmi-phy@3a0 {
+      compatible = "amlogic,meson8-hdmi-tx-phy";
+      reg = <0x3a0 0xc>;
+      clocks = <&tmds_clock>;
+      #phy-cells = <0>;
+    };
+  - |
+    hdmi-phy@3a0 {
+      compatible = "amlogic,meson8b-hdmi-tx-phy", "amlogic,meson8-hdmi-tx-phy";
+      reg = <0x3a0 0xc>;
+      clocks = <&tmds_clock>;
+      #phy-cells = <0>;
+    };
-- 
2.33.1

