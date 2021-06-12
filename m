Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3893A3A4C67
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFLDWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:22:12 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:38549 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhFLDWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:22:09 -0400
Received: by mail-pf1-f179.google.com with SMTP id z26so5984338pfj.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XV0Qk0BuzN6wUqR1vqGpn6yoZA5f4NQ5Xcg4vWZ1Rm0=;
        b=WT/Kkp678WFEtTw3tvRLUPoitu5HOoHei1zdyPbjAhsjxmzrwvuEzgNUScmSXqNMPO
         7gQgBA1SHjCAAMEEGkmB0q336T+bK8MBfvWcnQ9Yfo6RFEtdN8JjhFQzrDDSUtdjYSrx
         muxMc9nmNj7RRIXzift7eLaEYB7rc/Q4Fdxgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XV0Qk0BuzN6wUqR1vqGpn6yoZA5f4NQ5Xcg4vWZ1Rm0=;
        b=XM68dvXyghtHUweYyVeyGaEIyinSamdcGerGogLOP9uRE17cAx2Wf2UezPZ+RDcifq
         Hl3gTQ05ApAnvfivZiCU0BeQ3t2eI3EGcPFc+1zMPeSaXkDi0skR86a3KGbhnXgIT7sM
         0Z7EfTmARYzDzr2JQ2xaeAjgJhkybCjp0GrRqe/6TyDk9Oz4jchhI4MQ+HFSEmXe3ocy
         L5qUhAL7Pf22obzAJlGrhU/JwVyCLMqq3s7Y67JQOcr71fTRYUtNlJoMcmn5bGJVq7HI
         hZgzJ5dcRhR44TtIfKVx06A7LReqPur22tj0DyoCUQY1w7MinD67KKix9FRGaM19thXm
         nLvg==
X-Gm-Message-State: AOAM533pvxxHLcI0S7AknDQhBrtpv2LTLLA637yV01wVlWCxf5BZLs/T
        tYJ9TM4bpvupDDClfWsgv3ETOQ==
X-Google-Smtp-Source: ABdhPJyaFFhvfnYwF8dL6T3ALuNk5LE5muzp+I5mHnEB4e3fDMZHvlimf7X0gry/boB49yEVQWSkvA==
X-Received: by 2002:a63:4c66:: with SMTP id m38mr6617706pgl.157.1623467940393;
        Fri, 11 Jun 2021 20:19:00 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:cbbc:c8a0:4601:2039])
        by smtp.gmail.com with ESMTPSA id h5sm6688519pfn.127.2021.06.11.20.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 20:19:00 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        maoguang.meng@mediatek.com, yong.wu@mediatek.com
Subject: [PATCH v5 1/3] dt-bindings: mediatek: convert mtk jpeg decoder/encoder to yaml
Date:   Sat, 12 Jun 2021 11:18:51 +0800
Message-Id: <20210612031853.3115482-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert mediatek jpeg decoder and encoder bindings to yaml.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../bindings/media/mediatek-jpeg-decoder.txt  | 38 --------
 .../bindings/media/mediatek-jpeg-decoder.yaml | 89 +++++++++++++++++++
 .../bindings/media/mediatek-jpeg-encoder.txt  | 35 --------
 .../bindings/media/mediatek-jpeg-encoder.yaml | 80 +++++++++++++++++
 4 files changed, 169 insertions(+), 73 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
deleted file mode 100644
index 39c1028b2dfb4..0000000000000
--- a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-* Mediatek JPEG Decoder
-
-Mediatek JPEG Decoder is the JPEG decode hardware present in Mediatek SoCs
-
-Required properties:
-- compatible : must be one of the following string:
-	"mediatek,mt8173-jpgdec"
-	"mediatek,mt7623-jpgdec", "mediatek,mt2701-jpgdec"
-	"mediatek,mt2701-jpgdec"
-- reg : physical base address of the jpeg decoder registers and length of
-  memory mapped region.
-- interrupts : interrupt number to the interrupt controller.
-- clocks: device clocks, see
-  Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
-- clock-names: must contain "jpgdec-smi" and "jpgdec".
-- power-domains: a phandle to the power domain, see
-  Documentation/devicetree/bindings/power/power_domain.txt for details.
-- mediatek,larb: must contain the local arbiters in the current Socs, see
-  Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
-  for details.
-- iommus: should point to the respective IOMMU block with master port as
-  argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
-  for details.
-
-Example:
-	jpegdec: jpegdec@15004000 {
-		compatible = "mediatek,mt2701-jpgdec";
-		reg = <0 0x15004000 0 0x1000>;
-		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
-		clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
-			  <&imgsys CLK_IMG_JPGDEC>;
-		clock-names = "jpgdec-smi",
-			      "jpgdec";
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
-		mediatek,larb = <&larb2>;
-		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
-			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
-	};
diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
new file mode 100644
index 0000000000000..9b87f036f1785
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
@@ -0,0 +1,89 @@
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
+          - enum:
+              - mediatek,mt8173-jpgdec
+              - mediatek,mt2701-jpgdec
+      - items:
+          - enum:
+              - mediatek,mt7623-jpgdec
+          - const: mediatek,mt2701-jpgdec
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
+  mediatek,larb:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Must contain the local arbiters in the current Socs, see
+      Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+      for details.
+
+  iommus:
+    maxItems: 2
+    description: |
+      Points to the respective IOMMU block with master port as argument, see
+      Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
+      Ports are according to the HW.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - mediatek,larb
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt2701-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/mt2701-larb-port.h>
+    #include <dt-bindings/power/mt2701-power.h>
+    jpegdec: jpegdec@15004000 {
+      compatible = "mediatek,mt2701-jpgdec";
+      reg = <0x15004000 0x1000>;
+      interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
+      clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
+                <&imgsys CLK_IMG_JPGDEC>;
+      clock-names = "jpgdec-smi",
+                    "jpgdec";
+      power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
+      mediatek,larb = <&larb2>;
+      iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
+               <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
deleted file mode 100644
index 5e53c6ab52d01..0000000000000
--- a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-* MediaTek JPEG Encoder
-
-MediaTek JPEG Encoder is the JPEG encode hardware present in MediaTek SoCs
-
-Required properties:
-- compatible : "mediatek,mt2701-jpgenc"
-  followed by "mediatek,mtk-jpgenc"
-- reg : physical base address of the JPEG encoder registers and length of
-  memory mapped region.
-- interrupts : interrupt number to the interrupt controller.
-- clocks: device clocks, see
-  Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
-- clock-names: must contain "jpgenc". It is the clock of JPEG encoder.
-- power-domains: a phandle to the power domain, see
-  Documentation/devicetree/bindings/power/power_domain.txt for details.
-- mediatek,larb: must contain the local arbiters in the current SoCs, see
-  Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
-  for details.
-- iommus: should point to the respective IOMMU block with master port as
-  argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
-  for details.
-
-Example:
-	jpegenc: jpegenc@1500a000 {
-		compatible = "mediatek,mt2701-jpgenc",
-			     "mediatek,mtk-jpgenc";
-		reg = <0 0x1500a000 0 0x1000>;
-		interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_LOW>;
-		clocks =  <&imgsys CLK_IMG_VENC>;
-		clock-names = "jpgenc";
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
-		mediatek,larb = <&larb2>;
-		iommus = <&iommu MT2701_M4U_PORT_JPGENC_RDMA>,
-			 <&iommu MT2701_M4U_PORT_JPGENC_BSDMA>;
-	};
diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
new file mode 100644
index 0000000000000..5e35ecfd21f1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
@@ -0,0 +1,80 @@
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
+  mediatek,larb:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Must contain the local arbiters in the current Socs, see
+      Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+      for details.
+
+  iommus:
+    maxItems: 2
+    description: |
+      Points to the respective IOMMU block with master port as argument, see
+      Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
+      Ports are according to the HW.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - mediatek,larb
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt2701-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/mt2701-larb-port.h>
+    #include <dt-bindings/power/mt2701-power.h>
+    jpegenc: jpegenc@1500a000 {
+      compatible = "mediatek,mt2701-jpgenc",
+                   "mediatek,mtk-jpgenc";
+      reg = <0x1500a000 0x1000>;
+      interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_LOW>;
+      clocks =  <&imgsys CLK_IMG_VENC>;
+      clock-names = "jpgenc";
+      power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
+      mediatek,larb = <&larb2>;
+      iommus = <&iommu MT2701_M4U_PORT_JPGENC_RDMA>,
+               <&iommu MT2701_M4U_PORT_JPGENC_BSDMA>;
+    };
-- 
2.32.0.272.g935e593368-goog

