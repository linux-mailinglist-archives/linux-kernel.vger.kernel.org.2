Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D49A330F69
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhCHNgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:36:13 -0500
Received: from inva020.nxp.com ([92.121.34.13]:35008 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229627AbhCHNfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:35:39 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C6A81A0BB7;
        Mon,  8 Mar 2021 14:35:38 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B0E631A0BB1;
        Mon,  8 Mar 2021 14:35:31 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EF06B402AC;
        Mon,  8 Mar 2021 14:35:22 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 3/6] ASoC: dt-bindings: fsl_rpmsg: Add binding doc for rpmsg cpu dai driver
Date:   Mon,  8 Mar 2021 21:22:27 +0800
Message-Id: <1615209750-2357-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615209750-2357-1-git-send-email-shengjiu.wang@nxp.com>
References: <1615209750-2357-1-git-send-email-shengjiu.wang@nxp.com>
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
 .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
new file mode 100644
index 000000000000..5731c1fbc0a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
@@ -0,0 +1,118 @@
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
+description: |
+  fsl_rpmsg cpu dai driver is virtual driver for rpmsg audio, which doesn't
+  touch hardware. It is mainly used for getting the user's configuration
+  from device tree and configure the clocks which is used by Cortex-M core.
+  So in this document define the needed property.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx7ulp-rpmsg
+      - fsl,imx8mn-rpmsg
+      - fsl,imx8mm-rpmsg
+      - fsl,imx8mp-rpmsg
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
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
+    enum: [0, 1]
+    default: 0
+    description: Instance index for sound card in
+                 M core side, which share one rpmsg
+                 channel.
+
+  fsl,version:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2]
+    default: 2
+    description: The version of M core image, which is
+                 to make driver compatible with different image.
+
+  fsl,buffer-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: pre allocate dma buffer size
+
+  fsl,enable-lpa:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: enable low power audio path.
+
+  fsl,rpmsg-out:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      This is a boolean property. If present, the transmitting function
+      will be enabled.
+
+  fsl,rpmsg-in:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      This is a boolean property. If present, the receiving function
+      will be enabled.
+
+  fsl,codec-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    default: 0
+    description: Sometimes the codec is registered by
+                 driver not by the device tree, this items
+                 can be used to distinguish codecs.
+
+  audio-codec:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the audio codec
+
+  memory-region:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the reserved memory nodes
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
+    };
-- 
2.27.0

