Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0BC40A44F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 05:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbhINDWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 23:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbhINDWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:22:19 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B852C061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:20:52 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q68so11369327pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tTEiTbO1ZH85XonKLmdTYGjcvfIzkgPG2492l17rrOI=;
        b=o0Wp+y9Oc1SJtQMVmXF5bDY6z8etnwqllWaOXlatEAHh6g/e8PFaZ5snnZBs++t+oc
         rGt61Oar74qZzrkPtfF6qRGdWrsK4weJGlCy4H3WQ2Ob5CEvVMRFeOC9PCTJ3l0YU+JJ
         xs4K66GUk3C1rkGaPeA9+6kLMl9ylzRukNiKnBUHBaVWvhTsbgpN6x3zwMlCFFwNxhwR
         +BGmWYkMSGsSQGzrbcXxlCXjx0rJxg0e8fY+wYOq3i64Cs/zbiL9zJ0Trfafq9sei6Yc
         9UvVLyDk1HlWbkwhSW8M3LvOc6PzZoz8ICTi7lZZBZPZHL/9AAlEILSaqnFA2rRJM1vs
         BgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tTEiTbO1ZH85XonKLmdTYGjcvfIzkgPG2492l17rrOI=;
        b=RLSQlm8gtx3FinHYiCIsIyz7U+rNa02yGbt6TgHCEs81kn/CY0lNfqDgg5lBuxYkg/
         68mAPL2x08dzIO6fsNdz2dLCO9gecibhx0dqQhiWF2eML1Cd2k8HQ6Y6dUTXd/uM3rhG
         0pJ1P4ZxBltrEkIRlVSco/WQEmrBHSZOXNMEB451rnU4kPJbonrkx4ayCHtGi67880mF
         TrbBgvZ8ibtbiXA6EIuucqYvWvRINymoP0IFf3FXSxVZ/n/fj3dmkDBgxZjwo2iO4i9V
         XE9WR5aesuXK+s9quBDUEo32JZn6XfGpX7/q7so4hV5bZkdGgAWpAy7TXwQbEMq33ELs
         dnrg==
X-Gm-Message-State: AOAM533nijrUJ0p1lsJhRQo8mRv8gskszKXTYLH7zjVTMAAhldA+1zCg
        PfJJT/jcLlA5PWi8X083/QiT1g==
X-Google-Smtp-Source: ABdhPJxc67ZwkwMeb3rMevjY1tOcyCMODfRBsnj+wvzInM8/hFFQTju7+UhIiGnXaYQeha86SFNgYw==
X-Received: by 2002:a05:6a00:14c4:b0:412:444e:f600 with SMTP id w4-20020a056a0014c400b00412444ef600mr2488264pfu.83.1631589651751;
        Mon, 13 Sep 2021 20:20:51 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id t68sm9714498pgc.59.2021.09.13.20.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 20:20:51 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/2] dt-bindings: clk: qcom: Add QCM2290 Global Clock Controller bindings
Date:   Tue, 14 Sep 2021 11:20:40 +0800
Message-Id: <20210914032041.6547-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210914032041.6547-1-shawn.guo@linaro.org>
References: <20210914032041.6547-1-shawn.guo@linaro.org>
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
index 000000000000..f8130d8ce259
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
+  Qualcomm global clock control module which supports the clocks, resets and
+  power domains on QCM2290.
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

