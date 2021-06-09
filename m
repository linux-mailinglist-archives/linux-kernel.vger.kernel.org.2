Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325EF3A115F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbhFIKn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:43:58 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:37527 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbhFIKn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:43:57 -0400
Received: by mail-pg1-f174.google.com with SMTP id t9so19099118pgn.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3KSqDVs9YRSwE4rOwA0va7NCLHw84o+H5YF3VkLQdM=;
        b=JtSlkmTPs+H1JCpMlMT4IMsfQa8AN05+Jwzr9y0eMBoFqPN3OLlDF/sSIU2wdbnafj
         Bvwc8QVi2hybfJT8seIRU25PwWiVOUXoe3zAOyP1PsE0Jbs8WypZ6B02spebC97i8YPP
         dCTZsIfDepmonyk02MH7akhX/22srZngJ2VAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3KSqDVs9YRSwE4rOwA0va7NCLHw84o+H5YF3VkLQdM=;
        b=GaFC6sUV+Hz1VIwUwRJ28NL3cE1Q85f1Es0f2rh9pbGSfpTcWt54HZXH+S3RdUFOp6
         mwCqf4xA35N1ankb0IK+oWcaYbcVPCLACa+9qQz4Q1C2hI5mOTZ8yeodpEuWlf6cHVW5
         r7wtpNMEjFcg9y5rHWjNqh5K/Z69kpqo6Kweaffef+DKlOTli646t2qD9WnQi/aeSlVF
         Ph6fwSHuFroFun9I+0Q2Av/NiCp7UX9PYGCfmq6y5OMBHv6KIBUjO9A19EOCjh+2XH6U
         rOyX+BRxehecKMe3qOkzNWDv2Drfn9EcBqQJ4RcgrhNj/WnpFy6cH8Q6CyASAIcD+plF
         ZIaQ==
X-Gm-Message-State: AOAM531jYoQ5DRrm0e6835OYM8HeVT3TtYi8A3k6Eiw4Iygzdbyq5zI/
        Hy1hzd1nX47o2Bwe8mU7hk2hCg==
X-Google-Smtp-Source: ABdhPJxeWSnFVRMewe1zjN1xVuTUbrFOPSw8XzwNwPRTj6Pvhj8lQCDm/w6gJDaJPdNL+Nt/nRAF9A==
X-Received: by 2002:a63:f245:: with SMTP id d5mr3191835pgk.416.1623235262439;
        Wed, 09 Jun 2021 03:41:02 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:83f0:56eb:3535:6bd5])
        by smtp.gmail.com with ESMTPSA id k1sm13223904pfa.30.2021.06.09.03.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:41:01 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        maoguang.meng@mediatek.com, yong.wu@mediatek.com
Subject: [PATCH] dt-bindings: mediatek: convert mtk jpeg decoder/encoder to yaml
Date:   Wed,  9 Jun 2021 18:40:54 +0800
Message-Id: <20210609104053.617751-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert mediatek jpeg decoder and encoder bindings to yaml.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
mediatek,larb in the original file will be removed after this series[1]
[1] https://patchwork.kernel.org/project/linux-mediatek/patch/20210410091128.31823-2-yong.wu@mediatek.com/
---
 .../bindings/media/mediatek-jpeg-decoder.yaml | 73 +++++++++++++++++++
 .../bindings/media/mediatek-jpeg-encoder.yaml | 65 +++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
new file mode 100644
index 0000000000000..812f366163d8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek JPEG Decoder Device Tree Bindings
+
+maintainers:
+  - Xia Jiang <xia.jiang@mediatek.com>
+
+description: |-
+  Mediatek JPEG Decoder is the JPEG decode hardware present in Mediatek SoCs
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - const: mediatek,mt8173-jpgdec
+      - items:
+        - const: mediatek,mt2701-jpgdec
+      - items:
+        - enum:
+            - mediatek,mt7623-jpgdec
+        - const: mediatek,mt2701-jpgdec
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: jpgdec-smi
+      - const: jpgdec
+
+  power-domains:
+    maxItems: 1
+
+  iommus:
+    minItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    jpegdec: jpegdec@15004000 {
+      compatible = "mediatek,mt2701-jpgdec";
+      reg = <0 0x15004000 0 0x1000>;
+      interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
+      clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
+                <&imgsys CLK_IMG_JPGDEC>;
+      clock-names = "jpgdec-smi",
+                    "jpgdec";
+      power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
+      iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
+               <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
+    };
+
diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
new file mode 100644
index 0000000000000..8ffc17fe576d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek-jpeg-encoder.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek JPEG Encoder Device Tree Bindings
+
+maintainers:
+  - Xia Jiang <xia.jiang@mediatek.com>
+
+description: |-
+  MediaTek JPEG Encoder is the JPEG encode hardware present in MediaTek SoCs
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt2701-jpgenc
+          - mediatek,mt8183-jpgenc
+      - const: mediatek,mtk-jpgenc
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: jpgenc
+
+  power-domains:
+    maxItems: 1
+
+  iommus:
+    minItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    jpegenc: jpegenc@1500a000 {
+      compatible = "mediatek,mt2701-jpgenc",
+                   "mediatek,mtk-jpgenc";
+      reg = <0 0x1500a000 0 0x1000>;
+      interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_LOW>;
+      clocks =  <&imgsys CLK_IMG_VENC>;
+      clock-names = "jpgenc";
+      power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
+      iommus = <&iommu MT2701_M4U_PORT_JPGENC_RDMA>,
+               <&iommu MT2701_M4U_PORT_JPGENC_BSDMA>;
+    };
+
-- 
2.32.0.rc1.229.g3e70b5a671-goog

