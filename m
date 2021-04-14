Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA4735F856
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352272AbhDNPuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352147AbhDNPtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:49:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3DBC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:49:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w23so16335100ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqR7BlF4HSnnBDnstX8+p5EmjKpi9oGoXkglRwnfXtQ=;
        b=Il2kAK6DaEhXk+Qu28VBaiON0vWv1u/STSJGWLYoCZQo86bwM/AkbYBHlq3XXu/uYy
         AX5uN7c/OBVfvb+tei4O5wbQkaZ77VhCfd8qHxqzA4lHJx5KFVouATL5e8vI850X23or
         +Tdt9nLraopIL8QvLgifNX9y7GxjD0fuJsJtcUUcBZBWAeCFqXL5cBn0rGBNYiBRPBuI
         e1y7zSEiPSgPSp5T718r35LzOPabgcrf4Uhq3omH8KpVpUUxjZ/TSBd4Xwh2u5x1URlG
         HNy5u2bt65Q9kBNw950LI1detP/eJl55k76NZgkNg4fCN4o2IUesYji3AYJgtF/r0nHi
         THoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqR7BlF4HSnnBDnstX8+p5EmjKpi9oGoXkglRwnfXtQ=;
        b=ljGeuG4PH8VIJyUnZsolKk330GWvx3QgABqv/1BpJ1RKeEjwM8hh2HSfDYyoNMj5pN
         T9tyMafewjvpC2WdEHBaUYgjkZO21OTCMcEoYmbe/p49NaRbPHm+btm5EhAtDVc0+pb2
         ib5ez2qNbZy/cFRzRhiJZVWmXeIMcJMIbnSBtG6AuV6Il1LlP8SxBsH1zSXj3QoKWxY2
         ILxrX2UFoWK3zkjsQ+FUCsHm2QgkWEY03jsifoTz/UAlnj8WZezm2j7UbtlqobFqp7/B
         2PO4TpYogF2pxs1IZzYHT71uZEHO0YBM1pv8X626INtwxAQuQpvChgpgrtNZNTo5DUAK
         qcdw==
X-Gm-Message-State: AOAM532qzhsLp+OTldig/AVnnTYS5I6dtbvBWSFnHjDvLD5dg/5m5USu
        F6DTCG/tja1uj9+wTXQbBokJEw==
X-Google-Smtp-Source: ABdhPJzWZ53gfi0xzVnwwXXBQEC/fU5WKuwlHPkPefaXJjw9xj0tfy9UvIFAmGFbr1grNOvT9H7zoA==
X-Received: by 2002:a17:906:d8c:: with SMTP id m12mr15958347eji.347.1618415364624;
        Wed, 14 Apr 2021 08:49:24 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q12sm10495540ejy.91.2021.04.14.08.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:49:24 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 1/9] ASoC: dt-bindings: wcd938x: add bindings for wcd938x
Date:   Wed, 14 Apr 2021 16:48:37 +0100
Message-Id: <20210414154845.21964-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210414154845.21964-1-srinivas.kandagatla@linaro.org>
References: <20210414154845.21964-1-srinivas.kandagatla@linaro.org>
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
---
 .../bindings/sound/qcom,wcd938x.yaml          | 176 ++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
new file mode 100644
index 000000000000..4c8fa8290af0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
@@ -0,0 +1,176 @@
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
+    maxItems: 1
+    description: A reference to Soundwire tx device phandle
+
+  qcom,rx-device:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
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
+  qcom,mbhc-hphl-switch:
+    description: Indicates that HPHL switch type is normally closed
+    type: boolean
+
+  qcom,mbhc-ground-switch:
+    description: Indicates that Headset Ground switch type is normally closed
+    type: boolean
+
+  qcom,mbhc-button0-vthreshold-microvolt:
+    description: Voltage threshold value headset button0
+    minimum: 0
+    maximum: 500000
+
+  qcom,mbhc-button1-vthreshold-microvolt:
+    description: Voltage threshold value headset button1
+    minimum: 0
+    maximum: 500000
+
+  qcom,mbhc-button2-vthreshold-microvolt:
+    description: Voltage threshold value headset button2
+    minimum: 0
+    maximum: 500000
+
+  qcom,mbhc-button3-vthreshold-microvolt:
+    description: Voltage threshold value headset button3
+    minimum: 0
+    maximum: 500000
+
+  qcom,mbhc-button4-vthreshold-microvolt:
+    description: Voltage threshold value headset button4
+    minimum: 0
+    maximum: 500000
+
+  qcom,mbhc-button5-vthreshold-microvolt:
+    description: Voltage threshold value headset button5
+    minimum: 0
+    maximum: 500000
+
+  qcom,mbhc-button6-vthreshold-microvolt:
+    description: Voltage threshold value headset button6
+    minimum: 0
+    maximum: 500000
+
+  qcom,mbhc-button7-vthreshold-microvolt:
+    description: Voltage threshold value headset button7
+    minimum: 0
+    maximum: 500000
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
+  - qcom,mbhc-hphl-switch
+  - qcom,mbhc-ground-switch
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
+        qcom,mbhc-hphl-switch;
+        qcom,mbhc-ground-switch;
+        qcom,mbhc-button0-vthreshold-microvolt = <75000>;
+        qcom,mbhc-button1-vthreshold-microvolt = <150000>;
+        qcom,mbhc-button2-vthreshold-microvolt = <237000>;
+        qcom,mbhc-button3-vthreshold-microvolt = <500000>;
+        qcom,mbhc-button5-vthreshold-microvolt = <500000>;
+        qcom,mbhc-button6-vthreshold-microvolt = <500000>;
+        qcom,mbhc-button7-vthreshold-microvolt = <500000>;
+    };
+
+    /* ... */
+
+    soundwire@3230000 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        reg = <0x03230000 0x2000>;
+        wcd938x_tx: codec@0,3 {
+            compatible = "sdw20217010d00";
+            reg  = <0 3>;
+            qcom,direction = "tx";
+            qcom,port-mapping = <2 3 4 5>;
+        };
+
+        wcd938x_rx: codec@0,4 {
+            compatible = "sdw20217010d00";
+            reg  = <0 4>;
+            qcom,direction = "rx";
+            qcom,port-mapping = <1 2 3 4 5>;
+        };
+
+    };
+
+...
-- 
2.21.0

