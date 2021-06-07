Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6312239E06D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 17:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhFGPcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 11:32:01 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:53977 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhFGPbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 11:31:55 -0400
Received: by mail-wm1-f44.google.com with SMTP id h3so10324485wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 08:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mfKfpXv/FKdYTJyCyYtnDd8R2p7FnhZ0IR4Bym/nKpw=;
        b=wkGj5rzV3qM3xQWilS7mtTQPd7a6twRqhOOKcVxbYhqE2syUo/m8UuljhncuIX9041
         Wt8F1/JKhLFqbAnW+v1Isot3jcFABJIfvfC7Gi/HUZFXjNPHjShRXZjmeH4eKWkAjuJ3
         1Y66Wf6iOOxGxJnjrQnGAhR/niTCC9pgb3cE9sg+Zh12cXSaVosbwB10jdGfNstDimh+
         8rEtZsq/qnKKtyWscjp1uT3vPYZsQXqtiYvOhhYIDyi4o1W/vO85NPq/Qu/w9MlbuE6o
         HPqGCy3hVFz/FVwO9nsREO6j+w2SSDiFntKjmnGy7gObpnOcRzgeuLrj3bbclq3fWt9b
         gTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mfKfpXv/FKdYTJyCyYtnDd8R2p7FnhZ0IR4Bym/nKpw=;
        b=g+9GpXtlEmMtXYRYtMviZdyo4Zb1Wc6q7ZOXLt0lAxZqoJnJzNqbDb05Su7jBZbS17
         +PVPhVIOyzZeB+uWtd0JoaZ6lT4xhu9AOtX2+KCYssp4hCQVcxMUJpwYHcATM0JxT5ON
         EWKp320rdHoa3zXGxgzuarYREAnGZ33ysPTVO4O9mWX+zPMBqX7OE0khuV3mZYqHnzQ9
         +gCFljJR1t2rqo81U7lCypHVVPeZjNSHWHyfHd5E/YYlJ1Ev5gNo6WKjEqHqBld+BoKg
         c09/dcvMEcgDjBO5DKMbs3jOxcNewetABW9Jac15Mqmex3ezivb3Jr73vlPyy2cre4Q1
         9OdQ==
X-Gm-Message-State: AOAM533x5V6J0Okfno4JLyCFQPAtfX5sODF/aKywq0ARgx88bRZy2KPJ
        OaB+WUBHA8WvauPsqpdfhoHr0g==
X-Google-Smtp-Source: ABdhPJy+jo33/oQr90rG/P8vhsQ6lSEYBZ5NX0gOgrtpJilMBrRFqEc5ESz3yGSXx9CXMpc+/zBhLA==
X-Received: by 2002:a1c:32c6:: with SMTP id y189mr17515101wmy.54.1623079743076;
        Mon, 07 Jun 2021 08:29:03 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q3sm16370170wrr.43.2021.06.07.08.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:29:02 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, broonie@kernel.org
Cc:     plai@codeaurora.org, tiwai@suse.de, robh@kernel.org,
        devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 03/13] ASoC: qcom: dt-bindings: add bindings Audio Processing manager
Date:   Mon,  7 Jun 2021 16:28:26 +0100
Message-Id: <20210607152836.17154-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210607152836.17154-1-srinivas.kandagatla@linaro.org>
References: <20210607152836.17154-1-srinivas.kandagatla@linaro.org>
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
 .../devicetree/bindings/sound/qcom,q6apm.yaml | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6apm.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
new file mode 100644
index 000000000000..9906ef935206
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
@@ -0,0 +1,72 @@
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
+#APM Services
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+    description:
+      APM devices use subnodes for services.
+
+    properties:
+      compatible:
+        enum:
+          - qcom,q6apm-dai
+          - qcom,q6apm-bedai
+
+      iommus:
+        maxItems: 1
+
+      "#sound-dai-cels":
+        const: 1
+
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: true
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
+          q6apm-dai {
+            compatible = "qcom,q6apm-dai";
+            #sound-dai-cels = <1>;
+          };
+
+          q6apm-bedai {
+            compatible = "qcom,q6apm-bedai";
+            #sound-dai-cels = <1>;
+          };
+        };
+    };
-- 
2.21.0

