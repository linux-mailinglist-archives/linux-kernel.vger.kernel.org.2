Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42CC387B51
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhEROjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbhEROj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:39:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3AFC061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:38:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r12so10524579wrp.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgmJGXmS6RCspCVU9ceSBH9yezcF2/kLSegrw/MRv68=;
        b=G4VUZsx2f5aesTTAUc0HKjw22l1mpxmMaYDtriJQtoi+Ul6qa23OIAriyuNbIABPPp
         8kJwTfOYFztNguzI60C8xzFQYPaPV9ppJXfy0HMba/cfsW0GPj4YAXFmuYOK2lergmMl
         QCHVKxi84469uul5Wl9t29ZE8LjefDAVlzYN2j447Jzc2gwaRZT918TxlIxelKng8zTR
         VkHo7e//MlgbhnhXCY+r0Np0CbaToU9FwL+l/YrnVnCVjS+1yK6aslA2JvqF3xv5eYDA
         d6I2DJmX2hslwWbEAXaUBEmpby7yNf22PfrBmcmijPfUVoTkcCovv/YKI/Z+0LVVN7Tg
         AuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgmJGXmS6RCspCVU9ceSBH9yezcF2/kLSegrw/MRv68=;
        b=aG0ECRQdXZDw4qcjxTJtISzeWrEyhJpInxCQA2FOJIj/lLmDcGf1KUlzRluDN3XeK6
         w/lToa+PC353vkt23objv1Om6ivEZwMmOGqoqwS0YP3Qwo6gtwxN2koJarW6MOSGRIf9
         DjG1ifYHMj9XqGxvl3gOC/uiDBRMXv/UHLC+1p1F+EoIyZXuyBJ5UcKe9rBMdjz1n+mJ
         LUIyhoT6m4c5/6/L66bYKzF07aczCLNVHYTTkpM3OgGeh7pSxssza0HulurtFqQXIf7p
         RfCa1y9DQjXpRKIeBMN1w1jviRf5BvgJvusNutCHQ+MChDKOLAqUM60juVj0ENnf2BeT
         9XNg==
X-Gm-Message-State: AOAM533JL0jZ/Uap+DDqObAI+t/tvI25Z7REccU/S50DWvzoxf4HsV6a
        NnAQJIDiqL9ezqr33oHKm1Tlfw==
X-Google-Smtp-Source: ABdhPJwBK0Vgow3GRYUnf7g37TwzoMyUtYdpdHJPnwJPiNVshiVLmMQ69rwp40pVux6yA/FPuu0IqQ==
X-Received: by 2002:adf:ce85:: with SMTP id r5mr7875105wrn.198.1621348689424;
        Tue, 18 May 2021 07:38:09 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id m6sm21329087wrp.29.2021.05.18.07.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:38:08 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 4/9] ASoC: dt-bindings: wcd938x-sdw: add bindings for wcd938x-sdw
Date:   Tue, 18 May 2021 15:37:54 +0100
Message-Id: <20210518143759.16837-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210518143759.16837-1-srinivas.kandagatla@linaro.org>
References: <20210518143759.16837-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
connected over SoundWire. This device has two SoundWire devices RX and
TX respectively. This bindings is for those slave devices on WCD9380/WCD9385.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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

