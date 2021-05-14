Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCBF380752
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhENKgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbhENKfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 06:35:47 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AADC061760
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:34:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso1182914wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wD5Koc4+Y8WGCkqYQ0J6ZM9ix1nXZLNkx7wv0f/ctNc=;
        b=p7rfnDdFplz7oQZhmZvU5pGbbefgRQBfPVgMgKRSsnp1eDEr2TQOerze2J4ouFU1PX
         NRTaowGsZqal4+mdn1QBNcAtDzPwcTnqJ1PaSQZ/2wxHZZUTEJQ4gTMitFDYaKNGjozV
         sNSjDCempf3Oxchd7Ge6rNu5tPR3M5ejVQ1SdqSpRhcdwtKmAdTt0+vJWeHh4QOic7GE
         8GyBoWcB/DWQlslLoctND0ecn9I9Y6NJMVqElsx2Dh+NICea01d+w5wS6oou+HUbUH4z
         NgBFQ8iZMxiNq0TKDb1rCrq8n8ocEB4E0RCoH4dIzm2UmBLkOGYC40E8srGUcSuCM+nh
         BBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wD5Koc4+Y8WGCkqYQ0J6ZM9ix1nXZLNkx7wv0f/ctNc=;
        b=rQrqiQ7qSW2k+I+QfCa4IyrVhPvM5qgHGYkU6n6P6ZDCyU3iyUp1hSi1U/+y1CsIAK
         n4tn46oQFsCbWP5rJ+h05Whdua7R1twMKzIUCzCja4ryvwKxfPE1+UyxxBMS5V1xgqwM
         HsUaVTfupb+oohmK/D4UWRty/ALL5DMcA8t3EvD9EffZvxx3oHf1q3BRP6fHBLyUYsTi
         UM9e6EyTbW1tdrogck7esdWe06rMY6bBbwyuaTCqluxzjpzbCR6RIAAkZnaf1DQk+XpY
         CSBIohK6rH5ahqDeJdTphF47OjTu7f62zLaPs/JfBx+z54KGmZ5HdoPEygv1gFYNpbZF
         popw==
X-Gm-Message-State: AOAM53286uQJedcYb9hOzDlmc6ioZPdIzYKHNC4XnhwnHWXNH1wDLbGp
        S/8boCC3w+TFQZV6OmEDYq4oOw==
X-Google-Smtp-Source: ABdhPJydrg8yHoYnTefCkO3f9aDWw6ujj2A14QG5kCaRd5qk8mo49wNEOeTFpEGq8EFjJ/pqzC/0rg==
X-Received: by 2002:a1c:2685:: with SMTP id m127mr8850674wmm.135.1620988473696;
        Fri, 14 May 2021 03:34:33 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id k16sm5015498wmi.44.2021.05.14.03.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 03:34:33 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 4/9] ASoC: dt-bindings: wcd938x-sdw: add bindings for wcd938x-sdw
Date:   Fri, 14 May 2021 11:34:00 +0100
Message-Id: <20210514103405.29927-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210514103405.29927-1-srinivas.kandagatla@linaro.org>
References: <20210514103405.29927-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
connected over SoundWire. This device has two SoundWire devices RX and
TX respectively. This bindings is for those slave devices on WCD9380/WCD9385.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,wcd938x-sdw.yaml      | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
new file mode 100644
index 000000000000..49a267b306f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,wcd938x-sdw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for Qualcomm SoundWire Slave devices on WCD9380/WCD9385
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC.
+  It has RX and TX Soundwire slave devices. This bindings is for the
+  slave devices.
+
+properties:
+  compatible:
+    const: sdw20217010d00
+
+  reg:
+    maxItems: 1
+
+  qcom,tx-port-mapping:
+    description: |
+      Specifies static port mapping between slave and master tx ports.
+      In the order of slave port index.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 4
+
+  qcom,rx-port-mapping:
+    description: |
+      Specifies static port mapping between slave and master rx ports.
+      In the order of slave port index.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 5
+    maxItems: 5
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
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

