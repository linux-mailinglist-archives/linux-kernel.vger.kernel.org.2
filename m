Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F433C8783
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbhGNPd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239686AbhGNPd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:33:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC53C061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:31:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m11-20020a05600c3b0bb0290228f19cb433so4186035wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UrNm6WC6FkrE8NCfyfqxMMW9r3LTd4X3kSslIi+iafU=;
        b=c7nJy1CCafNyk5ARpsiv/GYzpBo97LDBfVc80FFOF4i68EHkl2hENl466304IAHD8G
         yYw0pOQteFnLeco5tvonZN3X7BTWQ5jaHKJ14BbQ/WCwLCVoYKxy9Vsjpkvtvs1vx7yO
         Cn3OI4BJYMEfNhV2v4gMq1XRf/S8GGP7iOFeVjbWbHeeSWjrDQuUJE7gfLsnqV1lFXXu
         YuXkFpwNiDhAqTr+v/XPB6gzozxExO5smbc2rCTIKbYhxoMqyoE3vqoSHRDSR5eAGExG
         49UK23sNKp85mVjdOIe6eOn5fmmypNRHCJQ5/18mPeqLuqp0A8Dhev+MDg0aSSIpdwQw
         z21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UrNm6WC6FkrE8NCfyfqxMMW9r3LTd4X3kSslIi+iafU=;
        b=fNiaIQzJeGuW7LT0Lf78+latY6Y+UFx+PRiM4BsRZUdBuTKwKOUXjVb58cJ/aY3sqI
         vXByoRzwg6iY+aLIwknGpCJkC+4ONZJ4F/tdzbT8wp7YFHj0M1fV6RS/bI6tWoJVFoUJ
         bARQJXoJQEPzkoSGW/26jUVu0UdUMRvZ2DUQrukZmGDU4c4goaG6me5ElOmPQ8Tol++Q
         I25gQGVTa9uH+O6RVxHNZAITj1ZuIytcUMLvOt16LqIp+06PjAGvvnpraXxhJeRl4nRQ
         4udXuht8AwV+mN+6P+ZF6moTYzJ3t1CWJ2wBTUfnsEb81t/ruMcEHhDLHP8IeBGt07Rw
         G+9w==
X-Gm-Message-State: AOAM532hbIH7+FfzGA5fmfsMTrO7aQdKHf6RfRY06ru64MCjOwxVJC6u
        cd7VsCBLcoM4aFCB07gwcS60bA==
X-Google-Smtp-Source: ABdhPJx3HVOA/QLWBWfKgrRTOHSvk6i+9bN+9/LmB4lQSx1wfvv3b6xCndGB0fIYxP+dnpcXcgknRw==
X-Received: by 2002:a1c:143:: with SMTP id 64mr11940913wmb.187.1626276658727;
        Wed, 14 Jul 2021 08:30:58 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id y6sm2465174wma.48.2021.07.14.08.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:30:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     plai@codeaurora.org, tiwai@suse.de, devicetree@vger.kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 04/16] ASoC: qcom: dt-bindings: add bindings Audio Processing manager
Date:   Wed, 14 Jul 2021 16:30:27 +0100
Message-Id: <20210714153039.28373-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings support for Qualcomm Audio Processing Manager
service in Audio DSP.

Audio Process Manager is one of the static service in DSP which is
responsible for Command/response handling, graph Management
and Control/Event management between modules.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6apm.yaml | 87 +++++++++++++++++++
 include/dt-bindings/sound/qcom,q6apm.h        |  8 ++
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
 create mode 100644 include/dt-bindings/sound/qcom,q6apm.h

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
new file mode 100644
index 000000000000..6f27567523a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/sound/qcom,q6apm.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Audio Process Manager binding
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  This binding describes the Qualcomm Audio Process Manager service in DSP
+
+properties:
+  compatible:
+    const: qcom,q6apm
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+#APM Services
+patternProperties:
+  'apm@[0-9]+$':
+    type: object
+    description:
+      APM devices use subnodes for services.
+
+    properties:
+      compatible:
+        enum:
+          - qcom,q6apm-dais
+          - qcom,q6apm-bedais
+
+      iommus:
+        maxItems: 1
+
+      "#sound-dai-cells":
+        const: 1
+
+      reg:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+      - '#sound-dai-cells'
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    gpr {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        gprservice@1 {
+          compatible = "qcom,q6apm";
+          reg = <1>;
+
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          apm@1 {
+            compatible = "qcom,q6apm-dais";
+            #sound-dai-cells = <1>;
+            reg = <1>;
+          };
+
+          apm@2 {
+            compatible = "qcom,q6apm-bedais";
+            #sound-dai-cells = <1>;
+            reg = <2>;
+          };
+        };
+    };
diff --git a/include/dt-bindings/sound/qcom,q6apm.h b/include/dt-bindings/sound/qcom,q6apm.h
new file mode 100644
index 000000000000..3c3987eb6e95
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,q6apm.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_Q6_APM_H__
+#define __DT_BINDINGS_Q6_APM_H__
+
+/* Audio Process Manager (APM) virtual ports IDs */
+#include <dt-bindings/sound/qcom,q6afe.h>
+
+#endif /* __DT_BINDINGS_Q6_APM_H__ */
-- 
2.21.0

