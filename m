Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C793635F861
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352344AbhDNPuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352456AbhDNPuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:50:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83D0C061344
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:49:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sd23so23498064ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9klurVQ9zaPgZiimhz9hUIzAK6dPBY5bXiVGcul6OE=;
        b=w3P0MHZgxNgpNfFYAq2gmPdZrV7GUG+M5QtlVg6DAc8uPqNt93EKgxKPFCjkJ35Q7F
         gmPG+NEEm/uO2i7CkLyIp4plI6sV/IG7gHmngXfZ+QtF+SuPMQ3iujXnmWYlUO+lBBig
         6fuEWVzhrcSBZSdoVB3vBzOUJ4MN0I4IMlo4OmwZOH2PeMl0mry4dsDaMWnMSE41OojN
         16/D0CZ4guSwifAAKV0r6b7OGE45Qq5sj/tjOpAdAlG5RnROkQW5UvdshCSm4v495FFZ
         fUeSQzePBsCFpJzL2VT0m6qU/LBnE4ISp1nevv9dAU5HZht2xOE75ru6s1k1Hl/4+wlh
         I/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9klurVQ9zaPgZiimhz9hUIzAK6dPBY5bXiVGcul6OE=;
        b=jALDinlSkSUPipW9IYdOFRR99re+ZIfRg6ywf4unuzx1fe+mjPeHGZH+VXt6e6inD2
         mLBpL8zeyNFBt+Hy4F5FyOulQ6Ie/ENg9ODRi23i+ufs/fkhqlNvcGcyXbx2v5Maxmkx
         LjFcHzhqz0CZDa/AqNEJygIK+nzSB/EfpSr6RoJMTguHn+8NqzArPWPKKsLasQJZWA1a
         KjEJG8x4Kb/q9BANLRCwSUvojWxEhQymGHpi/0qOtqR8rJk6zH/vD7b+haYmoGSTQwoN
         pQAcCRpHPHy/QTjpB/2Rt5YnLFfMZ722x4WCIqPOoo/zrMAhM9Vcts3FbVmAid9eviB7
         XcHA==
X-Gm-Message-State: AOAM532gCfb9jskr3yWOusZgQLDljGJ5vVR46FOuzw96KMZrYpBL1YC5
        LnR3tI4MYTzPFfkf7rW1JUq1gTItrkbd6Q==
X-Google-Smtp-Source: ABdhPJzopcPuHp+P53ubCJe/TbePBdtumhDcyarmzsRWLkCWIDduTL0agiZLzwZxLHSC0aA/ZAzg5w==
X-Received: by 2002:a17:906:ecb8:: with SMTP id qh24mr39510393ejb.162.1618415368378;
        Wed, 14 Apr 2021 08:49:28 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q12sm10495540ejy.91.2021.04.14.08.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:49:27 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 4/9] ASoC: dt-bindings: wcd938x-sdw: add bindings for wcd938x-sdw
Date:   Wed, 14 Apr 2021 16:48:40 +0100
Message-Id: <20210414154845.21964-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210414154845.21964-1-srinivas.kandagatla@linaro.org>
References: <20210414154845.21964-1-srinivas.kandagatla@linaro.org>
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
 .../bindings/sound/qcom,wcd938x-sdw.yaml      | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
new file mode 100644
index 000000000000..fff33c65491b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
@@ -0,0 +1,61 @@
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
+  qcom,direction:
+    description: direction of the SoundWire device instance
+    enum:
+      - rx
+      - tx
+
+  qcom,port-mapping:
+    description: |
+      Specifies static port mapping between slave and master ports.
+      In the order of slave port index.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 5
+
+required:
+  - compatible
+  - reg
+  - qcom,direction
+  - qcom,port-mapping
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
+            qcom,direction = "tx";
+            qcom,port-mapping = <2 3 4 5>;
+        };
+    };
+
+...
-- 
2.21.0

