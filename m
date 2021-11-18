Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22A9455BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbhKRMsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:48:37 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:34397 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344783AbhKRMs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:48:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637239528; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=EU9wjOtBBt5duPFGiYo1JKEFXc08Okk/3hNbf8UDtS4=; b=ZhKmwUz9rsh3jnJekvg9qgsx/Qwq6uDjQjzgb1N7uFT6P5yUkVSTMIjf7r6KnR0Txe21NZCY
 1f7ZFuftGpZtlLqZweLMpT/9HgFe1UeoytM5IQJ0ntqOzlL+btFYGD71ZTblaRB/2mZiM/Ut
 G5zuRFGPViaZ8X/zzuMjd3WlgbQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 61964ae8ed14d5980f3ff988 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Nov 2021 12:45:28
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E0D20C43460; Thu, 18 Nov 2021 12:45:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F853C4361B;
        Thu, 18 Nov 2021 12:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5F853C4361B
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: [PATCH v6 1/2] ASoC: google: dt-bindings: Add sc7280-herobrine machine bindings
Date:   Thu, 18 Nov 2021 18:15:05 +0530
Message-Id: <1637239506-9387-2-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637239506-9387-1-git-send-email-srivasam@codeaurora.org>
References: <1637239506-9387-1-git-send-email-srivasam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings documentation file for sc7280 sound card
registration.

Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
 .../bindings/sound/google,sc7280-herobrine.yaml    | 171 +++++++++++++++++++++
 1 file changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml

diff --git a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
new file mode 100644
index 0000000..d1687b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
@@ -0,0 +1,171 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/google,sc7280-herobrine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google SC7280-Herobrine ASoC sound card driver
+
+maintainers:
+  - Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
+  - Judy Hsiao <judyhsiao@chromium.org>
+
+description:
+  This binding describes the SC7280 sound card which uses LPASS for audio.
+
+properties:
+  compatible:
+    enum:
+      - google,sc7280-herobrine
+
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source.
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^dai-link@[0-9a-f]$":
+    description:
+      Each subnode represents a dai link. Subnodes of each dai links would be
+      cpu/codec dais.
+
+    type: object
+
+    properties:
+      link-name:
+        description: Indicates dai-link name and PCM stream name.
+        $ref: /schemas/types.yaml#/definitions/string
+        maxItems: 1
+
+      reg:
+        maxItems: 1
+        description: dai link address.
+
+      cpu:
+        description: Holds subnode which indicates cpu dai.
+        type: object
+        properties:
+          sound-dai: true
+
+      codec:
+        description: Holds subnode which indicates codec dai.
+        type: object
+        properties:
+          sound-dai: true
+
+    required:
+      - link-name
+      - cpu
+      - codec
+      - reg
+      - sound-dai
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - model
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+
+  - |
+    #include <dt-bindings/sound/qcom,lpass.h>
+    sound {
+        compatible = "google,sc7280-herobrine";
+        model = "sc7280-wcd938x-max98360a-4dmic";
+
+        audio-routing =
+            "IN1_HPHL", "HPHL_OUT",
+            "IN2_HPHR", "HPHR_OUT",
+            "AMIC1", "MIC BIAS1",
+            "AMIC2", "MIC BIAS2",
+            "VA DMIC0", "MIC BIAS3",
+            "VA DMIC1", "MIC BIAS3",
+            "VA DMIC2", "MIC BIAS4",
+            "VA DMIC3", "MIC BIAS4",
+            "TX SWR_ADC0", "ADC1_OUTPUT",
+            "TX SWR_ADC1", "ADC2_OUTPUT",
+            "TX SWR_ADC2", "ADC3_OUTPUT",
+            "TX SWR_DMIC0", "DMIC1_OUTPUT",
+            "TX SWR_DMIC1", "DMIC2_OUTPUT",
+            "TX SWR_DMIC2", "DMIC3_OUTPUT",
+            "TX SWR_DMIC3", "DMIC4_OUTPUT";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dai-link@0 {
+            link-name = "WCD Playback";
+            reg = <LPASS_CDC_DMA_RX0>;
+            cpu {
+                sound-dai = <&lpass_cpu LPASS_CDC_DMA_RX0>;
+            };
+
+            codec {
+                sound-dai = <&wcd938x 0>, <&swr0 0>, <&rxmacro 0>;
+            };
+        };
+        dai-link@1 {
+            link-name = "WCD Capture";
+            reg = <LPASS_CDC_DMA_TX3>;
+            cpu {
+                sound-dai = <&lpass_cpu LPASS_CDC_DMA_TX3>;
+            };
+
+            codec {
+                sound-dai = <&wcd938x 1>, <&swr1 0>, <&txmacro 0>;
+            };
+        };
+
+        dai-link@2 {
+            link-name = "MI2S Playback";
+            reg = <MI2S_SECONDARY>;
+            cpu {
+                sound-dai = <&lpass_cpu MI2S_SECONDARY>;
+            };
+
+            codec {
+                sound-dai = <&max98360a>;
+            };
+        };
+
+        dai-link@3 {
+            link-name = "DMIC Capture";
+            reg = <LPASS_CDC_DMA_VA_TX0>;
+            cpu {
+                sound-dai = <&lpass_cpu LPASS_CDC_DMA_VA_TX0>;
+            };
+
+            codec {
+                sound-dai = <&vamacro 0>;
+            };
+        };
+
+        dai-link@5 {
+            link-name = "DP Playback";
+            reg = <LPASS_DP_RX>;
+            cpu {
+                sound-dai = <&lpass_cpu LPASS_DP_RX>;
+            };
+
+            codec {
+                sound-dai = <&mdss_dp>;
+            };
+        };
+    };
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

