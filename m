Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCDE32492D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 04:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhBYDHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 22:07:07 -0500
Received: from inva021.nxp.com ([92.121.34.21]:40632 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236950AbhBYDGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 22:06:16 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3F20620073E;
        Thu, 25 Feb 2021 04:05:29 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E037200729;
        Thu, 25 Feb 2021 04:05:22 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DD58E4032A;
        Thu, 25 Feb 2021 04:05:14 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 7/7] ASoC: dt-bindings: imx-rpmsg: Add binding doc for rpmsg machine driver
Date:   Thu, 25 Feb 2021 10:52:43 +0800
Message-Id: <1614221563-26822-8-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614221563-26822-1-git-send-email-shengjiu.wang@nxp.com>
References: <1614221563-26822-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Imx-rpmsg is a new added machine driver for supporting audio on Cortex-M
core. The Cortex-M core will control the audio interface, DMA and audio
codec, setup the pipeline, the audio driver on Cortex-A core side is just
to communitcate with M core, it is a virtual sound card and don't touch
the hardware.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../bindings/sound/imx-audio-rpmsg.yaml       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-rpmsg.yaml

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-rpmsg.yaml b/Documentation/devicetree/bindings/sound/imx-audio-rpmsg.yaml
new file mode 100644
index 000000000000..ff9b3fc69dae
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/imx-audio-rpmsg.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/imx-audio-rpmsg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX audio complex with rpmsg
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+description: |
+  imx-rpmsg is a machine driver for supporting audio by rpmsg.
+  The Cortex-M core will control the audio interface, DMA and audio
+  codec, setup the pipeline, the audio driver on Cortex-A core side
+  is just to communitcate with M core, it is a virtual sound card
+  and don't touch the hardware.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx-audio-rpmsg
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+  audio-cpu:
+    description: The phandle of an CPU DAI controller
+
+  rpmsg-out:
+    description: |
+      This is a boolean property. If present, the transmitting function
+      will be enabled,
+
+  rpmsg-in:
+    description: |
+      This is a boolean property. If present, the receiving function
+      will be enabled.
+
+required:
+  - compatible
+  - model
+  - audio-cpu
+
+additionalProperties: false
+
+examples:
+  - |
+    sound-rpmsg {
+        compatible = "fsl,imx-audio-rpmsg";
+        model = "ak4497-audio";
+        audio-cpu = <&rpmsg_audio>;
+        rpmsg-out;
+    };
-- 
2.27.0

