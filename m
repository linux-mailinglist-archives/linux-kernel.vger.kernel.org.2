Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A8F312385
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 11:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhBGKg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 05:36:26 -0500
Received: from inva020.nxp.com ([92.121.34.13]:50648 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhBGKgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 05:36:19 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E28C31A195E;
        Sun,  7 Feb 2021 11:35:31 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BB4C71A03DA;
        Sun,  7 Feb 2021 11:35:26 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 404094028B;
        Sun,  7 Feb 2021 11:35:20 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/7] ASoC: dt-bindings: fsl_rpmsg: Add binding doc for rpmsg cpu dai driver
Date:   Sun,  7 Feb 2021 18:23:51 +0800
Message-Id: <1612693435-31418-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl_rpmsg cpu dai driver is driver for rpmsg audio, which is mainly used
for getting the user's configuration from device tree and configure the
clocks which is used by Cortex-M core. So in this document define the
needed property.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
new file mode 100644
index 000000000000..2d3ce10d42fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,rpmsg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Audio RPMSG CPU DAI Controller
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx7ulp-rpmsg
+      - fsl,imx8mn-rpmsg
+      - fsl,imx8mm-rpmsg
+      - fsl,imx8mp-rpmsg
+
+  clocks:
+    items:
+      - description: Peripheral clock for register access
+      - description: Master clock
+      - description: DMA clock for DMA register access
+      - description: Parent clock for multiple of 8kHz sample rates
+      - description: Parent clock for multiple of 11kHz sample rates
+    minItems: 5
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: mclk
+      - const: dma
+      - const: pll8k
+      - const: pll11k
+    minItems: 5
+
+  power-domains:
+    maxItems: 1
+
+  fsl,audioindex:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: instance index for rpmsg image
+
+  fsl,version:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: rpmsg image version index
+
+  fsl,buffer-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: pre allocate dma buffer size
+
+  fsl,enable-lpa:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: enable low power audio path.
+
+  fsl,codec-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Sometimes the codec is registered by
+                 driver not the device tree, this items
+                 can be used to distinguish codecs
+
+required:
+  - compatible
+  - fsl,audioindex
+  - fsl,version
+  - fsl,buffer-size
+
+additionalProperties: false
+
+examples:
+  - |
+    rpmsg_audio: rpmsg_audio {
+        compatible = "fsl,imx8mn-rpmsg";
+        fsl,audioindex = <0> ;
+        fsl,version = <2>;
+        fsl,buffer-size = <0x6000000>;
+        fsl,enable-lpa;
+        status = "okay";
+    };
-- 
2.27.0

