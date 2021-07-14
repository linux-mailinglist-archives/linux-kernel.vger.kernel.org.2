Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6B23C877D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbhGNPdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239647AbhGNPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:33:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51DDC061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:30:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j34so1836718wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xiCF2nRgXBkkZxRW+nKblAu8sGXdLERpAmm5UZ/e/m8=;
        b=SRhSOcNwWN+ksk7Vs4KchDJ5/wH8TgYYFftErjY+9pbOkYNwDha7sNoYZzFCOjEfZc
         lY1Dw+HqNQ8AeiorkcGTa5q2YsGSgM//zTCf4DONWjgNRuN8RgK9qSi6aMfR9NlapphG
         hsimlLmoze5ccvvySMp4Dou4BUjHp6MMGbXq2gvMyECV7Tfh+hBr+BQbAS0JFTM95Orz
         K46foeXTtB2XGa/aB9Ip4syGkC/ulMZba2MyYBBbp16TP+DN2i7yGM2Sbywp6AAzMuXq
         Gt2UJg2fWZAuRCMt+oX7eBebrMAi3BtUJIepBy4DNWc7s3A5IC+EknMgD7u8VlnUhOu4
         gpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xiCF2nRgXBkkZxRW+nKblAu8sGXdLERpAmm5UZ/e/m8=;
        b=KzlXj5TffVSV9Iw/lmoJ/jArRCs6KaBzD+x2z2pt2x5yc6KJT4N9mBo8oTcXcSQOZx
         6fAVdr7a8TYBQpnn01IUmp3Asf1DniMMUcRK8xP0ojMwU8WvN+w8ifYQARu8qWCPjBcc
         D5VZR/UA2I2evpzMlLytha6AQuWzoLn89odiVCFKVo6sw4Amf6xb5xbrr8JET6JXxkwe
         lt4EXTeZTXGj29eS/8Zu56NS0oBUZ22AurSlXmEHICvGyCb5aTB4nMdZpuqo4dTlEqU0
         diuXsUuM5oMbfqWOUodAWsYaleEDnhhm4jEXpxgWu/zg/OplTebJ3aQGEvqn/uws3qly
         KLBg==
X-Gm-Message-State: AOAM533cu9SWRrr2IipLPV8iWioNdVvZJ3Ip+sLZF0Nqp1fRF/DD1UXv
        TrtZopxN8hgWZ/MDWaBx/Gjw4A==
X-Google-Smtp-Source: ABdhPJxSHFnk5M8T9HV9b3Wlbx6jGLABuKYvfRmdDLOQGvZMCT8Q7DeavolQ7oLahZc5RlYjMxv/lQ==
X-Received: by 2002:a05:600c:3b93:: with SMTP id n19mr4770604wms.3.1626276655306;
        Wed, 14 Jul 2021 08:30:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id y6sm2465174wma.48.2021.07.14.08.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:30:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     plai@codeaurora.org, tiwai@suse.de, devicetree@vger.kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 01/16] soc: dt-bindings: qcom: add gpr bindings
Date:   Wed, 14 Jul 2021 16:30:24 +0100
Message-Id: <20210714153039.28373-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
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
 .../bindings/soc/qcom/qcom,gpr.yaml           | 83 +++++++++++++++++++
 include/dt-bindings/soc/qcom,gpr.h            | 18 ++++
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,gpr.yaml
 create mode 100644 include/dt-bindings/soc/qcom,gpr.h

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,gpr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,gpr.yaml
new file mode 100644
index 000000000000..d6dda44b655e
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,gpr.yaml
@@ -0,0 +1,83 @@
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
+  qcom,protection-domain:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: protection domain service name and path for gpr service
+      has dependency on.
+    items:
+      - const: avs/audio
+      - const: msm/adsp/audio_pd
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
+        qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        gprservice@1 {
+          reg = <GPR_APM_MODULE_IID>;
+        };
+    };
diff --git a/include/dt-bindings/soc/qcom,gpr.h b/include/dt-bindings/soc/qcom,gpr.h
new file mode 100644
index 000000000000..1c68906e079c
--- /dev/null
+++ b/include/dt-bindings/soc/qcom,gpr.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_QCOM_GPR_H
+#define __DT_BINDINGS_QCOM_GPR_H
+
+/* DOMAINS */
+
+#define GPR_DOMAIN_ID_MODEM	1
+#define GPR_DOMAIN_ID_ADSP	2
+#define GPR_DOMAIN_ID_APPS	3
+
+/* Static Services */
+
+#define GPR_APM_MODULE_IID		1
+#define GPR_PRM_MODULE_IID		2
+#define GPR_AMDB_MODULE_IID		3
+#define GPR_VCPM_MODULE_IID		4
+
+#endif /* __DT_BINDINGS_QCOM_GPR_H */
-- 
2.21.0

