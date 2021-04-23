Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8A7368CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbhDWGLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:11:22 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45688 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhDWGLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:11:20 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2431420415A;
        Fri, 23 Apr 2021 08:10:44 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 52EB120416D;
        Fri, 23 Apr 2021 08:10:37 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CF91340339;
        Fri, 23 Apr 2021 08:10:28 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] ASoC: dt-bindings: imx-akcodec: Add binding doc for akcodec machine driver
Date:   Fri, 23 Apr 2021 13:51:47 +0800
Message-Id: <1619157107-3734-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619157107-3734-1-git-send-email-shengjiu.wang@nxp.com>
References: <1619157107-3734-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Imx-akcodec is a new added machine driver for supporting
ak4458/ak5558/ak5552/ak4497 codec on i.MX platforms.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../bindings/sound/imx-audio-akcodec.yaml     | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml b/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
new file mode 100644
index 000000000000..7419bf7224e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/imx-audio-akcodec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX audio complex with AK4458/AK5558/AK5552/AK4497 codec
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8mq-audio-ak4458
+      - fsl,imx8mq-audio-ak4497
+      - fsl,imx8mq-audio-ak5558
+      - fsl,imx-audio-ak4497
+      - fsl,imx-audio-ak4458
+      - fsl,imx-audio-ak5558
+      - fsl,imx-audio-ak5552
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+  audio-cpu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of a CPU DAI controller
+
+  audio-codec:
+    description: The phandle of Codec DAI controllers, there are two
+                 controllers maximum.
+
+  audio-asrc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of ASRC. It can be absent if there's no
+                 need to add ASRC support via DPCM.
+
+  fsl,tdm:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      This is a boolean property. If present, the TDM mode is enabled.
+
+required:
+  - compatible
+  - model
+  - audio-cpu
+  - audio-codec
+
+additionalProperties: false
+
+examples:
+  - |
+    sound-ak4458 {
+        compatible = "fsl,imx-audio-ak4458";
+        model = "ak4458-audio";
+        audio-cpu = <&sai1>;
+        audio-codec = <&ak4458_1>, <&ak4458_2>;
+    };
-- 
2.17.1

