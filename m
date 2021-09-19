Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABBA41094B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 04:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhISCfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 22:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbhISCfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 22:35:16 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD70C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 19:33:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso5509721pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 19:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a4c6z0cG19n6c2Zm1N/qnshB5WpgXDQ8GkP6YBttexA=;
        b=S5ZRZdGmMq/mZyEyQeQ5mZn5wHfIRJ5rpEMLrY9lX4OYgULXmMb1lUeNY3x12eRSry
         hwgJowVIBbKjmj4PbzBAbBX8SR10kCU6UiPUrm4AhmnIXkCIFdzBQg0tF8Vlh80GZzAu
         cIT/EAeW2M6lqU7kFlsAU2IM6RQIZnnObpi3ywrNUTAlGExFbYzC7gwmLBXBnrBp7t3I
         yUfeF73PNJrKwE4smMIBkjqDJvb7Tjmxy5/08LW3QHeO+cAiFA1ST5eAIpyvxLE9UVGf
         qXSJhGbQagZpjvH4ozyQgA4bv/BlduQlbKZZgmzdEQcG5r6WCifPG6DrHRqHlmGu2oB8
         aztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a4c6z0cG19n6c2Zm1N/qnshB5WpgXDQ8GkP6YBttexA=;
        b=Oh8LaYxx1fA9qC2/POgs9aOi9hXHUus4glRvCMpRCbXNXbD7f3nYl0KQ3TwAMe/9PO
         mVe4WhNYNjw5NNHrIb/B99OVh/BMfpzNJeGbwpYN3FNHml+8uzxCchpxdESYWUNjFdRP
         FGZ2ikNxyLhiqNuh/ttQjSQQK12oFQf6pvvCOsLQXg0qy4kX1eFyd5yt8mRI5YUEjZT0
         P6Lciw/tdXTadW6RGHEFu9B8ANS6XLJUH3DgTy5n76CHlpyfUxl2TRVswa/oAH7mdkaz
         XskYELyA6AF7H+WfON+Br91R/G54Jm+aworzJnNcKXriJj3IkQdJzcZYcp/51EdX0htP
         FSqg==
X-Gm-Message-State: AOAM531V2ceBB5uXZW8jpdl2E5jo0RbHHYNB9vRO3M+rTxFWMZhewZJh
        O+0HX0ncnghg5PE1nRV/TnDCkw==
X-Google-Smtp-Source: ABdhPJxLEDVhGMswAi3nQk8FGy9AuYDc8JV/2BTH1k20Qaz/O1bDvvnax6L6aabxA7ROW7N+ScKI3w==
X-Received: by 2002:a17:902:ce83:b0:13b:67d5:2c4e with SMTP id f3-20020a170902ce8300b0013b67d52c4emr16697787plg.45.1632018831749;
        Sat, 18 Sep 2021 19:33:51 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id t13sm9316687pjg.25.2021.09.18.19.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 19:33:51 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: clk: qcom: Add QCM2290 Global Clock Controller bindings
Date:   Sun, 19 Sep 2021 10:33:07 +0800
Message-Id: <20210919023308.24498-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210919023308.24498-1-shawn.guo@linaro.org>
References: <20210919023308.24498-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds device tree bindings for QCM2290 Global Clock Controller.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/clock/qcom,gcc-qcm2290.yaml      | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qcm2290.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-qcm2290.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-qcm2290.yaml
new file mode 100644
index 000000000000..5de9c8263138
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-qcm2290.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-qcm2290.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller Binding for QCM2290
+
+maintainers:
+  - Shawn Guo <shawn.guo@linaro.org>
+
+description: |
+  Qualcomm global clock control module which supports the clocks, resets
+  and power domains on QCM2290.
+
+  See also:
+  - dt-bindings/clock/qcom,gcc-qcm2290.h
+
+properties:
+  compatible:
+    const: qcom,gcc-qcm2290
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Sleep clock source
+
+  clock-names:
+    items:
+      - const: bi_tcxo
+      - const: sleep_clk
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  protected-clocks:
+    description:
+      Protected clock specifier list as per common clock binding.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - reg
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    clock-controller@1400000 {
+        compatible = "qcom,gcc-qcm2290";
+        reg = <0x01400000 0x1f0000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+        #power-domain-cells = <1>;
+        clock-names = "bi_tcxo", "sleep_clk";
+        clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&sleep_clk>;
+    };
+...
-- 
2.17.1

