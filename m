Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B75337AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCKRfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhCKRfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:35:02 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2A8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:35:01 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b18so2971914wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0j7/mJ9hsNyjCz2UBWw3RsdNjgdghs6t6j2jgPrVNrk=;
        b=rga90TJQbvQrd3kwdDuvr+LQ7z/gzSpin1AY+VA1GT+L1ZqklkHgPTy4pJK5eEXVhi
         AmLINd6V2mM8ZaZ6hLOf+DL/VPF1M++87p+S/SrIF6cpz0dAlnhbN/pnjRWY3qI952iU
         0ABAq3eVC3UYrvFuF0acbZQ8KGX4b1Tix/UN+/PmWgpMCAvPgaTRenSlL5diXEyQpqdJ
         lXuKNEswB5aktZEyPz/1vTX4CzQSQnInjzm8ZjDosLsIKbE0TdqBCY7qvDQ4XvV/Uh6K
         bgTxG55DvvjUViEGvMKy86UqMw2nHAsv+VaLTOYeJJG+Q6LvfJpnRHTE1SHHo8fqTeOD
         TpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0j7/mJ9hsNyjCz2UBWw3RsdNjgdghs6t6j2jgPrVNrk=;
        b=BGBf9TJPuhBlSbFVInDtN50sOIZE5RTBr9z8cIIHsfwxA4I1B/AcRP5TKvVLU2O6zu
         HApIKCRyKZuo2AAF77kiufexIUX+qRZDe5SrP/nMV9vWskgpWadFoGhsZlo4uoSGHEfi
         9h3HGbeXj+FJyAFHor0WheFt+9tZEP3vPisxqrFtFiUpPa8To8H2I8fvljpySnkIrJcH
         wOcT60S1n44OsI4MEp8nvgaBuOycGWwYinUBQttMx+N/lT3+r65g+yF4XVTAd1efbkrI
         ZBQgaALmeYOPo9sT/phluQqbwx0yUnyNAKDazhGpFijLcOss4SDWyv+jKgR7pNlQpOKA
         vOyA==
X-Gm-Message-State: AOAM532shD7KpHrDX9xLfz+jB3sEwy6kMjIR+ouItYDQWQEzZU4/JclE
        v9KsFekvwiPT4sZA0dliZyxLyg==
X-Google-Smtp-Source: ABdhPJxEUFo6cMD0/ZpJBZmxQy4BlsY81g5xJ2+fwPZDElx+nFy+7zBVOW0yKqaFbs682soKa6bW4g==
X-Received: by 2002:a5d:4b06:: with SMTP id v6mr10144419wrq.41.1615484100414;
        Thu, 11 Mar 2021 09:35:00 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id 36sm5221152wrh.94.2021.03.11.09.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:34:59 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/7] ASoC: dt-bindings: wcd938x: add bindings for wcd938x
Date:   Thu, 11 Mar 2021 17:34:10 +0000
Message-Id: <20210311173416.25219-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210311173416.25219-1-srinivas.kandagatla@linaro.org>
References: <20210311173416.25219-1-srinivas.kandagatla@linaro.org>
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
 .../bindings/sound/qcom,wcd938x.yaml          | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
new file mode 100644
index 000000000000..81c8957145d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
@@ -0,0 +1,127 @@
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
+    const: sdw20217010d00
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO spec for reset line to use
+    maxItems: 1
+
+  direction:
+    oneOf:
+      - const: rx
+      - const: tx
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
+    description: Indicates that HPHL switch type is normally closed!
+    type: boolean
+
+  qcom,mbhc-ground-switch:
+    description: Indicates that Headset Gound switch type is normally closed!
+    type: boolean
+
+  qcom,mbhc-vthreshold:
+    description: |
+      Voltage threshold values for all the headset buttons
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 8
+    maxItems: 8
+
+  qcom,port-mapping:
+    description: |
+      Specifies static port mapping between slave and master ports.
+      In the order of slave port index.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 5
+
+  '#sound-dai-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - qcom,micbias1-microvolt
+  - qcom,micbias2-microvolt
+  - qcom,micbias3-microvolt
+  - qcom,micbias4-microvolt
+  - qcom,port-mapping
+  - qcom,mbhc-hphl-switch
+  - qcom,mbhc-ground-switch
+  - qcom,mbhc-vthreshold
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    soundwire@3230000 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        reg = <0x03230000 0x2000>;
+
+        codec@0,3 {
+            compatible = "sdw20217010d00";
+            reg  = <0 3>;
+            reset-gpios = <&tlmm 32 0>;
+            direction = "tx";
+            #sound-dai-cells = <1>;
+            qcom,micbias1-microvolt = <1800000>;
+            qcom,micbias2-microvolt = <1800000>;
+            qcom,micbias3-microvolt = <1800000>;
+            qcom,micbias4-microvolt = <1800000>;
+            qcom,mbhc-hphl-switch;
+            qcom,mbhc-ground-switch;
+            qcom,mbhc-vthreshold = <75 150 237 500 500 500 500 500>;
+            qcom,port-mapping = <2 3 4 5>;
+        };
+    };
+
+...
-- 
2.21.0

