Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC68F43059E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 01:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbhJPXWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 19:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241159AbhJPXWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 19:22:00 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1EDC06176F
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 16:19:40 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so660124otl.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 16:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FkP4lqvH6ZOJT/fX9WTaeVqu3z8mUf6wLhul8KmE4w0=;
        b=vD9EOlTSpylZht/VGRfDs5EMGozH3jPEpImOoRhKP5/9TwZJFttyZQ2wmgMQSMKJkR
         IYVcZQ7ZJ6auJ6l/Aa8stcncMYx6dNcWGO6ANMy7G7lKbapCA2bAUAIHseuCKUke7yMN
         T5QPn2PW5L+ZQ28hspIUZ3nFnOfMw+640Qbvb7P2H+PUK8/U2eMMWlsv61s7c6vssyR+
         rSx4KBgqv3xkFl2heF9JsYyVT2Yil/e9DmgsbRskuRWZRxgnkwTGwPJVppdBUtXPWcXe
         pnfO/EfogSnw4pGrMy3u3crgTBSSY656wdLtknbiDXW3owJ/jJKEJtkXW5XMcK9unr9S
         mfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FkP4lqvH6ZOJT/fX9WTaeVqu3z8mUf6wLhul8KmE4w0=;
        b=SAlsEXkuPbs49m6KbgFDxzPMmetAelN65zhkhOeg4MbzHtBv94ueHyP7Ar5qTk88PV
         q9gZ22SYGzR6a9BwWWa1ecabJY9EfV8JD4ZJz+56aAMZkQettC/64zHKuDm5nIcV1Ejm
         JCpxjlU3vV3A37BnAAQX6VaZClltGA3PBUaGEmrmcs6KIPA5swHMx0XsySEnC4kuIgzn
         yW1xycFD3FDRlDC7b7COUZLS5F2tNPpO4XYCh/z0Za1ujGo0Z9DQJJ9Kc0hiYSN2BA3X
         AxyTc5rNhiC1PHMMEMslViwwmoClm2PUmtO1ftdh+sPac1KCeQxNzVV4C6lqGzlqqLUX
         8ldw==
X-Gm-Message-State: AOAM531Kl1oPaOrXt73QPFZfck3d7oZ3FzgkP9PsOBhEiM7/pe9Jh/0V
        M1a0XUK+0VGu0/gl/ShjSUUoYA==
X-Google-Smtp-Source: ABdhPJx7dvI/TRBqyslSRyo6qlBeJ/yPa6weJz1/rB3rtJ+fUFVYJ7Nzy1AXN/wII8aeWu24ugjkZg==
X-Received: by 2002:a05:6830:442c:: with SMTP id q44mr5450606otv.154.1634426379977;
        Sat, 16 Oct 2021 16:19:39 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id l8sm1430287otv.8.2021.10.16.16.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 16:19:39 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        abhinavk@codeaurora.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: phy: Introduce Qualcomm eDP/DP PHY binding
Date:   Sat, 16 Oct 2021 16:21:27 -0700
Message-Id: <20211016232128.2341395-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a binding for the eDP/DP PHY hardware block found in several
different Qualcomm platforms.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- None

 .../devicetree/bindings/phy/qcom,edp-phy.yaml | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
new file mode 100644
index 000000000000..c258e4f7e332
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/qcom,edp-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm DP/eDP PHY
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  The Qualcomm DP/eDP PHY is found in a number of Qualcomm platform and
+  provides the physical interface for DisplayPort and Embedded Display Port.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc8180x-dp-phy
+      - qcom,sc8180x-edp-phy
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
2.29.2

