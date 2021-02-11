Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E28318B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 13:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhBKMpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 07:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhBKMbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:31:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06896C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 04:28:04 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m13so3946063wro.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 04:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2yW/hk09p66uX8WS858rHDTLq5rtQMroyjmtenWxC34=;
        b=N12R1Vp4V4jY2vL511pCxty/p5pS8eH5Lp2htNYa1eQlE7UUypEBiHAedhJfIpuAZk
         9ie4lnos6r4RA3ijipYNBhsUjlblhGMuyPlg/kxKtejHR/MsVe3pLTv52gVIz9myejiF
         9IXvhiq5DaJ9WQP5GXnMPaBh1qZBnDdwIQ2BeiwMQN5HSRYe/RUGhmQo0KOYWvtPYFyJ
         L+UvHzsD+w0B7iNHzxrtDEH9im4ixC4duw0jcZOIU/g3OnANYXzNm5pVgLl3apn7tEc4
         Y+pq5twei3Sgtof5WE5KpKrdrJO9qGej0CiDGhG0s6IF6FSLZoMF/Qk6kYQIUZzhpCV8
         xA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2yW/hk09p66uX8WS858rHDTLq5rtQMroyjmtenWxC34=;
        b=p6RvKa2FYG64hk9AgCakK2uwhwmp6qJIdcJMerYDhWHhL+egQyWsgrgTgk5ljjO4tj
         FjO+mi+nM/1EWRPTTSFW707hoh2ldo0Q+Dy15g4GcU3PNJiLyEQ1J2LeLgnzsP7tZsnt
         /elCawrDCtwBYjdorJGuFNqAXnTTZ+ifdy7++nu9a+rwDB/m2WosaNC9ji+t0oU3g58k
         urJDEvJcNIbgdLckk4WWbRn5V4IStMd1MB5Y52LyPG/XNU01Hp3tE3zE8V5AHfqZ5P9p
         o4d9sbX7XQtHTyq2Fv1IvfhSJGltRNQdRv5nSDpE+OIRlW10daEpZK+nfMcS3MgdhJmP
         xmBA==
X-Gm-Message-State: AOAM53224ZB4xdX7XOiH03vNk+2DsOSfFEs6YsPss8R/VaP2jpnzQOpH
        QkxdPVVkXF0E7NCPQt3NiAXLzA==
X-Google-Smtp-Source: ABdhPJxohTH3t7HtGznisEnUEoJoQNh+tX6fL8+RAwxyUSn40ahbaAQJ8HJvnNLUDzk9Vo5x/N14cg==
X-Received: by 2002:adf:9565:: with SMTP id 92mr5477528wrs.201.1613046482804;
        Thu, 11 Feb 2021 04:28:02 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id d20sm4026477wrc.12.2021.02.11.04.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 04:28:02 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 5/7] ASoC: qcom: dt-bindings: add bindings for lpass tx macro codec
Date:   Thu, 11 Feb 2021 12:27:33 +0000
Message-Id: <20210211122735.5691-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210211122735.5691-1-srinivas.kandagatla@linaro.org>
References: <20210211122735.5691-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is for LPASS has internal codec TX macro which is
for connecting with Soundwire TX codecs like WCD938x.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/qcom,lpass-tx-macro.yaml   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
new file mode 100644
index 000000000000..6b5ca02ccce4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,lpass-tx-macro.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPASS(Low Power Audio Subsystem) TX Macro audio codec DT bindings
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+properties:
+  compatible:
+    const: qcom,sm8250-lpass-tx-macro
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 1
+
+  '#clock-cells':
+    const: 0
+
+  clocks:
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: mclk
+      - const: npl
+      - const: macro
+      - const: dcodec
+      - const: fsgen
+
+  clock-output-names:
+    items:
+      - const: mclk
+
+  qcom,dmic-sample-rate:
+    description: dmic sample rate
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/sound/qcom,q6afe.h>
+    codec@3220000 {
+      compatible = "qcom,sm8250-lpass-tx-macro";
+      reg = <0x3220000 0x1000>;
+      #sound-dai-cells = <1>;
+      #clock-cells = <0>;
+      clocks = <&aoncc 0>,
+               <&aoncc 1>,
+               <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&vamacro>;
+      clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+      clock-output-names = "mclk";
+      qcom,dmic-sample-rate = <600000>;
+    };
-- 
2.21.0

