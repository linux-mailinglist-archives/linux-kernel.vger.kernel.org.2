Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1B5444BC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 00:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhKCXpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 19:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhKCXpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 19:45:07 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109EEC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 16:42:29 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id g91-20020a9d12e4000000b0055ae68cfc3dso3124601otg.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 16:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+d/nRNEJxMOGI8UBycJTdeWCVBuzJgHXdG+LEv8+0j8=;
        b=JdOhq/HClnkGQS23jj6+31XHbNjiGlAwL/9e+IkZq4KCzp6TBfQfQwOuaSNnz3mZ26
         PlbKAYYNhUOdB4keuDUdyjekriD7+uNjdQgokuJwRLqQLVtyZw6QWoinUwqLvfCeaLIg
         hLB4qyUkIJ5DhTRJ2XXjoObV6HnbePNoYOHO75e2AeO07einwNwz+6KTAwvmbt1i7e5l
         AxRYlzqm2ZNFnsGrhw10F7xiR9fRTGbNH3OyFh+fa1U09OjMBl8WNr8yn5dbL4R/TEqj
         dqZXVYW+AyfXaSmwe64OwIRQa0iM+PchBhj0sPXyOpcOWezySxDOzLLWRYKdA25hhObG
         SfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+d/nRNEJxMOGI8UBycJTdeWCVBuzJgHXdG+LEv8+0j8=;
        b=m7SonNT1IyLyAxpBpvZ67zL/m6XBH6uD+ymiQbjUoMV69oyMfOGaNdbJVWM54fjxYS
         6bbsfforfIKMnFLhwfyt290GWPqn2B19uC5zmXpe9Fmd4lUwTMju0RpwdDM+mM1egxji
         IjEYBJLhFDeXWcASEe2VOpCx9Uy0bZqqnczFxNJOakCEJvpm7UpszhwimUVrKg8sMerF
         fZzSkky9yTLliZAM/QCU5cXf7YfZUBbrITPGfSf6KBRpL5/Zdokkedvpeuc7cgonw1oM
         NK3AWtx5YOylFlQh/M4YsOpMwgRzIzVlLVYNFRYs+2d2g4FGQ1jqLjl8/UoeQHhdYGB3
         08iA==
X-Gm-Message-State: AOAM5336jJ1yc4jFTRNMFanofEAnZErq52fUr5vsimSEkF5oekci8K7v
        brZLkF7dAzNUBufMqnvWZPU1xQ==
X-Google-Smtp-Source: ABdhPJx5/8ld6TaAtiYbuEiJO1GUBBEeX7N9PmwIjai1+k5TueK58Gpxyb1gPjDsoHRqWT5bBmy0mw==
X-Received: by 2002:a05:6830:12da:: with SMTP id a26mr15102946otq.318.1635982948408;
        Wed, 03 Nov 2021 16:42:28 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c16sm885139oov.32.2021.11.03.16.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 16:42:27 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: phy: Introduce Qualcomm eDP PHY binding
Date:   Wed,  3 Nov 2021 16:44:09 -0700
Message-Id: <20211103234410.1352424-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a binding for the eDP PHY hardware block found in several
different Qualcomm platforms.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Dropped DP compatible from the binding

 .../devicetree/bindings/phy/qcom,edp-phy.yaml | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
new file mode 100644
index 000000000000..9076e19b6417
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/qcom,edp-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm eDP PHY
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  The Qualcomm eDP PHY is found in a number of Qualcomm platform and provides
+  the physical interface for Embedded Display Port.
+
+properties:
+  compatible:
+    const: qcom,sc8180x-edp-phy
+
+  reg:
+    items:
+      - description: PHY base register block
+      - description: tx0 register block
+      - description: tx1 register block
+      - description: PLL register block
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: aux
+      - const: cfg_ahb
+
+  "#clock-cells":
+    const: 1
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#clock-cells"
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@aec2a00 {
+      compatible = "qcom,sc8180x-edp-phy";
+      reg = <0x0aec2a00 0x1c0>,
+            <0x0aec2200 0xa0>,
+            <0x0aec2600 0xa0>,
+            <0x0aec2000 0x19c>;
+
+      clocks = <&dispcc 0>, <&dispcc 1>;
+      clock-names = "aux", "cfg_ahb";
+
+      #clock-cells = <1>;
+      #phy-cells = <0>;
+    };
+...
-- 
2.33.1

