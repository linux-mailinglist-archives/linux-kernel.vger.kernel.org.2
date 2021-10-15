Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942BB42FDEB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbhJOWNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243287AbhJOWNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:13:31 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44DEC061762
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 15:11:23 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so14801397ott.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 15:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bjNfLq1QB8fLMEsBwBn7uXas0Vm/2KjKssKVAEdSfj8=;
        b=KvsCdlqRbTQxItKSMZiHq3p6Va9Qh3RKVjLBfVJ4SOznSPmvxDzk2kt99hpvY73VYt
         +zVIRzhpTR4g6JMbDOXMdjCFB0vmupv2QOjHMJNhblbhaTy2WG9MSkfncfOmL0h4Lpl9
         g3vresA3V5A0p+v7OaO7R5sLYMhcvbysuFXBk1k/JN09Vsq9vj3AqK4+UnnnX6t1h147
         UDPPpWQQloLjakwbY4hq84Fzch5En+LAHAP1IbI35RnmIruI9uJcg2IQsh42yX+qtY5L
         GP1eJIVO8IouIkTvBldYf8UkUS5qRrfliGNu6DOpGHcfTPc1zwSPTLdVyC7mWZXLMDhl
         24RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bjNfLq1QB8fLMEsBwBn7uXas0Vm/2KjKssKVAEdSfj8=;
        b=pXidOMF5LW1SU22VTLsJ22VyFdyqaGhIMSkNAaZg30cLIED+/OxIl6iLGiUQO4Fl2W
         Y1FY3ItL5vDU4XAkB5+jBkCvvoyi4y60dRR8hhEasFP3+BB/r36/rauji+Gv0hFfyIMu
         trORZs1DD/e4l610/Q3F4ap5QVzWOOd41ZR0C4l7PB+x+vRueoEHEvLkX18IVIBQJ4yp
         9YcuCTW6Dt5ib7zwjucE+8NC/JxvJ/d/Iaj+6Itm6V99kD+RkxmYHR1Gwo30UoPBeRhI
         5ZG0aifFMIpuJ6cDnzOUcQw7hNWZ8JCE6331bYGdMIacAa1lCddJ5d9gzvAFZlJ0rCt0
         Xr0g==
X-Gm-Message-State: AOAM5318cQYI1OKKNXcizQCVugKwncRcfWB14NRlbKzcJc2WtvJ5n5Pu
        V/rm5xrO1GhLl/7LOVBlTrXicg==
X-Google-Smtp-Source: ABdhPJzXC14+f95z1L9QMi3O+ePps8LkjmJida0VipaUCsJGioxCOn1qwVYVKGBFEFjwPVeB8Xlzsg==
X-Received: by 2002:a05:6830:30a4:: with SMTP id g4mr10125929ots.312.1634335883234;
        Fri, 15 Oct 2021 15:11:23 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id f10sm1599635otc.26.2021.10.15.15.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 15:11:22 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        abhinavk@codeaurora.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: phy: Introduce Qualcomm eDP/DP PHY binding
Date:   Fri, 15 Oct 2021 15:13:11 -0700
Message-Id: <20211015221312.1699043-1-bjorn.andersson@linaro.org>
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

Changes since v1:
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

