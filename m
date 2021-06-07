Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4B039E06C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhFGPb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 11:31:56 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:37758 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhFGPbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 11:31:52 -0400
Received: by mail-wr1-f52.google.com with SMTP id i94so13065586wri.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhIJnb1mQgSu0gmVypIYBdkC4S9c9PzuSNZQUQzKNNY=;
        b=tJomgDBcK0JlDDBHG5N4A3BmQEbquxf/O+e92BfCz1qRVRtleR1Gts4Bcopx/S8yPc
         PSeQZgiL1dD1/JGrQ4BFWbn5oTDzImnqmkHsaiklkOHGP+QZt1np1zwzHgj7a8lRGfz7
         jFh8V2AgiF3Al1+38L+Tuh/iFpimcfMzdLjgyNrL5R3n+lkl3G/c78MzwQxYo5zLWBed
         Qk/uSVj/DKFcEeqVMw6xM5ffu2RN0ZHw8P1Gr0nrFOk3H6gqFsKnxUK7obO3YHHikvCi
         munwdxAkLd+ePvmnY3wBDKUs582u9syKeh/2EyzUyt4PMfTxtNl5FzL/hlTNwHDPB/46
         kM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhIJnb1mQgSu0gmVypIYBdkC4S9c9PzuSNZQUQzKNNY=;
        b=DMoPgOYrfdfJjP8TthcTkxNBck82xvJl4UZI9BITNyuDXTsPD9qGEO4im8k5dWFD5a
         FPp/x+CC1ke6TFlee4oCHdLEeqw+AmJtxz4ClqmbDuGu+JzzviEf4+3KNhWns9g+lC4g
         h+9xdtpNlVOqIr18F9diNkjAAyvUoRCcRLKwYS1qrPVBObacIPkCgU56MnDBoNhLZsI2
         y2t/hlaQGvjBLvgz7BTGhs3Q29uH6b1PLhH/g4N9Sm5EowhFIPGTw8eUeNcVvnfMM1EY
         w4WY6J3dnCO1ByDB0YJ42eVxbQxZDYLEF1vdiBzGhhQY5vd8i00b8i6019m4pryPlJrj
         B3gg==
X-Gm-Message-State: AOAM533ZctMNxftugX3Y4bmaFWdrxKtOD0oCW/qHzEy+nGQOrw9FDCWR
        TzAQRVEt+QKl2axMmJf3f4dhuw==
X-Google-Smtp-Source: ABdhPJxNjr+z1V7LeyDaphGfhZjV6FSkbENIz0QIxQc48rGOBMJhjuXyt948w4Tu+t6N1YbdGRa2Sg==
X-Received: by 2002:adf:f98e:: with SMTP id f14mr17786882wrr.408.1623079740401;
        Mon, 07 Jun 2021 08:29:00 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q3sm16370170wrr.43.2021.06.07.08.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:28:59 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, broonie@kernel.org
Cc:     plai@codeaurora.org, tiwai@suse.de, robh@kernel.org,
        devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 01/13] soc: dt-bindings: qcom: add gpr bindings
Date:   Mon,  7 Jun 2021 16:28:24 +0100
Message-Id: <20210607152836.17154-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210607152836.17154-1-srinivas.kandagatla@linaro.org>
References: <20210607152836.17154-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm Generic Packet router aka GPR is the IPC mechanism found
in AudioReach next generation signal processing framework to perform
command and response messages between various processors.

GPR has concepts of static and dynamic port, all static services like
APM (Audio Processing Manager), PRM (Proxy resource manager) have
fixed port numbers where as dynamic services like graphs have dynamic
port numbers which are allocated at runtime. All GPR packet messages
will have source and destination domain and port along with opcode
and payload.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/soc/qcom/qcom,gpr.yaml           | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,gpr.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,gpr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,gpr.yaml
new file mode 100644
index 000000000000..cc08ec51de6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,gpr.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,gpr.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Generic Packet Router binding
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  This binding describes the Qualcomm Generic Packet Router,Shared Memory Manager,
+  used to send and receive packets between Audio DSP and Application processor.
+
+properties:
+  compatible:
+    const: qcom,gpr
+
+  qcom,glink-channels:
+    const: adsp_apps
+    description:
+      glink channel associated with gpr function
+
+  qcom,gpr-domain:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 3]
+    description:
+      Selects the processor domain for gpr
+        1 = Modem Domain
+        2 = Audio DSP Domain
+        3 = Application Processor Domain
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+#GPR Services
+patternProperties:
+  'gprservice@[0-9]+$':
+    type: object
+    description:
+      GPR node's client devices use subnodes for desired static port services.
+
+    properties:
+      reg:
+        maxItems: 1
+        description: Service port id
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - qcom,glink-channels
+  - qcom,gpr-domain
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/qcom,gpr.h>
+    gpr {
+        compatible = "qcom,gpr";
+        qcom,glink-channels = "adsp_apps";
+        qcom,gpr-domain = <GPR_DOMAIN_ID_ADSP>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        gprservice@1 {
+          reg = <GPR_APM_MODULE_IID>;
+        };
+    };
-- 
2.21.0

