Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398CE3A0F59
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 11:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbhFIJM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 05:12:56 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:43665 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237789AbhFIJMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 05:12:55 -0400
Received: by mail-wm1-f48.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso3692398wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 02:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iQ2z9ZGal8v2nmHqBZXofvg2D10jxLfiFOLsbiZ2ZJQ=;
        b=HIwTbNLp8nukA39m64b158FSxY0cMGZ3x43lq6bQpH8Rlgsl0AP83is/ymuSYFFprE
         v3Z6FrWcteO672+3T5WweQvre7rngffllUL6WJNiOdYyDYxQE0SPdXS1kibSdP6TucU/
         e/UX1KDeODpDto/ghvwyBGhW7XFQei48+f3OtAFwpg0MniY5ciTlNJ+NunrUphPQPJ6h
         cyY8IMP0fXBT95bJQWOrkJ63qo9oZ9HtXxpihCmPXC4aB7MeC8rNz/W6mTc/pX2ZTZgz
         7YnyBgjKVKtnWfPTWdo6iqO2AlKhCiJpukpOvcIfxLUPDrVFLf0v6e7P1FnkBqee406A
         zvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQ2z9ZGal8v2nmHqBZXofvg2D10jxLfiFOLsbiZ2ZJQ=;
        b=qL1rwUiRL2BK/l226dCdVsSPEbQxfOUrrr+u++RYZwZiJiQqd/tMIFThoBAr+SOc4E
         8r5lX+/zAC2Vt4NHMtWvrZRnNXL473CDEb1C1RqFJalPKfZtdNh6s/PK2VDVAg+0graM
         74Zvun0zM6WUmPC+8K+Fq4V3MDMAbv9p4xxyTaNHkIS0AkGswh7VHp5Il4tD5/GsP4tr
         bWErGo/kVeXFimxFG2ohTeBZhpa+fQl2SN9WIefvs/klqSsI1nCv50Kck4yYyLJYA05Z
         TOu9xWV30tztndW+FFrAMRPkSqOf2P8q01WvEEiUEXfkgMNDklr6qy9/g+CLHXFwFgsH
         S/WQ==
X-Gm-Message-State: AOAM533IJmpOxQUPna6DLMktLQaUzSMSxm8DpPuo67c0Sk6nDm089F7+
        aZV+FRd0J620THrDXkkPMeX+5AKWKN5ZLQ==
X-Google-Smtp-Source: ABdhPJyvdpfB1B0r6fB74HF3lg6zL8p+pTdb/E6OxRGH9Vr9WFB0eKPwQluzfY2o2s7AQoo7nQYtEg==
X-Received: by 2002:a7b:c002:: with SMTP id c2mr26576297wmb.118.1623229800233;
        Wed, 09 Jun 2021 02:10:00 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id v18sm25165385wrb.10.2021.06.09.02.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 02:09:59 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v9 1/9] ASoC: dt-bindings: wcd938x: add bindings for wcd938x
Date:   Wed,  9 Jun 2021 10:09:35 +0100
Message-Id: <20210609090943.7896-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210609090943.7896-1-srinivas.kandagatla@linaro.org>
References: <20210609090943.7896-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
connected over SoundWire. This device has two SoundWire device RX and
TX respectively, supporting 4 x ADCs, ClassH, Ear, Aux PA, 2xHPH,
7 x TX diff inputs, 8 DMICs, MBHC.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/qcom,wcd938x.yaml          | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
new file mode 100644
index 000000000000..cb74ce40c2e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,wcd938x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for Qualcomm WCD9380/WCD9385 Audio Codec
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC.
+  It has RX and TX Soundwire slave devices.
+
+properties:
+  compatible:
+    enum:
+      - qcom,wcd9380-codec
+      - qcom,wcd9385-codec
+
+  reset-gpios:
+    description: GPIO spec for reset line to use
+    maxItems: 1
+
+  vdd-buck-supply:
+    description: A reference to the 1.8V buck supply
+
+  vdd-rxtx-supply:
+    description: A reference to the 1.8V rx supply
+
+  vdd-io-supply:
+    description: A reference to the 1.8V I/O supply
+
+  qcom,tx-device:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: A reference to Soundwire tx device phandle
+
+  qcom,rx-device:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: A reference to Soundwire rx device phandle
+
+  qcom,micbias1-microvolt:
+    description: micbias1 voltage
+    minimum: 1800000
+    maximum: 2850000
+
+  qcom,micbias2-microvolt:
+    description: micbias2 voltage
+    minimum: 1800000
+    maximum: 2850000
+
+  qcom,micbias3-microvolt:
+    description: micbias3 voltage
+    minimum: 1800000
+    maximum: 2850000
+
+  qcom,micbias4-microvolt:
+    description: micbias4 voltage
+    minimum: 1800000
+    maximum: 2850000
+
+  qcom,hphl-jack-type-normally-closed:
+    description: Indicates that HPHL jack switch type is normally closed
+    type: boolean
+
+  qcom,ground-jack-type-normally-closed:
+    description: Indicates that Headset Ground switch type is normally closed
+    type: boolean
+
+  qcom,mbhc-headset-vthreshold-microvolt:
+    description: Voltage threshold value for headset detection
+    minimum: 0
+    maximum: 2850000
+
+  qcom,mbhc-headphone-vthreshold-microvolt:
+    description: Voltage threshold value for headphone detection
+    minimum: 0
+    maximum: 2850000
+
+  qcom,mbhc-buttons-vthreshold-microvolt:
+    description:
+      Array of 8 Voltage threshold values corresponding to headset
+      button0 - button7
+    minItems: 8
+    maxItems: 8
+
+  '#sound-dai-cells':
+    const: 1
+
+required:
+  - compatible
+  - reset-gpios
+  - qcom,tx-device
+  - qcom,rx-device
+  - qcom,micbias1-microvolt
+  - qcom,micbias2-microvolt
+  - qcom,micbias3-microvolt
+  - qcom,micbias4-microvolt
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    codec {
+        compatible = "qcom,wcd9380-codec";
+        reset-gpios = <&tlmm 32 0>;
+        #sound-dai-cells = <1>;
+        qcom,tx-device = <&wcd938x_tx>;
+        qcom,rx-device = <&wcd938x_rx>;
+        qcom,micbias1-microvolt = <1800000>;
+        qcom,micbias2-microvolt = <1800000>;
+        qcom,micbias3-microvolt = <1800000>;
+        qcom,micbias4-microvolt = <1800000>;
+        qcom,hphl-jack-type-normally-closed;
+        qcom,ground-jack-type-normally-closed;
+        qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+        qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+    };
+
+    /* ... */
+
+    soundwire@3210000 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        reg = <0x03210000 0x2000>;
+        wcd938x_rx: codec@0,4 {
+            compatible = "sdw20217010d00";
+            reg  = <0 4>;
+            qcom,rx-port-mapping = <1 2 3 4 5>;
+        };
+    };
+
+    soundwire@3230000 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        reg = <0x03230000 0x2000>;
+        wcd938x_tx: codec@0,3 {
+            compatible = "sdw20217010d00";
+            reg  = <0 3>;
+            qcom,tx-port-mapping = <2 3 4 5>;
+        };
+    };
+
+...
-- 
2.21.0

