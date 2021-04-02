Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D61E352DE4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbhDBQpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 12:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbhDBQpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 12:45:18 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E95C0613E6;
        Fri,  2 Apr 2021 09:45:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso4573320wmq.1;
        Fri, 02 Apr 2021 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uSob29oYaBD73CCB/j/clh43BRBqLKux2ktJmFxUmDk=;
        b=YWUiNligtSscvw8SK/+E5pGBzy9YmR1T7zL5MsFponmfhhKa+DP7iyTuSLM4Y00nyw
         KLD3e97DzlYyjE0E5zoOsPN7ZdqQ6PwRDpVn501qaj2tCI+ZwxOdhlCfP0ifEYQOerzZ
         FswsYDM4SM9GXStD+ODGGY1eytGP5fNTqbxLVb77yGy59FI4hthM1QURMFyoAjpiJDRW
         qGmr2ZOSWR9NVULpVuOKNAk7vXwNbntFcSx7DIg9Hh/vuSSAXIjKrFimoWDqSDyWUaGT
         2FvcbLiy/ADBIGGp3O3x6KwZ9KnhpGNbWgakDN7EGggUc4r/Z9Yik3sCrnOGXZigEmwI
         e9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uSob29oYaBD73CCB/j/clh43BRBqLKux2ktJmFxUmDk=;
        b=DAw+5vKUSiZ2Fba433Tlek+y+Yrj3rGZOSnP0oQ/IiF0IiYhSas6cXQOYrLcVmlb+U
         +QryAYH44YQhML6cKOcx38DHAx2xtsYZ/Ni2wNzUSXG4yNqmqVB/e4CC1hcbgRLZn8LH
         ZZLDCHKrlVSkzdP7IorUy7odTF0VcEV0Z/9layXQvEeOaxSbWV2iB8T8aiMedQF/8g0h
         9gH0IlscFG+3yEIVYefD02lZfjQD4WbJbvzI8EKZ07IStr1XrNyIh46o7jF6unKemVIH
         kBjXLpWClNYF8Yl3EfZaNMB8Tti8qzs9b2xeSxOyWpXsThcjuSNmh8Rrj9RXLiBvNJNz
         mU5w==
X-Gm-Message-State: AOAM532JpcOr6QFZSdDBFeOKMqiXmr/YSGKaPcs7OX7bA1OaxDiRG0z0
        fUUkungSMcZULIlUSCDAY8g=
X-Google-Smtp-Source: ABdhPJw+bObrUc5PBrW6wCAv4oDJgNnndWJkWiu323bncNMhXXU9t25IODtErVOy/Rh7lWH6az2HyQ==
X-Received: by 2002:a05:600c:220d:: with SMTP id z13mr13525344wml.1.1617381914074;
        Fri, 02 Apr 2021 09:45:14 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700dc0d270f04d57395.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:dc0d:270f:4d5:7395])
        by smtp.gmail.com with ESMTPSA id y10sm15027627wrl.19.2021.04.02.09.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 09:45:13 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de,
        peng.fan@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: power: Add documentation for imx8m power domain driver
Date:   Fri,  2 Apr 2021 18:45:05 +0200
Message-Id: <20210402164506.520121-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210402164506.520121-1-adrien.grassein@gmail.com>
References: <20210402164506.520121-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the imx8m(m|n|p) power domain driver.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../bindings/power/fsl,imx-power-domain.yaml  | 89 +++++++++++++++++++
 MAINTAINERS                                   |  8 ++
 include/dt-bindings/power/imx8mm-power.h      | 21 +++++
 include/dt-bindings/power/imx8mn-power.h      | 15 ++++
 include/dt-bindings/power/imx8mp-power.h      | 28 ++++++
 5 files changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-power-domain.yaml
 create mode 100644 include/dt-bindings/power/imx8mm-power.h
 create mode 100644 include/dt-bindings/power/imx8mn-power.h
 create mode 100644 include/dt-bindings/power/imx8mp-power.h

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-power-domain.yaml b/Documentation/devicetree/bindings/power/fsl,imx-power-domain.yaml
new file mode 100644
index 000000000000..8b4811aa80eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/fsl,imx-power-domain.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/fsl,imx-power-domain.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX 8mm, 8mn and 8mp Power Domain
+
+maintainers:
+  - Adrien Grassein <adrien.grassein@gmail.com>
+
+description: |+
+  i.MX processors include support for multiple power domains which are used
+  to gate power to one or more peripherals on the processor.
+
+allOf:
+  - $ref: power-domain.yaml#
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8mm-pm-domain
+      - fsl,imx8mn-pm-domain
+      - fsl,imx8mp-pm-domain
+
+  domain-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Human readable string with domain name. Will be visible in userspace
+      to let user to distinguish between multiple domains in SoC.
+
+  domain-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Power domain index. Valid values are defined in
+      include/dt-bindings/power/imx8mm-power.h for i.MX 8mm
+      include/dt-bindings/power/imx8mn-power.h for i.MX 8mn
+      include/dt-bindings/power/imx8mp-power.h for i.MX 8mp
+
+    maxItems: 1
+
+  clocks:
+    description: |
+      A number of phandles to clocks that need to be enabled during domain
+      power-up sequencing to ensure reset propagation into devices located
+      inside this power domain.
+    minItems: 1
+    maxItems: 6
+
+  power-supply:
+    description:
+      A phandle to a supply to enable when powering on the domain.
+
+  fsl,active-wakeup:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Instructs genpd to keep the PM domain powered on.
+
+  fsl,rpm-always-on:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Instructs genpd to always keep the PM domain powered on except
+      for system suspend.
+
+  "#power-domain-cells":
+    const: 0
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - domain-name
+  - domain-index
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/power/imx8mm-power.h>
+    #include <dt-bindings/clock/imx8mm-clock.h>
+
+    hsiomix_pd: power-domain-hsio {
+        compatible = "fsl,imx8mm-pm-domain";
+        domain-index = <IMX8MM_POWER_DOMAIN_HSIOMIX>;
+        #power-domain-cells = <0>;
+        domain-name = "hsiomix";
+        clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 38d823d72e52..97536afca0e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13010,6 +13010,14 @@ L:	linux-imx@nxp.com
 S:	Maintained
 F:	drivers/clk/imx/
 
+NXP i.MX 8M(M|N|P) POWER DOMAIN DRIVER
+M:	Adrien Grassein <adrien.grassein@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/fsl,imx-power-domain.yaml
+F:	include/dt-bindings/power/imx8mm-power.h
+F:	include/dt-bindings/power/imx8mn-power.h
+F:	include/dt-bindings/power/imx8mp-power.h
+
 NXP i.MX 8MQ DCSS DRIVER
 M:	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
 R:	Lucas Stach <l.stach@pengutronix.de>
diff --git a/include/dt-bindings/power/imx8mm-power.h b/include/dt-bindings/power/imx8mm-power.h
new file mode 100644
index 000000000000..bec25fd32394
--- /dev/null
+++ b/include/dt-bindings/power/imx8mm-power.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ *  Copyright (C) 2021 Adrien Grassein <adrien.grassein@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_IMX8MM_POWER_H__
+#define __DT_BINDINGS_IMX8MM_POWER_H__
+
+#define IMX8MM_POWER_DOMAIN_HSIOMIX	0
+#define IMX8MM_POWER_DOMAIN_PCIE1	1
+#define IMX8MM_POWER_DOMAIN_USB_OTG1	2
+#define IMX8MM_POWER_DOMAIN_USB_OTG2	3
+#define IMX8MM_POWER_DOMAIN_GPU		4
+#define IMX8MM_POWER_DOMAIN_VPU		5
+#define IMX8MM_POWER_DOMAIN_VPU_G1	6
+#define IMX8MM_POWER_DOMAIN_VPU_G2	7
+#define IMX8MM_POWER_DOMAIN_VPU_H1	8
+#define IMX8MM_POWER_DOMAIN_DISPLAY	9
+#define IMX8MM_POWER_DOMAIN_MIPI	10
+
+#endif
diff --git a/include/dt-bindings/power/imx8mn-power.h b/include/dt-bindings/power/imx8mn-power.h
new file mode 100644
index 000000000000..dfa0711171cd
--- /dev/null
+++ b/include/dt-bindings/power/imx8mn-power.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ *  Copyright (C) 2021 Adrien Grassein <adrien.grassein@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_IMX8MN_POWER_H__
+#define __DT_BINDINGS_IMX8MN_POWER_H__
+
+#define IMX8MN_POWER_DOMAIN_HSIOMIX	0
+#define IMX8MN_POWER_DOMAIN_USB_OTG1	2
+#define IMX8MN_POWER_DOMAIN_GPU		4
+#define IMX8MN_POWER_DOMAIN_DISPLAY	9
+#define IMX8MN_POWER_DOMAIN_MIPI	10
+
+#endif
diff --git a/include/dt-bindings/power/imx8mp-power.h b/include/dt-bindings/power/imx8mp-power.h
new file mode 100644
index 000000000000..660e6b7d6c69
--- /dev/null
+++ b/include/dt-bindings/power/imx8mp-power.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ *  Copyright (C) 2021 Adrien Grassein <adrien.grassein@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_IMX8MP_POWER_H__
+#define __DT_BINDINGS_IMX8MP_POWER_H__
+
+#define IMX8MP_POWER_DOMAIN_HSIOMIX	0
+#define IMX8MP_POWER_DOMAIN_PCIE1	1
+#define IMX8MP_POWER_DOMAIN_USB_OTG1	2
+#define IMX8MP_POWER_DOMAIN_USB_OTG2	3
+#define IMX8MP_POWER_DOMAIN_MLMIX	4
+#define IMX8MP_POWER_DOMAIN_AUDIOMIX	5
+#define IMX8MP_POWER_DOMAIN_GPU_MIX	6
+#define IMX8MP_POWER_DOMAIN_GPU_2D	7
+#define IMX8MP_POWER_DOMAIN_GPU_3D	8
+#define IMX8MP_POWER_DOMAIN_VPUMIX	9
+#define IMX8MP_POWER_DOMAIN_G1		10
+#define IMX8MP_POWER_DOMAIN_G2		11
+#define IMX8MP_POWER_DOMAIN_H1		12
+#define IMX8MP_POWER_MEDIAMIX		13
+#define IMX8MP_ISP_DWP			14
+#define IMX8MP_MIPI_PHY1		15
+#define IMX8MP_MIPI_PHY2		16
+#define IMX8MP_HDMI_MIX			17
+#define IMX8MP_HDMI_PHY			18
+#endif
-- 
2.25.1

